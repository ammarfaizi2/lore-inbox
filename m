Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTJWWFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 18:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTJWWFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 18:05:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:52106 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261823AbTJWWFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 18:05:16 -0400
Date: Thu, 23 Oct 2003 15:03:03 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
       Dave Hollis <dhollis@davehollis.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.4.23-pre8: usbnet.c doesn't compile with gcc 2.95
Message-ID: <20031023220303.GA21242@kroah.com>
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet> <20031023194748.GH11807@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023194748.GH11807@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 09:47:49PM +0200, Adrian Bunk wrote:
> I'm getting the following compile error in 2.4.23-pre8 with gcc 2.95:

This can be fixed with this patch.  I'll send it to Marcelo in the next
batch of USB fixes.

thanks,

greg k-h


# USB: fix build bug with usbnet and older versions of gcc.

diff -Nru a/drivers/usb/usbnet.c b/drivers/usb/usbnet.c
--- a/drivers/usb/usbnet.c	Thu Oct 23 15:02:44 2003
+++ b/drivers/usb/usbnet.c	Thu Oct 23 15:02:44 2003
@@ -381,14 +381,14 @@
 
 #ifdef DEBUG
 #define devdbg(usbnet, fmt, arg...) \
-	printk(KERN_DEBUG "%s: " fmt "\n" , (usbnet)->net.name, ## arg)
+	printk(KERN_DEBUG "%s: " fmt "\n" , (usbnet)->net.name , ## arg)
 #else
 #define devdbg(usbnet, fmt, arg...) do {} while(0)
 #endif
 
 #define devinfo(usbnet, fmt, arg...) \
 	do { if ((usbnet)->msg_level >= 1) \
-	printk(KERN_INFO "%s: " fmt "\n" , (usbnet)->net.name, ## arg); \
+	printk(KERN_INFO "%s: " fmt "\n" , (usbnet)->net.name , ## arg); \
 	} while (0)
 
 
