Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVCaQO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVCaQO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVCaQO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:14:56 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:32487 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261533AbVCaQOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:14:34 -0500
To: linux-kernel@vger.kernel.org
cc: ak@suse.de, Ian.Pratt@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Incorrect comment in leave_mm()?
Date: Thu, 31 Mar 2005 17:14:30 +0100
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1DH2JS-00021o-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a question regarding the per-cpu tlbstate logic that is used to
lazily switch to the swapper_pgdir when running a process with no
mm_struct of its own.

There is a comment in arch/i386/kernel/smp.c:leave_mm() that
states 'We need to reload %cr3 since the page tables may be going away
from under us'. AFAICT this is not true -- the currently-running task
holds a reference on the active_mm until it is context-switched off
the CPU, at which point the reference is dropped in
sched.c:finish_task_switch(). Until that point the pgd cannot be
freed and so kernel mappings should remain valid to use. 

Although the corresponding function in arch/x86_64 doesn't include
this comment, Andi Kleen recently modified it to switch to the
swapper_pg_dir, instead of doing a simple __flush_tlb. Does this mean 
that I am missing something, and the comment in arch/i386 is in fact
correct? 

 Thanks,
 Keir
