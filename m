Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263676AbREYKKd>; Fri, 25 May 2001 06:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263677AbREYKKX>; Fri, 25 May 2001 06:10:23 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:17170 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S263676AbREYKKR>;
	Fri, 25 May 2001 06:10:17 -0400
Message-ID: <3B0D733F.1829DC88@yahoo.com>
Date: Thu, 24 May 2001 16:46:55 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.4 i586)
MIME-Version: 1.0
To: Hal Duston <hald@sound.net>
CC: linux-kernel@vger.kernel.org, rasmus@jaquet.dk
Subject: Re: PS/2 Esdi patch #8
In-Reply-To: <Pine.GSO.4.10.10105231748550.23376-200000@sound.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hal Duston wrote:

> http://www.sound.net/~hald/projects/ps2esdi/ps2esdi-2.4.4-patch4
> 
> Hal Duston
> hald@sound.net

You PS/2 ESDI guys might want to set the max sectors for your
driver - old default used to be 128, currently 255 (which maybe
hardware can handle ok?) - the xd and hd drivers were broken until
a similar fix was added to them.

Probably makes sense for driver to set it regardless, seeing 
as default (MAX_SECTORS) has changed several times over last
few months.  At least then it will be under driver control
and not at the mercy of some global value.

Paul.

--- drivers/block/ps2esdi.c~	Sun Apr 29 04:42:35 2001
+++ drivers/block/ps2esdi.c	Thu May 24 16:33:46 2001
@@ -117,6 +117,7 @@
 static char ps2esdi_valid[MAX_HD];
 static int ps2esdi_sizes[MAX_HD << 6];
 static int ps2esdi_blocksizes[MAX_HD << 6];
+static int ps2esdi_maxsect[MAX_HD << 6];
 static int ps2esdi_drives;
 static struct hd_struct ps2esdi[MAX_HD << 6];
 static u_short io_base;
@@ -414,8 +415,11 @@
 
 	ps2esdi_gendisk.nr_real = ps2esdi_drives;
 
-	for (i = 0; i < (MAX_HD << 6); i++)
+	/* 128 was old default, maybe maxsect=255 is ok too? - Paul G. */
+	for (i = 0; i < (MAX_HD << 6); i++) {
+		ps2esdi_maxsect[i] = 128;
 		ps2esdi_blocksizes[i] = 1024;
+	}
 
 	request_dma(dma_arb_level, "ed");
 	request_region(io_base, 4, "ed");



