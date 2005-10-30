Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVJ3RED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVJ3RED (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 12:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVJ3RED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 12:04:03 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:8900 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932183AbVJ3REC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 12:04:02 -0500
Date: Sun, 30 Oct 2005 19:03:57 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] fix memory leak in sd_mod.o
Message-ID: <20051030170357.GA21497@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle freeing of sd_max_sectors in sd_exit().

Signed-off-by: Dan Aloni <da-x@monatomic.org>

---
commit 94e91dcc1b0903a45642fcb906d8a26c996db277
tree b1d1b44ab4738268f839c83e5e56832124d4b2f3
parent 2afb6d8ea04e81a1547e8e51b7550a8fd69b9fce
author Dan Aloni <da-x@monatomic.org> Sun, 30 Oct 2005 18:56:35 +0200
committer Dan Aloni <da-x@monatomic.org> Sun, 30 Oct 2005 18:56:35 +0200

 drivers/scsi/sd.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1472,6 +1472,7 @@ static void __exit exit_sd(void)
 		kfree(sd_sizes);
 		kfree(sd_blocksizes);
 		kfree(sd_hardsizes);
+		kfree(sd_max_sectors);
 		for (i = 0; i < N_USED_SD_MAJORS; i++) {
 			kfree(sd_gendisks[i].de_arr);
 			kfree(sd_gendisks[i].flags);
@@ -1482,6 +1483,7 @@ static void __exit exit_sd(void)
 		del_gendisk(&sd_gendisks[i]);
 		blksize_size[SD_MAJOR(i)] = NULL;
 		hardsect_size[SD_MAJOR(i)] = NULL;
+		max_sectors[SD_MAJOR(i)] = NULL;
 		read_ahead[SD_MAJOR(i)] = 0;
 	}
 	sd_template.dev_max = 0;




-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net
