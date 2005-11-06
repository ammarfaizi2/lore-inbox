Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVKFFVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVKFFVk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 00:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVKFFVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 00:21:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34004 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932286AbVKFFVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 00:21:40 -0500
Date: Sat, 5 Nov 2005 21:21:33 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Does shmem_getpage==>shmem_alloc_page==>alloc_page_vma hold
 mmap_sem?
Message-Id: <20051105212133.714da0d2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

The comment in mm/mempolicy.c for alloc_page_vma() states:

  Should be called with the mm_sem of the vma hold.

However it seems that the call chain (#ifdef CONFIG_NUMA):

  shmem_getpage ==> shmem_alloc_page ==> alloc_page_vma

where shmem_getpage() is called from many of the mm/shmem.c file
operations, is called without holding mmap_sem.  There is no
mention of mmap_sem in the entire mm/shmem.c file.

This doesn't seem right.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
