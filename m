Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUJAXPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUJAXPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 19:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUJAXPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 19:15:49 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:23172 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266603AbUJAXOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 19:14:06 -0400
Subject: Re: 2.6.9-rc2-mm4 ps hang ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041001145536.182dada9.akpm@osdl.org>
References: <1096646925.12861.50.camel@dyn318077bld.beaverton.ibm.com>
	 <20041001120926.4d6f58d5.akpm@osdl.org>
	 <1096666140.12861.82.camel@dyn318077bld.beaverton.ibm.com>
	 <20041001145536.182dada9.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-qTA8sm5MLv6L07zm4vmy"
Organization: 
Message-Id: <1096672002.12861.84.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Oct 2004 16:06:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qTA8sm5MLv6L07zm4vmy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-10-01 at 14:55, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > > Can you work out who is holding mmap_sem for writing?
> > > 
> > 
> > grr.. okay. It hangs randomly. Don't we have code to record the holder
> > of a sem somewhere ?
> 
> The full sysrq-T trace should tell us.  All I saw from your initial email
> was two processes stuck in down_read().  That shouldn't happen, so either
> there was another process in down_write() somewhere or we mucked up the
> semaphore (it is corrupted, or someone forget up_write()).
> 

Here is the full sysrq-t output.

Thanks,
Badari



--=-qTA8sm5MLv6L07zm4vmy
Content-Disposition: attachment; filename=stacks
Content-Type: text/plain; name=stacks; charset=UTF-8
Content-Transfer-Encoding: 7bit

SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 0000000000000400     0     1      0     2               (NOTLB)
0000010006451d88 0000000000000002 00000000000000d0 000001019ffa5150 
       000000030000009f 00000101c1361110 00000101c1361448 0000000000000000 
       0000000006451db8 0000000000000216 
Call Trace:<ffffffff80144408>{__mod_timer+344} <ffffffff80445136>{schedule_timeout+166} 
       <ffffffff80143970>{process_timeout+0} <ffffffff8019524b>{do_select+1019} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff80195626>{sys_select+902} 
       <ffffffff8011075e>{system_call+126} 
migration/0   S ffffffff80132e3a     0     2      1             3       (L-TLB)
00000101dffb9e98 0000000000000046 0000010114455ea8 00000101de3932d0 
       000000000000007f 000001019ffa48e0 000001019ffa4c18 0000010114455e98 
       0000010114455ea0 0000000000000212 
