Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266860AbUGLOr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266860AbUGLOr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUGLOrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:47:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:30207 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266860AbUGLOrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:47:45 -0400
Date: Mon, 12 Jul 2004 07:47:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Instrumenting high latency
Message-ID: <78720000.1089643653@[10.10.2.4]>
In-Reply-To: <40F2A339.6050206@kolivas.org>
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <75270000.1089642258@[10.10.2.4]> <40F29FCF.3070302@kolivas.org> <78220000.1089642803@[10.10.2.4]> <40F2A339.6050206@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This works very nicely standalone getting us this for example with the fixed patch:
> 
> 6ms non-preemptible critical section violated 1 ms preempt threshold starting at exit_mmap+0x1c/0x188 and ending at exit_mmap+0x118/0x188
>   [<c011d769>] dec_preempt_count+0x14f/0x151
>   [<c014d0d4>] exit_mmap+0x118/0x188
>   [<c014d0d4>] exit_mmap+0x118/0x188
>   [<c011df0a>] mmput+0x61/0x7b
>   [<c01226fa>] do_exit+0x142/0x510
>   [<c014c928>] unmap_vma_list+0xe/0x17
>   [<c0122b8a>] do_group_exit+0x41/0xf9
>   [<c0105fd5>] sysenter_past_esp+0x52/0x71
> 
> which then an objdump of the inlined code has allowed us to track it down to this:
> 
>           profile_exit_mmap(mm);
>           lru_add_drain();
> c014cfce:       e8 18 72 ff ff          call   c01441eb <lru_add_drain>
>           spin_lock(&mm->page_table_lock);
> c014cfd3:       e8 16 06 fd ff          call   c011d5ee <inc_preempt_count>
> 
> 
> That's pretty specific. I dont think this comes under the umbrella of statistics as such. Sure it can be modified to do it but I was looking for a tool to find where specific latency hotspots still exist. Of course I'm not capable myself of tackling the actual hotspots but those who code those areas certainly can tackle them knowing what firm data shows.

Guess so. Thought it might be nice to have a measurement of worst case
latencies across various functions ... I'll have a play with it, and see
if I can come up with something.

M.

