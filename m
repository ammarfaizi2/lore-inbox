Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264812AbTGBWX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTGBWX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:23:57 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:64970 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264812AbTGBWW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:22:59 -0400
Date: Wed, 02 Jul 2003 15:25:43 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Yet another SDET hang (73-mm3) ... yawn
Message-ID: <570860000.1057184743@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.73-mm3 + feral + highpte (ext2)

Seems to be all wedged up on io_schedule. Not sure if it was
highpte that caused this or not, but I'd done one run on ext2
and one on ext3 without it, and they worked fine.

M.

sdetbench     S EE5119DC  4772  19025   419               (NOTLB)
ed947f70 00000086 fffffe00 ee5119dc ebb546f0 ee511940 c0127076 00000000 
       bffff810 ed947fac ed947f98 ec7db200 ee511940 ee511940 c011efc8 000001a3 
       00000000 000001a3 ed946000 00000008 ee5119dc ed946000 00000001 00000000 
Call Trace:
 [<c0127076>] do_sigaction+0x1d6/0x240
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

pdflush       D 00046C5D  4874      1          4029 19020 (L-TLB)
e9a85e4c 00000046 e9a85e60 00046c5d e9a85ecc eb5d1960 00000246 c3d3a5a0 
       c012308d c3d3a5a0 00000246 ede776a0 eb5d1960 e9a85e88 c0123b10 e9a85e60 
       c3d39bc0 e9a85eb8 c3d3a894 c3d3a894 00046c5d 00000001 4b87ad6e c0123a78 
Call Trace:
 [<c012308d>] add_timer+0x5d/0x6c
 [<c0123b10>] schedule_timeout+0x8c/0xac
 [<c0123a78>] process_timeout+0x0/0xc
 [<c0119df3>] io_schedule_timeout+0x2b/0x38
 [<c01c4baf>] blk_congestion_wait_wq+0x8b/0xa4
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c01c4bd9>] blk_congestion_wait+0x11/0x18
 [<c0135dff>] wb_kupdate+0xcf/0x10c
 [<c01366a9>] __pdflush+0x109/0x1a4
 [<c0136744>] pdflush+0x0/0x14
 [<c013674f>] pdflush+0xb/0x14
 [<c0135d30>] wb_kupdate+0x0/0x10c
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

pdflush       S EC00FFE4  4029      1                4874 (L-TLB)
ec00ffb8 00000046 ec00ffd8 ec00ffe4 ec00e000 ecad6ca0 00000000 00000400 
       00000001 00000000 00000000 ebd64540 ecad6ca0 00000001 c0136631 c0136744 
       00000000 00000000 00000000 c013674f ec00ffd8 ecad6ca0 00000000 00000fe2 
Call Trace:
 [<c0136631>] __pdflush+0x91/0x1a4
 [<c0136744>] pdflush+0x0/0x14
 [<c013674f>] pdflush+0xb/0x14
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

sh            S EBB5478C   419   4772   420               (NOTLB)
ea3edf70 00000082 fffffe00 ebb5478c ebf20d00 ebb546f0 00000000 0000000d 
       bffff880 ea3edfac ea3edf98 eade1ae0 ebb546f0 ebb546f0 c011efc8 ffffffff 
       00000000 ffffffff ea3ec000 00000008 ebb5478c ea3ec000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

spec_auto     S EBF20D9C   420    419   432               (NOTLB)
ed37ff70 00000082 fffffe00 ebf20d9c eea83350 ebf20d00 00000000 00000000 
       bffff1f0 ed37ffac ed37ff98 ebd64540 ebf20d00 ebf20d00 c011efc8 ffffffff 
       00000000 ffffffff ed37e000 00000008 ebf20d9c ed37e000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

make          S EB35872C   432    420   433     434       (NOTLB)
ecbf7f70 00000086 fffffe00 eb35872c edb0d350 eb358690 00000000 eb358690 
       c0118ed8 00000000 00000000 ebbc7ac0 eb358690 eb358690 c011efc8 ffffffff 
       00000000 00000000 ecbf6000 00000000 eb35872c ecbf6000 00000001 00000000 
Call Trace:
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

