Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUGMOkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUGMOkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUGMOkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:40:20 -0400
Received: from holomorphy.com ([207.189.100.168]:44437 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265269AbUGMOjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:39:51 -0400
Date: Tue, 13 Jul 2004 07:39:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lenar L?hmus <lenar@vision.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
Message-ID: <20040713143947.GG21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Lenar L?hmus <lenar@vision.ee>, linux-kernel@vger.kernel.org
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F3F0A0.9080100@vision.ee>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 05:24:32PM +0300, Lenar L?hmus wrote:
> My first results with 2.6.8-rc1 + preempt-timing:
> Boot-time:
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at kmap_atomic+0x13/0x70 and ending at kunmap_atomic+0x5/0x20
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at buffered_rmqueue+0xea/0x190 and ending at 
> buffered_rmqueue+0x144/0x190
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at search_by_key+0xe3/0xf70 and ending at do_IRQ+0xec/0x130
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at copy_mm+0x2e6/0x3b0 and ending at copy_mm+0x331/0x3b0
> 11ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at ohci_hub_resume+0x3c/0x350 [ohci_hcd] and ending at 
> ohci_hub_resume+0x79/0x350 [ohci_hcd]
> 14ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at schedule+0x36/0x480 and ending at schedule+0x291/0x480
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at new_inode+0x1a/0x80 and ending at new_inode+0x58/0x80
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at kmap_atomic+0x13/0x70 and ending at kunmap_atomic+0x5/0x20
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at kmap_atomic+0x13/0x70 and ending at kunmap_atomic+0x5/0x20

Boot-time stuff is unlikely to have much done about it. I highly suspect
this is the kmap_atomic() trick for pagecache writes. 1ms is probably
more than your box can handle if so.


On Tue, Jul 13, 2004 at 05:24:32PM +0300, Lenar L?hmus wrote:
> Normal use (logging in, browsing, playing video with mplayer, moving 
> windows around, etc):
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at search_by_key+0xe3/0xf70 and ending at 
> smp_apic_timer_interrupt+0x9a/0xe0
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at do_munmap+0xd2/0x140 and ending at do_munmap+0xeb/0x140
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at kmap_atomic+0x13/0x70 and ending at kunmap_atomic+0x5/0x20
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at __d_lookup+0x66/0x170 and ending at __d_lookup+0x9c/0x170
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at kmap_atomic+0x13/0x70 and ending at kunmap_atomic+0x5/0x20
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at copy_mm+0x2e6/0x3b0 and ending at copy_mm+0x331/0x3b0
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at find_get_page+0x14/0x60 and ending at find_get_page+0x2f/0x60
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at dev_queue_xmit+0x7f/0x320 and ending at 
> dev_queue_xmit+0x27f/0x320
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at dev_queue_xmit+0x7f/0x320 and ending at 
> dev_queue_xmit+0x27f/0x320
> 49ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at snd_pcm_action_lock_irq+0x1b/0x1d0 [snd_pcm] and ending at 
> snd_pcm_action_lock_irq+0x65/0x1d0 [snd_pcm]
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at do_no_page+0xd5/0x310 and ending at do_no_page+0x178/0x310
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at fget+0x28/0x70 and ending at fget+0x41/0x70
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at sys_ioctl+0x42/0x270 and ending at do_IRQ+0xec/0x130
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at dnotify_parent+0x27/0xc0 and ending at dnotify_parent+0x85/0xc0
> 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at buffered_rmqueue+0xea/0x190 and ending at 
> buffered_rmqueue+0x144/0x190

If you're getting these in find_get_page() and buffered_rmqueue() either
your box is definitely too slow to handle 1ms or sched_clock()'s results
are questionable on your machine. cpufreq?

On Tue, Jul 13, 2004 at 05:24:32PM +0300, Lenar L?hmus wrote:
> What I've excluded (happens all the time):
> 1) 2ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at schedule+0x36/0x480 and ending at do_IRQ+0xec/0x130
> it's 2ms 98%. This really happens all the time. Bogus?

Wild guess is that you took an IRQ in dec_preempt_count() and that threw
your results off. Let me know if the patch below helps at all. My guess
is it'll cause more apparent problems than it solves.


On Tue, Jul 13, 2004 at 05:24:32PM +0300, Lenar L?hmus wrote:
> 2) 49ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at sys_ioctl+0x42/0x270 and ending at sys_ioctl+0xbd/0x270
> 40-50 ms most of the time, 12 ms couple of times.
> Let me now if you need those traces for some of these (I've built kernel 
> with 8K stacks).

ioctl() is typically grossly inefficient and even involves the BKL.


-- wli

Index: timing-2.6.8-rc1/kernel/sched.c
===================================================================
--- timing-2.6.8-rc1.orig/kernel/sched.c
+++ timing-2.6.8-rc1/kernel/sched.c
@@ -4069,22 +4069,33 @@
 
 void touch_preempt_timing(void)
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
 	if (preempt_count() > 0 && system_state == SYSTEM_RUNNING &&
 						__get_cpu_var(preempt_entry))
 		__touch_preempt_timing(__builtin_return_address(0));
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(touch_preempt_timing);
 
 void inc_preempt_count(void)
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
 	preempt_count()++;
 	if (preempt_count() == 1 && system_state == SYSTEM_RUNNING)
 		__touch_preempt_timing(__builtin_return_address(0));
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(inc_preempt_count);
 
 void dec_preempt_count(void)
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
 	if (preempt_count() == 1 && system_state == SYSTEM_RUNNING &&
 					__get_cpu_var(preempt_entry)) {
 		u64 hold;
@@ -4108,6 +4119,7 @@
 		__get_cpu_var(preempt_entry) = 0;
 	}
 	preempt_count()--;
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(dec_preempt_count);
 #endif
