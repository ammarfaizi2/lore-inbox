Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266114AbUHTQ6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUHTQ6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUHTQ6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:58:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56780 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266114AbUHTQ6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:58:03 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8.1-mm3
Date: Fri, 20 Aug 2004 12:57:42 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201144.49522.jbarnes@engr.sgi.com>
In-Reply-To: <200408201144.49522.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201257.42064.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 11:44 am, Jesse Barnes wrote:
> On Friday, August 20, 2004 6:19 am, Andrew Morton wrote:
> > - This is (very) lightly tested.  Mainly a resync with various parties.
>
> Woo-hoo!  This boots *without changes* on a 512p Altix!  Now to re-run the
> profiles and try wli's new per-cpu profiling buffers.

I applied wli's per-cpu profiling patch, added some tweaks that he and I 
discussed on irc and things look pretty good.  We can now profile all 512 
CPUs in the system w/o livelocking :)

Here's the output part way through a kernbench run:

[root@ascender root]# time readprofile -m System.map-2.6.8.1-mm3 | sort -nr | 
head -20
62551761 total                                      9.6980
27173178 default_idle                             70763.4844
27081955 ia64_pal_call_static                     141051.8490
3175264 ia64_load_scratch_fpregs                 49613.5000
3166434 ia64_save_scratch_fpregs                 49475.5312
1603765 ia64_spinlock_contention                 16705.8854
135010 rcu_check_quiescent_state                351.5885
 11457 del_timer_sync                            22.3770
 10003 clear_page_tables                          7.6242
  9948 memset                                     9.4205
  7845 copy_page                                 30.6445
  7652 __d_lookup                                 8.5402
  7379 clear_page                                46.1187
  7177 zap_pte_range                              3.7380
  6044 __copy_user                                2.5873
  5168 file_move                                 23.0714
  4611 xfs_ilock                                  9.0059
  4230 atomic_dec_and_lock                       16.5234
  4035 finish_task_switch                        14.0104
  3938 file_kill                                 17.5804

real    1m32.554s
user    0m0.215s
sys     1m32.375s
