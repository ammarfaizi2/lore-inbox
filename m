Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264966AbUD3AIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUD3AIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 20:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265028AbUD3AIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 20:08:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:37624 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264966AbUD3AII
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 20:08:08 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: libata + siI3112 + 2.6.5-rc3 hang
Date: Fri, 30 Apr 2004 02:08:32 +0200
User-Agent: KMail/1.5.3
Cc: Jeff Garzik <jgarzik@pobox.com>
References: <20040429234258.GA6145@zip.com.au>
In-Reply-To: <20040429234258.GA6145@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404300208.32830.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Probably your drive needs mod15write quirk. please try this.

[PATCH] sata_sil.c: ST3200822AS needs MOD15WRITE quirk

 linux-2.6.6-rc2-bk4-bzolnier/drivers/scsi/sata_sil.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/scsi/sata_sil.c~sata_sil_fix drivers/scsi/sata_sil.c
--- linux-2.6.6-rc2-bk4/drivers/scsi/sata_sil.c~sata_sil_fix	2004-04-30 02:00:37.387289528 +0200
+++ linux-2.6.6-rc2-bk4-bzolnier/drivers/scsi/sata_sil.c	2004-04-30 02:00:53.417852512 +0200
@@ -82,6 +82,7 @@ struct sil_drivelist {
 	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
+	{ "ST3200822AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },

_

On Friday 30 of April 2004 01:42, CaT wrote:
> Just acquired a Seagate 200GB SATA HD (yeah, baby, yeah ;) and hooked
> it up to my onboard Silicon Image iI 3112 SATA Raid controller of my
> Gigabyte nforce2 MB. Things work fine for the most part except when
> heavy IO is done on the drive. Then the system hangs totally with no
> console error msgs displayed. This also happens under Debian sarge's
> 2.4.25 aswell and has occured when I did a mke2fs -c on a partition
> and (twice) with hdparm -tT. The first time hdparm works fine and
> infact clocks the HD at 62MB/s (wowsers!), but the second time the
> system hangs.

It will go down with a quirk :( blame SiI for not providing chipset errata.

> scsi0? I thought it detected it at scsi1? This reminds me. The MB has
> the connector labeled as SATA1 but on bootup it's detected as the primary
> SATA drive.

libata has zero knowledge about legacy ordering and it's GOOD thing.

Cheers,
Bartlomiej

