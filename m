Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbUKWTkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUKWTkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUKWTh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:37:28 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:2781 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S261525AbUKWTg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:36:26 -0500
Date: Tue, 23 Nov 2004 20:36:04 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Greg KH <greg@kroah.com>
Cc: Simon Fowler <simon@himi.org>, linux-kernel@vger.kernel.org
Subject: [2.6 PATCH] visor: Don't count outstanding URBs twice
Message-ID: <20041123193604.GA12605@k3.hellgate.ch>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Simon Fowler <simon@himi.org>, linux-kernel@vger.kernel.org
References: <20041116154943.GA13874@k3.hellgate.ch> <20041119174405.GE20162@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119174405.GE20162@kroah.com>
X-Operating-System: Linux 2.6.10-rc2 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys, can you please CC me when discussing patches of mine? I don't read
LKML religiously, and my procmail filters are pretty dumb. Thanks. So
my previous patch fixed the oops, but the driver's still borked.

Incrementing the outstanding_urbs counter twice for the same URB can't
be good. No wonder Simon didn't get far syncing his Palm.

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- linux-2.6.10-rc2-bk8/drivers/usb/serial/visor.c.orig	2004-11-23 20:23:27.592097112 +0100
+++ linux-2.6.10-rc2-bk8/drivers/usb/serial/visor.c	2004-11-23 20:24:53.496037728 +0100
@@ -497,7 +497,6 @@ static int visor_write (struct usb_seria
 		dev_dbg(&port->dev, "write limit hit\n");
 		return 0;
 	}
-	++priv->outstanding_urbs;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	buffer = kmalloc (count, GFP_ATOMIC);
