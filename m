Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWAJK77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWAJK77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWAJK77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:59:59 -0500
Received: from tornado.reub.net ([202.89.145.182]:37596 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932111AbWAJK76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:59:58 -0500
Message-ID: <43C3936C.7020502@reub.net>
Date: Tue, 10 Jan 2006 23:58:52 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060109)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org>	<43BFD8C1.9030404@reub.net>	<20060107133103.530eb889.akpm@osdl.org>	<43C38932.7070302@reub.net> <20060110023052.0d60a8ea.akpm@osdl.org>
In-Reply-To: <20060110023052.0d60a8ea.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/01/2006 11:30 p.m., Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>> Is there any other information I can gather to help narrow this one down?
> 
> sysrq-t, please.

Here you go:

SysRq : Show State

                                                sibling
   task             PC      pid father child younger older
init          S 00000000     0     1      0     2               (NOTLB)
c1921ec4 00000001 c0373f84 00000000 c0373f80 2d510cb0 00000033 000200d0
        00000044 00000002 00000009 c1920b78 c1920a50 c1920540 c180c060 2d514cf2
        00000033 00003a6e 00000001 c1921000 c0161800 00000282 c01234f1 c1921ed8
Call Trace:
  [<c0161800>] link_path_walk+0x65/0xcb
  [<c01234f1>] lock_timer_base+0x15/0x2f
  [<c012358e>] __mod_timer+0x83/0x9e
  [<c0312382>] schedule_timeout+0x49/0xac
  [<c012dae3>] add_wait_queue+0xf/0x30
  [<c0123e06>] process_timeout+0x0/0x5
  [<c016543b>] do_select+0x2db/0x2f5
  [<c0164fe5>] __pollwait+0x0/0x97
  [<c0165655>] sys_select+0x1e8/0x39c
  [<c0102a57>] sysenter_past_esp+0x54/0x75
migration/0   S 00000082     0     2      1             3       (L-TLB)
c1927fb0 00000001 00000000 00000082 00000002 dffc3a1f 00000009 00000000
        00000000 00000082 00000001 c1920158 c1920030 c036ea20 c1804060 e0360311
        00000009 00000c60 00000000 c1927000 f7904f70 f7904f68 f7904f6c 00000296
Call Trace:
  [<c0117c12>] complete+0x3a/0x4a
  [<c0118a9f>] migration_thread+0x7a/0x104
  [<c0118a25>] migration_thread+0x0/0x104
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
ksoftirqd/0   S C1804060     0     3      1             4     2 (L-TLB)
c1929fb0 c1920a50 c036e880 c1804060 c1921eac e6799862 00000006 f7a47d80
        00000000 00000082 0000000a c1928b78 c1928a50 c036ea20 c1804060 e694e651
        00000006 0000063d 00000000 c1929000 00000000 00193641 f7ca1030 0000000e
Call Trace:
  [<c01206ef>] ksoftirqd+0xba/0xbc
  [<c0120635>] ksoftirqd+0x0/0xbc
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
watchdog/0    S C01157B3     0     4      1             5     3 (L-TLB)
c192af88 00195ca5 c192af30 c01157b3 c1804060 2823ba88 00000034 00000000
        00000002 c1928540 00000001 c1928668 c1928540 c036ea20 c1804060 2823c527
        00000034 00000528 00000000 c192a000 00000000 00200282 c01234f1 c192af9c
Call Trace:
  [<c01157b3>] activate_task+0x9d/0xe7
  [<c01234f1>] lock_timer_base+0x15/0x2f
  [<c012358e>] __mod_timer+0x83/0x9e
  [<c01373ce>] watchdog+0x0/0x62
  [<c0312382>] schedule_timeout+0x49/0xac
  [<c0123e06>] process_timeout+0x0/0x5
  [<c01241a2>] msleep_interruptible+0x31/0x3f
  [<c013740c>] watchdog+0x3e/0x62
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
migration/1   S 00000082     0     5      1             6     4 (L-TLB)
c192bfb0 00000000 00000001 00000082 00000002 c0f4a8b8 00000009 f7bd4380
        00000000 00000082 00000001 c1928158 c1928030 f7a86540 c180c060 c0f791ee
        00000009 00000da7 00000001 c192b000 00000000 f7377f68 f743c540 00000753
Call Trace:
  [<c0118a9f>] migration_thread+0x7a/0x104
  [<c0118a25>] migration_thread+0x0/0x104
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
ksoftirqd/1   S C180C060     0     6      1             7     5 (L-TLB)
c1931fb0 c1928030 c036e880 c180c060 c192bfb0 7bed7983 00000003 00000000
        00000001 00000000 0000000a c1930b78 c1930a50 f7cd2030 c180c060 7c177ddd
        00000003 00000c84 00000001 c1931000 c1804060 001a0cad 00000018 00000018
Call Trace:
  [<c0117d3c>] set_user_nice+0xd0/0x10a
  [<c01206ef>] ksoftirqd+0xba/0xbc
  [<c0120635>] ksoftirqd+0x0/0xbc
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
watchdog/1    S C01157B3     0     7      1             8     6 (L-TLB)
c1932f88 001a29ef c1932f30 c01157b3 c1804060 282397ff 00000034 00000000
        00000002 c1930540 00000009 c1930668 c1930540 c1920540 c180c060 2823a171
        00000034 000004b0 00000001 c1932000 00000000 00000282 c01234f1 c1932f9c
Call Trace:
  [<c01157b3>] activate_task+0x9d/0xe7
  [<c01234f1>] lock_timer_base+0x15/0x2f
  [<c012358e>] __mod_timer+0x83/0x9e
  [<c01373ce>] watchdog+0x0/0x62
  [<c0312382>] schedule_timeout+0x49/0xac
  [<c0123e06>] process_timeout+0x0/0x5
  [<c01241a2>] msleep_interruptible+0x31/0x3f
  [<c013740c>] watchdog+0x3e/0x62
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
events/0      S 00000000     0     8      1             9     7 (L-TLB)
c1935f40 00000000 c193be00 00000000 00000000 1057a540 00000034 00000003
        c042e970 c042e964 0000000a c1930158 c1930030 c036ea20 c1804060 1057b3eb
        00000034 0000081f 00000000 c1935000 00000000 00000001 c1935f40 c0117b55
Call Trace:
  [<c0117b55>] __wake_up+0x32/0x43
  [<c0129cfc>] worker_thread+0x14b/0x247
  [<c0218d95>] flush_to_ldisc+0x0/0x110
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
events/1      S C1B3C000     0     9      1            10     8 (L-TLB)
c1951f40 c18ff800 c18fd440 c1b3c000 c1036760 e45128f1 00000033 00000282
        c18fd440 c0373880 0000000a c1950b78 c1950a50 c1920540 c180c060 e4516b9a
        00000033 00003c6e 00000001 c1951000 00000000 00000001 c1951f40 c0117b55
