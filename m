Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWAJLIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWAJLIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 06:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWAJLIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 06:08:34 -0500
Received: from wine.ocn.ne.jp ([220.111.47.146]:16367 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP id S932192AbWAJLId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 06:08:33 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.15] EXPORT_SYMBOL(__rcuref_hash);
From: Tetsuo Handa <from-linux-kernel@I-love.SAKURA.ne.jp>
Message-Id: <200601102008.CIJ48967.MYPFJGSMtNtVOLSFO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.50]
X-Accept-Language: ja,en
Date: Tue, 10 Jan 2006 20:08:10 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Some kernel modules (for example, unionfs.ko) need __rcuref_hash,
but __rcuref_hash is not exported.
I couldn't build unionfs-20050921-1517-stable.tar.gz for 80386.
The following patch is needed for 2.6.14 and later.

------- start of patch -------
--- before/kernel/rcupdate.c	2006-01-03 12:21:10.000000000 +0900
+++ after/kernel/rcupdate.c	2006-01-10 17:41:32.000000000 +0900
@@ -84,6 +84,7 @@
 spinlock_t __rcuref_hash[RCUREF_HASH_SIZE] = {
 	[0 ... (RCUREF_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
 };
+EXPORT_SYMBOL(__rcuref_hash);
 #endif
 
 /**
------- end of patch -------

Regards.