benchrun      S EDB0D3EC   433    432   439               (NOTLB)
e9d67f70 00000082 fffffe00 edb0d3ec ee4ded00 edb0d350 00000000 00000000 
       bffff570 e9d67fac e9d67f98 eb827ae0 edb0d350 edb0d350 c011efc8 ffffffff 
       00000000 ffffffff e9d66000 00000008 edb0d3ec e9d66000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

tee           S EC0D8270   434    420                 432 (NOTLB)
ea2bbf0c 00000086 ec0d8200 ec0d8270 ea2bbf4c eea83350 00000000 00000000 
       c010ae13 00000000 c010ae32 ee844960 eea83350 ea2bbf38 c0156e00 ee88a360 
       ebc01da0 ec0d8200 00000000 00000000 eea83350 c011aaf4 ea2bbf44 ea2bbf44 
Call Trace:
 [<c010ae13>] do_IRQ+0xb3/0x118
 [<c010ae32>] do_IRQ+0xd2/0x118
 [<c0156e00>] pipe_wait+0x70/0x94
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c0156fc1>] pipe_read+0x19d/0x208
 [<c014105a>] unmap_vma_list+0x1a/0x28
 [<c014bd1c>] vfs_read+0xa0/0xd0
 [<c014bf2d>] sys_read+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

benchrun      S EE4DED9C   439    433   444               (NOTLB)
e9a8ff70 00000086 fffffe00 ee4ded9c ec8180e0 ee4ded00 00000000 00000000 
       bffff0c4 e9a8ffac e9a8ff98 ee620560 ee4ded00 ee4ded00 c011efc8 ffffffff 
       00000000 ffffffff e9a8e000 00000008 ee4ded9c e9a8e000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

make          S EB98136C   444    439   621     446       (NOTLB)
e9b1bf70 00000082 fffffe00 eb98136c eb980040 eb9812d0 00000000 eb9812d0 
       c0118ed8 00000000 00000000 eb458520 eb9812d0 eb9812d0 c011efc8 ffffffff 
       00000000 00000000 e9b1a000 00000000 eb98136c e9b1a000 00000001 00000000 
Call Trace:
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

tee           S EB6077D0   446    439                 444 (NOTLB)
ea1f1f0c 00000086 eb607760 eb6077d0 ea1f1f4c ec8180e0 00000000 ea1f1f2c 
       c011ab0a ea2bbf38 00000001 e9cb1200 ec8180e0 ea1f1f38 c0156e00 ebf57ea0 
       ed41d220 eb607760 00000000 00000000 ec8180e0 c011aaf4 ea1f1f44 ea1f1f44 
Call Trace:
 [<c011ab0a>] autoremove_wake_function+0x16/0x38
 [<c0156e00>] pipe_wait+0x70/0x94
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c0156fc1>] pipe_read+0x19d/0x208
 [<c014bd1c>] vfs_read+0xa0/0xd0
 [<c014bf2d>] sys_read+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EB9800DC   621    444   626               (NOTLB)
e92a7f70 00000086 fffffe00 eb9800dc ecad7900 eb980040 00000000 00000000 
       bfffefa0 e92a7fac e92a7f98 eb4580a0 eb980040 eb980040 c011efc8 ffffffff 
       00000000 ffffffff e92a6000 00000008 eb9800dc e92a6000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

time          S ECAD799C   626    621   627               (NOTLB)
eba3bf70 00000086 fffffe00 ecad799c eab212f0 ecad7900 00000000 0000000f 
       bffff670 eba3bfac eba3bf98 e9bd5360 ecad7900 ecad7900 c011efc8 ffffffff 
       00000000 ffffffff eba3a000 00000008 ecad799c eba3a000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

time          S EAB2138C   627    626   628               (NOTLB)
e937df70 00000082 fffffe00 eab2138c eab20cc0 eab212f0 c0127076 00000000 
       bffff830 e937dfac e937df98 ea0d79e0 eab212f0 eab212f0 c011efc8 ffffffff 
       bffffab0 00000274 e937c000 00000008 eab2138c e937c000 00000001 00000000 
Call Trace:
 [<c0127076>] do_sigaction+0x1d6/0x240
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

