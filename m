Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVDDViz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVDDViz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVDDVby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:31:54 -0400
Received: from host201.dif.dk ([193.138.115.201]:6405 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261421AbVDDV3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:29:10 -0400
Date: Mon, 4 Apr 2005 23:31:35 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: David Howells <dhowells@redhat.com>
Subject: [PATCH] no need to cast pointer to (void *) when passing it to
 kfree()
Message-ID: <Pine.LNX.4.62.0504042326220.2496@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kfree() takes a void pointer argument, no need to cast.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm4-orig/mm/nommu.c	2005-03-31 21:20:08.000000000 +0200
+++ linux-2.6.12-rc1-mm4/mm/nommu.c	2005-04-04 23:25:23.000000000 +0200
@@ -761,7 +761,7 @@ static void put_vma(struct vm_area_struc
 			if (!(vma->vm_flags & (VM_IO | VM_SHARED)) && vma->vm_start) {
 				realalloc -= kobjsize((void *) vma->vm_start);
 				askedalloc -= vma->vm_end - vma->vm_start;
-				kfree((void *) vma->vm_start);
+				kfree(vma->vm_start);
 			}
 
 			realalloc -= kobjsize(vma);


