Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUBSPMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 10:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267316AbUBSO6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:58:34 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58340 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267306AbUBSOzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:55:46 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.3 (5/9)
Date: Thu, 19 Feb 2004 15:58:09 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191558.09917.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] kill default_flushcache() and ide_drive_t->flushcache

 linux-2.6.3-root/drivers/ide/ide-disk.c |    1 -
 linux-2.6.3-root/drivers/ide/ide.c      |   15 ---------------
 linux-2.6.3-root/include/linux/ide.h    |    1 -
 3 files changed, 17 deletions(-)

diff -puN drivers/ide/ide.c~ide_default_flushcache drivers/ide/ide.c
--- linux-2.6.3/drivers/ide/ide.c~ide_default_flushcache	2004-02-19 02:10:21.971117024 +0100
+++ linux-2.6.3-root/drivers/ide/ide.c	2004-02-19 02:10:21.986114744 +0100
@@ -2168,20 +2168,6 @@ static int default_cleanup (ide_drive_t 
 	return ide_unregister_subdriver(drive);
 }
 
-/*
- *	Default function to use for the cache flush operation. This
- *	must be replaced for disk devices (see ATA specification
- *	documents on cache flush and drive suspend rules)
- *
- *	If we have no device attached or the device is not writable
- *	this handler is sufficient.
- */
- 
-static int default_flushcache (ide_drive_t *drive)
-{
-	return 0;
-}
-
 static ide_startstop_t default_do_request (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 	ide_end_request(drive, 0, 0);
@@ -2244,7 +2230,6 @@ static ide_startstop_t default_start_pow
 static void setup_driver_defaults (ide_driver_t *d)
 {
 	if (d->cleanup == NULL)		d->cleanup = default_cleanup;
-	if (d->flushcache == NULL)	d->flushcache = default_flushcache;
 	if (d->do_request == NULL)	d->do_request = default_do_request;
 	if (d->end_request == NULL)	d->end_request = default_end_request;
 	if (d->sense == NULL)		d->sense = default_sense;
diff -puN drivers/ide/ide-disk.c~ide_default_flushcache drivers/ide/ide-disk.c
--- linux-2.6.3/drivers/ide/ide-disk.c~ide_default_flushcache	2004-02-19 02:10:21.975116416 +0100
+++ linux-2.6.3-root/drivers/ide/ide-disk.c	2004-02-19 02:10:21.988114440 +0100
@@ -1700,7 +1700,6 @@ static ide_driver_t idedisk_driver = {
 	.busy			= 0,
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idedisk_cleanup,
-	.flushcache		= do_idedisk_flushcache,
 	.do_request		= ide_do_rw_disk,
 	.sense			= idedisk_dump_status,
 	.error			= idedisk_error,
diff -puN include/linux/ide.h~ide_default_flushcache include/linux/ide.h
--- linux-2.6.3/include/linux/ide.h~ide_default_flushcache	2004-02-19 02:10:21.979115808 +0100
+++ linux-2.6.3-root/include/linux/ide.h	2004-02-19 02:10:21.990114136 +0100
@@ -1160,7 +1160,6 @@ typedef struct ide_driver_s {
 	unsigned busy			: 1;
 	unsigned supports_dsc_overlap	: 1;
 	int		(*cleanup)(ide_drive_t *);
-	int		(*flushcache)(ide_drive_t *);
 	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, sector_t);
 	int		(*end_request)(ide_drive_t *, int, int);
 	u8		(*sense)(ide_drive_t *, const char *, u8);

_

