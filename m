Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276956AbRKFFXu>; Tue, 6 Nov 2001 00:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276591AbRKFFXW>; Tue, 6 Nov 2001 00:23:22 -0500
Received: from zero.tech9.net ([209.61.188.187]:28687 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S275012AbRKFFWf>;
	Tue, 6 Nov 2001 00:22:35 -0500
Subject: Re: 2.4.14 errors on full build - Y
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <17526.1005022179@ocs3.intra.ocs.com.au>
In-Reply-To: <17526.1005022179@ocs3.intra.ocs.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.05.15.31 (Preview Release)
Date: 06 Nov 2001 00:22:37 -0500
Message-Id: <1005024157.1506.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-05 at 23:49, Keith Owens wrote:
> Doing a full build of 2.4.14 (everything set to Y where possible), got
> the usual collection of errors.  Some of these errors have been around
> for weeks, any chance of them getting fixed?
> [...]
>   drivers/mtd/chips/jedec_probe.o: In function `jedec_probe_init':
>   drivers/mtd/chips/jedec_probe.o(.text.init+0x0): multiple definition of `jedec_probe_init'
>   drivers/mtd/chips/jedec.o(.text.init+0x0): first defined here

Another simple fix...the multiple function declarations should be
static.  Even better, a lot of the duplication between the driver should
be shared but that I shall leave as an exercises for the maintainer. 
Until then, Linus, please apply.

diff -urN linux-2.4.14/drivers/mtd/chips/jedec.c linux/drivers/mtd/chips/jedec.c
--- linux-2.4.14/drivers/mtd/chips/jedec.c	Mon Nov  5 20:11:15 2001
+++ linux/drivers/mtd/chips/jedec.c	Tue Nov  6 00:19:15 2001
@@ -873,7 +873,7 @@
    }
 }
 
-int __init jedec_probe_init(void)
+static int __init jedec_probe_init(void)
 {
 	register_mtd_chip_driver(&jedec_chipdrv);
 	return 0;
diff -urN linux-2.4.14/drivers/mtd/chips/jedec_probe.c linux/drivers/mtd/chips/jedec_probe.c
--- linux-2.4.14/drivers/mtd/chips/jedec_probe.c	Mon Nov  5 20:11:15 2001
+++ linux/drivers/mtd/chips/jedec_probe.c	Tue Nov  6 00:19:16 2001
@@ -422,7 +422,7 @@
 	module: THIS_MODULE
 };
 
-int __init jedec_probe_init(void)
+static int __init jedec_probe_init(void)
 {
 	register_mtd_chip_driver(&jedec_chipdrv);
 	return 0;


	Robert Love