run.sdet      S EAB20D5C   628    627   633               (NOTLB)
eb03ff70 00000082 fffffe00 eab20d5c eab20060 eab20cc0 00000000 00000000 
       bffff700 eb03ffac eb03ff98 ea0d76e0 eab20cc0 eab20cc0 c011efc8 ffffffff 
       00000000 ffffffff eb03e000 00000008 eab20d5c eb03e000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

run           S EAB200FC   633    628   635               (NOTLB)
ebecdf70 00000086 fffffe00 eab200fc ec1f6040 eab20060 00000000 0000000f 
       bffff250 ebecdfac ebecdf98 ea0d7860 eab20060 eab20060 c011efc8 ffffffff 
       00000000 ffffffff ebecc000 00000008 eab200fc ebecc000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

driver        S EC1F60DC   635    633   636               (NOTLB)
ec29ff70 00000086 fffffe00 ec1f60dc ec1f6ca0 ec1f6040 00000000 ec29e000 
       ec29ff7c 00000286 ec1f6ca0 ea0d7560 ec1f6040 ec1f6040 c011efc8 0000027c 
       00000000 0000027c ec29e000 ec29ffbc ec1f60dc ec29e000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

driver.exec   S EC1F6D3C   636    635   643               (NOTLB)
ec1cdf70 00000086 fffffe00 ec1f6d3c eb410d00 ec1f6ca0 eb4113d4 eb411330 
       ec1f6ca0 ec1cdfb0 00000286 ea0d7b60 ec1f6ca0 ec1f6ca0 c011efc8 ffffffff 
       00000000 0804b510 ec1cc000 ec1cdfb0 ec1f6d3c ec1cc000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EC8747AC   643    636  1067     645       (NOTLB)
eb0e3f70 00000086 fffffe00 ec8747ac e963ed40 ec874710 00000000 00000000 
       bffff940 eb0e3fac eb0e3f98 ee85bca0 ec874710 ec874710 c011efc8 ffffffff 
       00000000 ffffffff eb0e2000 00000008 ec8747ac eb0e2000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EBDED9FC   645    636  1129     651   643 (NOTLB)
eab75f70 00000086 fffffe00 ebded9fc ea9966d0 ebded960 00000000 00000009 
       bffff940 eab75fac eab75f98 ee85b6a0 ebded960 ebded960 c011efc8 ffffffff 
       00000000 ffffffff eab74000 00000008 ebded9fc eab74000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EA06E7AC   651    636  1141     653   645 (NOTLB)
ea5a5f70 00000086 fffffe00 ea06e7ac ecc06ca0 ea06e710 00000000 00000001 
       bffff940 ea5a5fac ea5a5f98 ebb013a0 ea06e710 ea06e710 c011efc8 ffffffff 
       00000000 ffffffff ea5a4000 00000008 ea06e7ac ea5a4000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EA06F40C   653    636  1109     659   651 (NOTLB)
ea4e5f70 00000082 fffffe00 ea06f40c e93f9980 ea06f370 00000000 0000000d 
       bffff940 ea4e5fac ea4e5f98 eafdaae0 ea06f370 ea06f370 c011efc8 ffffffff 
       00000000 ffffffff ea4e4000 00000008 ea06f40c ea4e4000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EA078D3C   659    636  1088     661   653 (NOTLB)
ed4cbf70 00000086 fffffe00 ea078d3c ea997960 ea078ca0 00000000 00000009 
       bffff940 ed4cbfac ed4cbf98 e91c77c0 ea078ca0 ea078ca0 c011efc8 ffffffff 
       00000000 ffffffff ed4ca000 00000008 ea078d3c ed4ca000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EA0780DC   661    636  1170     662   659 (NOTLB)
eb30bf70 00000082 fffffe00 ea0780dc ee513960 ea078040 00000000 00000000 
       bffff940 eb30bfac eb30bf98 ea0d7ce0 ea078040 ea078040 c011efc8 ffffffff 
       00000000 ffffffff eb30a000 00000008 ea0780dc eb30a000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EA07936C   662    636  1130     670   661 (NOTLB)
