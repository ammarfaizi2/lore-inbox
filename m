Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290285AbSA3Rzs>; Wed, 30 Jan 2002 12:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290286AbSA3Rym>; Wed, 30 Jan 2002 12:54:42 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:32292 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S290274AbSA3RxW>; Wed, 30 Jan 2002 12:53:22 -0500
Date: Wed, 30 Jan 2002 17:55:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 18pre7aa1 pagetable corroops
In-Reply-To: <20020130111810.A1309@athlon.random>
Message-ID: <Pine.LNX.4.21.0201301753420.1035-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

clear_pagetable corrupts memory and oopses when CONFIG_HIGHMEM,
but the pagetable has been allocated from low memory.

Hugh

--- 2.4.18-pre7aa1/include/linux/highmem.h	Wed Jan 30 15:30:21 2002
+++ linux/include/linux/highmem.h	Wed Jan 30 15:30:21 2002
@@ -103,7 +103,7 @@
 {
 	void * vaddr = kmap_pagetable(page);
 	clear_page(vaddr);
-	kunmap_high(vaddr);
+	kunmap_vaddr((unsigned long)vaddr);
 }
 
 /*