Call Trace:
  [<c0117b55>] __wake_up+0x32/0x43
  [<c0129cfc>] worker_thread+0x14b/0x247
  [<c01525b3>] cache_reap+0x0/0x17a
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
khelper       S 00800711     0    10      1            11     9 (L-TLB)
c1937f40 00000000 00000000 00800711 c1937f2c bbef926b 00000007 00000000
        00000000 00000000 0000000a c1936b78 c1936a50 f7cb7030 c1804060 bc293651
        00000007 000035af 00000000 c1937000 00000000 00000001 c1920540 c0117b55
Call Trace:
  [<c0117b55>] __wake_up+0x32/0x43
  [<c0129cfc>] worker_thread+0x14b/0x247
  [<c0129908>] __call_usermodehelper+0x0/0x51
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
kthread       S C1B97030     0    11      1    14     162    10 (L-TLB)
c1960f40 f7cb7540 00800711 c1b97030 00000002 9f7eae71 00000009 f79a3880
        00000000 f7904f34 00000009 c1950668 c1950540 f743c540 c1804060 9fa720c2
        00000009 0000070f 00000000 c1960000 00000000 000008ca f7cb7540 c0117b55
Call Trace:
  [<c0117b55>] __wake_up+0x32/0x43
  [<c0129cfc>] worker_thread+0x14b/0x247
  [<c012d83d>] keventd_create_kthread+0x0/0x46
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
kblockd/0     S F7C7DFA8     0    14     11            15       (L-TLB)
c1969f40 00000019 c180c060 f7c7dfa8 f7dc872c 7125ee13 0000000a c012dc60
        00000000 f7c7dfa8 0000000a c1967668 c1967540 c036ea20 c1804060 712612c5
        0000000a 000014ca 00000000 c1969000 00000000 00000001 c1969f40 c0117b55
Call Trace:
  [<c012dc60>] autoremove_wake_function+0x15/0x37
  [<c0117b55>] __wake_up+0x32/0x43
  [<c0129cfc>] worker_thread+0x14b/0x247
  [<c01da433>] blk_unplug_work+0x0/0x6
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
kblockd/1     S F7C7DFA8     0    15     11            16    14 (L-TLB)
c196af40 00000000 00000000 f7c7dfa8 f7dc872c b24106b9 00000021 c012dc60
        00000000 f7c7dfa8 0000000a c1967158 c1967030 c1920540 c180c060 b2411da4
        00000021 00000c8e 00000001 c196a000 00000000 00000001 c196af40 c0117b55
Call Trace:
  [<c012dc60>] autoremove_wake_function+0x15/0x37
  [<c0117b55>] __wake_up+0x32/0x43
  [<c0129cfc>] worker_thread+0x14b/0x247
  [<c01da433>] blk_unplug_work+0x0/0x6
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
kacpid        S C0116ECF     0    16     11           108    15 (L-TLB)
c19cbf40 00000001 c19cbf18 c0116ecf 00000000 01dac4a8 00000000 00000000
        c18049c0 00000000 00000009 c1936668 c1936540 c1920540 c180c060 01db2fa0
        00000000 000007e3 00000001 c19cb000 c1936540 c19cbf2c c0126d68 c1940254
Call Trace:
  [<c0116ecf>] find_busiest_group+0x1ec/0x351
  [<c0126d68>] do_sigaction+0x1a1/0x1f2
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c0129cfc>] worker_thread+0x14b/0x247
  [<c031118f>] schedule+0x31f/0xd03
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
khubd         S 00000004     0   108     11           160    16 (L-TLB)
c1b95f84 00000001 f7d3d420 00000004 000003e8 3624fba8 00000002 c1b95f72
        f7d3ea14 c0269480 0000000a c1b92668 c1b92540 c036ea20 c1804060 3642f8ca
        00000002 00000a25 00000000 c1b95000 00000000 00000002 c036ea20 f7d3ea00
Call Trace:
  [<c0269480>] hub_port_status+0x15/0x7e
  [<c026a9b3>] hub_thread+0x0/0x112
  [<c026aa97>] hub_thread+0xe4/0x112
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
pdflush       S F7C0BF34     0   160     11           161   108 (L-TLB)
f7c0bf94 c0117305 00000002 f7c0bf34 c1950540 927ec3a2 00000000 c1920540
        c1920540 c036e880 0000000a f7c0ab78 f7c0aa50 c1920540 c180c060 928dfdbd
        00000000 000008c6 00000001 f7c0b000 00000000 00000286 c01188d7 00000286
Call Trace:
  [<c0117305>] load_balance_newidle+0x42/0xf2
  [<c01188d7>] set_cpus_allowed+0x73/0x114
  [<c013f125>] pdflush+0x0/0x2d
  [<c013f00c>] __pdflush+0x7c/0x195
  [<c013f14d>] pdflush+0x28/0x2d
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
pdflush       D F7C0CC9C     0   161     11           163   160 (L-TLB)
f7c0ccc0 0140ef60 00000001 f7c0cc9c f7c79fa8 70e90228 0000000a f7c0cc94
        c012dc60 00000000 0000000a f7c0a668 f7c0a540 c036ea20 c1804060 70f43bb2
        0000000a 000b28d7 00000000 f7c0c000 f7c0ccb8 c0117b55 00000000 00000000
Call Trace:
  [<c012dc60>] autoremove_wake_function+0x15/0x37
  [<c0117b55>] __wake_up+0x32/0x43
  [<c0297589>] md_write_start+0xc7/0x159
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c028ef75>] make_request+0x58/0x458
  [<c013ce17>] __alloc_pages+0x57/0x2d2
  [<c01db8f0>] generic_make_request+0xb7/0x12a
  [<c015194a>] cache_init_objs+0x43/0x85
  [<c01db9a9>] submit_bio+0x46/0xd0
  [<c0158eec>] bio_alloc_bioset+0xd9/0x195
  [<c0158863>] submit_bh+0xc0/0x10d
  [<c0158924>] ll_rw_block+0x74/0xc4
  [<c01a7c04>] flush_commit_list+0x1d7/0x50e
  [<c01ac397>] do_journal_end+0x80a/0x971
  [<c01ab374>] journal_end_sync+0x62/0x73
  [<c019a0ca>] reiserfs_sync_fs+0x4f/0x5c
  [<c015a724>] sync_supers+0xa8/0xeb
  [<c013e854>] wb_kupdate+0x3a/0x148
  [<c013f125>] pdflush+0x0/0x2d
  [<c013f043>] __pdflush+0xb3/0x195
  [<c013f14d>] pdflush+0x28/0x2d
  [<c013e81a>] wb_kupdate+0x0/0x148
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
kswapd0       S F7C0A1E3     0   162      1           368    11 (L-TLB)
f7c0df90 f7c0a1da 0000000a f7c0a1e3 f7c0df9c 92eeead4 00000000 00000000
        0000000a f7c0a030 00000008 f7c0a158 f7c0a030 c036ea20 c1804060 92efc785
        00000000 00001a3c 00000000 f7c0d000 c0372060 c036e338 c0124213 f7c0d000
