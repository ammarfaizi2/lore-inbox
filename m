Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSGUCoc>; Sat, 20 Jul 2002 22:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317627AbSGUCoc>; Sat, 20 Jul 2002 22:44:32 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:17121 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317624AbSGUCob>; Sat, 20 Jul 2002 22:44:31 -0400
Date: Sat, 20 Jul 2002 22:47:33 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200207210247.g6L2lXE13782@devserv.devel.redhat.com>
To: Robert Love <rml@tech9.net>, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] low-latency zap_page_range
In-Reply-To: <mailman.1027196701.28591.linux-kernel2news@redhat.com>
References: <mailman.1027196701.28591.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The lock hold time in zap_page_range is horrid.  This patch breaks the
> work up into chunks and relinquishes the lock after each iteration. 
> This drastically lowers latency by creating a preemption point, as well
> as lowering lock contention. 

>  void zap_page_range(struct vm_area_struct *vma, unsigned long address, unsigned long size)

Arjan sent me something similar, done by AKPM, only he did this a
little differently. He added an argument to zap_page_range
which allowed to work it in the old way, if set. Then, he set it so
all places would use low latency EXCEPT a reading from /dev/zero.
I assume it was some locking somewhere in devices/char/mem.c,
though I was unable to figure which in particular.

Andrew, care to unconfuse me?

-- Pete
