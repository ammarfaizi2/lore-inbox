Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbUCTMTO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 07:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbUCTMTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 07:19:14 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4578 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263388AbUCTMTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 07:19:08 -0500
Date: Sat, 20 Mar 2004 13:18:54 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Martin Hicks <mort@wildopensource.com>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [patch] 2.6.5-rc2: fix scsi_transport_spi.c with gcc 2.95
Message-ID: <20040320121853.GF19464@fs.tum.de>
References: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.6.5-rc2 using gcc 2.95:

<--  snip  -->

...
  CC      drivers/scsi/scsi_transport_spi.o
drivers/scsi/scsi_transport_spi.c: In function `spi_dv_retrain':
drivers/scsi/scsi_transport_spi.c:388: parse error before `;'
drivers/scsi/scsi_transport_spi.c:392: parse error before `;'
drivers/scsi/scsi_transport_spi.c: In function `spi_dv_device_internal':
drivers/scsi/scsi_transport_spi.c:463: parse error before `;'
drivers/scsi/scsi_transport_spi.c:475: parse error before `;'
drivers/scsi/scsi_transport_spi.c:494: parse error before `;'
drivers/scsi/scsi_transport_spi.c: In function `spi_dv_device':
drivers/scsi/scsi_transport_spi.c:539: parse error before `;'
drivers/scsi/scsi_transport_spi.c:543: parse error before `;'
make[2]: *** [drivers/scsi/scsi_transport_spi.o] Error 1

<--  snip  -->


I found the patch below in -mm that fixes this problem.


Please apply
Adrian


<--  snip  -->


Work around the gcc-2.95 token pasting bug.


---

 25-akpm/drivers/scsi/scsi_transport_spi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/scsi/scsi_transport_spi.c~scsi_transport_spi-build-fix drivers/scsi/scsi_transport_spi.c
--- 25/drivers/scsi/scsi_transport_spi.c~scsi_transport_spi-build-fix	2004-03-14 02:45:22.999909632 -0800
+++ 25-akpm/drivers/scsi/scsi_transport_spi.c	2004-03-14 02:45:29.938854752 -0800
@@ -33,7 +33,7 @@
 #include <scsi/scsi_transport.h>
 #include <scsi/scsi_transport_spi.h>
 
-#define SPI_PRINTK(x, l, f, a...)	printk(l "scsi(%d:%d:%d:%d): " f, (x)->host->host_no, (x)->channel, (x)->id, (x)->lun, ##a)
+#define SPI_PRINTK(x, l, f, a...)	printk(l "scsi(%d:%d:%d:%d): " f, (x)->host->host_no, (x)->channel, (x)->id, (x)->lun , ##a)
 
 static void transport_class_release(struct class_device *class_dev);
 

_