eb787f70 00000086 fffffe00 ea07936c e963f9a0 ea0792d0 00000000 00000003 
       bffff940 eb787fac eb787f98 ea0936a0 ea0792d0 ea0792d0 c011efc8 ffffffff 
       00000000 ffffffff eb786000 00000008 ea07936c eb786000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S ED7B47AC   670    636  1242     672   662 (NOTLB)
eaf45f70 00000082 fffffe00 ed7b47ac ebb55980 ed7b4710 00000000 00000000 
       bffff940 eaf45fac eaf45f98 ec112940 ed7b4710 ed7b4710 c011efc8 ffffffff 
       00000000 ffffffff eaf44000 00000008 ed7b47ac eaf44000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EA7B813C   672    636  1079     674   670 (NOTLB)
e8d5bf70 00000086 fffffe00 ea7b813c ebdf2d40 ea7b80a0 00000000 00000003 
       bffff940 e8d5bfac e8d5bf98 e9cb1e00 ea7b80a0 ea7b80a0 c011efc8 ffffffff 
       00000000 ffffffff e8d5a000 00000008 ea7b813c e8d5a000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EA7B876C   674    636  1136     676   672 (NOTLB)
ead29f70 00000086 fffffe00 ea7b876c ec819370 ea7b86d0 00000000 00000004 
       bffff940 ead29fac ead29f98 eb458ca0 ea7b86d0 ea7b86d0 c011efc8 ffffffff 
       00000000 ffffffff ead28000 00000008 ea7b876c ead28000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EA7B93CC   676    636  1226     683   674 (NOTLB)
ec529f70 00000082 fffffe00 ea7b93cc e90886b0 ea7b9330 00000000 00000007 
       bffff940 ec529fac ec529f98 ec5bb380 ea7b9330 ea7b9330 c011efc8 ffffffff 
       00000000 ffffffff ec528000 00000008 ea7b93cc ec528000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EADFD3EC   683    636   859     690   676 (NOTLB)
ead13f70 00000082 fffffe00 eadfd3ec eafb9310 eadfd350 00000000 00000003 
       bffff940 ead13fac ead13f98 ea8ad680 eadfd350 eadfd350 c011efc8 ffffffff 
       00000000 ffffffff ead12000 00000008 eadfd3ec ead12000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S E9B4536C   690    636  1112     696   683 (NOTLB)
eb843f70 00000086 fffffe00 e9b4536c ecad72d0 e9b452d0 00000000 0000000c 
       bffff940 eb843fac eb843f98 eb827960 e9b452d0 e9b452d0 c011efc8 ffffffff 
       00000000 ffffffff eb842000 00000008 e9b4536c eb842000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S EB410D9C   696    636  1169           690 (NOTLB)
e9cb9f70 00000086 fffffe00 eb410d9c eea7e0a0 eb410d00 00000000 00000006 
       bffff940 e9cb9fac e9cb9f98 ec7db800 eb410d00 eb410d00 c011efc8 ffffffff 
       00000000 ffffffff e9cb8000 00000008 eb410d9c e9cb8000 00000001 00000000 
Call Trace:
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

make          S EAFB93AC   859    683  1145               (NOTLB)
e99fbf70 00000082 fffffe00 eafb93ac ea62c080 eafb9310 00000000 0000000b 
       c0118ed8 00000000 00000000 ea2b2e20 eafb9310 eafb9310 c011efc8 ffffffff 
       00000000 00000000 e99fa000 00000000 eafb93ac e99fa000 00000001 00000000 
Call Trace:
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

ed            D EB60BE90  1067    643                     (NOTLB)
eb60be54 00000082 c3d81bc0 eb60be90 eb60bea4 e963ed40 eb60be6c 0000000a 
       eb60be6c c0134ef2 f4ca9d68 eade11e0 e963ed40 eb60be60 c0119dbc eb60be90 
       ec7802ac c014ce75 ec7802ac 00000002 00000000 00079430 c038e7c0 00000000 
Call Trace:
 [<c0134ef2>] __pagevec_free+0x1a/0x24
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c01916d2>] ext2_free_blocks+0x26a/0x278
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c01604a6>] dput+0x18a/0x1b8
 [<c014caaf>] __fput+0x7f/0xa0
 [<c014ca2c>] fput+0x14/0x18
 [<c014b5ad>] filp_close+0x51/0x5c
 [<c014b60b>] sys_close+0x53/0x6c
 [<c0108cc7>] syscall_call+0x7/0xb

