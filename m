Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVLEVEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVLEVEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbVLEVEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:04:44 -0500
Received: from web34106.mail.mud.yahoo.com ([66.163.178.104]:28040 "HELO
	web34106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751466AbVLEVEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:04:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NmNff98oVbL2eUZIchurEq/6rn+Ma4BZhYfEwFl8XM/3YmjLU4+xpsVy23ohUyWeKsVJK3gnDC6nH5eTlpnZGznqY0v4QqEhvP62tkkSwujpzMEqVdigm9zv53jmL18eIbVCfF/Cudx+LvAW93UbLmeTsOHKzOxaGlifxvsRjRk=  ;
Message-ID: <20051205210442.17357.qmail@web34106.mail.mud.yahoo.com>
Date: Mon, 5 Dec 2005 13:04:41 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: nfs unhappiness with memory pressure
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1133814806.12393.10.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1591606237-1133816681=:17027"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1591606237-1133816681=:17027
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > Can somebody VM-savvy please explain how on earth they expect something
> > like throttle_vm_writeout() to make progress? Shouldn't that thing at
> > the very least be kicking pdflush every time it loops?
> 
> Can you try something like this patch, Kenny?
> 
> Cheers,
>   Trond
> 
> 
> > VM: Ensure that throttle_vm_writeout() can make progress

No change. :(

-Kenny


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

--0-1591606237-1133816681=:17027
Content-Type: text/x-log; name="sysrq.log"
Content-Description: 3165733884-sysrq.log
Content-Disposition: inline; filename="sysrq.log"

[  120.491185] SysRq : Show Regs
[  120.494350] 
[  120.495933] Pid: 0, comm:              swapper
[  120.500590] EIP: 0060:[<c0100d4f>] CPU: 3
[  120.504798] EIP is at default_idle+0x36/0x56
[  120.509273]  EFLAGS: 00000246    Not tainted  (2.6.15-rc5+nfs+k2)
[  120.515656] EAX: 00000000 EBX: c2338000 ECX: c22262e0 EDX: c2338000
[  120.522219] ESI: c053c380 EDI: c053c300 EBP: c2338f84 DS: 007b ES: 007b
[  120.529197] CR0: 8005003b CR2: b7d3f000 CR3: 36b4d000 CR4: 000006d0
[  122.665018] SysRq : Show State
[  122.668281] 
[  122.668282]                                                sibling
[  122.676341]   task             PC      pid father child younger older
[  122.683084] init          D 00000001     0     1      0     2               (NOTLB)
[  122.691406] c2331ce8 c2331cd8 00000004 00000001 c019afa7 c2331c9c c015c8cd f71c0a14 
[  122.699584]        00000000 c2330550 00022f80 00000000 00000202 c2217fe0 c2331cfc 00000202 
[  122.708671]        c2217fe0 c2331cfc c2217560 00000001 00000133 8d20aa2d 0000001c c2330550 
[  122.717755] Call Trace:
[  122.720557]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  122.725825]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  122.731357]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  122.736895]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  122.742524]  [<c014714d>] shrink_zone+0xe0/0xfa
[  122.747339]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  122.752333]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  122.757777]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  122.762951]  [<c013fc2a>] __get_free_pages+0x2c/0x4f
[  122.768215]  [<c016c561>] __pollwait+0x3a/0xae
[  122.772942]  [<c0166016>] pipe_poll+0x36/0xad
[  122.777579]  [<c016c8d1>] do_select+0x217/0x26e
[  122.782395]  [<c016cbc9>] sys_select+0x26a/0x3f7
[  122.787301]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  122.792658] migration/0   S 00000002     0     2      1             3       (L-TLB)
[  122.800978] c2339f94 c2339f84 00000004 00000002 c0116b9c c2337a70 c2227a20 00000001 
[  122.809158]        c220f5ac 00000001 00000073 c220f958 c220f958 c2227a20 c220f5a8 00000000 
[  122.818241]        c2227560 00000003 c220f560 00000000 00003394 026b476a 0000000e c048db40 
[  122.827324] Call Trace:
[  122.830125]  [<c0118d0c>] migration_thread+0x81/0x10d
[  122.835478]  [<c012fe68>] kthread+0xb7/0xbc
[  122.839934]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  122.845377] ksoftirqd/0   S 00000002     0     3      1             4     2 (L-TLB)
[  122.853697] c233af98 c233af88 00000004 00000002 000004d3 000e12b9 00000000 c233ba70 
[  122.861880]        c2337030 c2357a70 00000001 c2331f5c c2330a70 ffffffff c2337030 c233af6c 
[  122.870964]        00000000 00000000 c220f560 00000000 00000129 0678d7c6 00000004 c048db40 
[  122.880048] Call Trace:
[  122.882849]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  122.887484]  [<c012fe68>] kthread+0xb7/0xbc
[  122.891939]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  122.897384] migration/1   S 00000001     0     4      1             5     3 (L-TLB)
[  122.905700] c233cf94 c233cf80 00000004 00000001 00000082 00000001 c233cf44 00000000 
[  122.913876]        c048db40 c2337a70 00000003 c2227560 f78b7a70 00000005 00000008 f78b7a70 
[  122.922961]        00000000 c2217ec0 c2217560 00000001 00001493 42f120b6 00000009 f78b7a70 
[  122.932040] Call Trace:
[  122.934842]  [<c0118d0c>] migration_thread+0x81/0x10d
[  122.940194]  [<c012fe68>] kthread+0xb7/0xbc
[  122.944648]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  122.950091] ksoftirqd/1   S 00000001     0     5      1             6     4 (L-TLB)
[  122.958412] c2345f98 c2345f88 00000004 00000001 000000bd 00180d6e 00000000 c233b550 
[  122.966589]        c233b550 c2330a70 00000001 c2331f28 c2345000 ffffffff c233b550 c2345f6c 
[  122.975671]        c0407ed4 c22175a8 c2217560 00000001 000001ab 2fca1753 00000000 c2330550 
[  122.984759] Call Trace:
[  122.987575]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  122.992235]  [<c012fe68>] kthread+0xb7/0xbc
[  122.996717]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.002192] migration/2   S 00000004     0     6      1             7     5 (L-TLB)
[  123.010514] c2346f94 c2346f80 00000004 00000004 00000082 c2330550 c22175a8 f78a8700 
[  123.018737]        f7b7a550 c2330550 00000001 c2217560 f7a54030 000000b9 00000002 f7a54030 
[  123.027869]        00000000 c221fec0 c221f560 00000002 00001664 25534bef 00000006 f7a54030 
[  123.036999] Call Trace:
[  123.039816]  [<c0118d0c>] migration_thread+0x81/0x10d
[  123.045199]  [<c012fe68>] kthread+0xb7/0xbc
[  123.049680]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.055157] ksoftirqd/2   S 00000002     0     7      1             8     6 (L-TLB)
[  123.063480] c234df98 c234ca70 c221f560 00000002 00000164 00275ccf 00000000 c234ca70 
[  123.071701]        c234ca70 c234cb9c 00000001 c2331f28 c234d000 ffffffff c234ca70 c234df6c 
[  123.080829]        c0407ed4 c221f5a8 c221f560 00000002 00000045 00275f43 00000000 c2330030 
[  123.089958] Call Trace:
[  123.092774]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  123.097437]  [<c012fe68>] kthread+0xb7/0xbc
[  123.101916]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.107386] migration/3   S 00000003     0     8      1             9     7 (L-TLB)
[  123.115706] c234ef94 c234ef80 00000004 00000003 00000082 f7120550 c221fa20 00000000 
[  123.123926]        c2330030 c2330550 00000001 c2217560 f7ae1a70 00000012 00000002 f7ae1a70 
[  123.133057]        00000000 c2227ec0 c2227560 00000003 00000eff 529edf4c 00000008 f7ae1a70 
[  123.142186] Call Trace:
[  123.145001]  [<c0118d0c>] migration_thread+0x81/0x10d
[  123.150384]  [<c012fe68>] kthread+0xb7/0xbc
[  123.154864]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.160337] ksoftirqd/3   S 00000003     0     9      1            10     8 (L-TLB)
[  123.168657] c2353f98 c2353f88 00000004 00000003 000000c0 003698fe 00000000 c234c030 
[  123.176873]        c234c030 c2361550 00000001 c2331f28 c2353000 ffffffff c234c030 c2353f6c 
[  123.185990]        c0407ed4 c22275a8 c2227560 00000003 0000014c 4497dad4 00000003 c2337a70 
[  123.195074] Call Trace:
[  123.197865]  [<c0121786>] ksoftirqd+0xd6/0xf5
[  123.202473]  [<c012fe68>] kthread+0xb7/0xbc
[  123.206901]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.212312] events/0      S 00000002     0    10      1            11     9 (L-TLB)
[  123.220639] c2358f34 c2358f24 00000004 00000002 c220ffe0 00000202 c2358ef0 c0124bab 
[  123.228773]        c220ffe0 f7a38398 00000202 00000002 f7a38380 f7a38000 c2358f00 c0124c50 
[  123.237801]        c23489b0 c23489a8 c220f560 00000000 00003db9 af434da0 0000001c c048db40 
[  123.246831] Call Trace:
[  123.249615]  [<c012bd90>] worker_thread+0x207/0x225
[  123.254760]  [<c012fe68>] kthread+0xb7/0xbc
[  123.259189]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.264603] events/1      S 00000001     0    11      1            12    10 (L-TLB)
[  123.272924] c236af34 c236af24 00000004 00000001 00000202 00000001 c2354540 000007d0 
[  123.281057]        c236aef4 c012bb5c c22191b8 fffd55d5 00000000 c2300780 c22191a4 c236aefc 
[  123.290162]        c2348930 c2348928 c2217560 00000001 000005d9 533d40e5 0000001c c2330550 
[  123.299292] Call Trace:
[  123.302109]  [<c012bd90>] worker_thread+0x207/0x225
[  123.307312]  [<c012fe68>] kthread+0xb7/0xbc
[  123.311790]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.317262] events/2      S 00000004     0    12      1            13    11 (L-TLB)
[  123.325582] c2359f34 c2359f24 00000004 00000004 00000202 00000001 c2354540 000007d0 
[  123.334617]        c2359ef4 c012bb5c c22211b8 fffd55d7 00000000 c2300780 c22211a4 c2359efc 
[  123.343746]        c23488b0 c23488a8 c221f560 00000002 000008a0 535bc77c 0000001c c2330030 
[  123.352873] Call Trace:
[  123.355689]  [<c012bd90>] worker_thread+0x207/0x225
[  123.360891]  [<c012fe68>] kthread+0xb7/0xbc
[  123.365370]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.370843] events/3      R running     0    13      1            14    12 (L-TLB)
[  123.379071] khelper       S 00000004     0    14      1            15    13 (L-TLB)
[  123.387394] c235af34 c235af20 00000004 00000004 00000000 00000000 00000000 f7361d80 
[  123.395620]        00000000 f7a29d2c 00000000 f7a29d58 f7b97a70 f7a29d50 00000202 f7b97a70 
[  123.404753]        00000000 c221fec0 c221f560 00000002 0000017b 249842c5 00000006 f7b97a70 
[  123.413889] Call Trace:
[  123.416705]  [<c012bd90>] worker_thread+0x207/0x225
[  123.421905]  [<c012fe68>] kthread+0xb7/0xbc
[  123.426387]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.431861] kthread       S 00000002     0    15      1    20     144    14 (L-TLB)
[  123.440182] c2389f34 c2389f24 00000004 00000002 c2389ef0 c0117b5d f7ad9e88 00000003 
[  123.448403]        00000000 00000000 f7ad9f28 f7ad9f1c f7ad9f20 00000202 c2389f18 c0117cbb 
[  123.457535]        c2380b30 c2380b28 c220f560 00000000 000001b0 2318e05f 00000005 c048db40 
[  123.466668] Call Trace:
[  123.469483]  [<c012bd90>] worker_thread+0x207/0x225
[  123.474687]  [<c012fe68>] kthread+0xb7/0xbc
[  123.479166]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.484639] kblockd/0     S 00000002     0    20     15            21       (L-TLB)
[  123.492959] c238bf34 c238bf20 00000004 00000002 f7fd0c5c 00c4d18d 00000000 00000000 
[  123.501180]        c2330550 f7fd0c5c c238bee8 c040906a f78b7a70 0000001f c0579414 f78b7a70 
[  123.510310]        00000000 c220fec0 c220f560 00000000 00000c12 5303b35e 00000008 f78b7a70 
[  123.519436] Call Trace:
[  123.522252]  [<c012bd90>] worker_thread+0x207/0x225
[  123.527454]  [<c012fe68>] kthread+0xb7/0xbc
[  123.531933]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.537405] kblockd/1     S 00000001     0    21     15            22    20 (L-TLB)
[  123.545725] f7d58f34 f7d58f20 00000004 00000001 f7fd09dc 0014012f 00000000 f7a5d180 
[  123.553910]        f6c37550 f7fd09dc f7d58ee8 c040906a f6b0ba70 c02fccc2 00000003 f6b0ba70 
[  123.562994]        00000000 c2217ec0 c2217560 00000001 000014ab 21553fb6 00000006 f6b0ba70 
[  123.572076] Call Trace:
[  123.574921]  [<c012bd90>] worker_thread+0x207/0x225
[  123.580092]  [<c012fe68>] kthread+0xb7/0xbc
[  123.584546]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.589990] kblockd/2     S 00000004     0    22     15            23    21 (L-TLB)
[  123.598306] c238ff34 c238ff20 00000004 00000004 c238fed0 c040906a c238fef8 f7a43280 
[  123.606487]        f7120550 f78c707c c238fee8 00000000 f7206550 00000172 c23eee80 f7206550 
[  123.615583]        00000000 c221fec0 c221f560 00000002 00000ed0 628d2b7d 00000002 f7206550 
[  123.624714] Call Trace:
[  123.627528]  [<c012bd90>] worker_thread+0x207/0x225
[  123.632731]  [<c012fe68>] kthread+0xb7/0xbc
[  123.637209]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.642680] kblockd/3     S 00000003     0    23     15            24    22 (L-TLB)
[  123.651002] f7d59f34 f7d59f24 00000004 00000003 f7a3b25c 00a06705 00000000 00000202 
[  123.659214]        00000001 f7a3b25c f7d59ee8 c040906a f7d59f10 c02fccc2 c0579414 f7a3b25c 
[  123.668294]        c23eee30 c23eee28 c2227560 00000003 00000bf5 55d51770 00000008 c2337a70 
[  123.677361] Call Trace:
[  123.680149]  [<c012bd90>] worker_thread+0x207/0x225
[  123.685315]  [<c012fe68>] kthread+0xb7/0xbc
[  123.689775]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.695221] kacpid        S 00000002     0    24     15           142    23 (L-TLB)
[  123.703544] f7d78f34 f7d78f24 00000004 00000002 00000000 00000001 00000100 00000000 
[  123.711728]        00000080 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  123.720818]        00000000 00000202 c220f560 00000000 00000185 027fd001 00000000 c048db40 
[  123.729909] Call Trace:
[  123.732714]  [<c012bd90>] worker_thread+0x207/0x225
[  123.737889]  [<c012fe68>] kthread+0xb7/0xbc
[  123.742345]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.747790] pdflush       S 00000004     0   142     15           143    24 (L-TLB)
[  123.756107] f7dadf68 f7dadf58 00000004 00000004 c0124c50 c0493a5c fffd56de f7dadf68 
[  123.764288]        c014153c c0493a5c fffd56de fffcce26 00000000 00000000 f7dadf18 00000400 
[  123.773380]        00000000 00000000 c221f560 00000002 00000181 b059cc3e 0000001b c2330030 
[  123.782465] Call Trace:
[  123.785271]  [<c0141df8>] __pdflush+0x84/0x199
[  123.789995]  [<c0141f4d>] pdflush+0x40/0x47
[  123.794451]  [<c012fe68>] kthread+0xb7/0xbc
[  123.798910]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.804354] pdflush       D 00000003     0   143     15           145   142 (L-TLB)
[  123.812676] f7d5dcb0 f7d5dca0 00000004 00000003 0000001b 00000000 f7d5dc80 c0117800 
[  123.820864]        00000003 c2227560 00000086 03d8f695 0000000e c23ef030 f7d5dc6c f7d5dc6c 
[  123.829954]        c23ef030 00000003 c2227560 00000003 002e3da9 0579218a 0000000e c2337a70 
[  123.839041] Call Trace:
[  123.841844]  [<c040863b>] io_schedule+0x26/0x30
[  123.846662]  [<c013ab27>] sync_page+0x39/0x4e
[  123.851302]  [<c0408929>] __wait_on_bit_lock+0x58/0x67
[  123.856746]  [<c013b343>] __lock_page+0x84/0x8c
[  123.861561]  [<c017deb4>] mpage_writepages+0x34b/0x399
[  123.867008]  [<c01c88f1>] nfs_writepages+0x2e/0x11e
[  123.872185]  [<c01416f2>] do_writepages+0x2e/0x53
[  123.877182]  [<c017c072>] __sync_single_inode+0x60/0x1f1
[  123.882808]  [<c017c295>] __writeback_single_inode+0x92/0x195
[  123.888898]  [<c017c555>] sync_sb_inodes+0x1bd/0x2c2
[  123.894190]  [<c017c734>] writeback_inodes+0xda/0xe6
[  123.899482]  [<c01413e8>] background_writeout+0x69/0xa2
[  123.905048]  [<c0141e35>] __pdflush+0xc1/0x199
[  123.909801]  [<c0141f4d>] pdflush+0x40/0x47
[  123.914257]  [<c012fe68>] kthread+0xb7/0xbc
[  123.918713]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  123.924156] kswapd0       D 00000001     0   144      1           804    15 (L-TLB)
[  123.932476] f7de6c94 f7de6c84 00000004 00000001 00011200 00000000 c0409378 00000000 
[  123.940649]        00000003 00011200 f7e3f580 0000001b 00011200 f7de6c7c c0143db2 f7e31880 
[  123.949731]        00011200 00000000 c2217560 00000001 001e5571 05ebddf0 0000000e c2330550 
[  123.958804] Call Trace:
[  123.961604]  [<c040863b>] io_schedule+0x26/0x30
[  123.966416]  [<c013e464>] mempool_alloc+0xcf/0xd1
[  123.971406]  [<c01c996e>] nfs_flush_one+0x54/0x17f
[  123.976488]  [<c01c9aee>] nfs_flush_list+0x55/0xa3
[  123.981569]  [<c01ca420>] nfs_flush_inode+0x82/0xad
[  123.986741]  [<c01c88be>] nfs_writepage+0x1d7/0x1dc
[  123.991913]  [<c0146516>] pageout+0xb5/0x137
[  123.996468]  [<c0146782>] shrink_list+0x1ea/0x40c
[  124.001487]  [<c0146b40>] shrink_cache+0xf8/0x281
[  124.006508]  [<c0147138>] shrink_zone+0xcb/0xfa
[  124.011348]  [<c0147611>] balance_pgdat+0x286/0x37e
[  124.016551]  [<c01477ee>] kswapd+0xe5/0x10f
[  124.021030]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.026506] aio/0         S 00000002     0   145     15           146   143 (L-TLB)
[  124.034822] f7d69f34 f7d69f20 00000004 00000002 00000000 00000001 00000100 00000000 
[  124.043043]        00000080 00000080 00000080 c05566a0 c2330a70 c05566ac c220fec0 c2330a70 
[  124.052168]        00000000 c220fec0 c220f560 00000000 00000124 2ca5cbf6 00000000 c2330a70 
[  124.061297] Call Trace:
[  124.064112]  [<c012bd90>] worker_thread+0x207/0x225
[  124.069312]  [<c012fe68>] kthread+0xb7/0xbc
[  124.073792]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.079263] aio/1         S 00000001     0   146     15           147   145 (L-TLB)
[  124.087580] f7e2cf34 f7e2cf20 00000004 00000001 00000000 00000001 00000100 00000000 
[  124.095759]        00000080 00000000 00000000 c05566ac c2330a70 00000000 c2217ec0 c2330a70 
[  124.104839]        00000000 c2217ec0 c2217560 00000001 000000f3 2ca62a97 00000000 c2330a70 
[  124.113923] Call Trace:
[  124.116724]  [<c012bd90>] worker_thread+0x207/0x225
[  124.121900]  [<c012fe68>] kthread+0xb7/0xbc
[  124.126357]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.131801] aio/2         S 00000004     0   147     15           148   146 (L-TLB)
[  124.140928] f7d6af34 f7d6af24 00000004 00000004 00000000 00000001 00000100 00000000 
[  124.149058]        00000080 00000080 00000080 c05566a0 c05566a0 c05566ac c220fec0 c220fec0 
[  124.158084]        00000000 00000202 c221f560 00000002 000001ab 2ca695a2 00000000 c2330030 
[  124.167110] Call Trace:
[  124.169895]  [<c012bd90>] worker_thread+0x207/0x225
[  124.175036]  [<c012fe68>] kthread+0xb7/0xbc
[  124.179464]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.184875] aio/3         S 00000003     0   148     15           149   147 (L-TLB)
[  124.193106] f7e2ef34 f7e2ef24 00000004 00000003 00000000 00000001 00000100 00000080 
[  124.201234]        00000080 00000000 00000000 c05566ac c05566ac 00000000 c2217ec0 c2217ec0 
[  124.210259]        00000000 00000202 c2227560 00000003 0000017e 2ca6ee55 00000000 c2337a70 
[  124.219287] Call Trace:
[  124.222070]  [<c012bd90>] worker_thread+0x207/0x225
[  124.227211]  [<c012fe68>] kthread+0xb7/0xbc
[  124.231638]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.237047] xfslogd/0     S 00000002     0   149     15           150   148 (L-TLB)
[  124.245274] f7d6bf34 f7d6bf20 00000004 00000002 00000000 00000001 00000100 00000000 
[  124.253404]        00000100 00000080 00000080 c05566a0 c2330a70 c05566ac c220fec0 c2330a70 
[  124.262495]        00000000 c220fec0 c220f560 00000000 000000d8 2e49df27 00000000 c2330a70 
[  124.271614] Call Trace:
[  124.274430]  [<c012bd90>] worker_thread+0x207/0x225
[  124.279633]  [<c012fe68>] kthread+0xb7/0xbc
[  124.284115]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.289587] xfslogd/1     S 00000001     0   150     15           151   149 (L-TLB)
[  124.297908] f7e64f34 f7e64f20 00000004 00000001 00000000 00000001 00000100 00000000 
[  124.306130]        00000100 00000080 00000080 c05566ac c2330a70 c05566a0 c2217ec0 c2330a70 
[  124.315261]        00000000 c2217ec0 c2217560 00000001 000000e1 2e4a40dc 00000000 c2330a70 
[  124.324393] Call Trace:
[  124.327208]  [<c012bd90>] worker_thread+0x207/0x225
[  124.332409]  [<c012fe68>] kthread+0xb7/0xbc
[  124.336888]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.342359] xfslogd/2     S 00000004     0   151     15           152   150 (L-TLB)
[  124.350683] f7d6ef34 f7d6ef24 00000004 00000004 00000000 00000001 00000100 00000080 
[  124.358907]        00000100 00000080 00000080 c05566a0 c05566a0 c05566ac c220fec0 c220fec0 
[  124.368037]        00000000 00000202 c221f560 00000002 00000135 2e4ab2b7 00000000 c2330030 
[  124.377169] Call Trace:
[  124.379984]  [<c012bd90>] worker_thread+0x207/0x225
[  124.385181]  [<c012fe68>] kthread+0xb7/0xbc
[  124.389660]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.395129] xfslogd/3     S 00000003     0   152     15           153   151 (L-TLB)
[  124.403451] f7e66f34 f7e66f24 00000004 00000003 00000000 00000001 00000100 00000080 
[  124.411667]        00000100 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  124.420786]        00000000 00000202 c2227560 00000003 00000146 2e4b118c 00000000 c2337a70 
[  124.429910] Call Trace:
[  124.432724]  [<c012bd90>] worker_thread+0x207/0x225
[  124.437925]  [<c012fe68>] kthread+0xb7/0xbc
[  124.442404]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.447874] xfsdatad/0    S 00000002     0   153     15           154   152 (L-TLB)
[  124.456194] f7d6ff34 f7d6ff20 00000004 00000002 00000000 00000001 00000100 00000000 
[  124.464408]        00000100 00000080 00000080 c05566a0 c2330a70 c05566ac c220fec0 c2330a70 
[  124.473532]        00000000 c220fec0 c220f560 00000000 000000e0 2e4b6256 00000000 c2330a70 
[  124.482656] Call Trace:
[  124.485469]  [<c012bd90>] worker_thread+0x207/0x225
[  124.490669]  [<c012fe68>] kthread+0xb7/0xbc
[  124.495146]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.500616] xfsdatad/1    S 00000001     0   154     15           155   153 (L-TLB)
[  124.508932] f7e68f34 f7e68f20 00000004 00000001 00000000 00000001 00000100 00000000 
[  124.517149]        00000100 00000080 00000080 c05566ac c2330a70 c05566a0 c2217ec0 c2330a70 
[  124.526275]        00000000 c2217ec0 c2217560 00000001 000000d9 2e4bc69b 00000000 c2330a70 
[  124.535401] Call Trace:
[  124.538216]  [<c012bd90>] worker_thread+0x207/0x225
[  124.543415]  [<c012fe68>] kthread+0xb7/0xbc
[  124.547891]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.553360] xfsdatad/2    S 00000004     0   155     15           156   154 (L-TLB)
[  124.561676] f7d70f34 f7d70f24 00000004 00000004 00000000 00000001 00000100 00000080 
[  124.569891]        00000100 00000080 00000080 c05566a0 c05566a0 c05566ac c220fec0 c220fec0 
[  124.579021]        00000000 00000202 c221f560 00000002 0000013a 2e4c2d9c 00000000 c2330030 
[  124.588154] Call Trace:
[  124.590967]  [<c012bd90>] worker_thread+0x207/0x225
[  124.596166]  [<c012fe68>] kthread+0xb7/0xbc
[  124.600641]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.606110] xfsdatad/3    S 00000003     0   156     15           157   155 (L-TLB)
[  124.614405] f7e69f34 f7e69f24 00000004 00000003 00000000 00000001 00000100 00000080 
[  124.622529]        00000100 00000080 00000080 c05566ac c05566ac c05566a0 c2217ec0 c2217ec0 
[  124.631552]        00000000 00000202 c2227560 00000003 00000147 2e4c83ef 00000000 c2337a70 
[  124.640581] Call Trace:
[  124.643364]  [<c012bd90>] worker_thread+0x207/0x225
[  124.648503]  [<c012fe68>] kthread+0xb7/0xbc
[  124.652929]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.658337] xfsbufd       S 00000001     0   157     15           742   156 (L-TLB)
[  124.666557] f7d72f44 f7d72f34 00000004 00000001 00000100 00000080 00000080 00000000 
[  124.674682]        f7206030 c2330550 0216915a 0000000e 00000202 c2217fe0 f7d72f58 00000202 
[  124.683704]        c2217fe0 f7d72f58 c2217560 00000001 000000b1 e5ed67a9 0000001c c2330550 
[  124.692731] Call Trace:
[  124.695515]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  124.700742]  [<c040874c>] schedule_timeout_interruptible+0x1a/0x1c
[  124.707221]  [<c0272754>] xfsbufd+0x4e/0x1b0
[  124.711734]  [<c012fe68>] kthread+0xb7/0xbc
[  124.716165]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.721572] kseriod       S 00000002     0   742     15          1668   157 (L-TLB)
[  124.729796] f7f10f5c f7f10f4c 00000004 00000002 c02eff05 f8879da4 f7f10f10 c02efe91 
[  124.737924]        f8879d88 c04a8738 f8879da4 c04a63e0 f7f10f34 c02ef54e f8879d88 c04a8738 
[  124.746953]        00000286 00000202 c220f560 00000000 0000063d 6358b857 00000001 c048db40 
[  124.755975] Call Trace:
[  124.758757]  [<c02e4762>] serio_thread+0xea/0xec
[  124.763633]  [<c012fe68>] kthread+0xb7/0xbc
[  124.768057]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.773464] kjournald     S 00000001     0   804      1          1128   144 (L-TLB)
[  124.781686] f7fb9f58 f7fb9f48 00000004 00000001 f6b4504c 00000000 00000000 f7fb7800 
[  124.789808]        00000000 f726b200 f6a48e70 0000037f 00000202 c2227fe0 f7fb9fb8 f7fb9f2c 
[  124.798829]        f7fadc6c f7fadc64 c2217560 00000001 0000030b d4604302 0000000c c2330550 
[  124.807852] Call Trace:
[  124.810639]  [<c01b0eef>] kjournald+0x1d6/0x223
[  124.815425]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.820832] kjournald     S 00000004     0  1128      1          1129   804 (L-TLB)
[  124.829059] f7ac0f58 f7ac0f48 00000004 00000004 00000012 00000036 00000044 00000202 
[  124.837188]        5b3e363c 20202020 32382e35 36333038 f700205d 00000003 00000000 00000000 
[  124.846216]        f716606c f7166064 c221f560 00000002 0000033a 5bd83b5f 00000001 c2330030 
[  124.855239] Call Trace:
[  124.858020]  [<c01b0eef>] kjournald+0x1d6/0x223
[  124.862800]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.868209] kjournald     S 00000001     0  1129      1          1130  1128 (L-TLB)
[  124.876431] f7b3ef58 f7b3ef48 00000004 00000001 f722a02c 00000000 00000000 f71c4800 
[  124.884552]        00000000 f7344900 f788d6ec 0000028a 00000202 c2217fe0 f7b3efb8 f7b3ef2c 
[  124.893577]        f71c0c6c f71c0c64 c2217560 00000001 0000021e d4d9438e 0000000c c2330550 
[  124.902607] Call Trace:
[  124.905420]  [<c01b0eef>] kjournald+0x1d6/0x223
[  124.910260]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  124.915730] kjournald     D 00000001     0  1130      1          2761  1129 (L-TLB)
[  124.924863] f7fdfbec f7fdfbdc 00000004 00000001 f6a4520c c015a4f0 c21ff6d0 f7fdfbe0 
[  124.933083]        00000202 c2330550 c0492f80 00000006 00000202 c2217fe0 f7fdfc00 00000202 
[  124.942212]        c2217fe0 f7fdfc00 c2217560 00000001 000000fc 15ede76c 0000001d c2330550 
[  124.951339] Call Trace:
[  124.954154]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  124.959446]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  124.965010]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  124.970574]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  124.976228]  [<c014714d>] shrink_zone+0xe0/0xfa
[  124.981068]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  124.986089]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  124.991566]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  124.996767]  [<c013b51b>] find_or_create_page+0x83/0x97
[  125.002330]  [<c015b777>] grow_dev_page+0x38/0x15d
[  125.007444]  [<c015b954>] __getblk_slow+0xb8/0x124
[  125.012557]  [<c015bd1d>] __getblk+0x57/0x59
[  125.017131]  [<c01b1970>] journal_get_descriptor_buffer+0x4d/0xa4
[  125.023599]  [<c01ad7bf>] journal_write_commit_record+0x38/0x116
[  125.029974]  [<c01ade3f>] journal_commit_transaction+0x5a2/0x127f
[  125.036446]  [<c01b0dda>] kjournald+0xc1/0x223
[  125.041194]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  125.046668] khubd         S 00000001     0  1668     15          2770   742 (L-TLB)
[  125.054989] f72e0f60 f72e0f4c 00000004 00000001 000003e8 00000007 f72cab80 f7a5dd80 
[  125.063213]        f7206030 f73580b4 c0294432 f72e0f1c f7206550 00000007 00000010 f7206550 
[  125.072347]        00000000 c2217ec0 c2217560 00000001 00000e03 91e8c7a3 00000002 f7206550 
[  125.081480] Call Trace:
[  125.084295]  [<f8b01331>] hub_thread+0xe3/0xe5 [usbcore]
[  125.089968]  [<c012fe68>] kthread+0xb7/0xbc
[  125.094446]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  125.099919] portmap       S 00000001     0  2761      1          2774  1130 (NOTLB)
[  125.108238] f7a2ff00 f7a2fef0 00000004 00000001 00000202 f72ea00c 00000202 f7a2feb4 
[  125.116463]        c0130113 f72ea000 f7b9a680 00000202 f72ea028 00000202 f7a2fed0 c0130113 
[  125.125593]        f72ea000 f72f4480 c2217560 00000001 00000ba3 0a410b84 00000006 c2330550 
[  125.134727] Call Trace:
[  125.137546]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  125.142842]  [<c016ce88>] do_poll+0x9a/0xb9
[  125.147321]  [<c016cffd>] sys_poll+0x156/0x221
[  125.152073]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  125.157455] rpciod/0      S 00000002     0  2770     15          2771  1668 (L-TLB)
[  125.165779] f6d24f34 f6d24f24 00000004 00000002 f7e45104 c04100d4 f7e45100 f6d24ee4 
[  125.174000]        c01c6b66 f7e45100 f7e3eec0 f6d24f00 c03f0ee4 f7e45100 f6d24f00 00000000 
[  125.183128]        f73448b0 f73448a8 c220f560 00000000 000006ec aa8c16d7 0000000b c048db40 
[  125.192261] Call Trace:
[  125.195078]  [<c012bd90>] worker_thread+0x207/0x225
[  125.200281]  [<c012fe68>] kthread+0xb7/0xbc
[  125.204761]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  125.210233] rpciod/1      S 00000004     0  2771     15          2772  2770 (L-TLB)
[  125.218555] f7a12f34 c2361030 c2217a20 00000004 00000000 00000001 00000100 00000000 
[  125.226781]        00000100 00000000 42e170b2 00000004 c2361030 00000000 c220fec0 c2361030 
[  125.235914]        00000000 c2217ec0 c2217560 00000001 00000191 42e4db8d 00000004 c2361030 
[  125.245045] Call Trace:
[  125.247861]  [<c012bd90>] worker_thread+0x207/0x225
[  125.253065]  [<c012fe68>] kthread+0xb7/0xbc
[  125.257546]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  125.263017] rpciod/2      D 00000004     0  2772     15          2773  2771 (L-TLB)
[  125.271338] f70ccaa8 f70cca98 00000004 00000004 ffffffce f70cca74 c0117800 00000002 
[  125.279560]        c221f560 c2330030 05f561fa 0000000e 00000202 c221ffe0 f70ccabc 00000202 
[  125.288692]        c221ffe0 f70ccabc c221f560 00000002 00000143 2b8c50f7 0000001d c2330030 
[  125.297821] Call Trace:
[  125.300636]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  125.305931]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  125.311495]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  125.317058]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  125.322720]  [<c014714d>] shrink_zone+0xe0/0xfa
[  125.327560]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  125.332581]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  125.338056]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  125.343258]  [<c03b74ad>] tcp_sendmsg+0xaa0/0xb78
[  125.348281]  [<c03d4666>] inet_sendmsg+0x48/0x53
[  125.353212]  [<c0388716>] sock_sendmsg+0xb8/0xd3
[  125.358147]  [<c0388773>] kernel_sendmsg+0x42/0x4f
[  125.363259]  [<c038bc00>] sock_no_sendpage+0x5e/0x77
[  125.368556]  [<c03ee7af>] xs_tcp_send_request+0x2af/0x375
[  125.374306]  [<c03ed4c5>] xprt_transmit+0x4f/0x20b
[  125.379414]  [<c03ebce1>] call_transmit+0x68/0xc8
[  125.384435]  [<c03f0962>] __rpc_execute+0x5c/0x1ea
[  125.389548]  [<c03f0b27>] rpc_async_schedule+0x11/0x15
[  125.395019]  [<c012bd1d>] worker_thread+0x194/0x225
[  125.400221]  [<c012fe68>] kthread+0xb7/0xbc
[  125.404699]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  125.410173] rpciod/3      S 00000003     0  2773     15                2772 (L-TLB)
[  125.418494] f7a85f34 f7a85f20 00000004 00000003 f6cc0784 c04100d4 f6cc0780 00000000 
[  125.426691]        c2330030 f6cc0780 f7e3eec0 f7a85f00 f7b97550 00000039 f7a85f00 f7b97550 
[  125.435777]        00000000 c2227ec0 c2227560 00000003 00000efa 68208a87 0000000d f7b97550 
[  125.444862] Call Trace:
[  125.447662]  [<c012bd90>] worker_thread+0x207/0x225
[  125.452836]  [<c012fe68>] kthread+0xb7/0xbc
[  125.457292]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  125.462739] lockd         S 00000002     0  2774      1          2841  2761 (L-TLB)
[  125.471060] f7236f14 f7236f04 00000004 00000002 f720e380 00000001 c2217560 f7236ecc 
[  125.479240]        c01103a3 00000002 000000fc f7b7a030 c2217a20 f7236edc c0115796 00000202 
[  125.488319]        f73a0aec 00000202 c220f560 00000000 0000090e 42f05f34 00000004 c048db40 
[  125.497408] Call Trace:
[  125.500211]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  125.505475]  [<c03f4bcb>] svc_recv+0x387/0x4b9
[  125.510199]  [<c02049d1>] lockd+0x101/0x239
[  125.514657]  [<c0101175>] kernel_thread_helper+0x5/0xb
[  125.520103] syslogd       D 00000002     0  2841      1          2844  2774 (NOTLB)
[  125.528421] f7368cdc f7368ccc 00000004 00000002 c02884cf f7f634f4 f7a3b25c 00000003 
[  125.536601]        00000000 c048db40 c21b1e20 c0493400 00000202 c220ffe0 f7368cf0 00000202 
[  125.545684]        c220ffe0 f7368cf0 c220f560 00000000 00000150 397c1343 0000001d c048db40 
[  125.554766] Call Trace:
[  125.557566]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  125.562831]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  125.568363]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  125.573898]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  125.579522]  [<c014714d>] shrink_zone+0xe0/0xfa
[  125.584336]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  125.589330]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  125.594772]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  125.599946]  [<c013fc2a>] __get_free_pages+0x2c/0x4f
[  125.605212]  [<c016c561>] __pollwait+0x3a/0xae
[  125.609937]  [<c038fe22>] datagram_poll+0x2b/0xcd
[  125.614936]  [<c0388f06>] sock_poll+0x23/0x2a
[  125.619574]  [<c016c8d1>] do_select+0x217/0x26e
[  125.624389]  [<c016cbc9>] sys_select+0x26a/0x3f7
[  125.629294]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  125.634649] klogd         S 00000001     0  2844      1          2859  2841 (NOTLB)
[  125.642976] f7304d4c f7304d3c 00000004 00000001 c220fa20 f7304cf4 c0115796 00000000 
[  125.651159]        00000096 c2330550 c0116055 c048db40 c220f560 00000000 c2381880 f7380000 
[  125.660245]        00000a00 000000b7 c2217560 00000001 00000847 8f99b9ea 0000001c c2330550 
[  125.669324] Call Trace:
[  125.672125]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  125.677408]  [<f88b00ee>] unix_wait_for_peer+0xb3/0xb7 [unix]
[  125.683525]  [<f88b0abb>] unix_dgram_sendmsg+0x266/0x502 [unix]
[  125.689785]  [<c0388ab6>] sock_aio_write+0xea/0x106
[  125.694960]  [<c0159307>] do_sync_write+0xa7/0xe7
[  125.699968]  [<c01594b5>] vfs_write+0x16e/0x17d
[  125.704808]  [<c0159584>] sys_write+0x4b/0x75
[  125.709468]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  125.714852] ypbind        S 00000002     0  2859      1          2860  2844 (NOTLB)
[  125.723173] f7e6af00 f7e6aef0 00000004 00000002 00000202 f69a200c 00000202 f7e6aeb4 
[  125.731401]        c0130113 f69a2000 f70df880 00000202 f69a2028 00000202 f7e6aed0 c0130113 
[  125.740539]        f69a2000 f7ecc280 c220f560 00000000 0000130c 17ad0134 00000005 c048db40 
[  125.749670] Call Trace:
[  125.752492]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  125.757784]  [<c016ce88>] do_poll+0x9a/0xb9
[  125.763079]  [<c016cffd>] sys_poll+0x156/0x221
[  125.767831]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  125.773214] ypbind        S 00000002     0  2860      1          2861  2859 (NOTLB)
[  125.781531] f723beac f723be9c 00000004 00000002 c0493400 f723be5c f723bed4 c220f560 
[  125.789754]        00000000 00000001 00000001 00000000 00000046 00000000 f7e6aedc 00000000 
[  125.798835]        f723be84 c0117b1a c220f560 00000000 0001069f df266306 00000004 c048db40 
[  125.807916] Call Trace:
[  125.810719]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  125.815981]  [<c040874c>] schedule_timeout_interruptible+0x1a/0x1c
[  125.822503]  [<c0128559>] sys_rt_sigtimedwait+0x1f1/0x2e9
[  125.828216]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  125.833570] ypbind        D 00000002     0  2861      1          3021  2860 (NOTLB)
[  125.841890] f71dfcf8 f71dfce8 00000004 00000002 f73eb100 f73eb100 f71dfeb8 00000000 
[  125.850076]        00000000 c048db40 f7a60e80 00000040 00000202 c220ffe0 f71dfd0c 00000202 
[  125.859210]        c220ffe0 f71dfd0c c220f560 00000000 00000174 4de9a1b2 0000001d c048db40 
[  125.868340] Call Trace:
[  125.871157]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  125.876450]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  125.882014]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  125.887579]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  125.893239]  [<c014714d>] shrink_zone+0xe0/0xfa
[  125.898084]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  125.903105]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  125.908578]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  125.913782]  [<c013fc2a>] __get_free_pages+0x2c/0x4f
[  125.919074]  [<c016c561>] __pollwait+0x3a/0xae
[  125.923822]  [<c038fe22>] datagram_poll+0x2b/0xcd
[  125.928842]  [<c03ce48a>] udp_poll+0x22/0xfc
[  125.933413]  [<c0388f06>] sock_poll+0x23/0x2a
[  125.938073]  [<c016cdea>] do_pollfd+0x94/0x98
[  125.942730]  [<c016ce49>] do_poll+0x5b/0xb9
[  125.947211]  [<c016cffd>] sys_poll+0x156/0x221
[  125.951961]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  125.957343] automount     D 00000002     0  3021      1          3029  2861 (NOTLB)
[  125.965660] f7150d28 f7150d18 00000004 00000002 f7150cf4 c014b7e2 f7a9f300 f72d28b4 
[  125.973880]        b7f86000 c048db40 f78edb7c 00000001 00000202 c220ffe0 f7150d3c 00000202 
[  125.983009]        c220ffe0 f7150d3c c220f560 00000000 00000162 550f363f 0000001d c048db40 
[  125.992137] Call Trace:
[  125.994953]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  126.000246]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  126.005810]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  126.011374]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  126.017028]  [<c014714d>] shrink_zone+0xe0/0xfa
[  126.021870]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  126.026896]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  126.032371]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  126.037573]  [<c013fc2a>] __get_free_pages+0x2c/0x4f
[  126.042864]  [<c016c561>] __pollwait+0x3a/0xae
[  126.047614]  [<c0166016>] pipe_poll+0x36/0xad
[  126.052274]  [<c016cdea>] do_pollfd+0x94/0x98
[  126.056934]  [<c016ce49>] do_poll+0x5b/0xb9
[  126.061413]  [<c016cffd>] sys_poll+0x156/0x221
[  126.066163]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.071548] dbus-daemon-1 S 00000002     0  3029      1          3062  3021 (NOTLB)
[  126.079870] f70c6f00 f70c6ef0 00000004 00000002 000200d0 00000000 c0493880 00000044 
[  126.088097]        f70c6ee0 c17b4fa4 00000010 c0493880 00000000 00000202 f6ce1028 00000202 
[  126.097222]        f70c6ed8 c0130113 c220f560 00000000 0000c283 40012bcd 00000005 c048db40 
[  126.106351] Call Trace:
[  126.109154]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  126.114414]  [<c016ce88>] do_poll+0x9a/0xb9
[  126.118871]  [<c016cffd>] sys_poll+0x156/0x221
[  126.123598]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.128954] exim4         S 00000001     0  3062      1          3067  3029 (NOTLB)
[  126.137276] f7af6ea0 f7af6e90 00000004 00000001 c17ae530 c0493880 000000d0 f72e7030 
[  126.145457]        f7af6e80 c013f968 000200d0 00000000 c0493880 00000044 00000286 c17ae530 
[  126.154552]        00000010 c0493880 c2217560 00000001 00001913 69393fd9 00000005 c2330550 
[  126.163678] Call Trace:
[  126.166492]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  126.171783]  [<c016c80c>] do_select+0x152/0x26e
[  126.176620]  [<c016cbc9>] sys_select+0x26a/0x3f7
[  126.181546]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.186926] irqbalance    D 00000002     0  3067      1          3071  3062 (NOTLB)
[  126.195242] f723ad14 f723ad04 00000004 00000002 00000000 f723acc8 c01722c6 c2313200 
[  126.203461]        f00000dd c048db40 f720eb00 c2313200 00000202 c220ffe0 f723ad28 00000202 
[  126.212588]        c220ffe0 f723ad28 c220f560 00000000 00000153 5e4a6d73 0000001d c048db40 
[  126.221717] Call Trace:
[  126.224531]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  126.229819]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  126.235379]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  126.240940]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  126.246591]  [<c014714d>] shrink_zone+0xe0/0xfa
[  126.251428]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  126.256448]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  126.261918]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  126.267118]  [<c0142d35>] kmem_getpages+0x34/0x9d
[  126.272136]  [<c0143b91>] cache_grow+0xaf/0x16c
[  126.276977]  [<c0143db2>] cache_alloc_refill+0x164/0x207
[  126.282627]  [<c014403b>] kmem_cache_alloc+0x4e/0x50
[  126.287917]  [<c016690c>] getname+0x24/0xb3
[  126.292392]  [<c01587ad>] do_sys_open+0x1a/0xfa
[  126.297228]  [<c01588ac>] sys_open+0x1f/0x23
[  126.301794]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.307172] nrpe          S 00000002     0  3071      1          3076  3067 (NOTLB)
[  126.315492] f71e7de8 f71e7dd8 00000004 00000002 f7fadc00 c019daa0 00000032 f71e7ea4 
[  126.323709]        f71e7df8 f71e7e84 c0388716 f71e7df8 f7382d00 f71e7ea4 00000032 00000000 
[  126.332835]        f71e7dc8 c019db10 c220f560 00000000 0000a806 68cca1c6 00000005 c048db40 
[  126.341958] Call Trace:
[  126.344773]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  126.350069]  [<c03b54aa>] inet_csk_wait_for_connect+0xd7/0xdc
[  126.356174]  [<c03b550d>] inet_csk_accept+0x5e/0x154
[  126.361467]  [<c03d44fc>] inet_accept+0x30/0xb2
[  126.366309]  [<c0389755>] sys_accept+0xb3/0x173
[  126.371148]  [<c038a2c9>] sys_socketcall+0xc1/0x234
[  126.376352]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.381735] snmpd         S 00000002     0  3076      1          3084  3071 (NOTLB)
[  126.390056] f72d7ea0 f72d7e90 00000004 00000002 c0493880 c0492f80 000200d0 00000002 
[  126.398276]        00000044 c17af16c c0493880 000000d0 00000202 f6a43060 00000202 f72d7e74 
[  126.407405]        c0130113 f6a43000 c220f560 00000000 0001d0fd 83f7c635 00000005 c048db40 
[  126.416536] Call Trace:
[  126.419352]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  126.424648]  [<c016c80c>] do_select+0x152/0x26e
[  126.429492]  [<c016cbc9>] sys_select+0x26a/0x3f7
[  126.434422]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.439808] sshd          S 00000002     0  3084      1          3095  3076 (NOTLB)
[  126.448127] f727eea0 f727ee90 00000004 00000002 c17d3a24 c0493880 000000d0 f78d7030 
[  126.456347]        f727ee80 c013f968 000200d0 00000000 c0493880 00000044 f727eed4 c17d3a24 
[  126.465478]        00000010 c0493880 c220f560 00000000 0000939a 87aed9de 00000005 c048db40 
[  126.474506] Call Trace:
[  126.477289]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  126.482517]  [<c016c80c>] do_select+0x152/0x26e
[  126.487303]  [<c016cbc9>] sys_select+0x26a/0x3f7
[  126.492173]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.497496] xfs           S 00000002     0  3095      1          3099  3084 (NOTLB)
[  126.505720] f7aabea0 f7aabe90 00000004 00000002 00000002 00000044 c17afe38 c0493880 
[  126.513844]        000000d0 f7a82a70 f7aabe88 c013f968 000200d0 00000000 c0493880 00000202 
[  126.522867]        c220ffe0 f7aabeb4 c220f560 00000000 0013f3e3 b174fdf3 00000005 c048db40 
[  126.531889] Call Trace:
[  126.534673]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  126.539903]  [<c016c80c>] do_select+0x152/0x26e
[  126.544684]  [<c016cbc9>] sys_select+0x26a/0x3f7
[  126.549554]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.554874] xfs-xtt       S 00000002     0  3099      1          3236  3095 (NOTLB)
[  126.563099] f7269ea0 f7269e90 00000004 00000002 00000002 00000044 c17afa48 c0493880 
[  126.571226]        000000d0 f78b7550 f7269e88 c013f968 000200d0 00000000 c0493880 00000202 
[  126.580249]        c220ffe0 f7269eb4 c220f560 00000000 001ce8c6 b6f5fbe5 00000005 c048db40 
[  126.589276] Call Trace:
[  126.592865]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  126.598100]  [<c016c80c>] do_select+0x152/0x26e
[  126.602933]  [<c016cbc9>] sys_select+0x26a/0x3f7
[  126.607837]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.613159] S20xprint     S C220FEC0     0  3236      1  3237    3290  3099 (NOTLB)
[  126.621387] f7a83f08 00000000 c220f560 c220fec0 00000099 00000001 f7a83ee0 c013c381 
[  126.629514]        f7ffd800 0000002f c013f968 000200d2 f7fd7a70 00000002 00000000 f71133cc 
[  126.638539]        f7ffd800 f7113380 c220f560 00000000 00010daa c78685a6 00000005 f7fd7a70 
[  126.647566] Call Trace:
[  126.650382]  [<c011fa57>] do_wait+0x18a/0x376
[  126.655045]  [<c011fd03>] sys_wait4+0x3e/0x42
[  126.659704]  [<c011fd2e>] sys_waitpid+0x27/0x2b
[  126.664545]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.669927] S20xprint     S 00000002     0  3237   3236  3240    3238       (NOTLB)
[  126.678249] f7a94f08 f7a94ef8 00000004 00000002 00000044 c2174cc8 c04938a8 000200d2 
[  126.686465]        f7fd7a70 f7a94eec c013f968 000200d2 00000000 c04938a8 00000044 f71133cc 
[  126.695593]        c2174cc8 00000010 c220f560 00000000 0001d4c3 c7ce7231 00000005 c048db40 
[  126.704722] Call Trace:
[  126.707538]  [<c011fa57>] do_wait+0x18a/0x376
[  126.712179]  [<c011fd03>] sys_wait4+0x3e/0x42
[  126.716821]  [<c011fd2e>] sys_waitpid+0x27/0x2b
[  126.721661]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.727044] S20xprint     S 00000002     0  3238   3236                3237 (NOTLB)
[  126.735368] f7a61e9c f7a61e8c 00000004 00000002 00000000 00000000 c05566ac c05566ac 
[  126.743594]        00000000 c2217ec0 c2217ec0 00000286 c0491680 00000082 00000011 f7a2abf4 
[  126.752726]        f7a61f3c f7a61e6c c220f560 00000000 00016ca5 e2f5840d 00000005 c048db40 
[  126.761861] Call Trace:
[  126.764677]  [<c01656eb>] pipe_wait+0x6f/0x8e
[  126.769337]  [<c0165926>] pipe_readv+0x1c8/0x2f3
[  126.774267]  [<c0165a84>] pipe_read+0x33/0x37
[  126.778926]  [<c0159189>] vfs_read+0xa6/0x17d
[  126.783592]  [<c015950f>] sys_read+0x4b/0x75
[  126.788161]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.793548] Xprt          S 00000002     0  3240   3237                     (NOTLB)
[  126.801872] f7b95ea0 f7b95e90 00000004 00000002 00000002 00000044 c17b0834 c0493880 
[  126.810092]        000000d0 f7206a70 f7b95e88 c013f968 000200d0 00000000 c0493880 00000044 
[  126.819221]        00000257 c17b0834 c220f560 00000000 000176f9 e98a6f02 00000005 c048db40 
[  126.828345] Call Trace:
[  126.831160]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  126.836453]  [<c016c80c>] do_select+0x152/0x26e
[  126.841289]  [<c016cbc9>] sys_select+0x26a/0x3f7
[  126.846216]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.851596] rpc.statd     S 00000002     0  3290      1          3293  3236 (NOTLB)
[  126.859917] f7a5bea0 f7a5be90 00000004 00000002 00000000 c0493880 00000044 f7a5be74 
[  126.868134]        c17b0ae0 00000010 c0493880 00000000 00000202 f6af8028 00000202 f7a5be74 
[  126.877262]        c0130113 f6af8000 c220f560 00000000 000020f3 0a47ac1f 00000006 c048db40 
[  126.886395] Call Trace:
[  126.889211]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  126.894458]  [<c016c80c>] do_select+0x152/0x26e
[  126.899244]  [<c016cbc9>] sys_select+0x26a/0x3f7
[  126.904119]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  126.909440] ntpd          D 00000002     0  3293      1          3306  3290 (NOTLB)
[  126.917665] f714dcb8 f714dca8 00000004 00000002 00000001 00000282 00000000 00000003 
[  126.925790]        f73312b8 c048db40 f7b063c4 f714dca4 00000202 c220ffe0 f714dccc 00000202 
[  126.934817]        c220ffe0 f714dccc c220f560 00000000 00000168 8c633820 0000001d c048db40 
[  126.943843] Call Trace:
[  126.946627]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  126.951860]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  126.957358]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  126.962859]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  126.968450]  [<c014714d>] shrink_zone+0xe0/0xfa
[  126.973234]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  126.978197]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  126.983607]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  126.988750]  [<c013fc2a>] __get_free_pages+0x2c/0x4f
[  126.993981]  [<c016c561>] __pollwait+0x3a/0xae
[  126.998678]  [<c038fe22>] datagram_poll+0x2b/0xcd
[  127.003642]  [<c03ce48a>] udp_poll+0x22/0xfc
[  127.008164]  [<c0388f06>] sock_poll+0x23/0x2a
[  127.012771]  [<c016c8d1>] do_select+0x217/0x26e
[  127.017560]  [<c016cbc9>] sys_select+0x26a/0x3f7
[  127.022433]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  127.027755] atd           S 00000001     0  3306      1          3309  3293 (NOTLB)
[  127.036075] f7366f38 f7366f28 00000004 00000001 f7ff1194 f7113180 c21f7264 c21f7264 
[  127.044293]        c17b0f24 f7366f1c c014b59b c21f7264 00000028 f7366f0c 00000000 00000202 
[  127.053419]        c2217fe0 f7366f4c c2217560 00000001 00003e97 1adef83c 00000006 c2330550 
[  127.062543] Call Trace:
[  127.065358]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  127.070649]  [<c040874c>] schedule_timeout_interruptible+0x1a/0x1c
[  127.077202]  [<c012564b>] sys_nanosleep+0xc8/0x147
[  127.082313]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  127.087694] cron          S 00000002     0  3309      1          3315  3306 (NOTLB)
[  127.096017] f72e9f38 f72e9f28 00000004 00000002 00000000 f72e9f50 c016327c bf8c4a0c 
[  127.104149]        f72e9ee4 00000060 00000301 00000000 00000000 00008081 000081a4 00000202 
[  127.113216]        c220ffe0 f72e9f4c c220f560 00000000 00001af4 b1d9ad24 0000000f c048db40 
[  127.122301] Call Trace:
[  127.125101]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  127.130370]  [<c040874c>] schedule_timeout_interruptible+0x1a/0x1c
[  127.136913]  [<c012564b>] sys_nanosleep+0xc8/0x147
[  127.142002]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  127.147358] bash          S 00000002     0  3315      1  3385    3316  3309 (NOTLB)
[  127.155678] f7bc2f08 f7bc2ef8 00000004 00000002 00000044 c215fdf4 c04938a8 000200d2 
[  127.163874]        f78b7a70 f7bc2eec c013f968 000200d2 00000000 c04938a8 00000044 0000000e 
[  127.172995]        c215fdf4 00000010 c220f560 00000000 00002499 aa74e8ec 0000000b c048db40 
[  127.182017] Call Trace:
[  127.184802]  [<c011fa57>] do_wait+0x18a/0x376
[  127.189407]  [<c011fd03>] sys_wait4+0x3e/0x42
[  127.194009]  [<c011fd2e>] sys_waitpid+0x27/0x2b
[  127.198791]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  127.204114] getty         S 00000003     0  3316      1          3317  3315 (NOTLB)
[  127.212334] f7a4ee6c f7a4ee5c 00000004 00000003 c0167f40 c2316580 f7b3d000 f7ec0b38 
[  127.220459]        00000202 f7b15e00 00000202 f7a4ee3c c011c6dd 00000001 00000000 00000000 
[  127.229487]        f7b15e00 ffffffff c2227560 00000003 0000245c 5da0f3bd 00000006 c2337a70 
[  127.238512] Call Trace:
[  127.241293]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  127.246522]  [<c02d7079>] read_chan+0x57c/0x64b
[  127.251306]  [<c02d1be7>] tty_read+0xc9/0xcd
[  127.255825]  [<c0159189>] vfs_read+0xa6/0x17d
[  127.260436]  [<c015950f>] sys_read+0x4b/0x75
[  127.264949]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  127.270267] getty         S 00000006     0  3317      1          3318  3316 (NOTLB)
[  127.278487] f78ebe6c f6b0b550 c2227a20 00000006 c0167f40 c2316580 f7b3d000 00000000 
[  127.286611]        c2330030 f7180600 5dec8adc 00000006 f6b0b550 00000003 00000000 f6b0b550 
[  127.295636]        00000000 c2227ec0 c2227560 00000003 00001232 5dec8adc 00000006 f6b0b550 
[  127.304661] Call Trace:
[  127.307446]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  127.312681]  [<c02d7079>] read_chan+0x57c/0x64b
[  127.317467]  [<c02d1be7>] tty_read+0xc9/0xcd
[  127.321982]  [<c0159189>] vfs_read+0xa6/0x17d
[  127.326590]  [<c015950f>] sys_read+0x4b/0x75
[  127.331110]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  127.336429] getty         S 00000003     0  3318      1          3319  3317 (NOTLB)
[  127.344660] f78e7e6c f78e7e5c 00000004 00000003 c0167f40 c2316580 f7b3d000 f7ec0b38 
[  127.352792]        00000202 f78ba400 00000202 f78e7e3c c011c6dd 00000001 00000000 00000000 
[  127.361817]        f78ba400 ffffffff c2227560 00000003 000011c4 5ded2ac3 00000006 c2337a70 
[  127.370842] Call Trace:
[  127.373625]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  127.378851]  [<c02d7079>] read_chan+0x57c/0x64b
[  127.383633]  [<c02d1be7>] tty_read+0xc9/0xcd
[  127.388151]  [<c0159189>] vfs_read+0xa6/0x17d
[  127.392757]  [<c015950f>] sys_read+0x4b/0x75
[  127.397276]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  127.403408] getty         S 00000004     0  3319      1          3320  3318 (NOTLB)
[  127.411638] f7ad8e6c f7ad8e5c 00000004 00000004 c0167f40 c2316580 f69c8000 f7ec0b38 
[  127.419769]        00000202 f7b53000 00000202 f7ad8e3c c011c6dd 00000001 00000000 00000000 
[  127.428795]        f7b53000 ffffffff c221f560 00000002 0000154d 603f2ae7 00000006 c2330030 
[  127.437822] Call Trace:
[  127.440610]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  127.445846]  [<c02d7079>] read_chan+0x57c/0x64b
[  127.450634]  [<c02d1be7>] tty_read+0xc9/0xcd
[  127.455149]  [<c0159189>] vfs_read+0xa6/0x17d
[  127.459755]  [<c015950f>] sys_read+0x4b/0x75
[  127.464276]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  127.469597] getty         S 00000004     0  3320      1                3319 (NOTLB)
[  127.477824] f7a29e6c f7a29e5c 00000004 00000004 c0167f40 c2316580 f69c8000 f7ec0b38 
[  127.485955]        00000202 f6c81000 00000202 f7a29e3c c011c6dd 00000001 00000000 00000000 
[  127.494985]        f6c81000 ffffffff c221f560 00000002 000012ad 609a8e0f 00000006 c2330030 
[  127.504084] Call Trace:
[  127.506899]  [<c0408730>] schedule_timeout+0xa3/0xa5
[  127.512186]  [<c02d7079>] read_chan+0x57c/0x64b
[  127.517026]  [<c02d1be7>] tty_read+0xc9/0xcd
[  127.521594]  [<c0159189>] vfs_read+0xa6/0x17d
[  127.526254]  [<c015950f>] sys_read+0x4b/0x75
[  127.530822]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  127.536206] writetest     D 00000003     0  3385   3315                     (NOTLB)
[  127.544531] f72c09e4 f72c09d4 00000004 00000003 c0111ca1 00000000 f72c099c c053c988 
[  127.552751]        f72c0a6c c2337a70 f73f41f0 f72c0a3c 00000202 c2227fe0 f72c09f8 00000202 
[  127.561884]        c2227fe0 f72c09f8 c2227560 00000003 00000192 8a911700 0000001c c2337a70 
[  127.571016] Call Trace:
[  127.573832]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  127.579124]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  127.584691]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  127.590254]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  127.595909]  [<c014714d>] shrink_zone+0xe0/0xfa
[  127.600749]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  127.605770]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  127.611243]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  127.616450]  [<c0142d35>] kmem_getpages+0x34/0x9d
[  127.621473]  [<c0143b91>] cache_grow+0xaf/0x16c
[  127.626313]  [<c0143db2>] cache_alloc_refill+0x164/0x207
[  127.631968]  [<c014403b>] kmem_cache_alloc+0x4e/0x50
[  127.637257]  [<c01c4e05>] nfs_create_request+0x3d/0xcc
[  127.642735]  [<c01c9151>] nfs_update_request+0x172/0x1d9
[  127.648369]  [<c01c867e>] nfs_writepage_async+0x36/0x7e
[  127.653934]  [<c01c888f>] nfs_writepage+0x1a8/0x1dc
[  127.659134]  [<c017dd9b>] mpage_writepages+0x232/0x399
[  127.664604]  [<c01c88f1>] nfs_writepages+0x2e/0x11e
[  127.669804]  [<c01416f2>] do_writepages+0x2e/0x53
[  127.674823]  [<c013abd3>] __filemap_fdatawrite_range+0x97/0x99
[  127.681016]  [<c013ac0e>] filemap_fdatawrite+0x39/0x3d
[  127.686486]  [<c01c236a>] nfs_revalidate_mapping+0xd5/0x108
[  127.692411]  [<c01bfddb>] nfs_file_write+0x76/0x115
[  127.697610]  [<c0159307>] do_sync_write+0xa7/0xe7
[  127.702628]  [<c01593ed>] vfs_write+0xa6/0x17d
[  127.707377]  [<c01596ac>] sys_pwrite64+0x7d/0x81
[  127.712307]  [<c0102dd7>] sysenter_past_esp+0x54/0x75
[  130.310296] SysRq : Show Memory
[  130.313648] Mem-info:
[  130.316052] DMA per-cpu:
[  130.318771] cpu 0 hot: low 0, high 0, batch 1 used:0
[  130.323977] cpu 0 cold: low 0, high 0, batch 1 used:0
[  130.329272] cpu 1 hot: low 0, high 0, batch 1 used:0
[  130.334479] cpu 1 cold: low 0, high 0, batch 1 used:0
[  130.339774] cpu 2 hot: low 0, high 0, batch 1 used:0
[  130.344980] cpu 2 cold: low 0, high 0, batch 1 used:0
[  130.350276] cpu 3 hot: low 0, high 0, batch 1 used:0
[  130.355480] cpu 3 cold: low 0, high 0, batch 1 used:0
[  130.360774] DMA32 per-cpu: empty
[  130.364213] Normal per-cpu:
[  130.367203] cpu 0 hot: low 0, high 186, batch 31 used:105
[  130.372861] cpu 0 cold: low 0, high 62, batch 15 used:49
[  130.378428] cpu 1 hot: low 0, high 186, batch 31 used:32
[  130.383966] cpu 1 cold: low 0, high 62, batch 15 used:6
[  130.389414] cpu 2 hot: low 0, high 186, batch 31 used:180
[  130.395041] cpu 2 cold: low 0, high 62, batch 15 used:14
[  130.400577] cpu 3 hot: low 0, high 186, batch 31 used:31
[  130.406148] cpu 3 cold: low 0, high 62, batch 15 used:9
[  130.411623] HighMem per-cpu:
[  130.414701] cpu 0 hot: low 0, high 186, batch 31 used:90
[  130.420267] cpu 0 cold: low 0, high 62, batch 15 used:52
[  130.425834] cpu 1 hot: low 0, high 186, batch 31 used:20
[  130.431399] cpu 1 cold: low 0, high 62, batch 15 used:12
[  130.436966] cpu 2 hot: low 0, high 186, batch 31 used:181
[  130.442623] cpu 2 cold: low 0, high 62, batch 15 used:8
[  130.448099] cpu 3 hot: low 0, high 186, batch 31 used:0
[  130.453576] cpu 3 cold: low 0, high 62, batch 15 used:14
[  130.459143] Free pages:        9528kB (3064kB HighMem)
[  130.464531] Active:459749 inactive:37222 dirty:56603 writeback:241915 unstable:0 free:2382 slab:15300 mapped:9000 pagetables:97
[  130.476527] DMA free:3576kB min:68kB low:84kB high:100kB active:2696kB inactive:404kB present:16384kB pages_scanned:0 all_unreclaimable? no
[  130.489607] lowmem_reserve[]: 0 0 880 2031
[  130.494126] DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[  130.505935] lowmem_reserve[]: 0 0 880 2031
[  130.510455] Normal free:2888kB min:3756kB low:4692kB high:5632kB active:716876kB inactive:96820kB present:901120kB pages_scanned:250 all_unreclaimable? no
[  130.524885] lowmem_reserve[]: 0 0 0 9211
[  130.529223] HighMem free:3064kB min:512kB low:1740kB high:2968kB active:1119424kB inactive:51664kB present:1179092kB pages_scanned:0 all_unreclaimable? no
[  130.543656] lowmem_reserve[]: 0 0 0 0
[  130.547723] DMA: 2*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3576kB
[  130.558613] DMA32: empty
[  130.561332] Normal: 0*4kB 1*8kB 6*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 2888kB
[  130.572499] HighMem: 204*4kB 57*8kB 22*16kB 15*32kB 7*64kB 2*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 3064kB
[  130.584205] Swap cache: add 0, delete 0, find 0/0, race 0+0
[  130.590041] Free swap  = 4200956kB
[  130.593620] Total swap = 4200956kB
[  130.597196] Free swap:       4200956kB
[  130.609675] 524149 pages of RAM
[  130.612986] 294773 pages of HIGHMEM
[  130.616655] 6122 reserved pages
[  130.619961] 399280 pages shared
[  130.623267] 0 pages swap cached
[  130.626575] 56603 pages dirty
[  130.629703] 241915 pages writeback
[  130.633280] 9000 pages mapped
[  130.636407] 15300 pages slab
[  130.639443] 97 pages pagetables

--0-1591606237-1133816681=:17027--
