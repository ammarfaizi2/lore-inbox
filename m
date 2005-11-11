Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVKKJQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVKKJQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 04:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVKKJQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 04:16:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29366 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932307AbVKKJQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 04:16:10 -0500
Date: Fri, 11 Nov 2005 01:14:36 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com, Adrian Bunk <bunk@stusta.de>
Cc: stern@rowland.harvard.edu, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-usb@one-eyed-alien.net,
       zaitcev@redhat.com, <reuben-lkml@reub.net>
Subject: Re: [-mm patch] USB_LIBUSUAL shouldn't be user-visible
Message-Id: <20051111011436.5804aac8.zaitcev@redhat.com>
In-Reply-To: <20051108004716.GJ3847@stusta.de>
References: <20051107215226.GA25104@kroah.com>
	<Pine.LNX.4.44L0.0511071725220.5165-100000@iolanthe.rowland.org>
	<20051107222840.GB26417@kroah.com>
	<20051108004716.GJ3847@stusta.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally received a .config from Reuben Farrelly and reproduced the problem.
The libusual.o is being built, but not linked into the kernel image.

---

Never one to ignore a good idea, I propose to take a segment of
Adrian's patch which addresses this particular problem:

> --- linux-2.6.14-mm1-full/drivers/usb/Makefile.old	2005-11-08 01:31:00.000000000 +0100
> +++ linux-2.6.14-mm1-full/drivers/usb/Makefile	2005-11-08 01:31:26.000000000 +0100
> @@ -22,6 +22,7 @@
>  obj-$(CONFIG_USB_PRINTER)	+= class/
>  
>  obj-$(CONFIG_USB_STORAGE)	+= storage/
> +obj-$(CONFIG_USB_LIBUSUAL)	+= storage/
>  
>  obj-$(CONFIG_USB_AIPTEK)	+= input/
>  obj-$(CONFIG_USB_ATI_REMOTE)	+= input/

With a small change, this seems to work fine with the supplied .config.
Also I have tested my usual build modes and added Reuben's configuration
to my testing list.

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>

diff -urp -X dontdiff linux-2.6.14-mm1/drivers/usb/Makefile linux-2.6.14-mm1-reub/drivers/usb/Makefile
--- linux-2.6.14-mm1/drivers/usb/Makefile	2005-11-10 23:18:32.000000000 -0800
+++ linux-2.6.14-mm1-reub/drivers/usb/Makefile	2005-11-11 01:01:31.000000000 -0800
@@ -22,6 +22,7 @@ obj-$(CONFIG_USB_MIDI)		+= class/
 obj-$(CONFIG_USB_PRINTER)	+= class/
 
 obj-$(CONFIG_USB_STORAGE)	+= storage/
+obj-$(CONFIG_USB)		+= storage/
 
 obj-$(CONFIG_USB_AIPTEK)	+= input/
 obj-$(CONFIG_USB_ATI_REMOTE)	+= input/
