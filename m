Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUC3Ay6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbUC3Ay6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:54:58 -0500
Received: from [202.65.75.150] ([202.65.75.150]:20354 "EHLO
	pythia.bakeyournoodle.com") by vger.kernel.org with ESMTP
	id S263301AbUC3Ay4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:54:56 -0500
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Tue, 30 Mar 2004 08:47:18 +0800
To: Jim Ruxton <cinetron@passport.ca>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.6..5-rc2 "make modules" fails in drivers/scsi/scsi_transport_spi.c
Message-ID: <20040330004718.GY3445@bakeyournoodle.com>
Mail-Followup-To: Jim Ruxton <cinetron@passport.ca>,
	linux-kernel@vger.kernel.org
References: <4061A548.8060605@passport.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4061A548.8060605@passport.ca>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 10:12:08AM -0500, Jim Ruxton wrote:
> Hi any thoughts what I can do to fix this? Thanks
> A reply to me as well as the list would be appreciated.
> 
> LD [M] drivers/scsi/scsi_mod.o
> CC [M] drivers/scsi/scsi_transport_spi.o
> drivers/scsi/scsi_transport_spi.c: In function `spi_dv_retrain':
> drivers/scsi/scsi_transport_spi.c:388: parse error before `;'
> drivers/scsi/scsi_transport_spi.c:392: parse error before `;'
> drivers/scsi/scsi_transport_spi.c: In function `spi_dv_device_internal':
> drivers/scsi/scsi_transport_spi.c:463: parse error before `;'
> drivers/scsi/scsi_transport_spi.c:475: parse error before `;'
> drivers/scsi/scsi_transport_spi.c:494: parse error before `;'
> drivers/scsi/scsi_transport_spi.c: In function `spi_dv_device':
> drivers/scsi/scsi_transport_spi.c:539: parse error before `;'
> drivers/scsi/scsi_transport_spi.c:543: parse error before `;'
> make[2]: *** [drivers/scsi/scsi_transport_spi.o] Error 1
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2

I bet you're using an old (gcc-2.95)  Try:

################################################################################
--- 2.6.5-rc2.clean/drivers/scsi/scsi_transport_spi.c	2004-03-30 10:45:44.000000000 +1000
+++ 2.6.5-rc2.scsi/drivers/scsi/scsi_transport_spi.c	2004-03-30 10:51:01.000000000 +1000
@@ -33,7 +33,7 @@
 #include <scsi/scsi_transport.h>
 #include <scsi/scsi_transport_spi.h>
 
-#define SPI_PRINTK(x, l, f, a...)	printk(l "scsi(%d:%d:%d:%d): " f, (x)->host->host_no, (x)->channel, (x)->id, (x)->lun, ##a)
+#define SPI_PRINTK(x, l, f, a...)	printk(l "scsi(%d:%d:%d:%d): " f, (x)->host->host_no, (x)->channel, (x)->id, (x)->lun , ##a)
 
 static void transport_class_release(struct class_device *class_dev);
 
################################################################################

Yours Tony

        linux.conf.au       http://lca2005.linux.org.au/
	Apr 18-23 2005      The Australian Linux Technical Conference!

