Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262883AbTDAWTz>; Tue, 1 Apr 2003 17:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbTDAWTz>; Tue, 1 Apr 2003 17:19:55 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:49487 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262883AbTDAWTy>; Tue, 1 Apr 2003 17:19:54 -0500
Date: Tue, 1 Apr 2003 23:33:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 3/6 use generic_file_llseek
In-Reply-To: <Pine.LNX.4.44.0304012328390.1730-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0304012332181.1730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

default_llseek's use of BKL and not i_sem was recently exposed:
tmpfs should be using generic_file_llseek which guards with i_sem.

--- tmpfs2/mm/shmem.c	Tue Apr  1 21:34:59 2003
+++ tmpfs3/mm/shmem.c	Tue Apr  1 21:35:10 2003
@@ -1749,6 +1749,7 @@
 static struct file_operations shmem_file_operations = {
 	.mmap		= shmem_mmap,
 #ifdef CONFIG_TMPFS
+	.llseek		= generic_file_llseek,
 	.read		= shmem_file_read,
 	.write		= shmem_file_write,
 	.fsync		= simple_sync_file,

