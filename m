Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbUKCWOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUKCWOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUKCWMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:12:32 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:15265 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261933AbUKCWCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:02:03 -0500
Subject: truncate issues in 2.6.10-rc1-mm2 ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-mi9Cm3IxIHHVyfeRMlEd"
Organization: 
Message-Id: <1099518385.21024.22.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Nov 2004 13:47:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mi9Cm3IxIHHVyfeRMlEd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

I seem to be running into truncate issues on 2.6.10-rc1-mm2.
Kernel compile hangs. Here is the sysrq-t output for the
process. Do you know ?


cc1           D 000053567a8130b2     0 16244      1         20486 12881
(NOTLB)
00000101a5a09d98 0000000000000006 0000000100000001 000001017b121870
       0000000000076a00 00000101dfff7030 000001017b121b08
0000000000000001
       000053567a81808b ffffffff80198db9
Call Trace:<ffffffff80198db9>{__d_lookup+297}
<ffffffff803fcb30>{__down_write+128}
       <ffffffff8017f8a7>{do_truncate+71}
<ffffffff80198db9>{__d_lookup+297}
       <ffffffff8018e2ff>{get_write_access+79}
<ffffffff8018fd7f>{may_open+511}
       <ffffffff8019151f>{open_namei+815}
<ffffffff8017ebd7>{filp_open+39}
       <ffffffff8017e994>{get_unused_fd+244}
<ffffffff8017ec4c>{sys_open+76}
       <ffffffff801106ae>{system_call+126}


BTW, the compile is hung, so I tried killing it and did make
again. So you see 2 "cc"s. second one is waiting for the first
one to finish up.
 
Thanks,
Badari



--=-mi9Cm3IxIHHVyfeRMlEd
Content-Disposition: attachment; filename=dmesg.out
Content-Type: text/plain; name=dmesg.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

root     16244     1  0 10:27 pts/2    00:00:00 /usr/lib64/gcc-lib/x86_64-suse-linux/3.3.3/cc1 -E -quiet -nostdinc -Iincluderoot     20486     1  0 12:18 pts/2    00:00:00 /usr/lib64/gcc-lib/x86_64-suse-linux/3.3.3/cc1 -quiet -nostdinc -Iinclude -Droot     25379 11567  0 14:23 pts/1    00:00:00 ps -aef

SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 0000603dd13889e6     0     1      0     2               (NOTLB)
000001000641bd88 0000000000000002 0000000100000000 00000101dfff7730 
       0000000000000858 00000101dfff7030 00000101dfff79c8 0000000000000000 
       000000000641be68 0000000000000216 
Call Trace:<ffffffff80142b88>{__mod_timer+344} <ffffffff803fc6f6>{schedule_timeout+166} 
       <ffffffff80142150>{process_timeout+0} <ffffffff801948eb>{do_select+1019} 
       <ffffffff80194050>{__pollwait+0} <ffffffff80194cc6>{sys_select+902} 
       <ffffffff801106ae>{system_call+126} 
migration/0   S 000001000c0046e0     0     2      1             3       (L-TLB)
0000010006427ea8 0000000000000046 0000000000000076 00000101dfff67b0 
       00000000000002b6 00000101bc435870 00000101dfff6a48 000001017a5cde98 
       000001017a5cdea0 0000000000000216 
