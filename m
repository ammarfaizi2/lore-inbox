Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTEKMRA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTEKMRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:17:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12778 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261305AbTEKMQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:16:58 -0400
Date: Sun, 11 May 2003 14:29:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.69-dj1: agp_init shouldn't be static
Message-ID: <20030511122934.GH1107@fs.tum.de>
References: <20030510145653.GA26216@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510145653.GA26216@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-dj makes agp_init static resulting in the following error at the final 
linking:


<--  snip  -->

...
386/oprofile/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
drivers/built-in.o(.init.text+0x6b584): In function `i810fb_init':
: undefined reference to `agp_init'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The following patch fixes it:


--- linux-2.5.69-dj1/drivers/char/agp/backend.c.old	2003-05-11 14:12:29.000000000 +0200
+++ linux-2.5.69-dj1/drivers/char/agp/backend.c	2003-05-11 14:13:30.000000000 +0200
@@ -307,7 +307,7 @@
 EXPORT_SYMBOL_GPL(agp_remove_bridge);
 
 
-static int __init agp_init(void)
+int __init agp_init(void)
 {
 	printk(KERN_INFO "Linux agpgart interface v%d.%d (c) Dave Jones\n",
 	       AGPGART_VERSION_MAJOR, AGPGART_VERSION_MINOR);



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

