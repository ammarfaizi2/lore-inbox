Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267670AbUHTRJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267670AbUHTRJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268352AbUHTRJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:09:28 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:9106 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267670AbUHTRJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:09:07 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8.1-mm3
Date: Fri, 20 Aug 2004 13:08:30 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201144.49522.jbarnes@engr.sgi.com> <200408201257.42064.jbarnes@engr.sgi.com>
In-Reply-To: <200408201257.42064.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201308.30662.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 12:57 pm, Jesse Barnes wrote:
> I applied wli's per-cpu profiling patch, added some tweaks that he and I
> discussed on irc and things look pretty good.  We can now profile all 512
> CPUs in the system w/o livelocking :)
>
> Here's the output part way through a kernbench run:

In the interest of consistency with my last run and to see if marcelo and 
akpm's fixes made a difference, here's the top 30 profile hits:

[root@ascender root]# time readprofile -n -m System.map-2.6.8.1-mm3 | sort -nr 
| head -30
120535656 total                                     18.6877
53156327 ia64_pal_call_static                     276855.8698
52716600 default_idle                             137282.8125
6122150 ia64_save_scratch_fpregs                 95658.5938
6118803 ia64_load_scratch_fpregs                 95606.2969
1918154 ia64_spinlock_contention                 19980.7708
 92550 collate_per_cpu_profiles                 192.8125
 22281 rcu_check_quiescent_state                 58.0234
 19673 file_move                                 87.8259
 15470 file_kill                                 69.0625
 15417 clear_page                                96.3563
 14668 __d_lookup                                16.3705
 12638 clear_page_tables                          9.6326
 12616 copy_page                                 49.2812
 11772 atomic_dec_and_lock                       45.9844
 11690 memset                                    11.0701
 11415 del_timer_sync                            22.2949
 10952 __copy_user                                4.6884
  9090 xfs_ilock                                 17.7539
  9087 zap_pte_range                              4.7328
  8122 finish_task_switch                        28.2014
  7125 find_get_page                             17.1274
  6288 link_path_walk                             0.6318
  6047 get_zone_counts                           15.7474
  6045 __down_trylock                            18.8906
  5745 _pagebuf_find                              3.9896
  4873 xfs_trans_push_ail                         3.1725
  4613 current_kernel_time                       24.0260
  4200 xfs_iaccess                                4.1016
  4199 fd_install                                14.5799

real    1m32.766s
user    0m0.191s
sys     1m32.592s
