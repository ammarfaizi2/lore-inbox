Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935998AbWK1SBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935998AbWK1SBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 13:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936000AbWK1SBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 13:01:25 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:11197 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S935998AbWK1SBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 13:01:24 -0500
X-AuditID: d80ac21c-a2b72bb00000557e-fc-456c797364a5 
Date: Tue, 28 Nov 2006 18:01:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: d binderman <dcb314@hotmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: mm/fremap.c(104): remark #593: variable "pte_val" was set but
 never used    
In-Reply-To: <BAY107-F24D4E1EDA745C0EBACC9139CE60@phx.gbl>
Message-ID: <Pine.LNX.4.64.0611281757150.32539@blonde.wat.veritas.com>
References: <BAY107-F24D4E1EDA745C0EBACC9139CE60@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Nov 2006 18:01:23.0444 (UTC) FILETIME=[37305B40:01C71317]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006, d binderman wrote:
> 
> I just tried to compile Linux kernel 2.6.18.3 with the Intel C
> C compiler.
> 
> The compiler said
> 
> mm/fremap.c(104): remark #593: variable "pte_val" was set but never used
> 
> The source code is
> 
>    pte_t pte_val;
> 
> I have checked the source code and I agree with the compiler.
> Suggest delete local variable.

You're right, thank you, here's a patch...


[PATCH] kill install_file_pte's pte_val

David Binderman and his Intel C compiler rightly observe that
install_file_pte no longer has any use for its pte_val.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/fremap.c |    2 --
 1 file changed, 2 deletions(-)

--- 2.6.19-rc6/mm/fremap.c	2006-11-16 08:22:25.000000000 +0000
+++ linux/mm/fremap.c	2006-11-28 17:50:47.000000000 +0000
@@ -101,7 +101,6 @@ int install_file_pte(struct mm_struct *m
 {
 	int err = -ENOMEM;
 	pte_t *pte;
-	pte_t pte_val;
 	spinlock_t *ptl;
 
 	pte = get_locked_pte(mm, addr, &ptl);
@@ -114,7 +113,6 @@ int install_file_pte(struct mm_struct *m
 	}
 
 	set_pte_at(mm, addr, pte, pgoff_to_pte(pgoff));
-	pte_val = *pte;
 	/*
 	 * We don't need to run update_mmu_cache() here because the "file pte"
 	 * being installed by install_file_pte() is not a real pte - it's a
