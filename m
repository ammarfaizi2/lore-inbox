Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTE0M47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbTE0M4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:56:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9998 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263567AbTE0Myy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:54:54 -0400
Date: Tue, 27 May 2003 14:08:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.70] oops when rmmod yenta_socket
Message-ID: <20030527140805.D16734@flint.arm.linux.org.uk>
Mail-Followup-To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
	linux-kernel@vger.kernel.org
References: <20030527124952.GB13051@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030527124952.GB13051@butterfly.hjsoft.com>; from glynis@butterfly.hjsoft.com on Tue, May 27, 2003 at 08:49:52AM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 08:49:52AM -0400, John M Flinchbaugh wrote:
> i shutdown pcmcia and tried to rmmod yenta_socket, and i got the oops
> below at the end of this dmesg.  so far, 2.5.70 has looked alot like
> 2.5.69-bk11 that i'd been running before.

Try this patch, thanks to Pavel Roskin for this.

--- linux.orig/drivers/pcmcia/pci_socket.c
+++ linux/drivers/pcmcia/pci_socket.c
@@ -196,9 +196,9 @@ static void __devexit cardbus_remove (st
 	pci_socket_t *socket = pci_get_drvdata(dev);
 
 	/* note: we are already unregistered from the cs core */
+	class_device_unregister(&socket->cls_d.class_dev);
 	if (socket->op && socket->op->close)
 		socket->op->close(socket);
-	class_device_unregister(&socket->cls_d.class_dev);
 	pci_set_drvdata(dev, NULL);
 }
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

