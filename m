Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFROG>; Wed, 6 Dec 2000 12:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLFRN4>; Wed, 6 Dec 2000 12:13:56 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:20748 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129183AbQLFRNk>; Wed, 6 Dec 2000 12:13:40 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14894.27665.893145.458412@wire.cadcamlab.org>
Date: Wed, 6 Dec 2000 10:40:49 -0600 (CST)
To: Brian Kress <kressb@fsc-usa.com>
Cc: Roberto Ragusa <robertoragusa@technologist.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel panic in SoftwareRAID autodetection
In-Reply-To: <14893.25967.936504.881427@notabene.cse.unsw.edu.au>
	<yam8375.1358.149393648@a4000>
	<20001205183657.J6567@cadcamlab.org>
	<3A2E3C39.B96B9516@fsc-usa.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Brian Kress <kressb@fsc-usa.com>]
> I got resounding silence to posting the patch last time, so I'm not
> sure if anyone actually wants this patch,

Well, I like it, but admittedly it's mostly in the "cleanup" category
(though it does fix the LVM name issue) so at this point in 2.4 I guess
Linus has more important stuff to worry about.

The best thing about your patch is that by putting the logic back in
the individual drivers, it makes check.c not depend on your module
configuration (so you can compile a disk module, either inside or
outside the kernel tree, without worrying about editing or recompiling
check.c).

> +char *DAC960_disk_name(struct gendisk *hd, int minor, char *buf)
> +char *cciss_disk_name(struct gendisk *hd, int minor, char *buf)
> +char *ida_disk_name(struct gendisk *hd, int minor, char *buf)
> +char* ide_disk_name(struct gendisk *hd, int minor, char *buf)
> +char *lvm_hd_name(struct gendisk *, int, char *);
> +char *lvm_hd_name(struct gendisk *hd, int minor, char *buf)
> +char *md_disk_name(struct gendisk*, int, char *);
> +char * md_disk_name(struct gendisk *hd, int minor, char* buf)
> +char *scsi_disk_name(struct gendisk *hd, int minor, char *buf)

These should all be 'static char *'.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
