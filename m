Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbTIUUdn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 16:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTIUUdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 16:33:42 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:2508 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S262570AbTIUUd2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 16:33:28 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Process in D state (was Re: 2.6.0-test5-mm2)
Date: Sun, 21 Sep 2003 16:30:06 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030914234843.20cea5b3.akpm@osdl.org> <200309201534.36362.rob@landley.net> <20030920144902.47c2c7c4.akpm@osdl.org>
In-Reply-To: <20030920144902.47c2c7c4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309211630.08735.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 September 2003 17:49, Andrew Morton wrote:

> >  How do I debug this?  (Is there some way to get the output of Ctrl-ScrLk
> > to go to the log instead of just the console?  My system isn't currently
> > hung, it's just got a process that is.  This process being hung prevents
> > my partitions from being unmounted on shutdown, which is annoying.)
>
> sysrq-T followed by `dmesg -s 1000000 > foo' should capture it.

And here it is.  The process in D state is "tar".

Robsys_select+0x2e6/0x530
 [<c0128f00>] do_timer+0xe0/0xf0
 [<c0156518>] vfs_write+0xc8/0x120
 [<c034b286>] sysenter_past_esp+0x43/0x65

kdeinit       S C03B1B5C  1155      1          1162  1153 (NOTLB)
c7793e70 00000086 00000010 c03b1b5c 00000000 000000d0 0000000a c7793e84 
       00000246 0000176a 0f674689 000000a6 c8ce00a0 00061ef0 c7793e84 00000008 
       c7793eac c012908e c7793e84 00061ef0 caeae960 c03b0378 c6cd1e84 00061ef0 
Call Trace:
 [<c012908e>] schedule_timeout+0x5e/0xb0
 [<c0129020>] process_timeout+0x0/0x10
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c034b286>] sysenter_past_esp+0x43/0x65

kdeinit       S C03B1B5C  1162      1          1191  1155 (NOTLB)
c6ea3e70 00000086 00000010 c03b1b5c 00000000 000000d0 816d00fc c6ea3e84 
       00000246 000020ff 0f491dbe 000000a6 c72df350 00062004 c6ea3e84 00000008 
       c6ea3eac c012908e c6ea3e84 00062004 c6ea8ee0 c03b0388 c5545e84 00062004 
Call Trace:
 [<c012908e>] schedule_timeout+0x5e/0xb0
 [<c0129020>] process_timeout+0x0/0x10
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c034b286>] sysenter_past_esp+0x43/0x65
 [<c034007b>] ip_mc_msfilter+0x4b/0x280

artsd         S 00000000  1167   1147          1195       (NOTLB)
c6cfbe70 00200082 bffff2c8 00000000 00000000 c72de6f0 c03b1934 c6cfbe84 
       00200246 000027b7 0a0a36c9 000000a6 c72de6f0 00061d86 c6cfbe84 00000006 
       c6cfbeac c012908e c6cfbe84 00061d86 c034787b c03afeb8 c03afeb8 00061d86 
Call Trace:
 [<c012908e>] schedule_timeout+0x5e/0xb0
 [<c034787b>] unix_poll+0x2b/0xa0
 [<c0129020>] process_timeout+0x0/0x10
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c034b286>] sysenter_past_esp+0x43/0x65

kdeinit       S C03B1B5C  1191      1          1147  1162 (NOTLB)
c6d1be70 00200082 00000010 c03b1b5c 00000000 000000d0 c6d1be88 000000d0 
       c9da86b0 0005e45a 100b4c10 00000098 c72ded20 00000000 7fffffff 00000008 
       c6d1beac c01290dd 00000010 c6d1be94 c6ea8920 00200246 c728f340 c65075a0 
Call Trace:
 [<c01290dd>] schedule_timeout+0xad/0xb0
 [<c0162343>] pipe_poll+0x33/0x80
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c034b286>] sysenter_past_esp+0x43/0x65

kwrapper      S C9AF7EF8  1192   1090                1104 (NOTLB)
c9af7ef8 00000082 00061d4c c9af7ef8 c013236f c9af7edc 000f41a8 c9af7f68 
       00000246 00001749 1280efb3 000000a6 c9da8ce0 c9af6000 000003ea 00000000 
       c9af7f94 c0133089 c9af7f68 00062136 00000000 c9af7f20 c0459e00 c9af6028 
Call Trace:
 [<c013236f>] adjust_abs_time+0xaf/0x120
 [<c0133089>] do_clock_nanosleep+0x1a9/0x2f0
 [<c011df40>] default_wake_function+0x0/0x30
 [<c011df40>] default_wake_function+0x0/0x30
 [<c012d009>] sys_rt_sigaction+0x119/0x140
 [<c0132c20>] nanosleep_wake_up+0x0/0x10
 [<c0132cf0>] sys_nanosleep+0xa0/0x140
 [<c034b286>] sysenter_past_esp+0x43/0x65

kdeinit       S 26CB14AE  1194      1          1197  1147 (NOTLB)
c67ffe70 00000086 c68000e0 26cb14ae 00000098 000000d0 26cb14ae 00000098 
       c68000e0 00001130 26cb14ae 00000098 c68019a0 00000000 7fffffff 00000013 
       c67ffeac c01290dd 00040000 c67ffe94 c034787b c7e2ada0 c57f7cd8 c67fff0c 
Call Trace:
 [<c01290dd>] schedule_timeout+0xad/0xb0
 [<c034787b>] unix_poll+0x2b/0xa0
 [<c02f96b9>] sock_poll+0x29/0x30
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c0128ac6>] update_wall_time+0x16/0x40
 [<c034b286>] sysenter_past_esp+0x43/0x65

kdeinit       S 52DA127F  1195   1147          1200  1167 (NOTLB)
c8ed9e70 00000086 c72de0c0 52da127f 00000099 000000d0 52da127f 00000099 
       c72de0c0 0000463d 52dc8ef0 00000099 c9da9310 00000000 7fffffff 0000000a 
       c8ed9eac c01290dd 00000200 c8ed9e94 c034787b c6d607c0 c64c17f8 c8ed9f0c 
Call Trace:
 [<c01290dd>] schedule_timeout+0xad/0xb0
 [<c034787b>] unix_poll+0x2b/0xa0
 [<c02f96b9>] sock_poll+0x29/0x30
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c0128ac6>] update_wall_time+0x16/0x40
 [<c034b286>] sysenter_past_esp+0x43/0x65
 [<c034007b>] ip_mc_msfilter+0x4b/0x280

kdeinit       S C03B1B5C  1197      1          1199  1194 (NOTLB)
c6cd1e70 00000082 00000010 c03b1b5c 00000000 000000d0 af3dc5b5 c6cd1e84 
       00000246 0000c565 09686f1c 000000a6 c72de0c0 00061ea7 c6cd1e84 00000009 
       c6cd1eac c012908e c6cd1e84 00061ea7 c6ea86a0 c7793e84 c5975e84 00061ea7 
Call Trace:
 [<c012908e>] schedule_timeout+0x5e/0xb0
 [<c0129020>] process_timeout+0x0/0x10
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c034b286>] sysenter_past_esp+0x43/0x65

kdeinit       S 01FB8307  1199      1          1204  1197 (NOTLB)
c5975e70 00000086 c9da86b0 01fb8307 000000a6 000000d0 01fb8307 c5975e84 
       00000246 0000046b 020352b1 000000a6 c6801370 00061e2a c5975e84 00000009 
       c5975eac c012908e c5975e84 00061e2a c6ea85e0 c6cd1e84 c5aa3e84 00061e2a 
Call Trace:
 [<c012908e>] schedule_timeout+0x5e/0xb0
 [<c0129020>] process_timeout+0x0/0x10
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c034b286>] sysenter_past_esp+0x43/0x65
 [<c034007b>] ip_mc_msfilter+0x4b/0x280

kdeinit       S C03B1B5C  1200   1147          1201  1195 (NOTLB)
c50d7e70 00000082 00000010 c03b1b5c 00000000 000000d0 bb603b25 c50d7e84 
       00000246 00000c31 ef250129 000000a5 c6800d40 00061ee3 c50d7e84 00000004 
       c50d7eac c012908e c50d7e84 00061ee3 c034787b c5aa3e84 c03b0378 00061ee3 
Call Trace:
 [<c012908e>] schedule_timeout+0x5e/0xb0
 [<c034787b>] unix_poll+0x2b/0xa0
 [<c0129020>] process_timeout+0x0/0x10
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c0128f00>] do_timer+0xe0/0xf0
 [<c034b286>] sysenter_past_esp+0x43/0x65

autorun       S C5127EF8  1201   1147          1205  1200 (NOTLB)
c5127ef8 00000082 00061b30 c5127ef8 c013236f c5127edc 000f41a8 c5127f68 
       00000246 00000a82 f24e192b 000000a5 c68000e0 c5126000 000003ea 00000000 
       c5127f94 c0133089 c5127f68 00061f1a 00000000 c5127f20 c0459e00 c5126028 
Call Trace:
 [<c013236f>] adjust_abs_time+0xaf/0x120
 [<c0133089>] do_clock_nanosleep+0x1a9/0x2f0
 [<c011df40>] default_wake_function+0x0/0x30
 [<c015e756>] blkdev_put+0xc6/0x1a0
 [<c011df40>] default_wake_function+0x0/0x30
 [<c0132c20>] nanosleep_wake_up+0x0/0x10
 [<c0132cf0>] sys_nanosleep+0xa0/0x140
 [<c034b286>] sysenter_past_esp+0x43/0x65

kdeinit       S 0FEB08DE  1204      1          1209  1199 (NOTLB)
c52d9e70 00000082 c5cd0040 0feb08de 00000098 000000d0 0feb08de 00000098 
       c5cd0040 00020e71 0ffcfa6c 00000098 c5cd1900 00000000 7fffffff 0000000a 
       c52d9eac c01290dd c7e24920 c52d9f0c c7e24000 c55c6120 00000009 c52d9eac 
Call Trace:
 [<c01290dd>] schedule_timeout+0xad/0xb0
 [<c021a4f9>] tty_poll+0x79/0xb0
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c0128ac6>] update_wall_time+0x16/0x40
 [<c034b286>] sysenter_past_esp+0x43/0x65

pam-panel-ico S 18B17F78  1205   1147  1206    1226  1201 (NOTLB)
c5499ef8 00000086 c5cd0ca0 18b17f78 000000a5 c5499ee4 18b17f78 000000a5 
       c5cd0ca0 0000a1d6 18b4abbf 000000a5 c5cd12d0 00000000 7fffffff c5499f58 
       c5499f34 c01290dd c5867b20 c6ea8320 c5499fa0 00000145 c6d116f8 c5499f34 
Call Trace:
 [<c01290dd>] schedule_timeout+0xad/0xb0
 [<c016880b>] do_pollfd+0x5b/0xa0
 [<c01688fa>] do_poll+0xaa/0xd0
 [<c0168abb>] sys_poll+0x19b/0x2a0
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c034b286>] sysenter_past_esp+0x43/0x65

pam_timestamp S 18AECCDD  1206   1205                     (NOTLB)
c5545e70 00000086 c5cd12d0 18aeccdd 000000a5 c5cd0ca0 18aeccdd c5545e84 
       00000246 0000028a 18b4c29d 000000a5 c5cd0ca0 00062076 c5545e84 00000002 
       c5545eac c012908e c5545e84 00062076 c6ea8320 c6ea3e84 c03f6f88 00062076 
Call Trace:
 [<c012908e>] schedule_timeout+0x5e/0xb0
 [<c0129020>] process_timeout+0x0/0x10
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c0156518>] vfs_write+0xc8/0x120
 [<c034b286>] sysenter_past_esp+0x43/0x65

kmail         S C03B1B5C  1209      1                1204 (NOTLB)
c5aa3e70 00000082 00000010 c03b1b5c 00000000 000000d0 682b9a04 c5aa3e84 
       00000246 0000ac8c ff725dd4 000000a5 c6800710 00061e00 c5aa3e84 00000009 
       c5aa3eac c012908e c5aa3e84 00061e00 caeae3a0 c5975e84 c50d7e84 00061e00 
Call Trace:
 [<c012908e>] schedule_timeout+0x5e/0xb0
 [<c0129020>] process_timeout+0x0/0x10
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c034b286>] sysenter_past_esp+0x43/0x65

kdeinit       S 52DDEBD1  1226   1147  1231    1228  1205 (NOTLB)
c538de70 00000086 c9da86b0 52ddebd1 00000099 000000d0 52ddebd1 00000099 
       c9da86b0 000038e7 52e42d85 00000099 c5cd0040 00000000 7fffffff 0000000c 
       c538deac c01290dd c77a1920 c538df0c c77a1000 c4abeac0 0000000b c538deac 
Call Trace:
 [<c01290dd>] schedule_timeout+0xad/0xb0
 [<c021a4f9>] tty_poll+0x79/0xb0
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c0128ac6>] update_wall_time+0x16/0x40
 [<c034b286>] sysenter_past_esp+0x43/0x65

kdeinit       S 183A5129  1228   1147          1348  1226 (NOTLB)
c4111e70 00000086 c9da86b0 183a5129 00000098 000000d0 183a5129 00000098 
       c9da86b0 0001c70d 1845398e 00000098 c41ab2f0 00000000 7fffffff 0000000a 
       c4111eac c01290dd 00000200 c4111e94 c034787b c8ec5ee0 c748c3f8 c4111f0c 
Call Trace:
 [<c01290dd>] schedule_timeout+0xad/0xb0
 [<c034787b>] unix_poll+0x2b/0xa0
 [<c02f96b9>] sock_poll+0x29/0x30
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c0128ac6>] update_wall_time+0x16/0x40
 [<c034b286>] sysenter_past_esp+0x43/0x65
 [<c034007b>] ip_mc_msfilter+0x4b/0x280

bash          S 0A99767E  1231   1226  1318               (NOTLB)
c5525f48 00000082 c72df980 0a99767e 00000086 00000001 0a99767e 00000086 
       c72df980 000c9652 0a9d3186 00000086 c5cd0670 c5cd0718 fffffe00 c5cd0670 
       c5525fbc c0123aac ffffffff 00000002 c72df980 c5525f78 c01220db c5cd0718 
Call Trace:
 [<c0123aac>] sys_wait4+0x1ec/0x2a0
 [<c01220db>] session_of_pgrp+0x1b/0xa0
 [<c011df40>] default_wake_function+0x0/0x30
 [<c011df40>] default_wake_function+0x0/0x30
 [<c034b286>] sysenter_past_esp+0x43/0x65

build.sh      S 080E3C48  1318   1231  1322               (NOTLB)
c72ddf48 00000086 c57f0520 080e3c48 00000001 00000001 080e3c48 c57f0520 
       c41aacc0 0007798b 00c35dc4 00000087 c72df980 c72dfa28 fffffe00 c72df980 
       c72ddfbc c0123aac ffffffff 00000000 c41aacc0 c72ddfbc c012d009 c72dfa28 
Call Trace:
 [<c0123aac>] sys_wait4+0x1ec/0x2a0
 [<c012d009>] sys_rt_sigaction+0x119/0x140
 [<c011df40>] default_wake_function+0x0/0x30
 [<c011df40>] default_wake_function+0x0/0x30
 [<c034b286>] sysenter_past_esp+0x43/0x65

make-static.s S 080E6A38  1322   1318  1346               (NOTLB)
c457bf48 00000086 c553b2e0 080e6a38 00000001 00000001 080e6a38 c553b2e0 
       00000000 0009f34b 0d892e58 00000087 c41aacc0 c41aad68 fffffe00 c41aacc0 
       c457bfbc c0123aac ffffffff 00000000 c41aa690 c457bfbc c012d009 c41aad68 
Call Trace:
 [<c0123aac>] sys_wait4+0x1ec/0x2a0
 [<c012d009>] sys_rt_sigaction+0x119/0x140
 [<c011df40>] default_wake_function+0x0/0x30
 [<c011df40>] default_wake_function+0x0/0x30
 [<c034b286>] sysenter_past_esp+0x43/0x65

tar           D A2D61B4D  1346   1322  1347               (NOTLB)
c2829db8 00000086 c5cd0040 a2d61b4d 00000093 000d009d a2d61b4d 00000093 
       c5cd0040 0000d535 a2d82d13 00000093 c41aa690 ca82ee98 00000286 c41aa690 
       c2829df0 c010b13b ca82eea0 00000001 c41aa690 c011df40 ca82eea0 ca82eea0 
Call Trace:
 [<c010b13b>] __down+0x7b/0xf0
 [<c011df40>] default_wake_function+0x0/0x30
 [<c01576e5>] unlock_buffer+0x35/0x60
 [<c010b323>] __down_failed+0xb/0x14
 [<c013e553>] .text.lock.filemap+0x31/0x9e
 [<c018fb40>] ext3_get_inode_loc+0x70/0x2b0
 [<c018b5df>] ext3_file_write+0x3f/0xd0
 [<c015641d>] do_sync_write+0xbd/0xf0
 [<c011f530>] autoremove_wake_function+0x0/0x50
 [<c0157157>] get_empty_filp+0x77/0x100
 [<c01644f8>] open_namei+0xa8/0x430
 [<c015574c>] dentry_open+0x12c/0x1c0
 [<c0155616>] filp_open+0x66/0x70
 [<c01564ff>] vfs_write+0xaf/0x120
 [<c015660f>] sys_write+0x3f/0x60
 [<c034b286>] sysenter_past_esp+0x43/0x65

bzip2         S A2CFBFF3  1347   1346                     (NOTLB)
c27ffec4 00000082 c41aa690 a2cfbff3 00000093 a2cfbff3 00000093 00000092 
       00000000 001167c9 a2f3c07e 00000093 c41ab920 c41633e8 c4163380 c27ffef4 
       c27fff20 c0161cda c011f555 c2829efc 00000000 c41ab920 c011f530 c27fff00 
Call Trace:
 [<c0161cda>] pipe_wait+0x8a/0xc0
 [<c011f555>] autoremove_wake_function+0x25/0x50
 [<c011f530>] autoremove_wake_function+0x0/0x50
 [<c011f530>] autoremove_wake_function+0x0/0x50
 [<c0162086>] pipe_write+0x106/0x300
 [<c01564ff>] vfs_write+0xaf/0x120
 [<c015660f>] sys_write+0x3f/0x60
 [<c034b286>] sysenter_past_esp+0x43/0x65

kdeinit       S C03B1B5C  1348   1147  1349          1228 (NOTLB)
c2227e70 00000086 00000010 c03b1b5c 00000000 000000d0 c2227e88 c2227e84 
       00000246 0000418e e0f607fa 000000a5 c41aa060 0006411d c2227e84 0000000c 
       c2227eac c012908e c2227e84 0006411d c3560000 c03b0290 c03b0290 0006411d 
Call Trace:
 [<c012908e>] schedule_timeout+0x5e/0xb0
 [<c0129020>] process_timeout+0x0/0x10
 [<c0168117>] do_select+0x147/0x270
 [<c0167e30>] __pollwait+0x0/0xb0
 [<c0168566>] sys_select+0x2e6/0x530
 [<c034b286>] sysenter_past_esp+0x43/0x65

bash          S C8CE0D00  1349   1348                     (NOTLB)
c373de58 00000082 00000246 c8ce0d00 0000001d 0000001d c3547000 0000001d 
       c41aa060 0002e81e aa3636d1 00000098 c8ce0d00 00000008 7fffffff c3547000 
       c373de94 c01290dd 636f6c40 6f686c61 6c207473 6c646e61 245d7965 c373de20 
Call Trace:
 [<c01290dd>] schedule_timeout+0xad/0xb0
 [<c01290dd>] schedule_timeout+0xad/0xb0
 [<c021df87>] read_chan+0x277/0x870
 [<c021e6fa>] write_chan+0x17a/0x240
 [<c011df40>] default_wake_function+0x0/0x30
 [<c011df40>] default_wake_function+0x0/0x30
 [<c011df40>] default_wake_function+0x0/0x30
 [<c021921b>] tty_write+0x1ab/0x210
 [<c0219040>] tty_read+0xe0/0x110
 [<c01562ef>] vfs_read+0xaf/0x120
 [<c01565af>] sys_read+0x3f/0x60
 [<c034b286>] sysenter_past_esp+0x43/0x65

bash          S 00000000  1377    989                     (NOTLB)
c442de58 00000082 caf2b000 00000000 c442de75 0000001d 0000001d caf2b000 
       c442deb4 000ba760 fb2325d9 000000a4 c8daf980 00000008 7fffffff caf2b000 
       c442de94 c01290dd 00000206 cb508c00 00002d0e c442de90 c0295f7b 0000001d 
Call Trace:
 [<c01290dd>] schedule_timeout+0xad/0xb0
 [<c0295f7b>] vgacon_cursor+0xcb/0x1a0
 [<c021df87>] read_chan+0x277/0x870
 [<c021e6fa>] write_chan+0x17a/0x240
 [<c011df40>] default_wake_function+0x0/0x30
 [<c011df40>] default_wake_function+0x0/0x30
 [<c011df40>] default_wake_function+0x0/0x30
 [<c021921b>] tty_write+0x1ab/0x210
 [<c0219040>] tty_read+0xe0/0x110
 [<c01562ef>] vfs_read+0xaf/0x120
 [<c01565af>] sys_read+0x3f/0x60
 [<c034b286>] sysenter_past_esp+0x43/0x65


