Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268690AbUHTTHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268690AbUHTTHC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268681AbUHTTEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:04:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:59350 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268662AbUHTS7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:59:44 -0400
Date: Fri, 20 Aug 2004 11:55:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Message-Id: <20040820115541.3e68c5be.akpm@osdl.org>
In-Reply-To: <200408201257.42064.jbarnes@engr.sgi.com>
References: <20040820031919.413d0a95.akpm@osdl.org>
	<200408201144.49522.jbarnes@engr.sgi.com>
	<200408201257.42064.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> I applied wli's per-cpu profiling patch, added some tweaks that he and I 
> discussed on irc and things look pretty good.  We can now profile all 512 
> CPUs in the system w/o livelocking :)

OK..

> Here's the output part way through a kernbench run:

(This doesn't sound like the sort of workload which people would buy an
Altix for?)

> [root@ascender root]# time readprofile -m System.map-2.6.8.1-mm3 | sort -nr | 
> head -20
> 62551761 total                                      9.6980
> 27173178 default_idle                             70763.4844

> 27081955 ia64_pal_call_static                     141051.8490
> 3175264 ia64_load_scratch_fpregs                 49613.5000
> 3166434 ia64_save_scratch_fpregs                 49475.5312

What do the above three mean?

> 1603765 ia64_spinlock_contention                 16705.8854

That's 0.04% of total non-idle CPU time.  This seems wrong.

> 135010 rcu_check_quiescent_state                351.5885
>  11457 del_timer_sync                            22.3770
>  10003 clear_page_tables                          7.6242
>   9948 memset                                     9.4205
>   7845 copy_page                                 30.6445
>   7652 __d_lookup                                 8.5402
>   7379 clear_page                                46.1187
>   7177 zap_pte_range                              3.7380
>   6044 __copy_user                                2.5873
>   5168 file_move                                 23.0714
>   4611 xfs_ilock                                  9.0059
>   4230 atomic_dec_and_lock                       16.5234
>   4035 finish_task_switch                        14.0104
>   3938 file_kill                                 17.5804
> 
> real    1m32.554s
> user    0m0.215s
> sys     1m32.375s