Call Trace:<ffffffff8013702b>{migration_thread+555} <ffffffff80136e00>{migration_thread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
ksoftirqd/0   S 0000000000000000     0     3      1             4     2 (L-TLB)
0000010180747f08 0000000000000046 ffffffff808e5680 ffffffff8054f180 
       000000000000009f 000001019ffa4070 000001019ffa43a8 0000000000000000 
       0000000000000000 ffffffff801400f1 
Call Trace:<ffffffff801400f1>{__do_softirq+113} <ffffffff801401b0>{ksoftirqd+0} 
       <ffffffff801401b0>{ksoftirqd+0} <ffffffff801401f5>{ksoftirqd+69} 
       <ffffffff801401b0>{ksoftirqd+0} <ffffffff80150799>{kthread+217} 
       <ffffffff801113af>{child_rip+8} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
migration/1   S ffffffff80132e3a     0     4      1             5     3 (L-TLB)
00000101dffbbe98 0000000000000046 0000010114455ea8 000001019f56c1f0 
       0000000100000081 00000101bffb7190 00000101bffb74c8 0000010114455e98 
       0000010114455ea0 0000000000000212 
Call Trace:<ffffffff8013702b>{migration_thread+555} <ffffffff80136e00>{migration_thread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
ksoftirqd/1   S 0000000000000000     0     5      1             6     4 (L-TLB)
000001000647bf08 0000000000000046 ffffffff808e5680 00000101c13608a0 
       000000010000009f 00000101bffb6920 00000101bffb6c58 0000000000000000 
       0000000000000080 ffffffff801400f1 
Call Trace:<ffffffff801400f1>{__do_softirq+113} <ffffffff801401b0>{ksoftirqd+0} 
       <ffffffff801401b0>{ksoftirqd+0} <ffffffff801401f5>{ksoftirqd+69} 
       <ffffffff801401b0>{ksoftirqd+0} <ffffffff80150799>{kthread+217} 
       <ffffffff801113af>{child_rip+8} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
migration/2   S ffffffff80132e3a     0     6      1             7     5 (L-TLB)
00000101bffb9e98 0000000000000046 00000101144ebea8 000001019f72f550 
       0000000200000081 00000101bffb60b0 00000101bffb63e8 00000101144ebe98 
       00000101144ebea0 0000000000000212 
Call Trace:<ffffffff8013702b>{migration_thread+555} <ffffffff80136e00>{migration_thread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
ksoftirqd/2   S 0000000000000000     0     7      1             8     6 (L-TLB)
000001000647df08 0000000000000046 00000101a0713720 00000101c1360030 
       000000020000009f 00000101dffbd1d0 00000101dffbd508 0000000000000000 
       0000000000000100 ffffffff801400f1 
Call Trace:<ffffffff801400f1>{__do_softirq+113} <ffffffff801401b0>{ksoftirqd+0} 
       <ffffffff801401b0>{ksoftirqd+0} <ffffffff801401f5>{ksoftirqd+69} 
       <ffffffff801401b0>{ksoftirqd+0} <ffffffff80150799>{kthread+217} 
       <ffffffff801113af>{child_rip+8} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
migration/3   S ffffffff80132e3a     0     8      1             9     7 (L-TLB)
000001018075be98 0000000000000046 00000101144ebea8 000001019f72f550 
       0000000300000081 00000101dffbc960 00000101dffbcc98 00000101144ebe98 
       00000101144ebea0 0000000000000212 
Call Trace:<ffffffff8013702b>{migration_thread+555} <ffffffff80136e00>{migration_thread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
ksoftirqd/3   S 0000000000000000     0     9      1            10     8 (L-TLB)
000001000647ff08 0000000000000046 ffffffff808e5680 000001019ffa5150 
       000000030000009f 00000101dffbc0f0 00000101dffbc428 0000000000000000 
       0000000000000180 ffffffff801400f1 
Call Trace:<ffffffff801400f1>{__do_softirq+113} <ffffffff801401b0>{ksoftirqd+0} 
       <ffffffff801401b0>{ksoftirqd+0} <ffffffff801401f5>{ksoftirqd+69} 
       <ffffffff801401b0>{ksoftirqd+0} <ffffffff80150799>{kthread+217} 
       <ffffffff801113af>{child_rip+8} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
events/0      S ffffffff80167320     0    10      1            11     9 (L-TLB)
000001017ff83e58 0000000000000046 000000007ffefc00 ffffffff8054f180 
       000000000000009f 00000101dff0f210 00000101dff0f548 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff80167320>{cache_reap+0} 
       <ffffffff8014bd3e>{worker_thread+270} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff8014bc30>{worker_thread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
events/1      S ffffffff80132e3a     0    11      1            12    10 (L-TLB)
0000010180761e58 0000000000000046 0000000080736000 000001019f72f550 
       0000000100000081 00000101dff0e9a0 00000101dff0ecd8 0000000000000001 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff80167322>{cache_reap+2} 
       <ffffffff80167320>{cache_reap+0} <ffffffff8014bd3e>{worker_thread+270} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff8014bc30>{worker_thread+0} <ffffffff80150799>{kthread+217} 
       <ffffffff801113af>{child_rip+8} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
events/2      S ffffffff80167320     0    12      1            13    11 (L-TLB)
00000101dff19e58 0000000000000046 00000000a0737000 00000101c1360030 
       000000020000009f 00000101dff0e130 00000101dff0e468 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff80167320>{cache_reap+0} 
       <ffffffff8014bd3e>{worker_thread+270} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff8014bc30>{worker_thread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
events/3      S ffffffff80167320     0    13      1            14    12 (L-TLB)
0000010180763e58 0000000000000046 00000000c1374000 000001019ffa5150 
       000000030000009f 000001017ff85250 000001017ff85588 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff80167320>{cache_reap+0} 
       <ffffffff8014bd3e>{worker_thread+270} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff8014bc30>{worker_thread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
khelper       S ffffffff80132e3a     0    14      1            15    13 (L-TLB)
000001017ff87e58 0000000000000046 00000000ffffffff 000001019f62d410 
       000000000000006e 000001017ff849e0 000001017ff84d18 0000000000000001 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff801113a7>{child_rip+0} 
       <ffffffff8014b590>{__call_usermodehelper+0} <ffffffff8014bd3e>{worker_thread+270} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff8014bc30>{worker_thread+0} <ffffffff80150799>{kthread+217} 
       <ffffffff801113af>{child_rip+8} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
kthread       S ffffffff80150640     0    15      1    16      75    14 (L-TLB)
0000010180777e58 0000000000000046 0000010006451870 00000101c1360030 
       000000020000009f 000001017ff84170 000001017ff844a8 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff8014bd3e>{worker_thread+270} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff8014bc30>{worker_thread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
kacpid        S ffffffff80150640     0    16     15            59       (L-TLB)
00000101c13abe58 0000000000000046 00000100dfeda800 00000101c1360030 
       000000020000009f 00000101bff61290 00000101bff615c8 0000000000000000 
       0000000000000016 0000000000010000 
Call Trace:<ffffffff80150640>{keventd_create_kthread+0} <ffffffff8014bd3e>{worker_thread+270} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff8014bc30>{worker_thread+0} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff80150799>{kthread+217} 
       <ffffffff801113af>{child_rip+8} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
kblockd/0     S ffffffff803266c0     0    59     15            60    16 (L-TLB)
00000101bff73e58 0000000000000046 00000100dfedc800 ffffffff8054f180 
       000000000000009f 00000101bff60a20 00000101bff60d58 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff803266c0>{blk_unplug_work+0} 
       <ffffffff8014bd3e>{worker_thread+270} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff8014bc30>{worker_thread+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
kblockd/1     S ffffffff803266c0     0    60     15            61    59 (L-TLB)
00000101c13ade58 0000000000000046 00000100dfedc800 00000101c13608a0 
       000000010000009f 00000101bff601b0 00000101bff604e8 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff803266c0>{blk_unplug_work+0} 
       <ffffffff8014bd3e>{worker_thread+270} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff8014bc30>{worker_thread+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
kblockd/2     S ffffffff803266c0     0    61     15            62    60 (L-TLB)
000001018079be58 0000000000000046 00000100dfe231e8 00000101c1360030 
       000000020000009f 000001000c06b310 000001000c06b648 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff803266c0>{blk_unplug_work+0} 
       <ffffffff8014bd3e>{worker_thread+270} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff8014bc30>{worker_thread+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
kblockd/3     S ffffffff80132e3a     0    62     15            73    61 (L-TLB)
00000101c13afe58 0000000000000046 ffffffff80880fa8 000001019f49c8e0 
       0000000300000088 000001000c06aaa0 000001000c06add8 0000000000000001 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff8032e7e0>{as_work_handler+0} 
       <ffffffff8014bd3e>{worker_thread+270} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff8014bc30>{worker_thread+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
pdflush       S ffffffff80132e3a     0    73     15            74    62 (L-TLB)
000001017ff0dec8 0000000000000046 0000000000000006 000001017ff84170 
       000000020000006e 000001000c06a230 000001000c06a568 ffffffff8013478d 
       ffffffff80550680 0000000000000000 
Call Trace:<ffffffff8013478d>{task_rq_lock+45} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff80164ebb>{pdflush+187} <ffffffff80164e00>{pdflush+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
pdflush       S ffffffff80150640     0    74     15            79    73 (L-TLB)
00000101a07b7ec8 0000000000000046 0000000100086850 00000101c1360030 
       000000020000009f 00000101807cd350 00000101807cd688 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80150640>{keventd_create_kthread+0} <ffffffff80164ebb>{pdflush+187} 
       <ffffffff80164e00>{pdflush+0} <ffffffff80150799>{kthread+217} 
       <ffffffff801113af>{child_rip+8} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
kswapd3       S 0000000000000000     0    75      1            76    15 (L-TLB)
000001017ff0feb8 0000000000000046 0000000000000008 000001019ffa5150 
       000000030000009f 00000101807892d0 0000010180789608 0000000000000000 
       0000000000000003 00000000000206cf 
Call Trace:<ffffffff8016b995>{kswapd+261} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80136db0>{finish_task_switch+64} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff8013805e>{schedule_tail+14} <ffffffff801113af>{child_rip+8} 
       <ffffffff8016b890>{kswapd+0} <ffffffff801113a7>{child_rip+0} 
       
aio/0         S ffffffff80150640     0    79     15            80    74 (L-TLB)
000001017ff23e58 0000000000000046 bff79013bff79013 ffffffff8054f180 
       000000000000009f 00000101807ccae0 00000101807cce18 0000000000000000 
       bff79013bff79013 0000000000010000 
Call Trace:<ffffffff80150640>{keventd_create_kthread+0} <ffffffff8014bd3e>{worker_thread+270} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff8014bc30>{worker_thread+0} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff80150799>{kthread+217} 
       <ffffffff801113af>{child_rip+8} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
kswapd2       S 0000000000000000     0    76      1            77    75 (L-TLB)
00000101807cfeb8 0000000000000046 0000000000000004 00000101c1360030 
       000000020000009f 0000010180788a60 0000010180788d98 0000000000000000 
       0000000000000002 00000000000206d0 
Call Trace:<ffffffff8016b995>{kswapd+261} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80136db0>{finish_task_switch+64} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff8013805e>{schedule_tail+14} <ffffffff801113af>{child_rip+8} 
       <ffffffff8016b890>{kswapd+0} <ffffffff801113a7>{child_rip+0} 
       
kswapd1       S 0000000000000000     0    77      1            78    76 (L-TLB)
00000101a07b9eb8 0000000000000046 0000000000000002 00000101c13608a0 
       000000010000009f 00000101807881f0 0000010180788528 0000000000000000 
       0000000000000001 00000000000206cf 
Call Trace:<ffffffff8016b995>{kswapd+261} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80136db0>{finish_task_switch+64} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff8013805e>{schedule_tail+14} <ffffffff801113af>{child_rip+8} 
       <ffffffff8016b890>{kswapd+0} <ffffffff801113a7>{child_rip+0} 
       
kswapd0       S ffffffff80132e3a     0    78      1            83    77 (L-TLB)
000001017ff11eb8 0000000000000046 0000000000000001 00000101c1361110 
       0000000000000078 00000101c13e3390 00000101c13e36c8 0000000000000013 
       000000000000c27a 00000000000206cf 
Call Trace:<ffffffff8016b995>{kswapd+261} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80136db0>{finish_task_switch+64} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff8013805e>{schedule_tail+14} <ffffffff801113af>{child_rip+8} 
       <ffffffff8016b890>{kswapd+0} <ffffffff801113a7>{child_rip+0} 
       
aio/1         S ffffffff80150640     0    80     15            81    79 (L-TLB)
00000101807d1e58 0000000000000046 0000000000000000 00000101c13608a0 
       000000010000009f 00000101807cc270 00000101807cc5a8 0000000000000000 
       0000000000000000 0000000000010000 
Call Trace:<ffffffff80150640>{keventd_create_kthread+0} <ffffffff8014bd3e>{worker_thread+270} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff8014bc30>{worker_thread+0} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff80150799>{kthread+217} 
       <ffffffff801113af>{child_rip+8} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
aio/2         S ffffffff80132e3a     0    81     15            82    80 (L-TLB)
00000101c13e5e58 0000000000000046 000001017ffc7800 000001017ff84170 
       000000020000006e 00000101a07bb3d0 00000101a07bb708 0000000000000000 
       0000000000015000 0000000000010000 
Call Trace:<ffffffff80150640>{keventd_create_kthread+0} <ffffffff8014bd3e>{worker_thread+270} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff8014bc30>{worker_thread+0} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff80150799>{kthread+217} 
       <ffffffff801113af>{child_rip+8} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
aio/3         S ffffffff80150640     0    82     15           839    81 (L-TLB)
00000101807d3e58 0000000000000046 0000000000000000 000001019ffa5150 
       000000030000009f 00000101a07bab60 00000101a07bae98 0000000000000000 
       0000000000000000 0000000000010000 
Call Trace:<ffffffff80150640>{keventd_create_kthread+0} <ffffffff8014bd3e>{worker_thread+270} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff8014bc30>{worker_thread+0} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff80150799>{kthread+217} 
       <ffffffff801113af>{child_rip+8} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff801506c0>{kthread+0} <ffffffff801113a7>{child_rip+0} 
       
jfsIO         S ffffffff80132e3a     0    83      1            84    78 (L-TLB)
00000101a07ffeb8 0000000000000046 ffffffff80571af0 00000101c1361110 
       0000000000000078 00000101c13e2b20 00000101c13e2e58 ffffffff80571ae0 
       ffffffff80571ae8 0000000000000216 
Call Trace:<ffffffff802a9f67>{jfsIOWait+311} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff801113af>{child_rip+8} 
       <ffffffff802a9e30>{jfsIOWait+0} <ffffffff801113a7>{child_rip+0} 
       
jfsCommit     S ffffffff80132e3a     0    84      1            85    83 (L-TLB)
00000101dfe39eb8 0000000000000046 ffffffff80571af0 00000101c1361110 
       0000000000000078 00000101c13e22b0 00000101c13e25e8 ffffffff80571ae0 
       ffffffff80571ae8 0000000000000216 
Call Trace:<ffffffff802ad872>{jfs_lazycommit+674} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff801113af>{child_rip+8} 
       <ffffffff802ad5d0>{jfs_lazycommit+0} <ffffffff801113a7>{child_rip+0} 
       
jfsCommit     S ffffffff80132e3a     0    85      1            86    84 (L-TLB)
000001019fe1beb8 0000000000000046 ffffffff80571af0 00000101c1361110 
       0000000000000078 000001017ff69410 000001017ff69748 ffffffff80571ae0 
       ffffffff80571ae8 0000000000000216 
Call Trace:<ffffffff802ad872>{jfs_lazycommit+674} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff801113af>{child_rip+8} 
       <ffffffff802ad5d0>{jfs_lazycommit+0} <ffffffff801113a7>{child_rip+0} 
       
jfsCommit     S ffffffff80132e3a     0    86      1            87    85 (L-TLB)
00000101bfe01eb8 0000000000000046 ffffffff80571af0 00000101c1361110 
       0000000000000078 000001017ff68ba0 000001017ff68ed8 ffffffff80571ae0 
       ffffffff80571ae8 0000000000000216 
Call Trace:<ffffffff802ad872>{jfs_lazycommit+674} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff801113af>{child_rip+8} 
       <ffffffff802ad5d0>{jfs_lazycommit+0} <ffffffff801113a7>{child_rip+0} 
       
jfsCommit     S ffffffff80132e3a     0    87      1            88    86 (L-TLB)
00000101dfe3beb8 0000000000000046 ffffffff80571af0 00000101c1361110 
       0000000000000078 000001017ff68330 000001017ff68668 ffffffff80571ae0 
       ffffffff80571ae8 0000000000000216 
Call Trace:<ffffffff802ad872>{jfs_lazycommit+674} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff801113af>{child_rip+8} 
       <ffffffff802ad5d0>{jfs_lazycommit+0} <ffffffff801113a7>{child_rip+0} 
       
jfsSync       S ffffffff80132e3a     0    88      1           674    87 (L-TLB)
000001019fe1dea8 0000000000000046 ffffffff80571af0 00000101c1361110 
       0000000000000078 000001017ff6b450 000001017ff6b788 ffffffff80571ae0 
       ffffffff80571ae8 0000000000000216 
Call Trace:<ffffffff802ae8d2>{jfs_sync+674} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff801113af>{child_rip+8} 
       <ffffffff802ae630>{jfs_sync+0} <ffffffff801113a7>{child_rip+0} 
       
kseriod       S ffffffff80132e3a     0   674      1           718    88 (L-TLB)
000001019fe51ec8 0000000000000046 0000000000000000 00000101c1361110 
       0000000000000078 000001017ff6abe0 000001017ff6af18 ffffffff8014cf79 
       0000000000000000 000001017ff6abe0 
Call Trace:<ffffffff8014cf79>{detach_pid+313} <ffffffff8031903b>{serio_thread+491} 
       <ffffffff80150970>{autoremove_wake_function+0} <ffffffff80136db0>{finish_task_switch+64} 
       <ffffffff80150970>{autoremove_wake_function+0} <ffffffff8013805e>{schedule_tail+14} 
       <ffffffff801113af>{child_rip+8} <ffffffff80318e50>{serio_thread+0} 
       <ffffffff801113a7>{child_rip+0} 
scsi_eh_0     S 0000000000000000     0   718      1           719   674 (L-TLB)
00000100dfe5fdd8 0000000000000046 00000101dff12508 00000101c1360030 
       000000020000009f 00000101a07ba2f0 00000101a07ba628 0000000000000000 
       0000000000000212 0000000000000001 
Call Trace:<ffffffff804440dd>{__down_interruptible+205} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff803261df>{elv_next_request+255} <ffffffff804456d3>{__down_failed_interruptible+53} 
       <ffffffff802be130>{kobject_release+0} <ffffffff8036f035>{.text.lock.scsi_error+45} 
       <ffffffff8013ed45>{do_exit+3093} <ffffffff801113af>{child_rip+8} 
       <ffffffff8036e1b0>{scsi_error_handler+0} <ffffffff801113a7>{child_rip+0} 
       
qla2200_0_dpc S ffffffff80132e3a     0   719      1           752   718 (L-TLB)
00000101bfe8dde8 0000000000000046 0000000000000001 00000101c1361110 
       0000000000000078 000001017ff6a370 000001017ff6a6a8 ffffffff8055dcc0 
       00000101dff103c8 ffffffff80144875 
Call Trace:<ffffffff80144875>{free_uid+21} <ffffffff804440dd>{__down_interruptible+205} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff804456d3>{__down_failed_interruptible+53} 
       <ffffffff8013c59c>{exit_fs+140} <ffffffff803939f2>{.text.lock.qla_os+25} 
       <ffffffff801113af>{child_rip+8} <ffffffff80391970>{qla2x00_do_dpc+0} 
       <ffffffff801113a7>{child_rip+0} 
scsi_eh_1     S ffffffff80132e3a     0   752      1          1720   719 (L-TLB)
000001019fddbdd8 0000000000000046 0000000000000001 00000101c1361110 
       0000000000000078 000001017fef54d0 000001017fef5808 ffffffff8055dcc0 
       00000100dfedbc00 ffffffff80144875 
Call Trace:<ffffffff80144875>{free_uid+21} <ffffffff804440dd>{__down_interruptible+205} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff804456d3>{__down_failed_interruptible+53} 
       <ffffffff8013c59c>{exit_fs+140} <ffffffff8036f035>{.text.lock.scsi_error+45} 
       <ffffffff8013ed45>{do_exit+3093} <ffffffff801113af>{child_rip+8} 
       <ffffffff8036e1b0>{scsi_error_handler+0} <ffffffff801113a7>{child_rip+0} 
       
reiserfs/0    S ffffffff801e8cb0     0   839     15           840    82 (L-TLB)
00000101bf8fde58 0000000000000046 0000000000000000 ffffffff8054f180 
       000000000000009f 000001017fef43f0 000001017fef4728 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff801e8cb0>{flush_async_commits+0} 
       <ffffffff8014bd3e>{worker_thread+270} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff8014bc30>{worker_thread+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
reiserfs/1    S ffffffff801e8cb0     0   840     15           841   839 (L-TLB)
0000010006559e58 0000000000000046 0000000000000000 00000101c13608a0 
       000000010000009f 00000101df97f510 00000101df97f848 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff801e8cb0>{flush_async_commits+0} 
       <ffffffff8014bd3e>{worker_thread+270} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff8014bc30>{worker_thread+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
reiserfs/2    S ffffffff801e8cb0     0   841     15           842   840 (L-TLB)
00000101bf8ffe58 0000000000000046 0000000000000000 00000101c1360030 
       000000020000009f 00000101df97eca0 00000101df97efd8 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff801e8cb0>{flush_async_commits+0} 
       <ffffffff8014bd3e>{worker_thread+270} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff8014bc30>{worker_thread+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
reiserfs/3    S ffffffff80132e3a     0   842     15                 841 (L-TLB)
000001000655be58 0000000000000046 0000000000000000 000001019f72f550 
       0000000300000081 00000101df97e430 00000101df97e768 0000000000000001 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80134733>{__wake_up+67} <ffffffff801e8cb0>{flush_async_commits+0} 
       <ffffffff8014bd3e>{worker_thread+270} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff8014bc30>{worker_thread+0} <ffffffff80150640>{keventd_create_kthread+0} 
       <ffffffff80150799>{kthread+217} <ffffffff801113af>{child_rip+8} 
       <ffffffff80150640>{keventd_create_kthread+0} <ffffffff801506c0>{kthread+0} 
       <ffffffff801113a7>{child_rip+0} 
irqbalance    S 0000000000000000     0  1720      1          3263   752 (NOTLB)
000001017c471ee8 0000000000000006 0000002a9556d000 ffffffff8054f180 
       000000000000009f 000001017c71a960 000001017c71ac98 0000000000000000 
       0000000000000000 0000000000000212 
Call Trace:<ffffffff80144408>{__mod_timer+344} <ffffffff80445136>{schedule_timeout+166} 
       <ffffffff80143970>{process_timeout+0} <ffffffff80144571>{sys_nanosleep+193} 
       <ffffffff8011075e>{system_call+126} 
syslogd       R  running task       0  3263      1          3309  1720 (NOTLB)
klogd         R  running task       0  3309      1          3415  3263 (NOTLB)
portmap       S ffffffff80132e3a     0  3415      1          3419  3309 (NOTLB)
000001019ea75e88 0000000000000006 00000000000000d0 00000101be502230 
       0000000200000089 000001019f62cba0 000001019f62ced8 0000000000000001 
       00000000dffdde80 000001019f62cba0 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150bdc>{add_wait_queue+28} 
       <ffffffff803ea071>{tcp_poll+33} <ffffffff80194d7c>{sys_poll+636} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff8011075e>{system_call+126} 
       
resmgrd       S 0000000000000001     0  3419      1          3449  3415 (NOTLB)
000001017a9c3e88 0000000000000006 00000000000000d0 ffffffff8054f180 
       000000000000009f 000001019e560960 000001019e560c98 0000000000000000 
       00000000df1d1a18 000001019e560960 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150bdc>{add_wait_queue+28} 
       <ffffffff80421a85>{unix_poll+21} <ffffffff80194d7c>{sys_poll+636} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff8011075e>{system_call+126} 
       
slpd          S 0000000000003f80     0  3449      1          3714  3419 (NOTLB)
00000101ddd93d88 0000000000000002 0000000000000001 000001019ffa5150 
       000000030000009f 00000101ddd4f310 00000101ddd4f648 0000000000000000 
       0000001000000000 0000000000000202 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150bdc>{add_wait_queue+28} 
       <ffffffff803c49e5>{datagram_poll+21} <ffffffff8019524b>{do_select+1019} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff80195626>{sys_select+902} 
       <ffffffff8011075e>{system_call+126} 
cupsd         S 000000000000000d     0  3682      1          9809  4006 (NOTLB)
000001017fd75d88 0000000000000006 0000000000000001 00000101c1360030 
       000000020000009f 000001017fef4c60 000001017fef4f98 0000000000000000 
       0000001080150970 0000000000000216 
Call Trace:<ffffffff80144408>{__mod_timer+344} <ffffffff80445136>{schedule_timeout+166} 
       <ffffffff80143970>{process_timeout+0} <ffffffff8019524b>{do_select+1019} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff80195626>{sys_select+902} 
       <ffffffff8011075e>{system_call+126} 
hwscand       S 0000000000000002     0  3714      1          3732  3449 (NOTLB)
00000101ddeaded8 0000000000000006 0000000000000007 000001019ffa5150 
       000000030000009f 000001017a52cae0 000001017a52ce18 0000000000000000 
       0000000000100011 000001017a52cae0 
Call Trace:<ffffffff802b30d1>{sys_msgrcv+657} <ffffffff802b3df8>{sys_msgget+264} 
       <ffffffff8011075e>{system_call+126} 
sshd          S ffffffff80132e3a     0  3732      1 11547    3822  3714 (NOTLB)
000001017b56dd88 0000000000000002 0000000000000001 000001019f72ece0 
       0000000000000087 00000101bf132030 00000101bf132368 00000101bf132030 
       0000001000000000 0000000000000206 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150bdc>{add_wait_queue+28} 
       <ffffffff803ea071>{tcp_poll+33} <ffffffff8019524b>{do_select+1019} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff80195626>{sys_select+902} 
       <ffffffff8011075e>{system_call+126} 
powersaved    S ffffffff80132e3a     0  3822      1          4006  3732 (NOTLB)
000001017ad73d88 0000000000000006 00000000000000d0 000001019e560960 
       0000000000000089 000001017c702c20 000001017c702f58 0000000000000001 
       000000007a816890 000001017c702c20 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150bdc>{add_wait_queue+28} 
       <ffffffff8019524b>{do_select+1019} <ffffffff801949b0>{__pollwait+0} 
       <ffffffff80195626>{sys_select+902} <ffffffff8011075e>{system_call+126} 
       
rpc.mountd    S ffffffff80132e3a     0  4006      1          3682  3822 (NOTLB)
000001017aa37d88 0000000000000006 00000000000000d0 00000101de3325f0 
       0000000000000088 00000101de6c0920 00000101de6c0c58 0000000000000001 
       000000007aa37dbc 00000101de6c0920 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150bdc>{add_wait_queue+28} 
       <ffffffff803ea071>{tcp_poll+33} <ffffffff8019524b>{do_select+1019} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff80195626>{sys_select+902} 
       <ffffffff8011075e>{system_call+126} 
nscd          S 00000101990e3e9c     0  9809      1          9810  3682 (NOTLB)
00000101990e3d78 0000000000000002 0000000000002651 000001019ffa5150 
       000000030000009f 00000101990e1450 00000101990e1788 0000000000000000 
       00000101990e3e68 00000101990e3db8 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80191178>{link_path_walk+3416} 
       <ffffffff80150a83>{prepare_to_wait_exclusive+35} <ffffffff803c52be>{skb_recv_datagram+398} 
       <ffffffff80150970>{autoremove_wake_function+0} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80423cf4>{unix_accept+116} <ffffffff803c02fe>{sys_accept+238} 
       <ffffffff80194e37>{sys_poll+823} <ffffffff801949b0>{__pollwait+0} 
       <ffffffff8011075e>{system_call+126} 
nscd          S 00000101990f5e9c     0  9810      1          9811  9809 (NOTLB)
00000101990f5d78 0000000000000002 00000101990f5cf0 00000101c13608a0 
       000000010000009f 00000101990e0be0 00000101990e0f18 0000000000000000 
       0000000000000000 000001019ffa00b0 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80150a83>{prepare_to_wait_exclusive+35} <ffffffff803c52be>{skb_recv_datagram+398} 
       <ffffffff80150970>{autoremove_wake_function+0} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80423cf4>{unix_accept+116} <ffffffff803c02fe>{sys_accept+238} 
       <ffffffff80194e37>{sys_poll+823} <ffffffff801949b0>{__pollwait+0} 
       <ffffffff8011075e>{system_call+126} 
nscd          S ffffffff80132e3a     0  9811      1          9812  9810 (NOTLB)
0000010199107d78 0000000000000002 0000000000002651 0000010199648170 
       0000000200000089 00000101990e0370 00000101990e06a8 0000010199107e18 
       0000010199107d90 0000000000000040 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150a83>{prepare_to_wait_exclusive+35} 
       <ffffffff803c52be>{skb_recv_datagram+398} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80150970>{autoremove_wake_function+0} <ffffffff80423cf4>{unix_accept+116} 
       <ffffffff803c02fe>{sys_accept+238} <ffffffff80194e37>{sys_poll+823} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff8011075e>{system_call+126} 
       
nscd          S ffffffff80132e3a     0  9812      1          9813  9811 (NOTLB)
000001019910bd78 0000000000000002 0000000000002651 00000101d99cc530 
       0000000300000089 0000010199109490 00000101991097c8 0000000000000000 
       000001019910bd90 0000000000000044 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150a83>{prepare_to_wait_exclusive+35} 
       <ffffffff803c52be>{skb_recv_datagram+398} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80150970>{autoremove_wake_function+0} <ffffffff80423cf4>{unix_accept+116} 
       <ffffffff803c02fe>{sys_accept+238} <ffffffff80194e37>{sys_poll+823} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff8011075e>{system_call+126} 
       
nscd          S ffffffff80132e3a     0  9813      1          9814  9812 (NOTLB)
000001019910dd78 0000000000000002 0000000000002651 00000101d99cc530 
       0000000300000089 0000010199108c20 0000010199108f58 0000000000000000 
       000001019910dd90 000000000000003d 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150a83>{prepare_to_wait_exclusive+35} 
       <ffffffff803c52be>{skb_recv_datagram+398} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80150970>{autoremove_wake_function+0} <ffffffff80423cf4>{unix_accept+116} 
       <ffffffff803c02fe>{sys_accept+238} <ffffffff80194e37>{sys_poll+823} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff8011075e>{system_call+126} 
       
nscd          S ffffffff80132e3a     0  9814      1          9824  9813 (NOTLB)
000001019910fd78 0000000000000002 0000000000002651 00000101990e0be0 
       0000000100000083 00000101991083b0 00000101991086e8 0000000000000000 
       000001019910fd90 0000000000000052 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150a83>{prepare_to_wait_exclusive+35} 
       <ffffffff803c52be>{skb_recv_datagram+398} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80150970>{autoremove_wake_function+0} <ffffffff80423cf4>{unix_accept+116} 
       <ffffffff803c02fe>{sys_accept+238} <ffffffff80194e37>{sys_poll+823} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff8011075e>{system_call+126} 
       
cron          S ffffffff80132e3a     0  9824      1         11025  9814 (NOTLB)
0000010199fe3ee8 0000000000000006 0000000000000000 00000101bd2baea0 
       0000000100000089 00000101998154d0 0000010199815808 00000000415d84fd 
       0000000025420b38 0000000000000212 
Call Trace:<ffffffff80144408>{__mod_timer+344} <ffffffff80445136>{schedule_timeout+166} 
       <ffffffff80143970>{process_timeout+0} <ffffffff80144571>{sys_nanosleep+193} 
       <ffffffff8011075e>{system_call+126} 
mingetty      S 0000010006536d08     0 11025      1         11027  9824 (NOTLB)
00000101b9569d78 0000000000000006 00000100000bf770 000001019ffa5150 
       000000030000009f 000001019f49d150 000001019f49d488 0000000000000000 
       0000000000000216 ffffffff802ccf1f 
Call Trace:<ffffffff802ccf1f>{vgacon_cursor+239} <ffffffff804450ae>{schedule_timeout+30} 
       <ffffffff8030414b>{write_chan+1003} <ffffffff80150bdc>{add_wait_queue+28} 
       <ffffffff803045f9>{read_chan+1081} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff802ff11a>{tty_ldisc_deref+122} 
       <ffffffff802ffafd>{tty_read+253} <ffffffff80181284>{vfs_read+228} 
       <ffffffff801813c3>{sys_read+83} <ffffffff8011075e>{system_call+126} 
       
mingetty      S ffffffff80132e3a     0 11027      1         11028 11025 (NOTLB)
00000101bf74dd78 0000000000000002 0000000000000000 0000010199109490 
       0000000300000084 000001017c71b1d0 000001017c71b508 ffffffff8016948e 
       0000000000000001 00000101c06d65e8 
Call Trace:<ffffffff8016948e>{release_pages+414} <ffffffff804450ae>{schedule_timeout+30} 
       <ffffffff8030414b>{write_chan+1003} <ffffffff80150bdc>{add_wait_queue+28} 
       <ffffffff803045f9>{read_chan+1081} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff802ff11a>{tty_ldisc_deref+122} 
       <ffffffff802ffafd>{tty_read+253} <ffffffff80181284>{vfs_read+228} 
       <ffffffff801813c3>{sys_read+83} <ffffffff8011075e>{system_call+126} 
       
mingetty      D 00000101dfd982a8     0 11028      1         11029 11027 (NOTLB)
00000101b88fbdf8 0000000000000002 0000003000000030 000001019ffa5150 
       000000030000009f 000001019f72e470 000001019f72e7a8 0000000000000000 
       00000000ffffd000 00000000ffffe000 
Call Trace:<ffffffff80445612>{__down_read+130} <ffffffff80131db5>{map_syscall32+53} 
       <ffffffff8012211a>{get_gate_vma+42} <ffffffff801b4d32>{m_stop+18} 
       <ffffffff801b4d86>{m_next+38} <ffffffff801a109b>{seq_read+395} 
       <ffffffff80181284>{vfs_read+228} <ffffffff801813c3>{sys_read+83} 
       <ffffffff8011075e>{system_call+126} 
mingetty      D 00000101dfd992a8     0 11029      1         11030 11028 (NOTLB)
00000101b99d9e38 0000000000000002 00000101b99d9e18 00000101c1360030 
       000000020000009f 000001017ca04d20 000001017ca05058 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80445612>{__down_read+130} <ffffffff801b4e08>{m_start+72} 
       <ffffffff801a0feb>{seq_read+219} <ffffffff80181284>{vfs_read+228} 
       <ffffffff801813c3>{sys_read+83} <ffffffff8011075e>{system_call+126} 
       
mingetty      S ffffffff80132e3a     0 11030      1         11031 11029 (NOTLB)
00000101b89f7d78 0000000000000002 0000000000000000 0000010199109490 
       0000000300000084 00000101d99ccda0 00000101d99cd0d8 ffffffff8016948e 
       0000000000000001 00000101c06f7cf8 
Call Trace:<ffffffff8016948e>{release_pages+414} <ffffffff804450ae>{schedule_timeout+30} 
       <ffffffff8030414b>{write_chan+1003} <ffffffff80150bdc>{add_wait_queue+28} 
       <ffffffff803045f9>{read_chan+1081} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff802ff11a>{tty_ldisc_deref+122} 
       <ffffffff802ffafd>{tty_read+253} <ffffffff80181284>{vfs_read+228} 
       <ffffffff801813c3>{sys_read+83} <ffffffff8011075e>{system_call+126} 
       
mingetty      S ffffffff80132e3a     0 11031      1         11032 11030 (NOTLB)
00000101b9587d78 0000000000000002 0000000000000000 000001017ca04d20 
       0000000200000084 00000101bf336ca0 00000101bf336fd8 ffffffff8016948e 
       0000000000000001 00000101a06d16b0 
Call Trace:<ffffffff8016948e>{release_pages+414} <ffffffff804450ae>{schedule_timeout+30} 
       <ffffffff8030414b>{write_chan+1003} <ffffffff80150bdc>{add_wait_queue+28} 
       <ffffffff803045f9>{read_chan+1081} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff802ff11a>{tty_ldisc_deref+122} 
       <ffffffff802ffafd>{tty_read+253} <ffffffff80181284>{vfs_read+228} 
       <ffffffff801813c3>{sys_read+83} <ffffffff8011075e>{system_call+126} 
       
db2fmcd       D 0000000000000000     0 11032      1          1373 11031 (NOTLB)
00000101b9b9bef8 0000000000000002 0000003700000037 00000101c13608a0 
       000000010000009f 0000010199649250 0000010199649588 0000000000000000 
       0000000000000206 ffffffff801353db 
Call Trace:<ffffffff801353db>{try_to_wake_up+971} <ffffffff80445570>{__down_write+128} 
       <ffffffff80125e7f>{sys32_mmap+143} <ffffffff80124b01>{ia32_sysret+0} 
       
sshd          S ffffffff80132e3a     0 11547   3732 11554   17260       (NOTLB)
000001017ac35d88 0000000000000006 00000000000000d0 000001019f56c1f0 
       0000000000000081 00000101de3932d0 00000101de393608 ffffffff80579c20 
       0000000000000000 0000000000000001 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150bdc>{add_wait_queue+28} 
       <ffffffff803ea071>{tcp_poll+33} <ffffffff8019524b>{do_select+1019} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff80195626>{sys_select+902} 
       <ffffffff8011075e>{system_call+126} 
bash          R  running task       0 11554  11547 11578               (NOTLB)
sh            S 0000000000000000     0 11578  11554 11580   19990       (NOTLB)
000001017c591e78 0000000000000006 000001017b36e000 ffffffff8054f180 
       000000000000009f 00000101bf336430 00000101bf336768 0000000000000000 
       00000101b96ef268 0000000000000000 
Call Trace:<ffffffff8013dec1>{do_wait+3217} <ffffffff80136db0>{finish_task_switch+64} 
       <ffffffff80145111>{do_sigaction+577} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff801451f4>{sys_rt_sigaction+148} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff8011075e>{system_call+126} 
fsstress.sh   S 0000000000000000     0 11580  11578 28374               (NOTLB)
000001017b36fe78 0000000000000006 00000101144ea000 000001019ffa5150 
       000000030000009f 000001019f72f550 000001019f72f888 0000000000000000 
       000001019a5e3768 0000000000000000 
Call Trace:<ffffffff8013dec1>{do_wait+3217} <ffffffff80136db0>{finish_task_switch+64} 
       <ffffffff80145111>{do_sigaction+577} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff801451f4>{sys_rt_sigaction+148} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff8011075e>{system_call+126} 
sh            S 0000000000000000     0 19990  11554 19995   26798 11578 (NOTLB)
00000101782a1e78 0000000000000006 000001017666c000 ffffffff8054f180 
       000000000000009f 00000101bf337510 00000101bf337848 0000000000000000 
       0000010174f44668 0000000000000000 
Call Trace:<ffffffff8013dec1>{do_wait+3217} <ffffffff80136db0>{finish_task_switch+64} 
       <ffffffff80145111>{do_sigaction+577} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff801451f4>{sys_rt_sigaction+148} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff8011075e>{system_call+126} 
fsstress.sh   S 0000000000000000     0 19995  19990 28373               (NOTLB)
000001017666de78 0000000000000002 0000000000000206 ffffffff8054f180 
       000000000000009f 000001019f56c1f0 000001019f56c528 0000000000000000 
       00000101770b12a8 0000000000000007 
Call Trace:<ffffffff8013dec1>{do_wait+3217} <ffffffff80136db0>{finish_task_switch+64} 
       <ffffffff80145111>{do_sigaction+577} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff801451f4>{sys_rt_sigaction+148} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff8011075e>{system_call+126} 
bash          S ffffffff80132e3a     0 26798  11554 30631   21006 19990 (NOTLB)
00000101be41fdf8 0000000000000002 0000000000000001 000001019f62c330 
       0000000300000086 000001017ca05590 000001017ca058c8 ffffffff8016d711 
       800000019d773065 00000101b97e7ff8 
Call Trace:<ffffffff8016d711>{do_wp_page+321} <ffffffff8018d900>{pipe_wait+160} 
       <ffffffff80150970>{autoremove_wake_function+0} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80150c39>{remove_wait_queue+25} <ffffffff8018de90>{pipe_readv+544} 
       <ffffffff8018df3a>{pipe_read+26} <ffffffff80181284>{vfs_read+228} 
       <ffffffff801813c3>{sys_read+83} <ffffffff8011075e>{system_call+126} 
       
bash          S 0000000000000000     0 30631  26798 30632               (NOTLB)
00000101ddabbe78 0000000000000006 0000000000000014 000001019ffa5150 
       000000030000009f 000001019f62c330 000001019f62c668 0000000000000000 
       00000000ffffffff 000001019f62cab8 
Call Trace:<ffffffff8013dec1>{do_wait+3217} <ffffffff80136db0>{finish_task_switch+64} 
       <ffffffff80145111>{do_sigaction+577} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff801451f4>{sys_rt_sigaction+148} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff801107e7>{sysret_signal+28} <ffffffff8011075e>{system_call+126} 
       
ps            D 00000101770b1680     0 30632  30631         30633       (NOTLB)
00000101dda8ddc8 0000000000000002 000000000000000c 00000101c1360030 
       000000020000009f 00000101dda9d690 00000101dda9d9c8 0000000000000000 
       00000101a0002ec0 00000101b97351b0 
Call Trace:<ffffffff80445612>{__down_read+130} <ffffffff80142dda>{access_process_vm+74} 
       <ffffffff801b71fb>{proc_pid_cmdline+123} <ffffffff801b67ab>{proc_info_read+107} 
       <ffffffff80181284>{vfs_read+228} <ffffffff801813c3>{sys_read+83} 
       <ffffffff8011075e>{system_call+126} 
grep          S ffffffff80132e3a     0 30633  30631         30634 30632 (NOTLB)
00000101dd243df8 0000000000000006 0000000000000002 00000101dda9c5b0 
       0000000000000086 00000101dda9ce20 00000101dda9d158 ffffffff80145a65 
       00000101753fd010 0000000000000000 
Call Trace:<ffffffff80145a65>{__dequeue_signal+485} <ffffffff8018d900>{pipe_wait+160} 
       <ffffffff80150970>{autoremove_wake_function+0} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff8018de90>{pipe_readv+544} <ffffffff8018df3a>{pipe_read+26} 
       <ffffffff80181284>{vfs_read+228} <ffffffff801813c3>{sys_read+83} 
       <ffffffff801107e7>{sysret_signal+28} <ffffffff8011075e>{system_call+126} 
       
grep          S ffffffff80132e3a     0 30634  30631         30637 30633 (NOTLB)
00000101dd255df8 0000000000000002 0000000000000002 000001017a52c270 
       0000000000000089 00000101dda9c5b0 00000101dda9c8e8 ffffffff80145a65 
       0000010176fdd010 0000000000000000 
Call Trace:<ffffffff80145a65>{__dequeue_signal+485} <ffffffff8018d900>{pipe_wait+160} 
       <ffffffff80150970>{autoremove_wake_function+0} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff8018de90>{pipe_readv+544} <ffffffff8018df3a>{pipe_read+26} 
       <ffffffff80181284>{vfs_read+228} <ffffffff801813c3>{sys_read+83} 
       <ffffffff801107e7>{sysret_signal+28} <ffffffff8011075e>{system_call+126} 
       
wc            S 000001019d52f6f0     0 30637  30631               30634 (NOTLB)
00000101da3a3df8 0000000000000006 0000000000000001 00000101c1360030 
       000000020000009f 00000101da3ab6d0 00000101da3aba08 0000000000000000 
       00000101beb91010 0000000000000000 
Call Trace:<ffffffff8018d900>{pipe_wait+160} <ffffffff80150970>{autoremove_wake_function+0} 
       <ffffffff80150970>{autoremove_wake_function+0} <ffffffff8018de90>{pipe_readv+544} 
       <ffffffff8018df3a>{pipe_read+26} <ffffffff80181284>{vfs_read+228} 
       <ffffffff801813c3>{sys_read+83} <ffffffff801107e7>{sysret_signal+28} 
       <ffffffff8011075e>{system_call+126} 
ps            D 00000101770b1680     0  1373      1               11032 (NOTLB)
00000101bdb3bdc8 0000000000000002 0000000000000000 000001019ffa5150 
       000000030000009f 000001017ca044b0 000001017ca047e8 0000000000000000 
       0000010199649250 ffffffff801b5ba3 
Call Trace:<ffffffff801b5ba3>{pid_revalidate+131} <ffffffff80445612>{__down_read+130} 
       <ffffffff80142dda>{access_process_vm+74} <ffffffff801b71fb>{proc_pid_cmdline+123} 
       <ffffffff801b67ab>{proc_info_read+107} <ffffffff80181284>{vfs_read+228} 
       <ffffffff801813c3>{sys_read+83} <ffffffff8011075e>{system_call+126} 
       
sshd          S ffffffff80132e3a     0 17260   3732 19220         11547 (NOTLB)
0000010178815d88 0000000000000002 00000000000000d0 000001019f72f550 
       0000000300000081 000001019f72ece0 000001019f72f018 ffffffff80579c20 
       0000000000000000 0000000000000001 
Call Trace:<ffffffff804450ae>{schedule_timeout+30} <ffffffff80150bdc>{add_wait_queue+28} 
       <ffffffff803ea071>{tcp_poll+33} <ffffffff8019524b>{do_select+1019} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff80195626>{sys_select+902} 
       <ffffffff8011075e>{system_call+126} 
bash          S 0000000000000000     0 19220  17260 20044               (NOTLB)
000001017887be78 0000000000000006 00000101ba78a000 00000101c1360030 
       000000020000009f 000001019f62d410 000001019f62d748 0000000000000000 
       0000010174f45328 0000000000000000 
Call Trace:<ffffffff8013dec1>{do_wait+3217} <ffffffff80136db0>{finish_task_switch+64} 
       <ffffffff80135400>{default_wake_function+0} <ffffffff80135400>{default_wake_function+0} 
       <ffffffff8011075e>{system_call+126} 
top           S 0000000000000001     0 20044  19220                     (NOTLB)
00000101ba78bd88 0000000000000006 0000001000000216 ffffffff8054f180 
       000000000000009f 00000101de6c00b0 00000101de6c03e8 0000000000000000 
       0000000000000000 0000000000000216 
Call Trace:<ffffffff80144408>{__mod_timer+344} <ffffffff80445136>{schedule_timeout+166} 
       <ffffffff80143970>{process_timeout+0} <ffffffff8019524b>{do_select+1019} 
       <ffffffff801949b0>{__pollwait+0} <ffffffff80195626>{sys_select+902} 
       <ffffffff8011075e>{system_call+126} 
ps            D ffffffff80132e3a     0 21006  11554               26798 (NOTLB)
0000010117609dc8 0000000000000006 0000000000000000 00000101d99cc530 
       0000000200000089 000001019f49c8e0 000001019f49cc18 00000101b97351b0 
       0000010199649250 ffffffff801b5ba3 
Call Trace:<ffffffff801b5ba3>{pid_revalidate+131} <ffffffff80445612>{__down_read+130} 
       <ffffffff80142dda>{access_process_vm+74} <ffffffff801b71fb>{proc_pid_cmdline+123} 
       <ffffffff801b67ab>{proc_info_read+107} <ffffffff80181284>{vfs_read+228} 
       <ffffffff801813c3>{sys_read+83} <ffffffff8011075e>{system_call+126} 
       
mkdir         R  running task       0 28373  19995                     (L-TLB)
fsstress.sh   R  running task       0 28374  11580                     (NOTLB)

--=-qTA8sm5MLv6L07zm4vmy--

