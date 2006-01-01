Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWAAPMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWAAPMc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 10:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWAAPMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 10:12:32 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:9689 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932229AbWAAPMb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 10:12:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CO8WKkFCrIbckH9zSsdE55cWx9T9xYJt4SiFjXTQSTPxiiavBePkmTxK9c4Jr4/2l/bXyLEtCrFa/5TNWISSvebffwBfLmOaaSgOgTDFMHi26Twok9+4+jaRBlQ4n4jUhmDFCHaSLtEek893/e4v/ykF+yUjvShNjWI23AduujM=
Message-ID: <221e0ff70601010712u6a0d395dq@mail.gmail.com>
Date: Sun, 1 Jan 2006 16:12:31 +0100
From: Gyorgy Jeney <nog.lkml@gmail.com>
To: rmk+serial@arm.linux.org.uk
Subject: [patch] serial: compare mapbase and not membase in find_port
Cc: linux-serial@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gyorgy Jeney

If the 8250_early driver uses bt_ioremap, find_port() is unable to find the
correct device since the address returned by ioremap is different to that
returned by bt_ioremap for the same address.  Since no more than one device
occupies the same physical address, compareing the physical addresses should
be safe.

Signed-off-by: Gyorgy Jeney <nog.lkml@gmail.com>

nog.

--- drivers/serial/8250.c	2005-10-28 02:02:08.000000000 +0200
+++ ../../linux-2.6.14/drivers/serial/8250.c	2006-01-01 10:27:39.000000000 +0100
@@ -2229,7 +2229,7 @@ static int __init find_port(struct uart_
 		port = &serial8250_ports[line].port;
 		if (p->iotype == port->iotype &&
 		    p->iobase == port->iobase &&
-		    p->membase == port->membase)
+		    p->mapbase == port->mapbase)
 			return line;
 	}
 	return -ENODEV;
