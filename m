Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVCUSTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVCUSTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 13:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCUSTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 13:19:24 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:7174 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261445AbVCUSTP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 13:19:15 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] FAT: Fix msdos ->[ac]{date,time}
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Mar 2005 03:19:08 +0900
Message-ID: <87is3k276r.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MSDOS doesn't have ->adate and ->c{date,time}, those should be filled
by zero.

This fixes my recent changes.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/msdos/namei.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN fs/msdos/namei.c~fat_msdos-zeroed-adate fs/msdos/namei.c
--- linux-2.6.12-rc1/fs/msdos/namei.c~fat_msdos-zeroed-adate	2005-03-20 02:59:21.000000000 +0900
+++ linux-2.6.12-rc1-hirofumi/fs/msdos/namei.c	2005-03-20 02:59:21.000000000 +0900
@@ -266,9 +266,11 @@ static int msdos_add_entry(struct inode 
 		de.attr |= ATTR_HIDDEN;
 	de.lcase = 0;
 	fat_date_unix2dos(ts->tv_sec, &time, &date);
-	de.time = de.ctime = time;
-	de.date = de.cdate = de.adate = date;
+	de.cdate = de.adate = 0;
+	de.ctime = 0;
 	de.ctime_cs = 0;
+	de.time = time;
+	de.date = date;
 	de.start = cpu_to_le16(cluster);
 	de.starthi = cpu_to_le16(cluster >> 16);
 	de.size = 0;
_
