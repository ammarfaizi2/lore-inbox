Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265994AbUFDUks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUFDUks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265988AbUFDUks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:40:48 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:46227 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S265994AbUFDUkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:40:46 -0400
From: Duncan Sands <baldrick@free.fr>
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
Date: Fri, 4 Jun 2004 22:40:43 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>,
       linux-usb-devel@lists.sourceforge.net
References: <20040604193911.GA3261@babylon.d2dc.net> <20040604195247.GA12688@kroah.com> <20040604200211.GB3261@babylon.d2dc.net>
In-Reply-To: <20040604200211.GB3261@babylon.d2dc.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406042240.43490.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> c4bae310 Call Trace:
>  [<c0336735>] __down+0x85/0x120
>  [<c033692f>] __down_failed+0xb/0x14
>  [<c026af27>] .text.lock.hub+0x69/0x82
>  [<c0272b7f>] usbdev_ioctl+0x19f/0x710
>  [<c015a45d>] file_ioctl+0x5d/0x170
>  [<c015a686>] sys_ioctl+0x116/0x250
>  [<c0103f8f>] syscall_call+0x7/0xb

Does this help?

Ciao,

Duncan.

--- linux-2.5/drivers/usb/core/devio.c.orig	2004-06-04 22:29:28.000000000 +0200
+++ linux-2.5/drivers/usb/core/devio.c	2004-06-04 22:40:22.000000000 +0200
@@ -50,6 +50,8 @@
 #include "hcd.h"	/* for usbcore internals */
 #include "usb.h"
 
+extern int __usb_reset_device(struct usb_device *udev);
+
 struct async {
 	struct list_head asynclist;
 	struct dev_state *ps;
@@ -719,7 +721,7 @@
 
 static int proc_resetdevice(struct dev_state *ps)
 {
-	return usb_reset_device(ps->dev);
+	return __usb_reset_device(ps->dev);
 
 }
 

