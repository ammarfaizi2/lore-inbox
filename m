Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267636AbUGWLMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267636AbUGWLMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 07:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267637AbUGWLMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 07:12:24 -0400
Received: from mk-smarthost-4.mail.uk.tiscali.com ([212.74.114.40]:25617 "EHLO
	mk-smarthost-4.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id S267636AbUGWLMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 07:12:02 -0400
From: David M <eseol@tiscali.co.uk>
To: linux-kernel@vger.kernel.org
Subject: xruns and preemptive violations in 2.6.8-rc1-mm1
Date: Fri, 23 Jul 2004 12:21:12 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407231221.12695.eseol@tiscali.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below are a number of alsa xruns and preemptive violations using the 
2.6.8-rc1-mm1 kernel.  

The get user pages appear very regular and predictable when using an audio app 
the other preemptive violations seem to happen when under heavy audio load.

XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c01367aa>] __pagevec_lru_add_active+0xea/0x120
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
 [<c0191d41>] rb_insert_color+0x11/0xf0
 [<c013c7b4>] __vma_link+0x44/0x80
 [<c013c974>] __insert_vm_struct+0x74/0x90
 [<c013cb3a>] vma_adjust+0x1aa/0x390
 [<c013e01c>] split_vma+0xcc/0x120
 [<c013eb28>] mprotect_fixup+0xe8/0x170
 [<c013ecf6>] sys_mprotect+0x146/0x1cc
 [<c010409b>] syscall_call+0x7/0xb
9ms non-preemptible critical section violated 2 ms preempt threshold starting 
at vma_adjust+0xe9/0x390 and ending at vma_adjust+0x1b3/0x390
 [<c01059db>] __dec_preempt_count+0x12b/0x130
 [<c013cb43>] vma_adjust+0x1b3/0x390
 [<c013cb43>] vma_adjust+0x1b3/0x390
 [<c013e01c>] split_vma+0xcc/0x120
 [<c013eb28>] mprotect_fixup+0xe8/0x170
 [<c013ecf6>] sys_mprotect+0x146/0x1cc
 [<c010409b>] syscall_call+0x7/0xb
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
 [<c013b45e>] do_anonymous_page+0x8e/0x180
 [<c013b5b0>] do_no_page+0x60/0x310
 [<c013ba60>] handle_mm_fault+0xe0/0x190
 [<c013a3e1>] get_user_pages+0x161/0x3f0
 [<c013bbc6>] make_pages_present+0x86/0xa0
 [<c013d51c>] do_mmap_pgoff+0x47c/0x6b0
 [<c010a226>] old_mmap+0xd6/0x110
 [<c010409b>] syscall_call+0x7/0xb
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0103e74>] do_signal+0xb4/0x110
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
 [<c014ad0d>] fget_light+0x2d/0x90
 [<c0149f1d>] sys_write+0x1d/0x70
 [<c0105788>] math_state_restore+0x28/0x50
 [<c010409b>] syscall_call+0x7/0xb
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0165d43>] dnotify_parent+0x93/0xc0
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0165d43>] dnotify_parent+0x93/0xc0
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
 [<c013b45e>] do_anonymous_page+0x8e/0x180
 [<c013b5b0>] do_no_page+0x60/0x310
 [<c013ba60>] handle_mm_fault+0xe0/0x190
 [<c013a3e1>] get_user_pages+0x161/0x3f0
 [<c013bbc6>] make_pages_present+0x86/0xa0
 [<c013d51c>] do_mmap_pgoff+0x47c/0x6b0
 [<c010a226>] old_mmap+0xd6/0x110
 [<c010409b>] syscall_call+0x7/0xb
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<c011c5d0>] process_timeout+0x0/0x10
 [<c01109fd>] wake_up_process+0x1d/0x30
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
 [<c0139c52>] zap_pte_range+0x92/0x250
 [<c0110d39>] finish_task_switch+0x29/0x90
 [<c0139e73>] zap_pmd_range+0x63/0x80
 [<c0139ee3>] unmap_page_range+0x53/0x80
 [<c013a016>] unmap_vmas+0x106/0x1d0
 [<c013e509>] exit_mmap+0x79/0x170
 [<c01127f0>] mmput+0x70/0xb0
 [<c011690e>] do_exit+0x14e/0x390
 [<c0116bfe>] do_group_exit+0x3e/0xc0
 [<c010409b>] syscall_call+0x7/0xb