Call Trace:<ffffffff801354d2>{migration_thread+530} <ffffffff801352c0>{migration_thread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
ksoftirqd/0   S 0000000d7530318f     0     3      1             4     2 (L-TLB)
00000101a0743f08 0000000000000046 0000000000000709 00000101dfff60b0 
       00000000000000c0 ffffffff804f5680 00000101dfff6348 0000000000000001 
       0000000000000000 ffffffff8013e471 
Call Trace:<ffffffff8013e471>{__do_softirq+113} <ffffffff8013e530>{ksoftirqd+0} 
       <ffffffff8013e575>{ksoftirqd+69} <ffffffff8013e530>{ksoftirqd+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
migration/1   S 000001018070d6e0     0     4      1             5     3 (L-TLB)
0000010006429ea8 0000000000000046 0000000100000074 00000101dfff57f0 
       0000000000000299 000001017fe89830 00000101dfff5a88 000001018251de98 
       000001018251dea0 0000000000000216 
Call Trace:<ffffffff801354d2>{migration_thread+530} <ffffffff801352c0>{migration_thread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
ksoftirqd/1   S 0000000e586efdc6     0     5      1             6     4 (L-TLB)
000001019ffb9f08 0000000000000046 0000000100000076 00000101dfff50f0 
       000000000000015a 00000101dfff7030 00000101dfff5388 0000000000000000 
       0000000000000080 ffffffff8013e471 
Call Trace:<ffffffff8013e471>{__do_softirq+113} <ffffffff8013e530>{ksoftirqd+0} 
       <ffffffff8013e530>{ksoftirqd+0} <ffffffff8013e575>{ksoftirqd+69} 
       <ffffffff8013e530>{ksoftirqd+0} <ffffffff8014eec9>{kthread+217} 
       <ffffffff801112ff>{child_rip+8} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
migration/2   S 00000101a070d6e0     0     6      1             7     5 (L-TLB)
000001000642bea8 0000000000000046 0000000200000074 00000101dfff4830 
       0000000000000295 000001017aa5d730 00000101dfff4ac8 00000101a56ebe98 
       00000101a56ebea0 0000000000000216 
Call Trace:<ffffffff801354d2>{migration_thread+530} <ffffffff801352c0>{migration_thread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
ksoftirqd/2   S 0000000000000002     0     7      1             8     6 (L-TLB)
000001019ffbbf08 0000000000000046 0000000200000076 00000101dfff4130 
       000000000000017c 0000010197dad0b0 00000101dfff43c8 0000000000000001 
       0000000000000100 ffffffff8013e471 
Call Trace:<ffffffff8013e471>{__do_softirq+113} <ffffffff8013e530>{ksoftirqd+0} 
       <ffffffff8013e530>{ksoftirqd+0} <ffffffff8013e575>{ksoftirqd+69} 
       <ffffffff8013e530>{ksoftirqd+0} <ffffffff8014eec9>{kthread+217} 
       <ffffffff801112ff>{child_rip+8} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
migration/3   S 00000101c07109a0     0     8      1             9     7 (L-TLB)
000001000642dea8 0000000000000046 0000000300000074 00000101dfff3870 
       0000000000000322 000001017b2cf830 00000101dfff3b08 00000101d38b9e98 
       00000101d38b9ea0 0000000000000216 
Call Trace:<ffffffff801354d2>{migration_thread+530} <ffffffff801352c0>{migration_thread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
ksoftirqd/3   S 0000000c525cd502     0     9      1            10     8 (L-TLB)
00000101a0747f08 0000000000000046 000000030000006f 00000101dfff3170 
       00000000000001e8 000001017cb991b0 00000101dfff3408 0000000000000001 
       0000000000000180 ffffffff8013e471 
Call Trace:<ffffffff8013e471>{__do_softirq+113} <ffffffff8013e530>{ksoftirqd+0} 
       <ffffffff8013e530>{ksoftirqd+0} <ffffffff8013e575>{ksoftirqd+69} 
       <ffffffff8013e530>{ksoftirqd+0} <ffffffff8014eec9>{kthread+217} 
       <ffffffff801112ff>{child_rip+8} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
events/0      S 0000603e784b1439     0    10      1            11     9 (L-TLB)
0000010006431e58 0000000000000046 000000007ffef400 00000101dffe68b0 
       0000000000003715 ffffffff804f5680 00000101dffe6b48 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff801668b2>{cache_reap+2} 
       <ffffffff801668b0>{cache_reap+0} <ffffffff8014a43e>{worker_thread+270} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff8014a330>{worker_thread+0} <ffffffff8014eec9>{kthread+217} 
       <ffffffff801112ff>{child_rip+8} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
events/1      S 0000603eb70be1c8     0    11      1            12    10 (L-TLB)
000001019ffbfe58 0000000000000046 000000019ffefc00 00000101dffe61b0 
       0000000000001b2e 00000101dfff7030 00000101dffe6448 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff801668b0>{cache_reap+0} 
       <ffffffff8014a43e>{worker_thread+270} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff8014a330>{worker_thread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
events/2      S 0000603e700b4059     0    12      1            13    11 (L-TLB)
0000010006433e58 0000000000000046 00000002bffecc00 00000101dffe5730 
       000000000000235f 000001017ffd2770 00000101dffe59c8 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff801668b0>{cache_reap+0} 
       <ffffffff8014a43e>{worker_thread+270} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff8014a330>{worker_thread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
events/3      S 0000603e97f5776e     0    13      1            14    12 (L-TLB)
0000010180749e58 0000000000000046 00000003dffb8400 00000101dffe5030 
       0000000000001653 000001017ffd2070 00000101dffe52c8 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff801668b0>{cache_reap+0} 
       <ffffffff8014a43e>{worker_thread+270} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff8014a330>{worker_thread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
khelper       S 00000101bffe8028     0    14      1            19    13 (L-TLB)
00000101c134be58 0000000000000046 000000000000006f 00000101bffe7770 
       0000000000000630 000001019e0a47f0 00000101bffe7a08 0000000000000001 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff801112f7>{child_rip+0} 
       <ffffffff80149c90>{__call_usermodehelper+0} <ffffffff8014a43e>{worker_thread+270} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff8014a330>{worker_thread+0} <ffffffff8014eec9>{kthread+217} 
       <ffffffff801112ff>{child_rip+8} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
kthread       S 0000000405a7313b     0    19      1    35     204    14 (L-TLB)
00000101c1351e58 0000000000000046 000000000641b850 00000101bffe7070 
       0000000000001298 ffffffff804f5680 00000101bffe7308 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014a43e>{worker_thread+270} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff8014a330>{worker_thread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
kacpid        S 0000000003a25dd6     0    35     19           121       (L-TLB)
00000100dfeb7e58 0000000000000046 00000003dfeb7e28 000001017ffc97b0 
       00000000000041c3 000001017ffd2070 000001017ffc9a48 0000000000000001 
       0000000003917f45 0000000000010000 
Call Trace:<ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014a43e>{worker_thread+270} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014a330>{worker_thread+0} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014eec9>{kthread+217} 
       <ffffffff801112ff>{child_rip+8} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
kblockd/0     S 0000064d92563206     0   121     19           122    35 (L-TLB)
000001019ff4be58 0000000000000046 0000000080619548 000001017ffc90b0 
       000000000000138a ffffffff804f5680 000001017ffc9348 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff802e66c0>{as_work_handler+0} 
       <ffffffff8014a43e>{worker_thread+270} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014a330>{worker_thread+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
kblockd/1     S 000060391a9f8771     0   122     19           123   121 (L-TLB)
00000101dff73e58 0000000000000046 00000001c13e3c00 00000101bff287f0 
       0000000000000999 00000101dfff7030 00000101bff28a88 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff802de390>{blk_unplug_work+0} 
       <ffffffff8014a43e>{worker_thread+270} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014a330>{worker_thread+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
kblockd/2     S 0000603dc236c476     0   123     19           124   122 (L-TLB)
000001000c059e58 0000000000000046 00000002c13e3c00 00000101bff280f0 
       0000000000000b2a 000001017ffd2770 00000101bff28388 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff802de390>{blk_unplug_work+0} 
       <ffffffff8014a43e>{worker_thread+270} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014a330>{worker_thread+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
kblockd/3     S 00000719f07d6759     0   124     19           202   123 (L-TLB)
00000101bff4fe58 0000000000000046 00000003c13e3c00 000001019ff22830 
       0000000000000a45 000001017ffd2070 000001019ff22ac8 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff802de390>{blk_unplug_work+0} 
       <ffffffff8014a43e>{worker_thread+270} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014a330>{worker_thread+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
pdflush       S 00000000192e2863     0   202     19           203   124 (L-TLB)
000001000c06bec8 0000000000000046 000000000000006a 000001019ff22130 
       000000000000055b 00000101bffe7070 000001019ff223c8 00000000fffffffc 
       0000000000000212 ffffffff8014ed70 
Call Trace:<ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff80133b6c>{set_user_nice+204} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8016457b>{pdflush+187} 
       <ffffffff801644c0>{pdflush+0} <ffffffff8014eec9>{kthread+217} 
       <ffffffff801112ff>{child_rip+8} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
pdflush       S 0000603dbc2468c3     0   203     19           208   202 (L-TLB)
00000101bff71ec8 0000000000000046 00000001064abf73 000001019ff3f870 
       0000000000001c4e 00000101dfff7030 000001019ff3fb08 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8016457b>{pdflush+187} 
       <ffffffff801644c0>{pdflush+0} <ffffffff8014eec9>{kthread+217} 
       <ffffffff801112ff>{child_rip+8} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
aio/0         S 000001019ff43828     0   208     19           209   203 (L-TLB)
00000101c13a7e58 0000000000000046 000000000000006b 00000101dff60030 
       0000000000001641 000001019ff44770 00000101dff602c8 0000000000000001 
       0000000019c9b945 0000000000010000 
Call Trace:<ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014a43e>{worker_thread+270} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014a330>{worker_thread+0} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014eec9>{kthread+217} 
       <ffffffff801112ff>{child_rip+8} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
kswapd3       S 0000000019ca1213     0   204      1           205    19 (L-TLB)
00000101bff73ea8 0000000000000046 000000030000007d 000001019ff3f170 
       000000000000186c 00000101dff60730 000001019ff3f408 0000000000000001 
       0000010100000003 ffffffff805c8e40 
Call Trace:<ffffffff8016b2b5>{kswapd+293} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8016b190>{kswapd+0} <ffffffff801112f7>{child_rip+0} 
       
kswapd2       S 0000000019ca2e83     0   205      1           206   204 (L-TLB)
000001000c06dea8 0000000000000046 0000000200000004 00000101dff5f8b0 
       0000000000001891 000001017ffd2770 00000101dff5fb48 0000000000000001 
       0000000000000002 0000000000000000 
Call Trace:<ffffffff8016b2b5>{kswapd+293} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8016b190>{kswapd+0} <ffffffff801112f7>{child_rip+0} 
       
kswapd1       S 0000000019ca4a20     0   206      1           207   205 (L-TLB)
000001019ff6dea8 0000000000000046 0000000100000002 00000101dff5f1b0 
       00000000000015a0 00000101dfff7030 00000101dff5f448 0000000000000001 
       0000000000000001 00000101bffe7770 
Call Trace:<ffffffff8016b2b5>{kswapd+293} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8016b190>{kswapd+0} <ffffffff801112f7>{child_rip+0} 
       
aio/1         S 0000000019cad463     0   209     19           210   208 (L-TLB)
00000101bff75e58 0000000000000046 00000001bff75e28 000001019ff44770 
       00000000000010f6 00000101dfff7030 000001019ff44a08 0000000000000001 
       0000000019caa9ed 0000000000010000 
Call Trace:<ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014a43e>{worker_thread+270} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014a330>{worker_thread+0} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014eec9>{kthread+217} 
       <ffffffff801112ff>{child_rip+8} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
kswapd0       S 0000010000011000     0   207      1           212   206 (L-TLB)
000001000c06fea8 0000000000000046 000000000000007d 00000101dff60730 
       0000000000000e60 00000101dfff7730 00000101dff609c8 00000101dff60730 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8016b2b5>{kswapd+293} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8016b190>{kswapd+0} <ffffffff801112f7>{child_rip+0} 
       
aio/2         S 0000000019cb3ed7     0   210     19           211   209 (L-TLB)
00000101c13a9e58 0000000000000046 00000002c13a9e28 000001019ff44070 
       00000000000013c3 000001017ffd2770 000001019ff44308 0000000000000001 
       0000000019cb023d 0000000000010000 
Call Trace:<ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014a43e>{worker_thread+270} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014a330>{worker_thread+0} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014eec9>{kthread+217} 
       <ffffffff801112ff>{child_rip+8} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
aio/3         S 0000000019cb9551     0   211     19          1005   210 (L-TLB)
000001019ff6fe58 0000000000000046 000000038014a330 000001000c04a7b0 
       00000000000021c4 000001017ffd2070 000001000c04aa48 0000000000000001 
       0000000000000000 0000000000010000 
Call Trace:<ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014a43e>{worker_thread+270} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014a330>{worker_thread+0} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014eec9>{kthread+217} 
       <ffffffff801112ff>{child_rip+8} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014edf0>{kthread+0} <ffffffff801112f7>{child_rip+0} 
       
jfsIO         S 0000000000000000     0   212      1           213   207 (L-TLB)
00000101a07abeb8 0000000000000046 000000000000007d 000001000c04a0b0 
       0000000000001b31 00000101dfff7730 000001000c04a348 ffffffff805135a0 
       ffffffff805135a8 0000000000000216 
Call Trace:<ffffffff80260cb7>{jfsIOWait+311} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff801112ff>{child_rip+8} 
       <ffffffff80260b80>{jfsIOWait+0} <ffffffff801112f7>{child_rip+0} 
       
jfsCommit     S ffffffff806750c8     0   213      1           214   212 (L-TLB)
0000010006465eb8 0000000000000046 000000000000007d 00000101c138e7f0 
       0000000000001196 00000101dfff7730 00000101c138ea88 ffffffff805135a0 
       ffffffff805135a8 0000000000000216 
Call Trace:<ffffffff802645d2>{jfs_lazycommit+674} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff801112ff>{child_rip+8} 
       <ffffffff80264330>{jfs_lazycommit+0} <ffffffff801112f7>{child_rip+0} 
       
jfsCommit     S 0000000000000000     0   214      1           215   213 (L-TLB)
0000010180795eb8 0000000000000046 000000000000007d 00000101c138e0f0 
       0000000000000ccf 00000101dfff7730 00000101c138e388 ffffffff805135a0 
       ffffffff805135a8 0000000000000216 
Call Trace:<ffffffff802645d2>{jfs_lazycommit+674} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff801112ff>{child_rip+8} 
       <ffffffff80264330>{jfs_lazycommit+0} <ffffffff801112f7>{child_rip+0} 
       
jfsCommit     S 0000000000000001     0   215      1           216   214 (L-TLB)
00000101c13cdeb8 0000000000000046 000000000000007d 00000101bff79830 
       0000000000000c24 00000101dfff7730 00000101bff79ac8 ffffffff805135a0 
       ffffffff805135a8 0000000000000216 
Call Trace:<ffffffff802645d2>{jfs_lazycommit+674} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff801112ff>{child_rip+8} 
       <ffffffff80264330>{jfs_lazycommit+0} <ffffffff801112f7>{child_rip+0} 
       
jfsCommit     S 0000000000000002     0   216      1           217   215 (L-TLB)
0000010180797eb8 0000000000000046 000000000000007d 00000101bff79130 
       0000000000000abd 00000101dfff7730 00000101bff793c8 ffffffff805135a0 
       ffffffff805135a8 0000000000000216 
Call Trace:<ffffffff802645d2>{jfs_lazycommit+674} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff801112ff>{child_rip+8} 
       <ffffffff80264330>{jfs_lazycommit+0} <ffffffff801112f7>{child_rip+0} 
       
jfsSync       S 0000000000000003     0   217      1           809   216 (L-TLB)
00000101c13cfea8 0000000000000046 000000000000007d 00000101bff7a870 
       00000000000010c5 00000101dfff7730 00000101bff7ab08 ffffffff805135a0 
       ffffffff805135a8 0000000000000216 
Call Trace:<ffffffff80265632>{jfs_sync+674} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff801112ff>{child_rip+8} 
       <ffffffff80265390>{jfs_sync+0} <ffffffff801112f7>{child_rip+0} 
       
kseriod       S 00000101a07cdf08     0   809      1           890   217 (L-TLB)
00000101a07cdec8 0000000000000046 000000000000007d 00000101bff7a170 
       0000000000002082 00000101dfff7730 00000101bff7a408 0000000000000006 
       00000101bff7a170 00000101bff7a7f4 
Call Trace:<ffffffff802cfedb>{serio_thread+443} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff80135270>{finish_task_switch+64} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8013605e>{schedule_tail+14} <ffffffff801112ff>{child_rip+8} 
       <ffffffff802cfd20>{serio_thread+0} <ffffffff801112f7>{child_rip+0} 
       
scsi_eh_0     S 000001017ff59ef8     0   890      1           891   809 (L-TLB)
000001017ff59dd8 0000000000000046 0000000300000075 00000101c13d61b0 
       00000000000025fc 00000101dfff7730 00000101c13d6448 0000000000000001 
       000000016c0c3490 00000101dfff7730 
Call Trace:<ffffffff803fb68d>{__down_interruptible+205} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff803fcc93>{__down_failed_interruptible+53} 
       <ffffffff803242b5>{.text.lock.scsi_error+45} <ffffffff8013cf58>{do_exit+3160} 
       <ffffffff801112ff>{child_rip+8} <ffffffff80323430>{scsi_error_handler+0} 
       <ffffffff801112f7>{child_rip+0} 
qla2200_0_dpc S 00000001bcd52096     0   891      1           927   890 (L-TLB)
00000101bfe15de8 0000000000000046 0000000000000073 00000101c13d68b0 
       00000000000054af 00000101dfff7730 00000101c13d6b48 0000000000000001 
       00000001bccfc74c 00000101dfff7730 
Call Trace:<ffffffff803fb68d>{__down_interruptible+205} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff803fcc93>{__down_failed_interruptible+53} 
       <ffffffff803492d0>{.text.lock.qla_os+25} <ffffffff8013cf58>{do_exit+3160} 
       <ffffffff801112ff>{child_rip+8} <ffffffff803472c0>{qla2x00_do_dpc+0} 
       <ffffffff801112f7>{child_rip+0} 
scsi_eh_1     S 00000101dfe71ef8     0   927      1           928   891 (L-TLB)
00000101dfe71dd8 0000000000000046 0000000200000076 00000101bff9c770 
       0000000000003d0c 00000101dfff7730 00000101bff9ca08 0000000000000001 
       00000001eccc4bd9 00000101dfff7730 
Call Trace:<ffffffff803fb68d>{__down_interruptible+205} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff803fcc93>{__down_failed_interruptible+53} 
       <ffffffff803242b5>{.text.lock.scsi_error+45} <ffffffff8013cf58>{do_exit+3160} 
       <ffffffff801112ff>{child_rip+8} <ffffffff80323430>{scsi_error_handler+0} 
       <ffffffff801112f7>{child_rip+0} 
qla2200_1_dpc S 00000002466c04c9     0   928      1           969   927 (L-TLB)
000001019fec7de8 0000000000000046 0000000300000073 00000101bff9c070 
       0000000000004706 00000101dfff7730 00000101bff9c308 0000000000000001 
       00000002466b0c60 00000101dfff7730 
Call Trace:<ffffffff803fb68d>{__down_interruptible+205} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff803fcc93>{__down_failed_interruptible+53} 
       <ffffffff803492d0>{.text.lock.qla_os+25} <ffffffff801112ff>{child_rip+8} 
       <ffffffff803472c0>{qla2x00_do_dpc+0} <ffffffff801112f7>{child_rip+0} 
       
scsi_eh_2     S 000001019fdc9ef8     0   969      1          1586   928 (L-TLB)
000001019fdc9dd8 0000000000000046 0000000200000075 000001017fe587b0 
       0000000000004113 00000101dfff7730 000001017fe58a48 0000000000000001 
       000000027a795ce8 00000101dfff7730 
Call Trace:<ffffffff803fb68d>{__down_interruptible+205} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff803fcc93>{__down_failed_interruptible+53} 
       <ffffffff803242b5>{.text.lock.scsi_error+45} <ffffffff8013cf58>{do_exit+3160} 
       <ffffffff801112ff>{child_rip+8} <ffffffff80323430>{scsi_error_handler+0} 
       <ffffffff801112f7>{child_rip+0} 
reiserfs/0    S 0000535658aa8781     0  1005     19          1006   211 (L-TLB)
00000101df8e5e58 0000000000000046 0000000000000000 00000101dff83030 
       000000000000b4ee ffffffff804f5680 00000101dff832c8 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff801e6670>{flush_async_commits+0} 
       <ffffffff8014a43e>{worker_thread+270} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014a330>{worker_thread+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
reiserfs/1    S 0000603b6e25a802     0  1006     19          1007  1005 (L-TLB)
00000100dffd7e58 0000000000000046 0000000100000000 000001017fe580b0 
       000000000000022f 00000101dfff7030 000001017fe58348 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff801e6670>{flush_async_commits+0} 
       <ffffffff8014a43e>{worker_thread+270} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014a330>{worker_thread+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
reiserfs/2    S 0000603dc209188b     0  1007     19          1008  1006 (L-TLB)
00000101bf9f9e58 0000000000000046 0000000200000000 00000101807b37f0 
       0000000000000d5a 000001017ffd2770 00000101807b3a88 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff801e6670>{flush_async_commits+0} 
       <ffffffff8014a43e>{worker_thread+270} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014a330>{worker_thread+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
reiserfs/3    S 0000071c44313fd8     0  1008     19                1007 (L-TLB)
00000100dffd9e58 0000000000000046 0000000300000000 00000101807b30f0 
       00000000000001de 000001017ffd2070 00000101807b3388 0000000000000000 
       0000000000000016 0000000000000003 
Call Trace:<ffffffff80133643>{__wake_up+67} <ffffffff801e6670>{flush_async_commits+0} 
       <ffffffff8014a43e>{worker_thread+270} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014a330>{worker_thread+0} <ffffffff8014ed70>{keventd_create_kthread+0} 
       <ffffffff8014eec9>{kthread+217} <ffffffff801112ff>{child_rip+8} 
       <ffffffff8014ed70>{keventd_create_kthread+0} <ffffffff8014edf0>{kthread+0} 
       <ffffffff801112f7>{child_rip+0} 
irqbalance    S 0000603cb4350562     0  1586      1          3198   969 (NOTLB)
000001017fdb3ee8 0000000000000002 0000000100000000 00000101bf4010f0 
       000000000000e68f 00000101dfff7030 00000101bf401388 0000000000000000 
       000001018070b0e0 0000000000000212 
Call Trace:<ffffffff80142b88>{__mod_timer+344} <ffffffff803fc6f6>{schedule_timeout+166} 
       <ffffffff80142150>{process_timeout+0} <ffffffff80142d11>{sys_nanosleep+193} 
       <ffffffff801106ae>{system_call+126} 
syslogd       R  running task       0  3198      1          3237  1586 (NOTLB)
klogd         S 0000603ecb566a08     0  3237      1          3334  3198 (NOTLB)
00000101db38dbd8 0000000000000002 00000000db38dba8 000001019e2181b0 
       0000000000000609 ffffffff804f5680 000001019e218448 0000000000000001 
       0000603ecb1743cd 00000101bf9e6870 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8037a28c>{alloc_skb+108} 
       <ffffffff8014f1b3>{prepare_to_wait_exclusive+35} <ffffffff803dab28>{unix_wait_for_peer+216} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff80133643>{__wake_up+67} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff8037a905>{memcpy_fromiovec+53} 
       <ffffffff803daf4b>{unix_dgram_sendmsg+987} <ffffffff80375724>{sock_aio_write+340} 
       <ffffffff80180b7d>{do_sync_write+173} <ffffffff80139492>{do_syslog+482} 
       <ffffffff8027749d>{__up_read+29} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff801b35be>{dnotify_parent+46} <ffffffff80180ca7>{vfs_write+247} 
       <ffffffff80180dd3>{sys_write+83} <ffffffff801106ae>{system_call+126} 
       
portmap       S 00001f6b260becb5     0  3334      1          3341  3237 (NOTLB)
000001019e15be88 0000000000000002 0000000000000000 000001019e0a40f0 
       0000000000043ccb ffffffff804f5680 000001019e0a4388 0000000000000000 
       000000009558c000 000001019e0a40f0 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f30c>{add_wait_queue+28} 
       <ffffffff803a1921>{tcp_poll+33} <ffffffff8019441c>{sys_poll+636} 
       <ffffffff80194050>{__pollwait+0} <ffffffff801106ae>{system_call+126} 
       
resmgrd       S 0000000000000000     0  3341      1          3417  3334 (NOTLB)
000001017f65fe88 0000000000000006 0000000000000074 000001019eab4070 
       0000000000006549 00000101d9752730 000001019eab4308 0000000000000206 
       000000007f9aecd8 000001019eab4070 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f30c>{add_wait_queue+28} 
       <ffffffff803d91a5>{unix_poll+21} <ffffffff8019441c>{sys_poll+636} 
       <ffffffff80194050>{__pollwait+0} <ffffffff801106ae>{system_call+126} 
       
hwscand       S 0000000d117657f8     0  3417      1          3453  3341 (NOTLB)
00000101d9815ed8 0000000000000002 0000000100000007 00000101db05a0b0 
       0000000000009b79 00000101dfff7030 00000101db05a348 0000000000000001 
       00000101db05a0b0 ffffffff80133df8 
Call Trace:<ffffffff80133df8>{wake_up_new_task+616} <ffffffff80269e51>{sys_msgrcv+657} 
       <ffffffff8026ab78>{sys_msgget+264} <ffffffff801106ae>{system_call+126} 
       
slpd          S 0000603e541a787b     0  3453      1          3758  3417 (NOTLB)
00000101bf335d88 0000000000000006 0000000000000000 000001019f18e130 
       00000000002ef310 ffffffff804f5680 000001019f18e3c8 0000000000000000 
       000000d000000010 0000000000000206 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f30c>{add_wait_queue+28} 
       <ffffffff8037ac85>{datagram_poll+21} <ffffffff801948eb>{do_select+1019} 
       <ffffffff80194050>{__pollwait+0} <ffffffff80194cc6>{sys_select+902} 
       <ffffffff801106ae>{system_call+126} 
cupsd         S 0000603ea7533d12     0  3713      1         10757  3840 (NOTLB)
000001017fdb9d88 0000000000000006 0000000300000000 000001019e884170 
       000000000000041d 000001017ffd2070 000001019e884408 0000000000000000 
       000000d000000010 0000000000000216 
Call Trace:<ffffffff80142b88>{__mod_timer+344} <ffffffff803fc6f6>{schedule_timeout+166} 
       <ffffffff80142150>{process_timeout+0} <ffffffff801948eb>{do_select+1019} 
       <ffffffff80194050>{__pollwait+0} <ffffffff80194cc6>{sys_select+902} 
       <ffffffff801106ae>{system_call+126} 
sshd          S 0000568e4340a783     0  3758      1 11535    3762  3453 (NOTLB)
000001017f4a3d88 0000000000000006 0000000000000000 00000101d89a7170 
       0000000000c28aba ffffffff804f5680 00000101d89a7408 0000000000000000 
       000000d000000010 0000000000000202 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f30c>{add_wait_queue+28} 
       <ffffffff803a1921>{tcp_poll+33} <ffffffff801948eb>{do_select+1019} 
       <ffffffff80194050>{__pollwait+0} <ffffffff80194cc6>{sys_select+902} 
       <ffffffff803fc193>{thread_return+51} <ffffffff801106ae>{system_call+126} 
       
powersaved    S 0000000a0b2a1d13     0  3762      1          3840  3758 (NOTLB)
00000101bf3c7d88 0000000000000002 0000000000000000 00000101d9752730 
       0000000000003a43 ffffffff804f5680 00000101d97529c8 0000000000000001 
       00000000065f90d0 00000101d9752730 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f30c>{add_wait_queue+28} 
       <ffffffff801948eb>{do_select+1019} <ffffffff80194050>{__pollwait+0} 
       <ffffffff80194cc6>{sys_select+902} <ffffffff801106ae>{system_call+126} 
       
rpc.mountd    S 00000101be5fbbc0     0  3840      1          3713  3762 (NOTLB)
00000100067ddd88 0000000000000006 0000000000000074 00000101d9398130 
       000000000001a3e7 000001019e5920f0 00000101d93983c8 0000000000000202 
       00000000067dddbc 00000101d9398130 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f30c>{add_wait_queue+28} 
       <ffffffff803a1921>{tcp_poll+33} <ffffffff801948eb>{do_select+1019} 
       <ffffffff80194050>{__pollwait+0} <ffffffff80194cc6>{sys_select+902} 
       <ffffffff801106ae>{system_call+126} 
nscd          S 0000603d03da5b9e     0 10757      1         10758  3713 (NOTLB)
00000101b8163e88 0000000000000002 0000000000000000 0000010178f6a030 
       00000000000010a7 ffffffff804f5680 0000010178f6a2c8 0000000000000000 
       00000000b8163ef8 0000000000000216 
Call Trace:<ffffffff80142b88>{__mod_timer+344} <ffffffff803fc6f6>{schedule_timeout+166} 
       <ffffffff80142150>{process_timeout+0} <ffffffff8019441c>{sys_poll+636} 
       <ffffffff80194050>{__pollwait+0} <ffffffff801106ae>{system_call+126} 
       
nscd          S 0000603c8cacac6d     0 10758      1         10759 10757 (NOTLB)
00000101b8741d78 0000000000000002 0000000000000075 00000101d355b8b0 
       0000000000000146 000001017aa5d030 00000101d355bb48 0000000000000001 
       00000101b8741d90 0000000000000047 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f1b3>{prepare_to_wait_exclusive+35} 
       <ffffffff8037b55e>{skb_recv_datagram+398} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff803db414>{unix_accept+116} 
       <ffffffff803765de>{sys_accept+238} <ffffffff801944d7>{sys_poll+823} 
       <ffffffff80194050>{__pollwait+0} <ffffffff801106ae>{system_call+126} 
       
nscd          S 0000603c8b2832bf     0 10759      1         10760 10758 (NOTLB)
00000101b82dbd78 0000000000000002 0000000000002a05 0000010197f48730 
       0000000000000167 ffffffff804f5680 0000010197f489c8 0000000000000001 
       00000101b82dbd90 0000000000000049 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f1b3>{prepare_to_wait_exclusive+35} 
       <ffffffff8037b55e>{skb_recv_datagram+398} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff803db414>{unix_accept+116} 
       <ffffffff803765de>{sys_accept+238} <ffffffff801944d7>{sys_poll+823} 
       <ffffffff80194050>{__pollwait+0} <ffffffff801106ae>{system_call+126} 
       
nscd          S 0000603c8ca9bb9d     0 10760      1         10761 10759 (NOTLB)
00000101b8361d78 0000000000000002 0000000200002a05 00000101bc435170 
       0000000000000f50 000001017ffd2770 00000101bc435408 0000000000000001 
       00000101b8361d90 0000000000000049 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f1b3>{prepare_to_wait_exclusive+35} 
       <ffffffff8037b55e>{skb_recv_datagram+398} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff803db414>{unix_accept+116} 
       <ffffffff803765de>{sys_accept+238} <ffffffff801944d7>{sys_poll+823} 
       <ffffffff80194050>{__pollwait+0} <ffffffff801106ae>{system_call+126} 
       
nscd          S 0000603c8b21de08     0 10761      1         10762 10760 (NOTLB)
00000101b82e3d78 0000000000000002 0000000200000074 000001019816b130 
       00000000000002dd 000001017aa5d730 000001019816b3c8 0000000000000001 
       00000101b82e3d90 0000000000000049 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f1b3>{prepare_to_wait_exclusive+35} 
       <ffffffff8037b55e>{skb_recv_datagram+398} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff803db414>{unix_accept+116} 
       <ffffffff803765de>{sys_accept+238} <ffffffff801944d7>{sys_poll+823} 
       <ffffffff80194050>{__pollwait+0} <ffffffff801106ae>{system_call+126} 
       
nscd          S 0000603c8ca868bb     0 10762      1         10770 10761 (NOTLB)
00000101bc4c9d78 0000000000000002 0000000200002a05 00000101bcb09030 
       00000000000021be 000001017ffd2770 00000101bcb092c8 0000000000000001 
       00000101bc4c9d90 0000000000000049 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f1b3>{prepare_to_wait_exclusive+35} 
       <ffffffff8037b55e>{skb_recv_datagram+398} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff803db414>{unix_accept+116} 
       <ffffffff803765de>{sys_accept+238} <ffffffff801944d7>{sys_poll+823} 
       <ffffffff80194050>{__pollwait+0} <ffffffff801106ae>{system_call+126} 
       
cron          S 000060336001a803     0 10770      1         12038 10762 (NOTLB)
0000010197d8fee8 0000000000000002 0000000200000000 0000010197dad0b0 
       000000000000195f 000001017ffd2770 0000010197dad348 0000000000000000 
       0000000025551cd8 0000000000000212 
Call Trace:<ffffffff80142b88>{__mod_timer+344} <ffffffff803fc6f6>{schedule_timeout+166} 
       <ffffffff80142150>{process_timeout+0} <ffffffff80142d11>{sys_nanosleep+193} 
       <ffffffff801106ae>{system_call+126} 
sshd          S 0000603ecabcc4ed     0 11535   3758 11567   12733       (NOTLB)
0000010179ca3d88 0000000000000002 0000000000000000 00000101d4a2b830 
       0000000000000e4a ffffffff804f5680 00000101d4a2bac8 0000000000000000 
       0000000000000000 0000000000000001 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f30c>{add_wait_queue+28} 
       <ffffffff803a1921>{tcp_poll+33} <ffffffff801948eb>{do_select+1019} 
       <ffffffff80194050>{__pollwait+0} <ffffffff80194cc6>{sys_select+902} 
       <ffffffff801106ae>{system_call+126} 
bash          R  running task       0 11567  11535                     (NOTLB)
mingetty      S 000000264d5c1867     0 12038      1         12039 10770 (NOTLB)
00000101dfa03d78 0000000000000006 0000000200000076 00000101dc82b0b0 
       000000000006adaf 00000101dc82b7b0 00000101dc82b348 0000000000000001 
       00000000000000ff 0000000000000000 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8028400f>{vgacon_cursor+239} 
       <ffffffff8014f30c>{add_wait_queue+28} <ffffffff802bb7c6>{read_chan+1094} 
       <ffffffff802bb2fc>{write_chan+892} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff802b5afa>{tty_ldisc_deref+122} 
       <ffffffff802b6e83>{tty_read+211} <ffffffff80180fd4>{vfs_read+228} 
       <ffffffff80181113>{sys_read+83} <ffffffff801106ae>{system_call+126} 
       
mingetty      S 000000265b155d1e     0 12039      1         12040 12038 (NOTLB)
00000101d73cbd78 0000000000000002 0000000300000001 00000101bf4017f0 
       0000000000051e4b 000001017ffd2070 00000101bf401a88 0000000000000001 
       00000000000000ff 0000000000000000 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff80138b19>{release_console_sem+393} 
       <ffffffff8014f30c>{add_wait_queue+28} <ffffffff802bb7c6>{read_chan+1094} 
       <ffffffff802bb2fc>{write_chan+892} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff802b5afa>{tty_ldisc_deref+122} 
       <ffffffff802b6e83>{tty_read+211} <ffffffff80180fd4>{vfs_read+228} 
       <ffffffff80181113>{sys_read+83} <ffffffff801106ae>{system_call+126} 
       
mingetty      S 000000265b764cf5     0 12040      1         12041 12039 (NOTLB)
00000101d6eb9d78 0000000000000002 0000000000000002 00000101dc82b7b0 
       0000000000379811 ffffffff804f5680 00000101dc82ba48 0000000000000001 
       00000000000000ff 0000000000000000 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff80138b19>{release_console_sem+393} 
       <ffffffff8014f30c>{add_wait_queue+28} <ffffffff802bb7c6>{read_chan+1094} 
       <ffffffff802bb2fc>{write_chan+892} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff802b5afa>{tty_ldisc_deref+122} 
       <ffffffff802b6e83>{tty_read+211} <ffffffff80180fd4>{vfs_read+228} 
       <ffffffff80181113>{sys_read+83} <ffffffff801106ae>{system_call+126} 
       
mingetty      S 00000101dfadc000     0 12041      1         12042 12040 (NOTLB)
00000101d7931d78 0000000000000002 0000000300000076 000001019f18e830 
       0000000000003518 00000101dc82b7b0 000001019f18eac8 0000010006541240 
       0000000000000001 000000264d9956f7 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8013413b>{try_to_wake_up+555} 
       <ffffffff8014f30c>{add_wait_queue+28} <ffffffff802bb7c6>{read_chan+1094} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff802b6e83>{tty_read+211} <ffffffff80180fd4>{vfs_read+228} 
       <ffffffff80181113>{sys_read+83} <ffffffff801106ae>{system_call+126} 
       
mingetty      S 000000265bdc3279     0 12042      1         12043 12041 (NOTLB)
00000101d49b5d78 0000000000000002 0000000300000004 00000101b8aa5070 
       00000000000d795a 000001017ffd2070 00000101b8aa5308 0000000000000000 
       00000000000000ff 0000000000000000 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff80138b19>{release_console_sem+393} 
       <ffffffff8014f30c>{add_wait_queue+28} <ffffffff802bb7c6>{read_chan+1094} 
       <ffffffff802bb2fc>{write_chan+892} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff802b5afa>{tty_ldisc_deref+122} 
       <ffffffff802b6e83>{tty_read+211} <ffffffff80180fd4>{vfs_read+228} 
       <ffffffff80181113>{sys_read+83} <ffffffff801106ae>{system_call+126} 
       
mingetty      S 000001019f231000     0 12043      1         12045 12042 (NOTLB)
00000101d7511d78 0000000000000002 0000000300000076 00000101bf9e6170 
       0000000000001859 00000101dc82b7b0 00000101bf9e6408 0000010198776dc0 
       0000000000000000 0000002653f63df9 
Call Trace:<ffffffff801336be>{task_rq_lock+78} <ffffffff803fc66e>{schedule_timeout+30} 
       <ffffffff8013413b>{try_to_wake_up+555} <ffffffff8014f30c>{add_wait_queue+28} 
       <ffffffff802bb7c6>{read_chan+1094} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff802b6e83>{tty_read+211} 
       <ffffffff80180fd4>{vfs_read+228} <ffffffff80181113>{sys_read+83} 
       <ffffffff801106ae>{system_call+126} 
db2fmcd       S 0000603ea618311f     0 12045      1         12684 12043 (NOTLB)
00000101d5dafee8 0000000000000002 00000000ffff6238 000001017fe89830 
       0000000000000176 ffffffff804f5680 000001017fe89ac8 0000000000000000 
       000001000c0020e0 0000000000000212 
Call Trace:<ffffffff80142b88>{__mod_timer+344} <ffffffff803fc6f6>{schedule_timeout+166} 
       <ffffffff80142150>{process_timeout+0} <ffffffff801599b1>{compat_sys_nanosleep+193} 
       <ffffffff80123d23>{cstar_do_call+27} 
db2dasrrm     S 000000347a1a6514     0 12684      1         12685 12045 (NOTLB)
00000101b83bfd48 0000000000000002 000000020000000e 00000101d89a7870 
       000000000001c710 000001017ffd2770 00000101d89a7b08 0000000000000000 
       00000000cccccccd 0000000000000004 
Call Trace:<ffffffff802b42aa>{extract_entropy+682} <ffffffff803fc66e>{schedule_timeout+30} 
       <ffffffff8037721d>{release_sock+29} <ffffffff803a21b0>{tcp_accept+288} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff803c3ec3>{inet_accept+51} <ffffffff803765de>{sys_accept+238} 
       <ffffffff803a59cd>{tcp_listen_start+365} <ffffffff8037721d>{release_sock+29} 
       <ffffffff803c4538>{inet_listen+120} <ffffffff8038bd50>{compat_sys_socketcall+160} 
       <ffffffff80123d23>{cstar_do_call+27} 
db2dasrrm     S 00005f1b4e2f44db     0 12685      1         12686 12684 (NOTLB)
00000101ba34dee8 0000000000000002 00000001080b78a3 00000101d9398830 
       000000000000de85 00000101dfff7030 00000101d9398ac8 0000000000000000 
       0000000000000000 0000000000000212 
Call Trace:<ffffffff80142b88>{__mod_timer+344} <ffffffff803fc6f6>{schedule_timeout+166} 
       <ffffffff80142150>{process_timeout+0} <ffffffff801599b1>{compat_sys_nanosleep+193} 
       <ffffffff80123d23>{cstar_do_call+27} 
db2dasrrm     S 00005bd56f9e91fd     0 12686      1         12689 12685 (NOTLB)
00000101b9ef3ee8 0000000000000002 0000000256c00a48 00000101bcb09730 
       0000000000006554 000001017ffd2770 00000101bcb099c8 0000000000000000 
       0000000000000000 0000000000000212 
Call Trace:<ffffffff80142b88>{__mod_timer+344} <ffffffff803fc6f6>{schedule_timeout+166} 
       <ffffffff80142150>{process_timeout+0} <ffffffff801599b1>{compat_sys_nanosleep+193} 
       <ffffffff80123d23>{cstar_do_call+27} 
db2dasrrm     S 0000000000000000     0 12689      1         12690 12686 (NOTLB)
000001017b795af8 0000000000000002 0000000000000077 000001019e2188b0 
       0000000000047de4 000001019e884870 000001019e218b48 00000101bed16610 
       000001019eabe9a8 ffffffff801dde48 
Call Trace:<ffffffff801dde48>{pathrelse+40} <ffffffff803fc66e>{schedule_timeout+30} 
       <ffffffff8014f1b3>{prepare_to_wait_exclusive+35} <ffffffff8037b55e>{skb_recv_datagram+398} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff80111149>{error_exit+0} <ffffffff803bd704>{udp_recvmsg+116} 
       <ffffffff80376bc3>{sock_common_recvmsg+51} <ffffffff8037447b>{sock_recvmsg+315} 
       <ffffffff8015dba0>{file_read_actor+0} <ffffffff80192980>{fasync_helper+240} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff80374b90>{sockfd_lookup+32} 
       <ffffffff803762bc>{sys_recvfrom+220} <ffffffff801970ef>{fcntl_setlk+799} 
       <ffffffff80175424>{anon_vma_unlink+132} <ffffffff80170a45>{remove_vm_struct+133} 
       <ffffffff80279b4e>{atomic_dec_and_lock+46} <ffffffff8018171e>{__fput+254} 
       <ffffffff8038bde0>{compat_sys_socketcall+304} <ffffffff80123d23>{cstar_do_call+27} 
       
db2dasrrm     S 0000000000000000     0 12690      1         12691 12689 (NOTLB)
0000010179c8fd48 0000000000000002 0000000000000077 000001019e884870 
       000000000003c08f 00000101dff83730 000001019e884b08 00000101db41d350 

       0000000000000007 00000101a07aec00 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f1b3>{prepare_to_wait_exclusive+35} 
       <ffffffff8037b55e>{skb_recv_datagram+398} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff803db414>{unix_accept+116} 
       <ffffffff803765de>{sys_accept+238} <ffffffff801815fb>{fget+91} 
       <ffffffff803da818>{unix_listen+232} <ffffffff8038bd50>{compat_sys_socketcall+160} 
       <ffffffff80123d23>{cstar_do_call+27} 
db2dasrrm     S 0000003478886fe2     0 12691      1         12715 12690 (NOTLB)
000001017f833d48 0000000000000002 0000000000000b38 00000101dff83730 
       0000000000025752 ffffffff804f5680 00000101dff839c8 0000000000000000 
       0000000000000007 00000101a07aec00 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f1b3>{prepare_to_wait_exclusive+35} 
       <ffffffff8037b55e>{skb_recv_datagram+398} <ffffffff8014f0a0>{autoremove_wake_function+0} 
       <ffffffff8014f0a0>{autoremove_wake_function+0} <ffffffff803db414>{unix_accept+116} 
       <ffffffff803765de>{sys_accept+238} <ffffffff801815fb>{fget+91} 
       <ffffffff803da818>{unix_listen+232} <ffffffff8038bd50>{compat_sys_socketcall+160} 
       <ffffffff80123d23>{cstar_do_call+27} 
db2fmd        S 0000603ea0f421a3     0 12715      1         12881 12691 (NOTLB)
000001019c00bee8 0000000000000002 000000039a8ad2f0 000001019eb2e870 
       0000000000001643 000001017ffd2070 000001019eb2eb08 0000000000000000 
       00000101b9e095f0 0000000000000212 
Call Trace:<ffffffff80142b88>{__mod_timer+344} <ffffffff803fc6f6>{schedule_timeout+166} 
       <ffffffff80142150>{process_timeout+0} <ffffffff801599b1>{compat_sys_nanosleep+193} 
       <ffffffff80123d23>{cstar_do_call+27} 
sshd          S 0000603ea8b61ad3     0 12733   3758 12747   15768 11535 (NOTLB)
000001017c6afd88 0000000000000006 000000007b4350f0 00000101d76d20b0 
       0000000000001f4d ffffffff804f5680 00000101d76d2348 0000000000000000 
       0000000000000000 0000000000000001 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f30c>{add_wait_queue+28} 
       <ffffffff803a1921>{tcp_poll+33} <ffffffff801948eb>{do_select+1019} 
       <ffffffff80194050>{__pollwait+0} <ffffffff80194cc6>{sys_select+902} 
       <ffffffff801106ae>{system_call+126} 
bash          S 000000447f2e29b0     0 12747  12733 12904               (NOTLB)
000001017a12be78 0000000000000006 0000000300000000 000001017fe89130 
       00000000000037d9 000001017ffd2070 000001017fe893c8 0000000000000000 
       00000100066d7728 0000000000000000 
Call Trace:<ffffffff8013c08e>{do_wait+3438} <ffffffff80133df8>{wake_up_new_task+616} 
       <ffffffff80135270>{finish_task_switch+64} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff801106ae>{system_call+126} 
       
agetty        S 000000afee02f734     0 12881      1         16244 12715 (NOTLB)
00000101b88fbd78 0000000000000006 0000000300000212 00000101d76d27b0 
       000000000000c493 000001017ffd2070 00000101d76d2a48 0000000000000000 
       0000000300000000 ffffffff8051b770 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f30c>{add_wait_queue+28} 
       <ffffffff803fcf75>{_spin_unlock_irqrestore+5} <ffffffff802bb7c6>{read_chan+1094} 
       <ffffffff802bb2fc>{write_chan+892} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff80134160>{default_wake_function+0} <ffffffff802b5afa>{tty_ldisc_deref+122} 
       <ffffffff802b6e83>{tty_read+211} <ffffffff80180fd4>{vfs_read+228} 
       <ffffffff80181113>{sys_read+83} <ffffffff801106ae>{system_call+126} 
       
top           S 0000603ea8b542bc     0 12904  12747                     (NOTLB)
00000101d4093d88 0000000000000006 0000000200000010 00000101ba6ec1b0 
       00000000000005b5 000001017ffd2770 00000101ba6ec448 0000000000000000 
       0000000000000000 0000000000000216 
Call Trace:<ffffffff80142b88>{__mod_timer+344} <ffffffff803fc6f6>{schedule_timeout+166} 
       <ffffffff80142150>{process_timeout+0} <ffffffff801948eb>{do_select+1019} 
       <ffffffff80194050>{__pollwait+0} <ffffffff80194cc6>{sys_select+902} 
       <ffffffff801106ae>{system_call+126} 
sshd          S 000060393aaff969     0 15768   3758 15783         12733 (NOTLB)
000001017e1a5d88 0000000000000006 0000000000000000 0000010197dad7b0 
       000000000000212b ffffffff804f5680 0000010197dada48 0000000000000001 
       0000000000000000 0000000000000001 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f30c>{add_wait_queue+28} 
       <ffffffff803a1921>{tcp_poll+33} <ffffffff801948eb>{do_select+1019} 
       <ffffffff80194050>{__pollwait+0} <ffffffff80194cc6>{sys_select+902} 
       <ffffffff801106ae>{system_call+126} 
bash          S 000060393ab92341     0 15783  15768                     (NOTLB)
000001017c54dd78 0000000000000006 0000000200000212 000001019e0a47f0 
       00000000000025a7 000001017ffd2770 000001019e0a4a88 0000000000000000 
       0000000300000000 ffffffff8051b770 
Call Trace:<ffffffff803fc66e>{schedule_timeout+30} <ffffffff8014f30c>{add_wait_queue+28} 
       <ffffffff802bb7c6>{read_chan+1094} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff8014f369>{remove_wait_queue+25} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff802b6e83>{tty_read+211} <ffffffff80180fd4>{vfs_read+228} 
       <ffffffff80181113>{sys_read+83} <ffffffff801106ae>{system_call+126} 
       
cc1           D 000053567a8130b2     0 16244      1         20486 12881 (NOTLB)
00000101a5a09d98 0000000000000006 0000000100000001 000001017b121870 
       0000000000076a00 00000101dfff7030 000001017b121b08 0000000000000001 
       000053567a81808b ffffffff80198db9 
Call Trace:<ffffffff80198db9>{__d_lookup+297} <ffffffff803fcb30>{__down_write+128} 
       <ffffffff8017f8a7>{do_truncate+71} <ffffffff80198db9>{__d_lookup+297} 
       <ffffffff8018e2ff>{get_write_access+79} <ffffffff8018fd7f>{may_open+511} 
       <ffffffff8019151f>{open_namei+815} <ffffffff8017ebd7>{filp_open+39} 
       <ffffffff8017e994>{get_unused_fd+244} <ffffffff8017ec4c>{sys_open+76} 
       <ffffffff801106ae>{system_call+126} 
cc1           D 00005963de381d56     0 20486      1               16244 (NOTLB)
000001017d92bd28 0000000000000006 0000000200000075 000001019816b830 
       0000000000013918 00000101d8c048b0 000001019816bac8 0000000000000010 
       000000d2a5ff5f48 0000000000000246 
Call Trace:<ffffffff803fb7b8>{__down+152} <ffffffff80134160>{default_wake_function+0} 
       <ffffffff803fcc59>{__down_failed+53} <ffffffff801800a4>{.text.lock.open+105} 
       <ffffffff80198db9>{__d_lookup+297} <ffffffff8018e2ff>{get_write_access+79} 
       <ffffffff8018fd7f>{may_open+511} <ffffffff8019151f>{open_namei+815} 
       <ffffffff8017ebd7>{filp_open+39} <ffffffff8017e994>{get_unused_fd+244} 
       <ffffffff8017ec4c>{sys_open+76} <ffffffff801106ae>{system_call+126} 
       

--=-mi9Cm3IxIHHVyfeRMlEd--