Call Trace:
  [<c0124213>] free_uid+0x11/0x48
  [<c011d088>] daemonize+0x1cb/0x22f
  [<c0141f37>] kswapd+0x117/0x12e
  [<c01029ba>] ret_from_fork+0x6/0x14
  [<c0141e20>] kswapd+0x0/0x12e
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c0141e20>] kswapd+0x0/0x12e
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
aio/0         S C0116ECF     0   163     11           164   161 (L-TLB)
c1b90f40 00000000 c1b90f18 c0116ecf 00000000 92eeead4 00000000 00000001
        c180c9c0 00000000 00000009 c1b8e668 c1b8e540 c036ea20 c1804060 92effd03
        00000000 00000a08 00000000 c1b90000 c1b8e540 c1b90f2c c0126d68 c1ba0d54
Call Trace:
  [<c0116ecf>] find_busiest_group+0x1ec/0x351
  [<c0126d68>] do_sigaction+0x1a1/0x1f2
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c0129cfc>] worker_thread+0x14b/0x247
  [<c031118f>] schedule+0x31f/0xd03
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
aio/1         S 00000000     0   164     11           252   163 (L-TLB)
c1b54f40 00000001 c180c9c0 00000000 c04123bc 92f00d5b 00000000 00000000
        00000000 00000001 00000009 c1b51158 c1b51030 c1920a50 c180c060 92f0389f
        00000000 0000072f 00000001 c1b54000 00000000 c1b54f2c c036ea20 c1b7a4d4
Call Trace:
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c0129cfc>] worker_thread+0x14b/0x247
  [<c031118f>] schedule+0x31f/0xd03
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
kseriod       S C0312ABC     0   252     11           277   164 (L-TLB)
f7cd4f80 00000001 f7cfc868 c0312abc 22222222 53e41492 00000002 00008080
        00000000 f7ceb114 0000000a f7cd2668 f7cd2540 c036ea20 c1804060 53ef5a4a
        00000002 00029830 00000000 f7cd4000 c0383060 f7d3d9c0 f7d3d9c0 c18ff100
Call Trace:
  [<c0312abc>] __mutex_unlock_slowpath+0x6d/0x202
  [<c0229030>] serio_thread+0x0/0x115
  [<c02290ee>] serio_thread+0xbe/0x115
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
ata/0         S C0116ECF     0   277     11           278   252 (L-TLB)
f7cd3f40 00000001 f7cd3f18 c0116ecf 00000000 b6716cff 00000000 00000000
        00000000 00000000 00000009 f7cd2b78 f7cd2a50 c1920a50 c1804060 b672017c
        00000000 00000c77 00000000 f7cd3000 00000000 f7cd3f2c c1950540 f7ced454
Call Trace:
  [<c0116ecf>] find_busiest_group+0x1ec/0x351
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c0129cfc>] worker_thread+0x14b/0x247
  [<c031118f>] schedule+0x31f/0xd03
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
ata/1         S C0116ECF     0   278     11           280   277 (L-TLB)
c1b96f40 00000000 c1b96f18 c0116ecf 00000000 b6702aea 00000000 00000001
        c180c9c0 00000000 0000000a c1b92158 c1b92030 c1920540 c180c060 b6723300
        00000000 000008fd 00000001 c1b96000 c1b92030 c1b96f2c c0126d68 c1bc1354
Call Trace:
  [<c0116ecf>] find_busiest_group+0x1ec/0x351
  [<c0126d68>] do_sigaction+0x1a1/0x1f2
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c0129cfc>] worker_thread+0x14b/0x247
  [<c031118f>] schedule+0x31f/0xd03
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
scsi_eh_0     S C031118F     0   280     11           281   278 (L-TLB)
c1b93fb8 c1804060 c03cdfe0 c031118f c1b93fc8 56a412ec 00000001 00000082
        00000002 56734bc4 00000009 c1b92b78 c1b92a50 c036ea20 c1804060 56a4b87d
        00000001 000005eb 00000000 c1b93000 00000001 00000bb2 00000001 c1b93000
Call Trace:
  [<c031118f>] schedule+0x31f/0xd03
  [<c0254522>] scsi_error_handler+0x0/0x9c
  [<c0254565>] scsi_error_handler+0x43/0x9c
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
scsi_eh_1     S C031118F     0   281     11           282   280 (L-TLB)
f7ccefb8 c1804060 c03cdfe0 c031118f f7ccefc8 572a2f76 00000001 00000082
        00000002 572a2f76 0000000a f7ccd158 f7ccd030 c036ea20 c1804060 575584e4
        00000001 00000486 00000000 f7cce000 00000001 00000c04 00000000 f7cce000
Call Trace:
  [<c031118f>] schedule+0x31f/0xd03
  [<c0254522>] scsi_error_handler+0x0/0x9c
  [<c0254565>] scsi_error_handler+0x43/0x9c
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
scsi_eh_2     S C031118F     0   282     11           283   281 (L-TLB)
f7cd0fb8 c1804060 c03cdfe0 c031118f f7cd0fc8 57e0ef48 00000001 00000082
        00000002 57e0ef48 0000000a f7ccdb78 f7ccda50 c036ea20 c1804060 58062a15
        00000001 0000049a 00000000 f7cd0000 00000001 00000b06 00000000 f7cd0000
Call Trace:
  [<c031118f>] schedule+0x31f/0xd03
  [<c0254522>] scsi_error_handler+0x0/0x9c
  [<c0254565>] scsi_error_handler+0x43/0x9c
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
scsi_eh_3     S C031118F     0   283     11           374   282 (L-TLB)
f7cccfb8 c1804060 c03cdfe0 c031118f f7cccfc8 58b6b7bf 00000001 00000082
        00000002 58b6b7bf 00000009 f7ccd668 f7ccd540 c036ea20 c1804060 58b6e355
        00000001 00000532 00000000 f7ccc000 00000001 00000ade 00000000 f7ccc000
Call Trace:
  [<c031118f>] schedule+0x31f/0xd03
  [<c0254522>] scsi_error_handler+0x0/0x9c
  [<c0254565>] scsi_error_handler+0x43/0x9c
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
kirqd         S 00000000     0   368      1           445   162 (L-TLB)
f7cb8f98 00000000 00000002 00000000 c1804060 16c46026 00000034 00000000
        00000000 c19cc1b8 0000000a f7cc1b78 f7cc1a50 c1920540 c180c060 16c47299
        00000034 00000cd4 00000001 f7cb8000 c1804060 00000282 c01234f1 f7cb8fac
