Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUDHNvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 09:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUDHNvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 09:51:51 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:63116 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261798AbUDHNvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 09:51:22 -0400
Date: Thu, 8 Apr 2004 14:51:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: rmap: nonlinear truncation
Message-ID: <Pine.LNX.4.44.0404081441480.7010-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you truncate the file beneath a nonlinear vma, your anon_vma
warns in __remove_from_page_cache then BUGs in page_referenced.
My anonmm leaves the pages unfreeable until the vma is unmapped.
pte_chains treats them as anonymous and can swap them out.  None
of us is right (allocating swap violates strict commit accounting).
I think we need to fix nonlinear truncation properly at last, I'm
looking at Daniel's invalidate_mmap_range patch from a month ago,
to see if we can springboard off that.

Hugh

