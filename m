Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267709AbUJNWYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUJNWYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUJNWRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:17:13 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:25461 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267930AbUJNWN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:13:28 -0400
Message-ID: <f44c5fdf04101415132436b7d1@mail.gmail.com>
Date: Fri, 15 Oct 2004 00:13:27 +0200
From: Radoslaw Szkodzinski <astralstorm@gmail.com>
Reply-To: Radoslaw Szkodzinski <astralstorm@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041014002433.GA19399@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004 02:24:33 +0200, Ingo Molnar <mingo@elte.hu> wrote:
> 
> i'm pleased to announce a significantly improved version of the
> Real-Time Preemption (PREEMPT_REALTIME) feature that i have been working
> towards in the past couple of weeks.
> 
> the patch (against 2.6.9-rc4-mm1) can be downloaded from:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U0
> 

I'm getting some scheduling_while_atomic messages concerning Reiser4.
They're non-fatal, please look into them.

scheduling while atomic: rc/0x04000001/908
caller is cond_resched+0x4c/0x69
 [<c0105666>] dump_stack+0x1e/0x20
 [<c035e40c>] schedule+0x94/0x3f9
 [<c035ec0d>] cond_resched+0x4c/0x69
 [<c012bda7>] _rw_mutex_read_lock+0x1f/0x33
 [<c019e7dd>] cbk_cache_scan_slots+0x5c/0x276
 [<c019ea22>] cbk_cache_search+0x2b/0x5e
 [<c019d84d>] coord_by_handle+0x12/0x29
 [<c019d831>] object_lookup+0xce/0xd8
 [<c01c8dad>] find_entry+0x123/0x2b7
 [<c01c788d>] lookup_name_hashed+0xc3/0x143
 [<c01c7997>] lookup_hashed+0x3e/0xc0
 [<c01a6bdd>] reiser4_lookup+0x83/0x10e
 [<c015e02c>] real_lookup+0x74/0xf4
 [<c015e2cb>] do_lookup+0x5e/0x9d
 [<c015ec7c>] link_path_walk+0x972/0xde6
 [<c015f49e>] path_lookup+0x19a/0x1a6
 [<c015f63a>] __user_walk+0x31/0x53
 [<c015a16d>] vfs_stat+0x1e/0x53
 [<c015a890>] sys_stat64+0x19/0x32
 [<c010509d>] sysenter_past_esp+0x52/0x71
scheduling while atomic: sh/0x04000001/4346
caller is cond_resched+0x4c/0x69
 [<c0105666>] dump_stack+0x1e/0x20
 [<c035e40c>] schedule+0x94/0x3f9
 [<c035ec0d>] cond_resched+0x4c/0x69
 [<c012bda7>] _rw_mutex_read_lock+0x1f/0x33
 [<c019e7dd>] cbk_cache_scan_slots+0x5c/0x276
 [<c019ea22>] cbk_cache_search+0x2b/0x5e
 [<c019d84d>] coord_by_handle+0x12/0x29
 [<c019d831>] object_lookup+0xce/0xd8
 [<c01cfc83>] find_file_item+0x127/0x1bc
 [<c01d1b2e>] read_unix_file+0x2e4/0x48d
 [<c01a74e8>] reiser4_read+0x90/0xaf
 [<c0150abb>] vfs_read+0xe0/0x126
 [<c015b39d>] kernel_read+0x4a/0x57
 [<c017aaeb>] load_elf_binary+0x303/0xba1
 [<c015bfe2>] search_binary_handler+0xd6/0x1f1
 [<c015c2fb>] do_execve+0x1fe/0x2af
 [<c0103c1c>] sys_execve+0x3f/0x91
 [<c010509d>] sysenter_past_esp+0x52/0x71

scheduling while atomic: gcc/0x04000001/5587
caller is cond_resched+0x4c/0x69
 [<c0105666>] dump_stack+0x1e/0x20
 [<c035e40c>] schedule+0x94/0x3f9
 [<c035ec0d>] cond_resched+0x4c/0x69
 [<c012bda7>] _rw_mutex_read_lock+0x1f/0x33
 [<c019e7dd>] cbk_cache_scan_slots+0x5c/0x276
 [<c019ea22>] cbk_cache_search+0x2b/0x5e
 [<c019d84d>] coord_by_handle+0x12/0x29
 [<c019d831>] object_lookup+0xce/0xd8
 [<c01c8dad>] find_entry+0x123/0x2b7
 [<c01c8acb>] rem_entry_hashed+0x75/0x1d5
 [<c01c97cb>] unlink_common+0xd4/0x1ca
 [<c01a6fe0>] unlink_file+0x48/0x75
 [<c01a703a>] reiser4_unlink+0x2d/0x37
 [<c0160d12>] vfs_unlink+0x1d1/0x225
 [<c0160e24>] sys_unlink+0xbe/0x145
 [<c010509d>] sysenter_past_esp+0x52/0x71
scheduling while atomic: xinit/0x04000001/5628
caller is cond_resched+0x4c/0x69
 [<c0105666>] dump_stack+0x1e/0x20
 [<c035e40c>] schedule+0x94/0x3f9
 [<c035ec0d>] cond_resched+0x4c/0x69
 [<c012bda7>] _rw_mutex_read_lock+0x1f/0x33
 [<c019e7dd>] cbk_cache_scan_slots+0x5c/0x276
 [<c019ea22>] cbk_cache_search+0x2b/0x5e
 [<c019d84d>] coord_by_handle+0x12/0x29
 [<c019d831>] object_lookup+0xce/0xd8
 [<c01cfc83>] find_file_item+0x127/0x1bc
 [<c01d1550>] readpage_unix_file+0xb1/0x35b
 [<c01a7961>] reiser4_readpage+0x4d/0x7d
 [<c0134e1e>] page_cache_read+0x72/0xea
 [<c013505d>] filemap_nopage+0x1c7/0x391
 [<c01d21bf>] unix_file_filemap_nopage+0x59/0x84
 [<c01429c9>] do_no_page+0xb5/0x32f
 [<c0142db6>] handle_mm_fault+0x91/0x164
 [<c01133db>] do_page_fault+0x20c/0x654
 [<c0105299>] error_code+0x2d/0x38