Call Trace:
  [<c01234f1>] lock_timer_base+0x15/0x2f
  [<c012358e>] __mod_timer+0x83/0x9e
  [<c0312382>] schedule_timeout+0x49/0xac
  [<c0123e06>] process_timeout+0x0/0x5
  [<c011136e>] balanced_irq+0x7f/0xb5
  [<c01112ef>] balanced_irq+0x0/0xb5
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
md5_raid1     S 00000008     0   374     11           378   283 (L-TLB)
f7cbaf48 f7cba000 c0297e08 00000008 00000001 2fef2d6a 00000033 f7cdc02c
        c01da41a f7d83600 0000000a f7cc1668 f7cc1540 c1920540 c180c060 2ff29043
        00000033 0133f6d5 00000001 f7cba000 00000000 00000282 c01234f1 f7cbaf5c
Call Trace:
  [<c0297e08>] md_check_recovery+0x18/0x435
  [<c01da41a>] generic_unplug_device+0x15/0x21
  [<c01234f1>] lock_timer_base+0x15/0x2f
  [<c012358e>] __mod_timer+0x83/0x9e
  [<c0312382>] schedule_timeout+0x49/0xac
  [<c0123e06>] process_timeout+0x0/0x5
  [<c0296860>] md_thread+0x118/0x15a
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c0296748>] md_thread+0x0/0x15a
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
md4_raid1     S 00000000     0   378     11           382   374 (L-TLB)
f7c7ef48 f7c7e000 c0297e08 00000000 00000000 4d06524d 00000034 00000000
        00000002 f7d83680 0000000a c1bc2b78 c1bc2a50 c1920540 c180c060 4d3dface
        00000034 00748f57 00000001 f7c7e000 00000000 00000282 c01234f1 f7c7ef5c
Call Trace:
  [<c0297e08>] md_check_recovery+0x18/0x435
  [<c01234f1>] lock_timer_base+0x15/0x2f
  [<c012358e>] __mod_timer+0x83/0x9e
  [<c0312382>] schedule_timeout+0x49/0xac
  [<c0123e06>] process_timeout+0x0/0x5
  [<c0296860>] md_thread+0x118/0x15a
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c0296748>] md_thread+0x0/0x15a
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
md3_raid1     S 00000008     0   382     11           386   378 (L-TLB)
f7ca6f48 f7ca6000 c0297e08 00000008 00000001 452bef0e 00000034 00000000
        00000002 f7d83700 0000000a c1b97668 c1b97540 c1920540 c180c060 45446c75
        00000034 0018781a 00000001 f7ca6000 00000000 00000282 c01234f1 f7ca6f5c
Call Trace:
  [<c0297e08>] md_check_recovery+0x18/0x435
  [<c01234f1>] lock_timer_base+0x15/0x2f
  [<c012358e>] __mod_timer+0x83/0x9e
  [<c0312382>] schedule_timeout+0x49/0xac
  [<c0123e06>] process_timeout+0x0/0x5
  [<c0296860>] md_thread+0x118/0x15a
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c0296748>] md_thread+0x0/0x15a
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
md2_raid1     D 00011210     0   386     11           390   382 (L-TLB)
f7c7de84 00000010 c18ec340 00011210 00000001 7826cfa1 00000014 c1000000
        00011210 00000000 0000000a c1b8e158 c1b8e030 c036ea20 c1804060 782777ad
        00000014 00006310 00000000 f7c7d000 c197de8c f76b1b00 c01591d3 f7cdc744
Call Trace:
  [<c01591d3>] bio_clone+0x9c/0xae
  [<c0291855>] md_super_wait+0xdf/0xf2
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c029941f>] bitmap_unplug+0x1c7/0x1ce
  [<c01da3ac>] blk_remove_plug+0x26/0x5d
  [<c0290011>] raid1d+0x7f/0x594
  [<c01234f1>] lock_timer_base+0x15/0x2f
  [<c01236c9>] del_timer_sync+0xa/0x10
  [<c0312389>] schedule_timeout+0x50/0xac
  [<c0296789>] md_thread+0x41/0x15a
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c0296748>] md_thread+0x0/0x15a
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
md1_raid1     S C1804060     0   390     11           393   386 (L-TLB)
c1b81f48 c1b81000 c0297e08 c1804060 0000000a 2e81c970 00000033 00000000
        00000002 f7d83800 0000000a f7ca1b78 f7ca1a50 c036ea20 c1804060 2ead36a6
        00000033 011f143c 00000000 c1b81000 00000000 00200282 c01234f1 c1b81f5c
Call Trace:
  [<c0297e08>] md_check_recovery+0x18/0x435
  [<c01234f1>] lock_timer_base+0x15/0x2f
  [<c012358e>] __mod_timer+0x83/0x9e
  [<c0312382>] schedule_timeout+0x49/0xac
  [<c0123e06>] process_timeout+0x0/0x5
  [<c0296860>] md_thread+0x118/0x15a
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c0296748>] md_thread+0x0/0x15a
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
md0_raid1     D 02E9B0CB     0   393     11           394   390 (L-TLB)
f7c79e2c c04123bc 00000000 02e9b0cb 00000c80 70e8e00b 0000000a 00000246
        f76666c0 f7d07660 0000000a c1b51668 c1b51540 c1920540 c180c060 70f4d67b
        0000000a 00009eaf 00000001 f7c79000 f7cdc744 c1000000 00011210 00000000
Call Trace:
  [<c0291855>] md_super_wait+0xdf/0xf2
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c02987f4>] write_sb_page+0x42/0x71
  [<c02988e5>] write_page+0xc2/0x134
  [<c0293355>] md_update_sb+0x7f/0x15b
  [<c0297f6f>] md_check_recovery+0x17f/0x435
  [<c028ffb3>] raid1d+0x21/0x594
  [<c01234f1>] lock_timer_base+0x15/0x2f
  [<c01236c9>] del_timer_sync+0xa/0x10
  [<c0312389>] schedule_timeout+0x50/0xac
  [<c0296789>] md_thread+0x41/0x15a
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c0296748>] md_thread+0x0/0x15a
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
reiserfs/0    D F7DBBC98     0   394     11           395   393 (L-TLB)
f7c74e9c f7bcce2c 00000000 f7dbbc98 00000000 7718f28d 0000000a ffffffff
        00000000 00000000 0000000a f7c78668 f7c78540 c036ea20 c1804060 77190c89
        0000000a 00000b06 00000000 f7c74000 c16f1540 00000001 00000003 f73849a4
Call Trace:
  [<c03134aa>] __down+0xb7/0x11f
  [<c031118f>] schedule+0x31f/0xd03
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0310e07>] __down_failed+0x7/0xc
  [<c01ac57e>] .text.lock.journal+0x8/0xfe
  [<c01ab3f8>] flush_async_commits+0x73/0x75
  [<c0129d6e>] worker_thread+0x1bd/0x247
  [<c01ab385>] flush_async_commits+0x0/0x75
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
reiserfs/1    D 01406F60     0   395     11                 394 (L-TLB)
c1b85db4 00000000 ffffffff 01406f60 00000082 7826ac88 00000014 f7dc872c
        00000000 c1b85d90 0000000a f7c78b78 f7c78a50 c1920540 c180c060 78271282
        00000014 00005b76 00000001 c1b85000 00000000 00000001 c1b85db4 c0117b55
