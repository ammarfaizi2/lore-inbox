Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265644AbUFXPeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbUFXPeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUFXPeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:34:15 -0400
Received: from holomorphy.com ([207.189.100.168]:29066 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265644AbUFXPeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:34:05 -0400
Date: Thu, 24 Jun 2004 08:33:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Yusuf Goolamabbas <yusufg@outblaze.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: finish_task_switch high in profiles in 2.6.7
Message-ID: <20040624153353.GE21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Yusuf Goolamabbas <yusufg@outblaze.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <20040624091548.GA8264@outblaze.com> <40DA9E89.9020801@yahoo.com.au> <20040624093440.GA8422@outblaze.com> <20040624143000.GU1552@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624143000.GU1552@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 07:30:00AM -0700, William Lee Irwin III wrote:
> This doesn't look like very intense context switching in either case. 2.6.7
> appears to be doing less context switching. I don't see a significant
> difference in system time, either.
> Could you please send me complete profiles?

$ awk '{ A[$2] = $1 } END { tot = A["total"]; for (x in A) { if (x != "total") { printf "%4.4f\t%s\n", 100.0*A[x]/tot, x } } }' < /tmp/yusuf-2.6.5 |sort -k 2,2 > /tmp/scaled-2.6.5
$ awk '{ A[$2] = $1 } END { tot = A["total"]; for (x in A) { if (x != "total") { printf "%4.4f\t%s\n", 100.0*A[x]/tot, x } } }' < /tmp/yusuf-2.6.7 |sort -k 2,2 > /tmp/scaled-2.6.7
$ join -1 2 -2 2 -e 0 -a 1 -a 2 /tmp/scaled-2.6.5 /tmp/scaled-2.6.7 | awk 'BEGIN { printf "%%before %%after %%diff func\n" } { A[$1] = $3 ; B[$1] = $2 ; D[$1] = $3 - $2 } END { n = 0; for (x in D) { ++n }; while (n != 0) { z = -1000.0; for (x in D) { if (D[x] > z) { y = x; z = A[x] } }; printf "%8.4f %8.4f %8.4f %s\n", B[y], A[y], D[y], y; delete D[y]; delete A[y]; delete B[y]; --n }; }'
%before %after %diff func
  0.0000  20.1599  20.1599 finish_task_switch
  5.0624  11.8057   6.7433 remove_wait_queue
  3.1585   8.6394   5.4809 add_wait_queue
  4.6310  13.1880   8.5570 __wake_up
  8.5601  14.5557   5.9956 default_idle
  1.6585   5.1191   3.4606 sysenter_past_esp
  0.0000   2.7146   2.7146 find_get_page
  0.6783   2.4149   1.7366 __mod_timer
  0.0000   1.9527   1.9527 do_gettimeofday
  0.0000   1.2470   1.2470 handle_IRQ_event
  0.0000   1.1866   1.1866 do_page_fault
  0.4665   1.5676   1.1011 del_timer
  0.0000   1.0097   1.0097 __do_softirq
  0.0000   0.9909   0.9909 do_sigaction
  0.5854   1.5738   0.9884 del_timer_sync
  0.0000   0.9764   0.9764 do_getitimer
  0.0000   0.9659   0.9659 do_setitimer
  0.0000   0.8161   0.8161 get_offset_tsc
  0.0000   0.7078   0.7078 current_kernel_time
  0.0000   0.6100   0.6100 in_group_p
  9.8078   0.0000  -9.8078 schedule
  3.8536   0.0000  -3.8536 page_remove_rmap
  0.4672   0.0000  -0.4672 free_hot_cold_page
  0.4482   0.0000  -0.4482 __find_get_block
  0.7119   0.0000  -0.7119 __kmalloc
  6.9793   0.0000  -6.9793 fput
 32.0727   0.0000 -32.0727 fget
  0.5465   0.0000  -0.5465 buffered_rmqueue
  0.5450   0.0000  -0.5450 kmem_cache_free
  0.8750   0.0000  -0.8750 kmem_cache_alloc
  0.9687   0.0000  -0.9687 kfree
  1.7187   0.0000  -1.7187 fget_light