ed            D EAE5DE90  1079    672                     (NOTLB)
eae5de54 00000082 c3d69bc0 eae5de90 eae5dea4 ebdf2d40 0000001c 00000007 
       c038007b ffffffef c01c423f ec5bbc80 ebdf2d40 eae5de60 c0119dbc eae5de90 
       e9fbf78c c014ce75 e9fbf78c 00000002 00000000 00079416 c038e560 00000000 
Call Trace:
 [<c01c423f>] blk_run_queues+0x9b/0xa0
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c01916d2>] ext2_free_blocks+0x26a/0x278
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c01604a6>] dput+0x18a/0x1b8
 [<c014caaf>] __fput+0x7f/0xa0
 [<c014ca2c>] fput+0x14/0x18
 [<c014b5ad>] filp_close+0x51/0x5c
 [<c014b60b>] sys_close+0x53/0x6c
 [<c0108cc7>] syscall_call+0x7/0xb

make          S EA9979FC  1088    659  1118               (NOTLB)
ec2f9f70 00000082 fffffe00 ea9979fc e963e0e0 ea997960 00000000 00000002 
       c0118ed8 00000000 00000000 ee8441e0 ea997960 ea997960 c011efc8 ffffffff 
       00000000 00000000 ec2f8000 00000000 ea9979fc ec2f8000 00000001 00000000 
Call Trace:
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c011efc8>] sys_wait4+0x20c/0x244
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0118ed8>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

ed            D E95EDE90  1112    690                     (NOTLB)
e95ede54 00000086 c3da1bc0 e95ede90 e95edea4 ecad72d0 e95ede6c 0000000e 
       e95ede6c c0134ef2 f20c4210 ec9b8ca0 ecad72d0 e95ede60 c0119dbc e95ede90 
       e9fbf78c c014ce75 e9fbf78c 00000002 00000000 00079412 c038e560 00000000 
Call Trace:
 [<c0134ef2>] __pagevec_free+0x1a/0x24
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c01916d2>] ext2_free_blocks+0x26a/0x278
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c01604a6>] dput+0x18a/0x1b8
 [<c014caaf>] __fput+0x7f/0xa0
 [<c014ca2c>] fput+0x14/0x18
 [<c014b5ad>] filp_close+0x51/0x5c
 [<c014b60b>] sys_close+0x53/0x6c
 [<c0108cc7>] syscall_call+0x7/0xb

cc            D EC605EB4  1118   1088                     (NOTLB)
ec605e78 00000086 c3d59bc0 ec605eb4 ec605ec8 e963e0e0 0000001c 00000005 
       eaa4007b ffffffef c01c423f ee8757c0 e963e0e0 ec605e84 c0119dbc ec605eb4 
       ec780210 c014ce75 ec780210 00000002 00000000 00079444 c038e120 00000000 
Call Trace:
 [<c01c423f>] blk_run_queues+0x9b/0xa0
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c0159e66>] sys_unlink+0xf6/0x138
 [<c0108cc7>] syscall_call+0x7/0xb

ed            D EC3EFE90  1129    645                     (NOTLB)
ec3efe54 00000086 c3d81bc0 ec3efe90 ec3efea4 ea9966d0 ec3efe6c 0000000a 
       ec3efe6c c0134ef2 f4e2c3c0 ea0d7260 ea9966d0 ec3efe60 c0119dbc ec3efe90 
       ec7802ac c014ce75 ec7802ac 00000002 00000000 00079438 c038e7c0 00000000 
Call Trace:
 [<c0134ef2>] __pagevec_free+0x1a/0x24
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c01916d2>] ext2_free_blocks+0x26a/0x278
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c01604a6>] dput+0x18a/0x1b8
 [<c014caaf>] __fput+0x7f/0xa0
 [<c014ca2c>] fput+0x14/0x18
 [<c014b5ad>] filp_close+0x51/0x5c
 [<c014b60b>] sys_close+0x53/0x6c
 [<c0108cc7>] syscall_call+0x7/0xb