Call Trace:
  [<c0117b55>] __wake_up+0x32/0x43
  [<c03122f0>] io_schedule+0x26/0x30
  [<c0155877>] sync_buffer+0x30/0x33
  [<c03124b4>] __wait_on_bit+0x42/0x5e
  [<c0155847>] sync_buffer+0x0/0x33
  [<c0312545>] out_of_line_wait_on_bit+0x75/0x7d
  [<c0155847>] sync_buffer+0x0/0x33
  [<c0158eec>] bio_alloc_bioset+0xd9/0x195
  [<c012dc82>] wake_bit_function+0x0/0x3c
  [<c01558db>] __wait_on_buffer+0x24/0x29
  [<c01a78ae>] write_ordered_buffers+0x1cf/0x20e
  [<c01a7469>] write_ordered_chunk+0x0/0x52
  [<c0117305>] load_balance_newidle+0x42/0xf2
  [<c013eaca>] do_writepages+0x23/0x37
  [<c031118f>] schedule+0x31f/0xd03
  [<c01a7e9f>] flush_commit_list+0x472/0x50e
  [<c01ab3f8>] flush_async_commits+0x73/0x75
  [<c0129d6e>] worker_thread+0x1bd/0x247
  [<c01ab385>] flush_async_commits+0x0/0x75
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0129bb1>] worker_thread+0x0/0x247
  [<c012d839>] kthread+0x93/0x97
  [<c012d7a6>] kthread+0x0/0x97
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
udevd         S C0373F84     0   445      1          1297   368 (NOTLB)
f7962ec4 3e8ac045 00000001 c0373f84 00000000 a499fb27 00000009 c013cd7f
        000200d0 00000044 00000007 f7cb7668 f7cb7540 c036ea20 c1804060 a4baa159
        00000009 00013a40 00000000 f7962000 c18e7500 c016cd2d f795d005 c0373f80
Call Trace:
  [<c013cd7f>] get_page_from_freelist+0x6d/0xae
  [<c016cd2d>] mntput_no_expire+0x13/0x5a
  [<c03123a7>] schedule_timeout+0x6e/0xac
  [<c012dae3>] add_wait_queue+0xf/0x30
  [<c0177311>] inotify_poll+0x29/0x55
  [<c016543b>] do_select+0x2db/0x2f5
  [<c0164fe5>] __pollwait+0x0/0x97
  [<c0165655>] sys_select+0x1e8/0x39c
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0102a57>] sysenter_past_esp+0x54/0x75
kjournald     S 00000000     0  1297      1          1357   445 (L-TLB)
f7ca8f74 c011bea4 f7ca8f80 00000000 00000000 fe56316f 00000003 f7a82458
        00000000 00000246 00000003 c1b83668 c1b83540 c036ea20 c1804060 fe57c6c1
        00000003 00002c60 00000000 f7ca8000 00000000 00000001 f7ca8f74 c0117b55
Call Trace:
  [<c011bea4>] vprintk+0x275/0x2a1
  [<c0117b55>] __wake_up+0x32/0x43
  [<c01c4b0d>] kjournald+0x228/0x241
  [<c01029ba>] ret_from_fork+0x6/0x14
  [<c01c48e0>] commit_timeout+0x0/0x5
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c01c48e5>] kjournald+0x0/0x241
  [<c0100fcd>] kernel_thread_helper+0x5/0xb
rc            S 00000003     0  1357      1  1794    1662  1297 (NOTLB)
f7b5ef28 00000000 00000000 00000003 00000000 c092ae32 00000009 c0373fa8
        f7c7ca50 000200d2 00000006 f7c7cb78 f7c7ca50 c036ea20 c1804060 c0c99f7b
        00000009 00014d64 00000000 f7b5e000 0000000e c014003d c17d9a20 c17cb940
Call Trace:
  [<c014003d>] __pagevec_lru_add_active+0xa8/0xb3
  [<c0144d7b>] do_wp_page+0x251/0x2a3
  [<c011ed8e>] do_wait+0x332/0x3d0
  [<c031118f>] schedule+0x31f/0xd03
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c011eeca>] sys_wait4+0x31/0x35
  [<c011eef5>] sys_waitpid+0x27/0x2b
  [<c0102a57>] sysenter_past_esp+0x54/0x75
syslogd       D F7CDC02C     0  1662      1          1665  1357 (NOTLB)
f71eaeb4 c01d848f 00000010 f7cdc02c f7c7dfa8 7162b6e9 0000000a f7bd4380
        00000001 00000000 00000009 c1b3db78 c1b3da50 c1b8e030 c180c060 718720da
        0000000a 0000309b 00000001 f71ea000 00000000 c0117b55 f743c540 00000000
Call Trace:
  [<c01d848f>] elv_set_request+0x1e/0x33
  [<c0117b55>] __wake_up+0x32/0x43
  [<c03122f0>] io_schedule+0x26/0x30
  [<c0138257>] sync_page+0x31/0x3c
  [<c03124b4>] __wait_on_bit+0x42/0x5e
  [<c0138226>] sync_page+0x0/0x3c
  [<c013882f>] wait_on_page_bit+0x75/0x7d
  [<c0138b40>] find_get_pages_tag+0x31/0x6f
  [<c012dc82>] wake_bit_function+0x0/0x3c
  [<c01383f9>] wait_on_page_writeback_range+0x9e/0x104
  [<c0255b0c>] scsi_issue_flush_fn+0x37/0x39
  [<c028ea19>] raid1_issue_flush+0x61/0xd0
  [<c028e9b8>] raid1_issue_flush+0x0/0xd0
  [<c0312abc>] __mutex_unlock_slowpath+0x6d/0x202
  [<c0155d24>] do_fsync+0x78/0xbb
  [<c0102a57>] sysenter_past_esp+0x54/0x75
klogd         S C013CE17     0  1665      1          1676  1662 (NOTLB)
f797fd90 000000d0 00000000 c013ce17 00000044 6f018104 0000000a f7bd4380
        00000000 000200d0 0000000a f7cbd668 f7cbd540 c1b3da50 c180c060 6f372d3f
        0000000a 00006b70 00000001 f797f000 00000000 f6cbd000 f743c540 000004b0
