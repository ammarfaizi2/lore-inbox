Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262886AbTDAWV4>; Tue, 1 Apr 2003 17:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262889AbTDAWV4>; Tue, 1 Apr 2003 17:21:56 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:29032 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262886AbTDAWVx>; Tue, 1 Apr 2003 17:21:53 -0500
Date: Tue, 1 Apr 2003 23:35:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 5/6 use cond_resched
In-Reply-To: <Pine.LNX.4.44.0304012328390.1730-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0304012334250.1730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cond_resched each time around the loop in shmem_file_write
and do_shmem_file_read, matching filemap.c.

--- tmpfs4/mm/shmem.c	Tue Apr  1 21:35:21 2003
+++ tmpfs5/mm/shmem.c	Tue Apr  1 21:35:32 2003
@@ -1211,6 +1211,8 @@
 		buf += bytes;
 		if (pos > inode->i_size)
 			inode->i_size = pos;
+
+		cond_resched();
 	} while (count);
 
 	*ppos = pos;
@@ -1302,6 +1304,8 @@
 		page_cache_release(page);
 		if (ret != nr || !desc->count)
 			break;
+
+		cond_resched();
 	}
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;