ed            D EC3A1E90  1136    674                     (NOTLB)
ec3a1e54 00000086 c3d41bc0 ec3a1e90 ec3a1ea4 ec819370 0000001c 00000002 
       c038007b ffffffef c01c423f eb31f0c0 ec819370 ec3a1e60 c0119dbc ec3a1e90 
       ec7802ac c014ce75 ec7802ac 00000002 00000000 0007943d c038e7c0 00000000 
Call Trace:
 [<c01c423f>] blk_run_queues+0x9b/0xa0
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c01916d2>] ext2_free_blocks+0x26a/0x278
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c01604a6>] dput+0x18a/0x1b8
 [<c014caaf>] __fput+0x7f/0xa0
 [<c014ca2c>] fput+0x14/0x18
 [<c014b5ad>] filp_close+0x51/0x5c
 [<c014b60b>] sys_close+0x53/0x6c
 [<c0108cc7>] syscall_call+0x7/0xb

ed            D EA959E90  1130    662                     (NOTLB)
ea959e54 00000086 c3d69bc0 ea959e90 ea959ea4 e963f9a0 ea959e6c 00000007 
       ea959e6c c0134ef2 f7955398 e9960e60 e963f9a0 ea959e60 c0119dbc ea959e90 
       ec7802ac c014ce75 ec7802ac 00000002 00000000 00079437 c038e7c0 00000000 
Call Trace:
 [<c0134ef2>] __pagevec_free+0x1a/0x24
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c01916d2>] ext2_free_blocks+0x26a/0x278
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c01604a6>] dput+0x18a/0x1b8
 [<c014caaf>] __fput+0x7f/0xa0
 [<c014ca2c>] fput+0x14/0x18
 [<c014b5ad>] filp_close+0x51/0x5c
 [<c014b60b>] sys_close+0x53/0x6c
 [<c0108cc7>] syscall_call+0x7/0xb

cc            D EC78FEB4  1145    859                     (NOTLB)
ec78fe78 00000082 c3d89bc0 ec78feb4 ec78fec8 ea62c080 ec78fec8 0000000b 
       c038e124 ec78007b c3d8007b ebbdd540 ea62c080 ec78fe84 c0119dbc ec78feb4 
       ec780210 c014ce75 ec780210 00000002 00000000 00079448 c038e120 00000000 
Call Trace:
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c0159e66>] sys_unlink+0xf6/0x138
 [<c0108cc7>] syscall_call+0x7/0xb

ed            D EBD7DE90  1141    651                     (NOTLB)
ebd7de54 00000082 c3d91bc0 ebd7de90 ebd7dea4 ecc06ca0 ebd7dea4 0000000c 
       c038e124 c013007b f1e7007b eafda7e0 ecc06ca0 ebd7de60 c0119dbc ebd7de90 
       ec780210 c014ce75 ec780210 00000002 00000000 0007944a c038e120 00000000 
Call Trace:
 [<c013007b>] load_module+0x983/0x9f4
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c01916d2>] ext2_free_blocks+0x26a/0x278
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c01604a6>] dput+0x18a/0x1b8
 [<c014caaf>] __fput+0x7f/0xa0
 [<c014ca2c>] fput+0x14/0x18
 [<c014b5ad>] filp_close+0x51/0x5c
 [<c014b60b>] sys_close+0x53/0x6c
 [<c0108cc7>] syscall_call+0x7/0xb

ed            D ECD25E64  1109    653                     (L-TLB)
ecd25e28 00000046 c3d99bc0 ecd25e64 ecd25e78 e93f9980 ecd25e78 0000000d 
       c038e7c4 c013007b f1f4007b eb8256c0 e93f9980 ecd25e34 c0119dbc ecd25e64 
       ec7802ac c014ce75 ec7802ac 00000002 00000000 0007943c c038e7c0 00000000 
