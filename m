Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVHRIxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVHRIxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 04:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVHRIxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 04:53:47 -0400
Received: from wwwmail3.Joensuu.FI ([193.167.41.4]:5819 "EHLO
	wwwmail3.joensuu.fi") by vger.kernel.org with ESMTP id S932128AbVHRIxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 04:53:46 -0400
Message-ID: <1124355224.43044c984be40@wwwmail.joensuu.fi>
Date: Thu, 18 Aug 2005 11:53:44 +0300
From: Valentin Rabinovich <vrabin@cs.joensuu.fi>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: mmap_kmem()
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug in mmap_kmem(), drivers/char/mem.c.
When mapping the kmem, page alingning seems to mess the address:

  unsigned long long val;
  val = (u64)vma->vm_pgoff << PAGE_SHIFT;
  vma->vm_pgoff = ((unsigned long)val >> PAGE_SHIFT) - PAGE_OFFSET;
  vma->vm_pgoff = __pa(val) >> PAGE_SHIFT;

Subtracting 0xc0000000 and shifting is made in wrong order.
Kernel: 2.6.12.3, 2.6.12.4

-- 
Valentin Rabinovich