Call Trace:
  [<c013ce17>] __alloc_pages+0x57/0x2d2
  [<c03123a7>] schedule_timeout+0x6e/0xac
  [<c0151b89>] cache_alloc_refill+0x54/0x210
  [<c012dbc6>] prepare_to_wait_exclusive+0x12/0x4c
  [<c030b7bb>] unix_wait_for_peer+0xb7/0xde
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c030c159>] unix_dgram_sendmsg+0x313/0x4e0
  [<c016b5dc>] update_atime+0x45/0x70
  [<c02a0375>] do_sock_write+0xa3/0xba
  [<c02a04bb>] sock_aio_write+0x68/0x6c
  [<c015488f>] do_sync_write+0xc3/0xff
  [<c0117130>] load_balance+0x4e/0x1e1
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c0154a03>] vfs_write+0x138/0x13f
  [<c0154ab5>] sys_write+0x41/0x6a
  [<c0102a57>] sysenter_past_esp+0x54/0x75
named         S F7BD4B80     0  1676      1          1677  1665 (NOTLB)
f7aa3f98 f7cb6f20 c0131948 f7bd4b80 00000001 ba820c84 00000007 00000001
        00000000 00000000 00000009 c1b83158 c1b83030 c036ea20 c1804060 bab043c4
        00000007 0007f858 00000000 f7aa3000 00000014 00000246 bfc30d28 00000008
Call Trace:
  [<c0131948>] futex_wake_op+0x24a/0x44b
  [<c0101d12>] sys_rt_sigsuspend+0xac/0xc8
  [<c0102a57>] sysenter_past_esp+0x54/0x75
named         S 00000010     0  1677      1          1678  1676 (NOTLB)
f7570ebc f7a3d180 00000010 00000010 b7a73324 7b9409ff 00000022 8009d6fc
        f7570e90 c029fabb 00000009 c1b97b78 c1b97a50 c1920540 c180c060 7bb0308a
        00000022 00009fba 00000001 f7570000 99120002 58186dc2 00000000 00000000
Call Trace:
  [<c029fabb>] move_addr_to_user+0x49/0x54
  [<c03123a7>] schedule_timeout+0x6e/0xac
  [<c0131505>] get_futex_key+0x39/0xee
  [<c0117b01>] __wake_up_common+0x39/0x5b
  [<c012dae3>] add_wait_queue+0xf/0x30
  [<c01320b2>] futex_wait+0x1d2/0x23b
  [<c0147ddc>] find_extend_vma+0x12/0x50
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0132362>] do_futex+0x49/0x89
  [<c02a1b78>] sys_socketcall+0x26a/0x271
  [<c013240d>] sys_futex+0x6b/0xbd
  [<c0102a57>] sysenter_past_esp+0x54/0x75
named         D 00000286     0  1678      1          1679  1677 (NOTLB)
f7cb6c24 c02a9645 00000004 00000286 c0151b89 b1c72edd 00000021 c197d01c
        00000246 00000246 00000009 c1bccb78 c1bcca50 c1920540 c180c060 b20076d6
        00000021 0002eb9f 00000001 f7cb6000 c02c4c94 80000000 00000000 f75ec1c0
Call Trace:
  [<c02a9645>] dev_queue_xmit+0x96/0x2ad
  [<c0151b89>] cache_alloc_refill+0x54/0x210
  [<c02c4c94>] ip_finish_output+0x0/0x22f
  [<c03134aa>] __down+0xb7/0x11f
  [<c01a7440>] write_chunk+0x29/0x52
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0310e07>] __down_failed+0x7/0xc
  [<c01ac57e>] .text.lock.journal+0x8/0xfe
  [<c01a8316>] flush_journal_list+0x10f/0x63f
  [<c01a8bc5>] flush_used_journal_lists+0xb1/0xce
  [<c01abb84>] flush_old_journal_lists+0x4a/0x53
  [<c01ac2f4>] do_journal_end+0x767/0x971
  [<c01ab127>] journal_end+0x9d/0xd4
  [<c019aaf4>] reiserfs_dirty_inode+0x77/0x82
  [<c0172b98>] __mark_inode_dirty+0x28/0x177
  [<c01962f9>] reiserfs_file_write+0x229/0x615
  [<c01157b3>] activate_task+0x9d/0xe7
  [<c016cd2d>] mntput_no_expire+0x13/0x5a
  [<c0161800>] link_path_walk+0x65/0xcb
  [<c01e8f90>] copy_to_user+0x4c/0x6a
  [<c015d224>] cp_new_stat64+0xf6/0x108
  [<c0154956>] vfs_write+0x8b/0x13f
  [<c01960d0>] reiserfs_file_write+0x0/0x615
  [<c0154ab5>] sys_write+0x41/0x6a
  [<c0102a57>] sysenter_past_esp+0x54/0x75
named         S 00000001     0  1679      1          1680  1678 (NOTLB)
f7389ebc c18049c0 00000069 00000001 00000001 dd9db4bd 00000026 f7bd4b80
        00000001 c1bcca50 00000009 f7caeb78 f7caea50 c1920540 c180c060 dd9e01b7
        00000026 000047e6 00000001 f7389000 00000000 00000282 c01234f1 f7389ed0
Call Trace:
  [<c01234f1>] lock_timer_base+0x15/0x2f
  [<c012358e>] __mod_timer+0x83/0x9e
  [<c0312382>] schedule_timeout+0x49/0xac
  [<c0131505>] get_futex_key+0x39/0xee
  [<c0123e06>] process_timeout+0x0/0x5
  [<c01320b2>] futex_wait+0x1d2/0x23b
  [<c0147ddc>] find_extend_vma+0x12/0x50
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0132362>] do_futex+0x49/0x89
  [<c01e8ffa>] copy_from_user+0x4c/0x82
  [<c013240d>] sys_futex+0x6b/0xbd
  [<c0102a57>] sysenter_past_esp+0x54/0x75
named         S 00000000     0  1680      1          1702  1679 (NOTLB)
f71ebec4 00000001 c0373f84 00000000 c0373f80 46faf5f5 00000026 000200d0
        00000044 00000002 00000009 f743c158 f743c030 c036ea20 c1804060 470586ad
        00000026 0000379b 00000000 f71eb000 00000000 00200092 c0373f80 000200d0
Call Trace:
  [<c03123a7>] schedule_timeout+0x6e/0xac
  [<c012dae3>] add_wait_queue+0xf/0x30
  [<c02cb342>] tcp_poll+0x14/0x15b
  [<c016543b>] do_select+0x2db/0x2f5
  [<c0164fe5>] __pollwait+0x0/0x97
  [<c0165655>] sys_select+0x1e8/0x39c
  [<c0102a57>] sysenter_past_esp+0x54/0x75
portmap       S 000000D0     0  1702      1          1711  1680 (NOTLB)
f7393f30 c0373f80 f7be8540 000000d0 00000000 8681e029 00000009 00000001
        f7393f34 f7a2d284 00000004 f7be8668 f7be8540 c1920540 c180c060 86969e2d
        00000009 00065fd1 00000001 f7393000 f7b73d18 00200246 c012dae3 f728d100
