Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266238AbRF3SUj>; Sat, 30 Jun 2001 14:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266241AbRF3SUf>; Sat, 30 Jun 2001 14:20:35 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:34940 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S266238AbRF3SUY>; Sat, 30 Jun 2001 14:20:24 -0400
Date: Sat, 30 Jun 2001 14:20:21 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] bogus fragment in fs/proc/generic.c in 2.4.6-pre8
Message-ID: <Pine.LNX.4.33.0106301417520.10315-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heyo,

This patch removes an unneeded 4x or 8x bloat in the size of
proc_alloc_map that was introduced in the pre8 patch.

		-ben

diff -urN /md0/kernels/2.4/v2.4.6-pre8/fs/proc/generic.c work/fs/proc/generic.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/proc/generic.c	Sat Jun 30 14:04:27 2001
+++ work/fs/proc/generic.c	Sat Jun 30 14:16:39 2001
@@ -190,7 +190,7 @@
 	return 0;
 }

-static unsigned long proc_alloc_map[PROC_NDYNAMIC / 8];
+static unsigned long proc_alloc_map[(PROC_NDYNAMIC + BITS_PER_LONG - 1) / BITS_PER_LONG];

 spinlock_t proc_alloc_map_lock = SPIN_LOCK_UNLOCKED;