Call Trace:
 [<c013007b>] load_module+0x983/0x9f4
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c01604a6>] dput+0x18a/0x1b8
 [<c014caaf>] __fput+0x7f/0xa0
 [<c014ca2c>] fput+0x14/0x18
 [<c014b5ad>] filp_close+0x51/0x5c
 [<c011dcd8>] put_files_struct+0x54/0xbc
 [<c011e727>] do_exit+0x1ab/0x348
 [<c011e8ea>] sys_exit+0xe/0x10
 [<c0108cc7>] syscall_call+0x7/0xb

ed            D EB583E64  1169    696                     (L-TLB)
eb583e28 00000046 c3d89bc0 eb583e64 eb583e78 eea7e0a0 eb583e78 0000000b 
       00000160 ec78007b c3d8007b ebbdd540 eea7e0a0 eb583e34 c0119dbc eb583e64 
       ec780210 c014ce75 ec780210 00000002 00000000 00079445 c038e120 00000000 
Call Trace:
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c01604a6>] dput+0x18a/0x1b8
 [<c014caaf>] __fput+0x7f/0xa0
 [<c014ca2c>] fput+0x14/0x18
 [<c014b5ad>] filp_close+0x51/0x5c
 [<c011dcd8>] put_files_struct+0x54/0xbc
 [<c011e727>] do_exit+0x1ab/0x348
 [<c011e8ea>] sys_exit+0xe/0x10
 [<c0108cc7>] syscall_call+0x7/0xb

ed            D E9761E64  1170    661                     (L-TLB)
e9761e28 00000046 c3d81bc0 e9761e64 e9761e78 ee513960 0000001c 0000000a 
       00000140 ffffffef c01c423f ec4ab860 ee513960 e9761e34 c0119dbc e9761e64 
       ec780210 c014ce75 ec780210 00000002 00000000 00079447 c038e120 00000000 
Call Trace:
 [<c01c423f>] blk_run_queues+0x9b/0xa0
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c01604a6>] dput+0x18a/0x1b8
 [<c014caaf>] __fput+0x7f/0xa0
 [<c014ca2c>] fput+0x14/0x18
 [<c014b5ad>] filp_close+0x51/0x5c
 [<c011dcd8>] put_files_struct+0x54/0xbc
 [<c011e727>] do_exit+0x1ab/0x348
 [<c011e8ea>] sys_exit+0xe/0x10
 [<c0108cc7>] syscall_call+0x7/0xb

rm            D EB133EB4  1226    676                     (NOTLB)
eb133e78 00000082 c3d51bc0 eb133eb4 eb133ec8 e90886b0 c3d5b760 00000004 
       ec8b19c8 e9fbf78c c3d5b760 e9687c80 e90886b0 eb133e84 c0119dbc eb133eb4 
       e9fbf78c c014ce75 e9fbf78c 00000002 00000000 00079401 c038e560 00000000 
Call Trace:
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c0159e66>] sys_unlink+0xf6/0x138
 [<c0108cc7>] syscall_call+0x7/0xb

rm            D EC7CDEB4  1242    670                     (NOTLB)
ec7cde78 00000082 c3d99bc0 ec7cdeb4 ec7cdec8 ebb55980 ec7cdec8 0000000d 
       c038e7c4 ec7c007b ec78007b eba4c040 ebb55980 ec7cde84 c0119dbc ec7cdeb4 
       ec7802ac c014ce75 ec7802ac 00000002 00000000 00079431 c038e7c0 00000000 
Call Trace:
 [<c0119dbc>] io_schedule+0x28/0x34
 [<c014ce75>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c011aaf4>] autoremove_wake_function+0x0/0x38
 [<c014dec9>] __bread_slow_wq+0x19/0xc0
 [<c014e17c>] __bread+0x2c/0x34
 [<c0195185>] ext2_get_inode+0x99/0xf8
 [<c0195569>] ext2_update_inode+0x35/0x36c
 [<c0193e90>] ext2_delete_inode+0x0/0x6c
 [<c0193ec2>] ext2_delete_inode+0x32/0x6c
 [<c0162df3>] generic_delete_inode+0x6b/0xd4
 [<c0162f94>] generic_drop_inode+0x10/0x20
 [<c016300a>] iput+0x66/0x6c
 [<c0159e66>] sys_unlink+0xf6/0x138
 [<c0108cc7>] syscall_call+0x7/0xb



