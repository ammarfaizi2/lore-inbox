Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262400AbSJQXwZ>; Thu, 17 Oct 2002 19:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262413AbSJQXwZ>; Thu, 17 Oct 2002 19:52:25 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13435 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262400AbSJQXwY>; Thu, 17 Oct 2002 19:52:24 -0400
Date: Fri, 18 Oct 2002 00:59:16 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, Matthew Wilcox <willy@debian.org>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 7/9 shmem_getpage flush_dcache
In-Reply-To: <Pine.LNX.4.44.0210180042480.7220-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210180057030.7220-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Matthew Wilcox <willy@debian.org>: shmem_getpage must
flush_dcache_page after allocating and clearing a new page.

--- tmpfs6/mm/shmem.c	Thu Oct 17 22:01:39 2002
+++ tmpfs7/mm/shmem.c	Thu Oct 17 22:01:49 2002
@@ -867,6 +867,7 @@
 		info->alloced++;
 		spin_unlock(&info->lock);
 		clear_highpage(page);
+		flush_dcache_page(page);
 		SetPageUptodate(page);
 	}
 