Call Trace:
  [<c012dae3>] add_wait_queue+0xf/0x30
  [<c03123a7>] schedule_timeout+0x6e/0xac
  [<c02a07ea>] sock_poll+0xc/0xe
  [<c0165864>] do_pollfd+0x5b/0xad
  [<c0165958>] do_poll+0xa2/0xc1
  [<c0165aee>] sys_poll+0x177/0x239
  [<c0164fe5>] __pollwait+0x0/0x97
  [<c0102a57>] sysenter_past_esp+0x54/0x75
mdadm         S 00000A00     0  1711      1          1791  1702 (NOTLB)
f7454e84 c1804060 f7cc1540 00000a00 f7cc1540 e6534d88 00000018 c0115e3c
        32383880 000000b7 00000009 f7a41668 f7a41540 c1920540 c180c060 e654730a
        00000018 00011f68 00000001 f7454000 00000000 ffffffff 01406f60 0000000a
Call Trace:
  [<c0115e3c>] try_to_wake_up+0x6e/0x3dd
  [<c03135be>] __down_interruptible+0xac/0x13c
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c0310e13>] __down_failed_interruptible+0x7/0xc
  [<c02984f3>] .text.lock.md+0xe3/0x130
  [<c0147024>] vma_merge+0xc0/0x1a1
  [<c029122e>] mddev_put+0x13/0x6c
  [<c0170c9c>] seq_read+0x1ec/0x2c5
  [<c0154718>] vfs_read+0x89/0x13d
  [<c0170ab0>] seq_read+0x0/0x2c5
  [<c0154a4b>] sys_read+0x41/0x6a
  [<c0102a57>] sysenter_past_esp+0x54/0x75
acpid         S 000200D0     0  1791      1          1799  1711 (NOTLB)
f7ae8f30 00000044 c013cd7f 000200d0 00000044 bf2526e8 00000009 000200d0
        00000000 c0373f80 00000005 c1bd1b78 c1bd1a50 c036ea20 c1804060 bf4815c5
        00000009 00036e00 00000000 f7ae8000 00000010 c16f7a00 f7b6c9c0 00000cf4
Call Trace:
  [<c013cd7f>] get_page_from_freelist+0x6d/0xae
  [<c03123a7>] schedule_timeout+0x6e/0xac
  [<c02a07ea>] sock_poll+0xc/0xe
  [<c0165864>] do_pollfd+0x5b/0xad
  [<c0165958>] do_poll+0xa2/0xc1
  [<c0165aee>] sys_poll+0x177/0x239
  [<c0164fe5>] __pollwait+0x0/0x97
  [<c0102a57>] sysenter_past_esp+0x54/0x75
S50hplip      S 00000003     0  1794   1357  1801               (NOTLB)
f7b92f28 000200d2 00000044 00000003 00000000 d821d839 00000009 c0373fa8
        f7c73a50 000200d2 00000007 f7c73b78 f7c73a50 c036ea20 c1804060 d827abe2
        00000009 000118b3 00000000 f7b92000 c0149870 c1b9712c c17ca860 fffba000
Call Trace:
  [<c0149870>] anon_vma_prepare+0x20/0xc6
  [<c0144ce8>] do_wp_page+0x1be/0x2a3
  [<c011ed8e>] do_wait+0x332/0x3d0
  [<c031118f>] schedule+0x31f/0xd03
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c011eeca>] sys_wait4+0x31/0x35
  [<c011eef5>] sys_waitpid+0x27/0x2b
  [<c0102a57>] sysenter_past_esp+0x54/0x75
hpiod         S 00000000     0  1799      1                1791 (NOTLB)
f79bce1c f79bcdd8 00000707 00000000 00000000 e22060cd 00000009 00000372
        00000000 c0321bc0 0000000a f7a86668 f7a86540 c1920540 c180c060 e254825f
        00000009 000125b9 00000001 f79bc000 00000000 00000000 00000000 00000000
Call Trace:
  [<c03123a7>] schedule_timeout+0x6e/0xac
  [<c02ca738>] inet_csk_wait_for_connect+0xea/0x112
  [<c030b2c7>] unix_find_other+0xe6/0x121
  [<c012dc4b>] autoremove_wake_function+0x0/0x37
  [<c02ca7c1>] inet_csk_accept+0x61/0x134
  [<c02e6cf4>] inet_accept+0x1f/0xa2
  [<c016a2f5>] alloc_inode+0x15/0x135
  [<c02a0ecc>] sys_accept+0x96/0x14f
  [<c014589f>] do_no_page+0x165/0x27e
  [<c01397d7>] filemap_nopage+0x0/0x3a3
  [<c0145ae8>] __handle_mm_fault+0xc0/0x217
  [<c02a19d4>] sys_socketcall+0xc6/0x271
  [<c0114423>] do_page_fault+0x0/0x5b5
  [<c0102a57>] sysenter_past_esp+0x54/0x75
bash          S F78C4150     0  1801   1794  1802               (NOTLB)
f71b9f28 000200d2 00000031 f78c4150 c0138928 d821bbbc 00000009 c0139ad6
        c1b97030 000200d2 00000005 c1b97158 c1b97030 c1920540 c180c060 d847a0ca
        00000009 0000f6a8 00000001 f71b9000 c17f23c0 c014589f c17d02e0 c17ce140
Call Trace:
  [<c0138928>] find_get_page+0x18/0x3a
  [<c0139ad6>] filemap_nopage+0x2ff/0x3a3
  [<c014589f>] do_no_page+0x165/0x27e
  [<c0144d7b>] do_wp_page+0x251/0x2a3
  [<c011ed8e>] do_wait+0x332/0x3d0
  [<c0117abc>] default_wake_function+0x0/0xc
  [<c011eeca>] sys_wait4+0x31/0x35
  [<c011eef5>] sys_waitpid+0x27/0x2b
  [<c0102a57>] sysenter_past_esp+0x54/0x75
python        D F7DDB6A8     0  1802   1801                     (NOTLB)
f7904b1c c01591d3 f7d89b50 f7ddb6a8 00000001 7eb66828 0000000a c028f2f7
        00000001 00000000 00000007 f743c668 f743c540 c036ea20 c1804060 7ec2673f
        0000000a 000bf8be 00000000 f7904000 00000000 00000001 f7904b1c c0117b55
