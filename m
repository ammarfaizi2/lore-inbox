Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315564AbSECGIr>; Fri, 3 May 2002 02:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315563AbSECGIq>; Fri, 3 May 2002 02:08:46 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:6294 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP
	id <S315564AbSECGIo>; Fri, 3 May 2002 02:08:44 -0400
Date: Fri, 3 May 2002 02:11:22 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.13 -- UFS compile error in fs/ufs/super.c:661: In function `ufs_fill_super': parse error before "uspi"
Mail-Followup-To: Miles Lane <miles@megapathdsl.net>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD22590.5010906@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020503060836.ZQUP25781.out004.verizon.net@pool-141-150-238-63.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=athlon 
> -DKBUILD_BASENAME=super  -c -o super.o super.c
> super.c: In function `ufs_fill_super':
> super.c:661: parse error before "uspi"
> super.c:666: parse error before "uspi"
> super.c:676: parse error before "uspi"
> super.c:681: parse error before "uspi"
> make[3]: *** [super.o] Error 1
> make[3]: Leaving directory `/usr/src/linux/fs/ufs'

The fix has already been posted.  4 missing commas.

--- fs/ufs/super.c.bak	Fri May  3 01:53:30 2002
+++ fs/ufs/super.c	Fri May  3 01:53:54 2002
@@ -663,12 +663,12 @@
 		goto failed;
 	}
 	if (uspi->s_bsize < 512) {
-		printk("ufs_read_super: fragment size %u is too small\n"
+		printk("ufs_read_super: fragment size %u is too small\n",
 			uspi->s_fsize);
 		goto failed;
 	}
 	if (uspi->s_bsize > 4096) {
-		printk("ufs_read_super: fragment size %u is too large\n"
+		printk("ufs_read_super: fragment size %u is too large\n",
 			uspi->s_fsize);
 		goto failed;
 	}
@@ -678,12 +678,12 @@
 		goto failed;
 	}
 	if (uspi->s_bsize < 4096) {
-		printk("ufs_read_super: block size %u is too small\n"
+		printk("ufs_read_super: block size %u is too small\n",
 			uspi->s_fsize);
 		goto failed;
 	}
 	if (uspi->s_bsize / uspi->s_fsize > 8) {
-		printk("ufs_read_super: too many fragments per block (%u)\n"
+		printk("ufs_read_super: too many fragments per block (%u)\n",
 			uspi->s_bsize / uspi->s_fsize);
 		goto failed;
 	}


-- 
Skip
