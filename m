Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273824AbRI0TCJ>; Thu, 27 Sep 2001 15:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273826AbRI0TB7>; Thu, 27 Sep 2001 15:01:59 -0400
Received: from [204.177.156.37] ([204.177.156.37]:35525 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S273824AbRI0TBq>; Thu, 27 Sep 2001 15:01:46 -0400
Date: Thu, 27 Sep 2001 20:03:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <laughing@shared-source.org>
cc: Rik van Riel <riel@conectiva.com.br>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.9-ac16 swapoff 2*vfree
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0109271956420.1095-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.9-ac16 swapoff warns "Trying to vfree() nonexistent vm area":
the new (outside locks) vfree added, the old (inside) not removed.

Hugh

--- 2.4.9-ac16/mm/swapfile.c	Thu Sep 27 19:10:00 2001
+++ linux/mm/swapfile.c	Thu Sep 27 19:43:12 2001
@@ -636,7 +636,6 @@
 	p->swap_device = 0;
 	p->max = 0;
 	swap_map = p->swap_map;
-	vfree(p->swap_map);
 	p->swap_map = NULL;
 	p->flags = 0;
 	swap_device_unlock(p);

