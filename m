Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbTAIHah>; Thu, 9 Jan 2003 02:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbTAIHah>; Thu, 9 Jan 2003 02:30:37 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62477 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261742AbTAIHag>;
	Thu, 9 Jan 2003 02:30:36 -0500
Date: Wed, 8 Jan 2003 23:38:49 -0800
From: Greg KH <greg@kroah.com>
To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre3 fails compile of ehci-hcd.c
Message-ID: <20030109073849.GC8400@kroah.com>
References: <1042096276.8219.126.camel@madmax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042096276.8219.126.camel@madmax>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 02:11:15AM -0500, Kristofer T. Karas wrote:
> Hello All,
> 
> Noticed that I could not get patch-2.4.21-pre3 to compile:
> 
> 	make[3]: Entering directory `/usr/src/kernels/linux-2.4.20/drivers/usb'
> 	ld -m elf_i386 -r -o usbcore.o usb.o usb-debug.o hub.o devio.o inode.o drivers.o devices.o hcd.o
> 	gcc -D__KERNEL__ -I/usr/src/kernels/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -iwithprefix include -DKBUILD_BASENAME=ehci_hcd  -c -o hcd/ehci-hcd.o hcd/ehci-hcd.chcd/ehci-hcd.c: In function `ehci_start':
> 	hcd/ehci-hcd.c:343: parse error before `;'
> 	hcd/ehci-hcd.c:416: parse error before `;'
> 	hcd/ehci-hcd.c: In function `ehci_stop':
> 	hcd/ehci-hcd.c:501: parse error before `;'
> 	hcd/ehci-hcd.c: In function `ehci_irq':
> 	hcd/ehci-hcd.c:685: parse error before `;'

Does this patch solve it for you?

thanks,

greg k-h


--- 1.5/drivers/usb/hcd/ehci-dbg.c	Mon Jan  6 16:43:05 2003
+++ edited/ehci-dbg.c	Wed Jan  8 23:45:02 2003
@@ -18,37 +18,23 @@
 
 /* this file is part of ehci-hcd.c */
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,50)
-
-#define ehci_dbg(ehci, fmt, args...) \
-	dev_dbg (*(ehci)->hcd.controller, fmt, ## args )
-#define ehci_err(ehci, fmt, args...) \
-	dev_err (*(ehci)->hcd.controller, fmt, ## args )
-#define ehci_info(ehci, fmt, args...) \
-	dev_info (*(ehci)->hcd.controller, fmt, ## args )
-#define ehci_warn(ehci, fmt, args...) \
-	dev_warn (*(ehci)->hcd.controller, fmt, ## args )
-
-#else
-
 #ifdef DEBUG
 #define ehci_dbg(ehci, fmt, args...) \
-	printk(KERN_DEBUG "%s %s: " fmt, hcd_name, \
-		(ehci)->hcd.pdev->slot_name, ## args )
+	printk(KERN_DEBUG "%s %s: " fmt , hcd_name , \
+		(ehci)->hcd.pdev->slot_name , ## args )
 #else
 #define ehci_dbg(ehci, fmt, args...) do { } while (0)
 #endif
 
 #define ehci_err(ehci, fmt, args...) \
-	printk(KERN_ERR "%s %s: " fmt, hcd_name, \
-		(ehci)->hcd.pdev->slot_name, ## args )
+	printk(KERN_ERR "%s %s: " fmt , hcd_name , \
+		(ehci)->hcd.pdev->slot_name , ## args )
 #define ehci_info(ehci, fmt, args...) \
-	printk(KERN_INFO "%s %s: " fmt, hcd_name, \
-		(ehci)->hcd.pdev->slot_name, ## args )
+	printk(KERN_INFO "%s %s: " fmt , hcd_name , \
+		(ehci)->hcd.pdev->slot_name , ## args )
 #define ehci_warn(ehci, fmt, args...) \
-	printk(KERN_WARNING "%s %s: " fmt, hcd_name, \
-		(ehci)->hcd.pdev->slot_name, ## args )
-#endif
+	printk(KERN_WARNING "%s %s: " fmt , hcd_name , \
+		(ehci)->hcd.pdev->slot_name , ## args )
 
 
 #ifdef EHCI_VERBOSE_DEBUG