Call Trace:
  [<c01591d3>] bio_clone+0x9c/0xae
  [<c028f2f7>] make_request+0x3da/0x458
  [<c0117b55>] __wake_up+0x32/0x43
  [<c03122f0>] io_schedule+0x26/0x30
  [<c0155877>] sync_buffer+0x30/0x33
  [<c03124b4>] __wait_on_bit+0x42/0x5e
  [<c0155847>] sync_buffer+0x0/0x33
  [<c0312545>] out_of_line_wait_on_bit+0x75/0x7d
  [<c0155847>] sync_buffer+0x0/0x33
  [<c012dc82>] wake_bit_function+0x0/0x3c
  [<c01558db>] __wait_on_buffer+0x24/0x29
  [<c01a2bf0>] search_by_key+0x12b/0xc4f
  [<c01a2ea6>] search_by_key+0x3e1/0xc4f
  [<c01236c9>] del_timer_sync+0xa/0x10
  [<c0312389>] schedule_timeout+0x50/0xac
  [<c0123e06>] process_timeout+0x0/0x5
  [<c012dc25>] finish_wait+0x25/0x4b
  [<c0191447>] reiserfs_read_locked_inode+0x69/0x105
  [<c016ad00>] get_new_inode+0x5f/0x12f
  [<c019156d>] reiserfs_iget+0x6f/0x86
  [<c01913d0>] reiserfs_init_locked_inode+0x0/0xe
  [<c018cdcc>] reiserfs_lookup+0xb2/0x117
  [<c0160810>] real_lookup+0x1d/0xc6
  [<c0160893>] real_lookup+0xa0/0xc6
  [<c0160acb>] do_lookup+0x6d/0x78
  [<c01611bc>] __link_path_walk+0x6e6/0xcc5
  [<c016cd2d>] mntput_no_expire+0x13/0x5a
  [<c0160d8e>] __link_path_walk+0x2b8/0xcc5
  [<c01617e0>] link_path_walk+0x45/0xcb
  [<c0153e23>] get_unused_fd+0x50/0xb2
  [<c0161ad8>] path_lookup+0x92/0x15a
  [<c0161bda>] __path_lookup_intent_open+0x3a/0x6f
  [<c0161c27>] path_lookup_open+0x18/0x1d
  [<c0162184>] open_namei+0x5a/0x5d2
  [<c015ccf7>] vfs_stat+0x14/0x3a
  [<c0153cb1>] filp_open+0x1c/0x35
  [<c0153e23>] get_unused_fd+0x50/0xb2
  [<c0153f4b>] do_sys_open+0x35/0xb6
  [<c0102a57>] sysenter_past_esp+0x54/0x75

Showing all blocking locks in the system:
S            init:    1 [c1920a50, 116] (not blocked on mutex)
S     migration/0:    2 [c1920030,   0] (not blocked on mutex)
S     ksoftirqd/0:    3 [c1928a50, 134] (not blocked on mutex)
S      watchdog/0:    4 [c1928540,   0] (not blocked on mutex)
S     migration/1:    5 [c1928030,   0] (not blocked on mutex)
S     ksoftirqd/1:    6 [c1930a50, 134] (not blocked on mutex)
S      watchdog/1:    7 [c1930540,   0] (not blocked on mutex)
S        events/0:    8 [c1930030, 110] (not blocked on mutex)
S        events/1:    9 [c1950a50, 110] (not blocked on mutex)
S         khelper:   10 [c1936a50, 110] (not blocked on mutex)
S         kthread:   11 [c1950540, 111] (not blocked on mutex)
S       kblockd/0:   14 [c1967540, 110] (not blocked on mutex)
S       kblockd/1:   15 [c1967030, 110] (not blocked on mutex)
S          kacpid:   16 [c1936540, 111] (not blocked on mutex)
S           khubd:  108 [c1b92540, 110] (not blocked on mutex)
S         pdflush:  160 [f7c0aa50, 120] (not blocked on mutex)
D         pdflush:  161 [f7c0a540, 115] (not blocked on mutex)
S         kswapd0:  162 [f7c0a030, 117] (not blocked on mutex)
S           aio/0:  163 [c1b8e540, 111] (not blocked on mutex)
S           aio/1:  164 [c1b51030, 111] (not blocked on mutex)
S         kseriod:  252 [f7cd2540, 110] (not blocked on mutex)
S           ata/0:  277 [f7cd2a50, 111] (not blocked on mutex)
S           ata/1:  278 [c1b92030, 110] (not blocked on mutex)
S       scsi_eh_0:  280 [c1b92a50, 111] (not blocked on mutex)
S       scsi_eh_1:  281 [f7ccd030, 110] (not blocked on mutex)
S       scsi_eh_2:  282 [f7ccda50, 110] (not blocked on mutex)
S       scsi_eh_3:  283 [f7ccd540, 111] (not blocked on mutex)
S           kirqd:  368 [f7cc1a50, 115] (not blocked on mutex)
S       md5_raid1:  374 [f7cc1540, 110] (not blocked on mutex)
S       md4_raid1:  378 [c1bc2a50, 110] (not blocked on mutex)
S       md3_raid1:  382 [c1b97540, 110] (not blocked on mutex)
D       md2_raid1:  386 [c1b8e030, 110] (not blocked on mutex)
S       md1_raid1:  390 [f7ca1a50, 110] (not blocked on mutex)
D       md0_raid1:  393 [c1b51540, 110] (not blocked on mutex)
D      reiserfs/0:  394 [f7c78540, 110] (not blocked on mutex)
D      reiserfs/1:  395 [f7c78a50, 110] (not blocked on mutex)
S           udevd:  445 [f7cb7540, 113] (not blocked on mutex)
S       kjournald: 1297 [c1b83540, 122] (not blocked on mutex)
S              rc: 1357 [f7c7ca50, 117] (not blocked on mutex)
D         syslogd: 1662 [c1b3da50, 116] (not blocked on mutex)
S           klogd: 1665 [f7cbd540, 115] (not blocked on mutex)
S           named: 1676 [c1b83030, 116] (not blocked on mutex)
S           named: 1677 [c1b97a50, 116] (not blocked on mutex)
D           named: 1678 [c1bcca50, 116] (not blocked on mutex)
S           named: 1679 [f7caea50, 116] (not blocked on mutex)
S           named: 1680 [f743c030, 116] (not blocked on mutex)
S         portmap: 1702 [f7be8540, 121] (not blocked on mutex)
S           mdadm: 1711 [f7a41540, 116] (not blocked on mutex)
S           acpid: 1791 [c1bd1a50, 120] (not blocked on mutex)
S        S50hplip: 1794 [f7c73a50, 116] (not blocked on mutex)
S           hpiod: 1799 [f7a86540, 115] (not blocked on mutex)
S            bash: 1801 [c1b97030, 119] (not blocked on mutex)
D          python: 1802 [f743c540, 118] (not blocked on mutex)

---------------------------
| showing all locks held: |
---------------------------

#001:             [f7dbcc4c] {alloc_super}
.. held by:           pdflush:  161 [f7c0a540, 115]
... acquired at:               sync_supers+0x8d/0xeb

#002:             [f73d62c4] {inode_init_once}
.. held by:            python: 1802 [f743c540, 118]
... acquired at:               real_lookup+0x1d/0xc6

#003:             [f724eb84] {inode_init_once}
.. held by:             named: 1678 [c1bcca50, 116]
... acquired at:               reiserfs_file_write+0x1be/0x615

=============================================


reuben
