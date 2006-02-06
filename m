Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWBFC4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWBFC4r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 21:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWBFC4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 21:56:47 -0500
Received: from cod.sandelman.ca ([192.139.46.139]:44775 "EHLO
	lists.sandelman.ca") by vger.kernel.org with ESMTP id S1750890AbWBFC4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 21:56:46 -0500
From: "Michael Richardson" <mcr@sandelman.ottawa.on.ca>
To: alan@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cast arguments to pr_debug() properly
X-Mailer: MH-E 7.82; nmh 1.1; XEmacs 21.4 (patch 17)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 05 Feb 2006 21:56:00 -0500
Message-ID: <20882.1139194560@sandelman.ottawa.on.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


This does not show up unless you #define DEBUG in the file, which most
people wouldn't do. On PPC405, at least, "sector_t" is unsigned long,
which doesn't match %llx/%llu. Since sector# may well be >32 bits,
promote the value to match the format.

Signed-off-by: Michael Richardson <mcr@xelerance.com>

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 449522f..0e1e0dd 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -190,7 +190,7 @@ static ide_startstop_t __ide_do_rw_disk(
 		if (lba48) {
 			task_ioreg_t tasklets[10];
 
-			pr_debug("%s: LBA=0x%012llx\n", drive->name, block);
+			pr_debug("%s: LBA=0x%012llx\n", drive->name, (unsigned long long)block);
 
 			tasklets[0] = 0;
 			tasklets[1] = 0;
@@ -317,7 +317,7 @@ static ide_startstop_t ide_do_rw_disk (i
 
 	pr_debug("%s: %sing: block=%llu, sectors=%lu, buffer=0x%08lx\n",
 		 drive->name, rq_data_dir(rq) == READ ? "read" : "writ",
-		 block, rq->nr_sectors, (unsigned long)rq->buffer);
+		 (unsigned long long)block, rq->nr_sectors, (unsigned long)rq->buffer);
 
 	if (hwif->rw_disk)
 		hwif->rw_disk(drive, rq);


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUAQ+a6wICLcPvd0N1lAQLXgwf9GeMAfO9yXKfW3urWX11dbc/YIVEtoNwt
Ommt5vH/Ogi2hXzDrtGucTg3vnU+bibp8OkYuu1OPszhWfKlM4v5BzQE3ZGtg7W0
4BKuwWmeHJXnM4ntJhlF44ixQWxYKQnnQqI0XKDMm7Q2NIUEwVNGSKVVLGRvFryo
t1bJl9xW/fB1PHWyOvBcp2YLeAge7wpGIzcuvFNnZiQc/MCKQMH6y7QsFXa6soMk
wTNBGLxWzLiQoku2mvhSL9fSqwYPez2qnV9OSJ0gYwVXWBVYC+YYlkDY9AdHd0yX
H6pN6kAP6hHBXdtVzXk42dQVWrNG0pwFDBefSWe6NXx61qseJAZUnQ==
=49UI
-----END PGP SIGNATURE-----
--=-=-=--