7ms non-preemptible critical section violated 2 ms preempt threshold starting 
at unmap_vmas+0x182/0x1d0 and ending at unmap_vmas+0x167/0x1d0
 [<c01059db>] __dec_preempt_count+0x12b/0x130
 [<c013a077>] unmap_vmas+0x167/0x1d0
 [<c013a077>] unmap_vmas+0x167/0x1d0
 [<c013e509>] exit_mmap+0x79/0x170
 [<c01127f0>] mmput+0x70/0xb0
 [<c011690e>] do_exit+0x14e/0x390
 [<c0116bfe>] do_group_exit+0x3e/0xc0
 [<c010409b>] syscall_call+0x7/0xb
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<c010601b>] do_IRQ+0xeb/0x130
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
 [<c013b45e>] do_anonymous_page+0x8e/0x180
 [<c013b5b0>] do_no_page+0x60/0x310
 [<c013ba60>] handle_mm_fault+0xe0/0x190
 [<c013a3e1>] get_user_pages+0x161/0x3f0
 [<c013bbc6>] make_pages_present+0x86/0xa0
 [<c013c044>] mlock_fixup+0xb4/0xd0
 [<c013c31f>] do_mlockall+0x7f/0x90
 [<c013c3c9>] sys_mlockall+0x99/0xa0
 [<c010409b>] syscall_call+0x7/0xb
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
 [<c013b45e>] do_anonymous_page+0x8e/0x180
 [<c013b5b0>] do_no_page+0x60/0x310
 [<c013ba60>] handle_mm_fault+0xe0/0x190
 [<c013a3e1>] get_user_pages+0x161/0x3f0
 [<c013bbc6>] make_pages_present+0x86/0xa0
 [<c013d51c>] do_mmap_pgoff+0x47c/0x6b0
 [<c010a226>] old_mmap+0xd6/0x110
 [<c010409b>] syscall_call+0x7/0xb
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
 [<c013b45e>] do_anonymous_page+0x8e/0x180
 [<c013b5b0>] do_no_page+0x60/0x310
 [<c013ba60>] handle_mm_fault+0xe0/0x190
 [<c013a3e1>] get_user_pages+0x161/0x3f0
 [<c013bbc6>] make_pages_present+0x86/0xa0
 [<c013d51c>] do_mmap_pgoff+0x47c/0x6b0
 [<c010a226>] old_mmap+0xd6/0x110
 [<c010409b>] syscall_call+0x7/0xb
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
 [<c013007b>] rmqueue_bulk+0x4b/0x80
 [<c01058ce>] __dec_preempt_count+0x1e/0x130
 [<c013a3ba>] get_user_pages+0x13a/0x3f0
 [<c013bbc6>] make_pages_present+0x86/0xa0
 [<c013d51c>] do_mmap_pgoff+0x47c/0x6b0
 [<c010a226>] old_mmap+0xd6/0x110
 [<c010409b>] syscall_call+0x7/0xb
4ms non-preemptible critical section violated 2 ms preempt threshold starting 
at get_user_pages+0x196/0x3f0 and ending at get_user_pages+0x13a/0x3f0
 [<c01059db>] __dec_preempt_count+0x12b/0x130
 [<c013a3ba>] get_user_pages+0x13a/0x3f0
 [<c013a3ba>] get_user_pages+0x13a/0x3f0
 [<c013bbc6>] make_pages_present+0x86/0xa0
 [<c013d51c>] do_mmap_pgoff+0x47c/0x6b0
 [<c010a226>] old_mmap+0xd6/0x110
 [<c010409b>] syscall_call+0x7/0xb
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<c011c331>] run_timer_softirq+0x111/0x1e0
 [<c011c066>] update_wall_time+0x16/0x40
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c01182cb>] __do_softirq+0x7b/0x80
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
 [<c0140283>] page_remove_rmap+0x23/0x90
 [<c0139cfa>] zap_pte_range+0x13a/0x250
 [<c0139e73>] zap_pmd_range+0x63/0x80
 [<c0139ee3>] unmap_page_range+0x53/0x80
 [<c013a016>] unmap_vmas+0x106/0x1d0
 [<c013e509>] exit_mmap+0x79/0x170
 [<c01127f0>] mmput+0x70/0xb0
 [<c011690e>] do_exit+0x14e/0x390
 [<c0116bfe>] do_group_exit+0x3e/0xc0
 [<c010409b>] syscall_call+0x7/0xb
8ms non-preemptible critical section violated 2 ms preempt threshold starting 
at unmap_vmas+0x182/0x1d0 and ending at unmap_vmas+0x167/0x1d0
 [<c01059db>] __dec_preempt_count+0x12b/0x130
 [<c013a077>] unmap_vmas+0x167/0x1d0
 [<c013a077>] unmap_vmas+0x167/0x1d0
 [<c013e509>] exit_mmap+0x79/0x170
 [<c01127f0>] mmput+0x70/0xb0
 [<c011690e>] do_exit+0x14e/0x390
 [<c0116bfe>] do_group_exit+0x3e/0xc0
 [<c010409b>] syscall_call+0x7/0xb
XRUN: pcmC0D0p
 [<d48b7f77>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<c0133e15>] kmem_freepages+0x85/0xa0
 [<c0133e99>] slab_destroy+0x59/0x80
 [<d48c76ba>] snd_ice1712_interrupt+0x1aa/0x240 [snd_ice1712]
 [<c0105c39>] handle_IRQ_event+0x49/0x80
 [<c0105fc3>] do_IRQ+0x93/0x130
 [<c0104208>] common_interrupt+0x18/0x20
 [<c013e5c3>] exit_mmap+0x133/0x170
 [<c01127f0>] mmput+0x70/0xb0
 [<c011690e>] do_exit+0x14e/0x390
 [<c0116bfe>] do_group_exit+0x3e/0xc0
 [<c010409b>] syscall_call+0x7/0xb

