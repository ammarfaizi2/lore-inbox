Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263332AbVCKOUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbVCKOUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 09:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263331AbVCKOTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 09:19:43 -0500
Received: from scilla.wseurope.com ([195.110.122.96]:11943 "EHLO
	corp.wseurope.com") by vger.kernel.org with ESMTP id S263320AbVCKOOS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 09:14:18 -0500
From: Simone Piunno <simone.piunno@wseurope.com>
Organization: Wireless Solutions
To: Baruch Even <baruch@ev-en.org>
Subject: Re: bonnie++ uninterruptible under heavy I/O load
Date: Fri, 11 Mar 2005 15:14:34 +0100
User-Agent: KMail/1.8
Cc: Fabio Coatti <fabio.coatti@wseurope.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
References: <200503111208.20283.simone.piunno@wseurope.com> <200503111420.52890.fabio.coatti@wseurope.com> <42319D2D.7060402@ev-en.org>
In-Reply-To: <42319D2D.7060402@ev-en.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200503111514.34949.simone.piunno@wseurope.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 14:29, venerdì 11 marzo 2005, Baruch Even ha scritto:

> echo t > /proc/sysrq-trigger

Before killing bonnie:

0>{keventd_create_kthread+0} 
<ffffffff801452d0>{kthread+0} <ffffffff8010e07b>{child_rip+0} 

aio/0         S ffff8100f577a200     0   295     13           296   292 
(L-TLB)
ffff81000c0e3e58 0000000000000046 0000000000000071 0000000000000070 
ffff8101ffe58130 ffff8101ffe58820 ffff8101ffe58a98 0000000000000000 
0000000000000000 0000000000010000 
Call Trace:<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff80141281>{worker_thread+305} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff801453a9>{kthread+217} <ffffffff8010e083>{child_rip+8} 
<ffffffff801453f0>{keventd_create_kthread+0} <ffffffff801452d0>{kthread+0} 
<ffffffff8010e07b>{child_rip+0} 
aio/1         S 00000000017116c9     0   296     13           307   295 
(L-TLB)
ffff81000c0e5e58 0000000000000046 0000000100000000 0000000000000189 
ffff81000c010e10 ffff8101ffe58130 ffff8101ffe583a8 0000000000000001 
0000000000000000 0000000000010000 
Call Trace:<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff80141281>{worker_thread+305} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff801453a9>{kthread+217} <ffffffff8010e083>{child_rip+8} 
<ffffffff801453f0>{keventd_create_kthread+0} <ffffffff801452d0>{kthread+0} 
<ffffffff8010e07b>{child_rip+0} 
kswapd1       S 0000000001743095     0   293      1           294   204 
(L-TLB)
ffff81000c0e1ea8 0000000000000046 0000000100000002 00000000000001ee 
ffff81000c010e10 ffff8101ffe59600 ffff8101ffe59878 0000000000000001 
0000000000000001 0000000000000000 
Call Trace:<ffffffff801589d5>{kswapd+293} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff801459d0>{autoremove_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff801588b0>{kswapd+0} <ffffffff8010e07b>{child_rip+0} 

kswapd0       S 0000000001740ba5     0   294      1           303   293 
(L-TLB)
ffff8101ffe5bea8 0000000000000046 0000000000000078 0000000000000176 
ffff8100f5795580 ffff8101ffe58f10 ffff8101ffe59188 0000000000000000 
0000000000000000 0000000000000000 
Call Trace:<ffffffff801589d5>{kswapd+293} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff801459d0>{autoremove_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff801588b0>{kswapd+0} <ffffffff8010e07b>{child_rip+0} 

jfsIO         S 0000000000000000     0   303      1           304   294 
(L-TLB)
ffff8100048bdeb8 0000000000000046 0000000000000075 00000000000001ad 
ffff81000c011500 ffff81000c0f7640 ffff81000c0f78b8 ffffffff805c03e0 
ffffffff805c03e8 0000000000000296 
Call Trace:<ffffffff8026878b>{jfsIOWait+283} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff80268670>{jfsIOWait+0} <ffffffff8010e07b>{child_rip+0} 

jfsCommit     S ffffffff806ec6a8     0   304      1           305   303 
(L-TLB)
ffff8101ffee5eb8 0000000000000046 0000000000000075 00000000000001ae 
ffff81000c011500 ffff81000c0f6f50 ffff81000c0f71c8 ffffffff805c03e0 
ffffffff805c03e8 0000000000000296 
Call Trace:<ffffffff8026b811>{jfs_lazycommit+593} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff8026b5c0>{jfs_lazycommit+0} <ffffffff8010e07b>{child_rip+0} 

jfsCommit     S 0000000000000000     0   305      1           306   304 
(L-TLB)
ffff8100048bfeb8 0000000000000046 0000000000000075 000000000000012f 
ffff81000c011500 ffff81000c0f6860 ffff81000c0f6ad8 ffffffff805c03e0 
ffffffff805c03e8 0000000000000296 
Call Trace:<ffffffff8026b811>{jfs_lazycommit+593} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff8026b5c0>{jfs_lazycommit+0} <ffffffff8010e07b>{child_rip+0} 

jfsSync       S 0000000000000001     0   306      1           311   305 
(L-TLB)
ffff8101ffee7ea8 0000000000000046 0000000000000075 0000000000000183 
ffff81000c011500 ffff81000c0f6170 ffff81000c0f63e8 ffffffff805c03e0 
ffffffff805c03e8 0000000000000296 
Call Trace:<ffffffff8026bc88>{jfs_sync+600} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff8026ba30>{jfs_sync+0} <ffffffff8010e07b>{child_rip+0} 

xfslogd/0     S ffff81000c0c3e00     0   307     13           308   296 
(L-TLB)
ffff8101ffee9e58 0000000000000046 0000000000000071 000000000000007c 
ffff8100048c0f90 ffff8100048c1680 ffff8100048c18f8 0000000000000000 
0000000000000000 0000000000010000 
Call Trace:<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff80141281>{worker_thread+305} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff801453a9>{kthread+217} <ffffffff8010e083>{child_rip+8} 
<ffffffff801453f0>{keventd_create_kthread+0} <ffffffff801452d0>{kthread+0} 
<ffffffff8010e07b>{child_rip+0} 
xfslogd/1     S ffff8100048e77f0     0   308     13           309   307 
(L-TLB)
ffff8100048c3e58 0000000000000046 000000010000007d 000000000000008f 
ffff8101ffeee1f0 ffff8100048c0f90 ffff8100048c1208 0000000000000001 
0000000000000096 0000000000000003 
Call Trace:<ffffffff8012c0e3>{__wake_up+67} 
<ffffffff802c4560>{pagebuf_iodone_work+0} 
<ffffffff802c4560>{pagebuf_iodone_work+0} 
<ffffffff80141281>{worker_thread+305} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff801453f0>{keventd_create_kthread+0} <ffffffff801453a9>{kthread+217} 
<ffffffff8010e083>{child_rip+8} <ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff801452d0>{kthread+0} <ffffffff8010e07b>{child_rip+0} 

xfsdatad/0    S ffff81000c0c3c00     0   309     13           310   308 
(L-TLB)
ffff8101ffeebe58 0000000000000046 0000000000000071 0000000000000064 
ffff8100048c01b0 ffff8100048c08a0 ffff8100048c0b18 0000000000000000 
0000000000000000 0000000000010000 
Call Trace:<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff80141281>{worker_thread+305} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff801453a9>{kthread+217} <ffffffff8010e083>{child_rip+8} 
<ffffffff801453f0>{keventd_create_kthread+0} <ffffffff801452d0>{kthread+0} 
<ffffffff8010e07b>{child_rip+0} 
xfsdatad/1    S 00000000018038d0     0   310     13                 309 
(L-TLB)
ffff8101ffeede58 0000000000000046 0000000100000000 0000000000000125 
ffff81000c010e10 ffff8100048c01b0 ffff8100048c0428 0000000000000001 
0000000000000000 0000000000010000 
Call Trace:<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff80141281>{worker_thread+305} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff801453a9>{kthread+217} <ffffffff8010e083>{child_rip+8} 
<ffffffff801453f0>{keventd_create_kthread+0} <ffffffff801452d0>{kthread+0} 
<ffffffff8010e07b>{child_rip+0} 
xfsbufd       S 00000001000c5d03     0   311      1           387   306 
(L-TLB)
ffff8100048c7e98 0000000000000046 000000000000007d 0000000000000103 
ffff8101ff515540 ffff8101ffeef6c0 ffff8101ffeef938 ffff8100f526c428 
ffff8100f526aaf0 0000000000000292 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff802c5a99>{pagebuf_daemon+153} 
<ffffffff8010e083>{child_rip+8} <ffffffff801182e0>{flat_send_IPI_mask+0} 
<ffffffff802c5a00>{pagebuf_daemon+0} <ffffffff8010e07b>{child_rip+0} 

kseriod       S 0000000002b6872e     0   387      1           460   311 
(L-TLB)
ffff8100048edeb8 0000000000000046 0000000000000077 00000000000001f8 
ffff8100f5795580 ffff8101ffeeefd0 ffff8101ffeef248 0000000000001158 
ffff8100f5795580 ffff8101ffeeefd0 
Call Trace:<ffffffff80354ce7>{serio_thread+455} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff801459d0>{autoremove_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff80354b20>{serio_thread+0} <ffffffff8010e07b>{child_rip+0} 

xfssyncd      S 00000001000c7054     0   460      1           675   387 
(L-TLB)
ffff8101ffc79e88 0000000000000046 000000010000007d 00000000000004f8 
ffff8101ffeee1f0 ffff8100f56f9700 ffff8100f56f9978 0000000000000000 
ffff8101051515d8 0000000000000296 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff802cac79>{xfssyncd+153} 
<ffffffff802cb1e0>{linvfs_fill_super+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff802cb1e0>{linvfs_fill_super+0} <ffffffff802b9cd0>{xfs_root+0} 
<ffffffff802cabe0>{xfssyncd+0} <ffffffff8010e07b>{child_rip+0} 

xfssyncd      S 00000001000cae78     0   675      1           676   460 
(L-TLB)
ffff8101ff295e88 0000000000000046 000000010000007d 0000000000000505 
ffff8101ffeee1f0 ffff8101ff539150 ffff8101ff5393c8 0000000000000000 
ffff81010510ac98 0000000000000296 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff802cac79>{xfssyncd+153} 
<ffffffff802cb1e0>{linvfs_fill_super+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff802cb1e0>{linvfs_fill_super+0} <ffffffff802b9cd0>{xfs_root+0} 
<ffffffff802cabe0>{xfssyncd+0} <ffffffff8010e07b>{child_rip+0} 

xfssyncd      S 00000001000caed9     0   676      1          1512   675 
(L-TLB)
ffff8101ff2b7e88 0000000000000046 000000010000007d 000000000000045d 
ffff8101ff538a60 ffff8101053c03b0 ffff8101053c0628 0000000000000000 
ffff81010510a5d8 0000000000000296 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff802cac79>{xfssyncd+153} 
<ffffffff802cb1e0>{linvfs_fill_super+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff802cb1e0>{linvfs_fill_super+0} <ffffffff802b9cd0>{xfs_root+0} 
<ffffffff802cabe0>{xfssyncd+0} <ffffffff8010e07b>{child_rip+0} 

syslog-ng     R  running task       0  1512      1          1728   676 (NOTLB)
ntpd          S ffff810004929380     0  1728      1          1822  1512 
(NOTLB)
ffff8101febc1d88 0000000000000086 000000010000007d 000000000000141a 
ffff8101ffeee1f0 ffff8101053d71d0 ffff8101053d7448 ffff8101053d71d0 
00000010febc1db8 0000000000000282 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff803dabf3>{datagram_poll+35} <ffffffff80413b2f>{udp_poll+15} 
<ffffffff80182477>{do_select+999} <ffffffff80181fa0>{__pollwait+0} 
<ffffffff80182845>{sys_select+885} <ffffffff8010d2f9>{sys_rt_sigreturn+553} 
<ffffffff8010d4ca>{system_call+126} 
master        S 00000101aa142085     0  1822      1  1839    1875  1728 
(NOTLB)
ffff8101fe0d5d88 0000000000000086 0000000100000074 00000000000019c9 
ffff8100f56f9010 ffff8101ff538370 ffff8101ff5385e8 0000000000000282 
0000000100000000 0000000000000296 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff8012c0e3>{__wake_up+67} 
<ffffffff80182845>{sys_select+885} <ffffffff8010d4ca>{system_call+126} 

pickup        S 00000001000ddceb     0  1839   1822          1840       
(NOTLB)
ffff8101fe5efd88 0000000000000082 000000010000007d 00000000000000a3 
ffff8101ffeee1f0 ffff8100f56f9010 ffff8100f56f9288 0000000000000000 
00000000000000d0 0000000000000296 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
qmgr          S 000000ef4b3774bc     0  1840   1822                1839 
(NOTLB)
ffff8101fe123d88 0000000000000082 0000000100000286 0000000000001609 
ffff81000c010e10 ffff8101053d78c0 ffff8101053d7b38 0000000000000000 
00000000000000d0 0000000000000296 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S ffff8101fdc0bc80     0  1875      1  1995    1915  1822 
(NOTLB)
ffff8101fdc3bd88 0000000000000082 0000000100000074 0000000000000717 
ffff810004ae0170 ffff8101053a67a0 ffff8101053a6a18 0000000000000000 
00000000000000d0 0000000000000286 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80150bce>{__get_free_pages+14} 
<ffffffff8014573c>{add_wait_queue+28} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
cron          S 00000001000cae17     0  1915      1          1932  1875 
(NOTLB)
ffff8101fe2d5ee8 0000000000000082 000000010000007a 00000000000007f4 
ffff8101ff538a60 ffff8101ff514760 ffff8101ff5149d8 0000000000000000 
0000000000000008 0000000000000292 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff80139ed2>{sys_nanosleep+194} 
<ffffffff8010d4ca>{system_call+126} 
agetty        S ffff8101ff314000     0  1932      1          1934  1915 
(NOTLB)
ffff81010520dd78 0000000000000082 0000000000000075 00000000000066f3 
ffff8101ff539840 ffff8101ffeee8e0 ffff8101ffeeeb58 0000000000000001 
00000000000000ff ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80130949>{release_console_sem+393} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff80333c67>{read_chan+1143} <ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

agetty        S ffff8101fe363000     0  1934      1          1935  1932 
(NOTLB)
ffff8101fefa7d78 0000000000000082 0000000100000075 0000000000003c4c 
ffff8101053a60b0 ffff8100f56f8230 ffff8100f56f84a8 0000000000000001 
00000000000000ff ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80130949>{release_console_sem+393} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff80333c67>{read_chan+1143} <ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

agetty        S ffff8101fe9c1000     0  1935      1          1936  1934 
(NOTLB)
ffff8101fe953d78 0000000000000082 0000000000000075 0000000000004254 
ffff8101ffeee8e0 ffff8101053d8720 ffff8101053d8998 0000000000000001 
00000000000000ff ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80130949>{release_console_sem+393} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff80333c67>{read_chan+1143} <ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

agetty        S 00000006ce68f5ba     0  1936      1          1937  1935 
(NOTLB)
ffff8101fe8c5d78 0000000000000082 0000000100000074 0000000000002e90 
ffff8101053a6e90 ffff8101053a60b0 ffff8101053a6328 0000000000000001 
00000000000000ff ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80130949>{release_console_sem+393} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff80333c67>{read_chan+1143} <ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

agetty        S 00000006ce6ced34     0  1937      1          1938  1936 
(NOTLB)
ffff8101fe95dd78 0000000000000086 0000000100000004 00000000000028c8 
ffff81000c010e10 ffff8101053a6e90 ffff8101053a7108 0000000000000001 
00000000000000ff ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80130949>{release_console_sem+393} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff80333c67>{read_chan+1143} <ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

agetty        S 00000006ce79c7c7     0  1938      1                1937 
(NOTLB)
ffff8101fe903d78 0000000000000086 0000000000000005 0000000000002440 
ffffffff80512a80 ffff8101ff539840 ffff8101ff539ab8 0000000000000000 
00000000000000ff ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80130949>{release_console_sem+393} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff80333c67>{read_chan+1143} <ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

sshd          S 7fffffffffffffff     0  1995   1875  1997    2004       
(NOTLB)
ffff8101fe391be8 0000000000000086 0000000100000075 000000000000003f 
ffff8101ff514e50 ffff8101ff514070 ffff8101ff5142e8 ffff8101ff6a3000 
ffff8100f550c4c0 ffffffff8044bf77 
Call Trace:<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80145863>{prepare_to_wait+35} 
<ffffffff8044c5dd>{unix_stream_recvmsg+621} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff803d43c6>{sock_aio_read+278} 
<ffffffff802f574d>{__up_read+29} <ffffffff802a25b8>{xfs_iunlock+104} 
<ffffffff8016efad>{do_sync_read+173} <ffffffff801779c9>{cdev_get+9} 
<ffffffff80177b42>{chrdev_open+338} <ffffffff8016e566>{dentry_open+230} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8016e64e>{filp_open+62} 
<ffffffff8016f0b4>{vfs_read+212} <ffffffff8016f383>{sys_read+83} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 000000f4d37eed09     0  1997   1995  1998               
(NOTLB)
ffff8101fe2edd88 0000000000000082 0000000100000073 0000000000000a23 
ffff8101053d6ae0 ffff8101ff514e50 ffff8101ff5150c8 ffffffff805c9a80 
0000000000000000 0000000000000001 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032f130>{tty_poll+176} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
bash          S 000000f4d3886297     0  1998   1997  2040               
(NOTLB)
ffff8101fdcade58 0000000000000082 0000000100000074 0000000000003b0c 
ffff8101ffeee1f0 ffff8101053d6ae0 ffff8101053d6d58 ffffffff8012a6eb 
0000000000000000 0000000000000001 
Call Trace:<ffffffff8012a6eb>{try_to_wake_up+555} 
<ffffffff80134375>{do_wait+3477} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 7fffffffffffffff     0  2004   1875  2006    2013  1995 
(NOTLB)
ffff8101fdc4bbe8 0000000000000086 0000000100000075 000000000000003e 
ffff8101053d63f0 ffff810004a65600 ffff810004a65878 ffff8101ff6e1c00 
ffff8101feed7a80 ffffffff8044bf77 
Call Trace:<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80145863>{prepare_to_wait+35} 
<ffffffff8044c5dd>{unix_stream_recvmsg+621} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff803d43c6>{sock_aio_read+278} 
<ffffffff802f574d>{__up_read+29} <ffffffff802a25b8>{xfs_iunlock+104} 
<ffffffff8016efad>{do_sync_read+173} <ffffffff801779c9>{cdev_get+9} 
<ffffffff80177b42>{chrdev_open+338} <ffffffff8016e566>{dentry_open+230} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8016e64e>{filp_open+62} 
<ffffffff8016f0b4>{vfs_read+212} <ffffffff8016f383>{sys_read+83} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S ffff8101053d2580     0  2006   2004  2007               
(NOTLB)
ffff8101fdca7d88 0000000000000086 000000010000007d 0000000000000e88 
ffff8101ffeee1f0 ffff8101053d63f0 ffff8101053d6668 ffffffff805c9a80 
0000000000000000 0000000000000001 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032f130>{tty_poll+176} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
bash          S 000000f5d3de228e     0  2007   2006  2041               
(NOTLB)
ffff8101fdd0be58 0000000000000082 0000000000000075 000000000000366c 
ffff8101ff515540 ffff8101053d9500 ffff8101053d9778 ffffffff8012a6eb 
0000000000000000 0000000000000001 
Call Trace:<ffffffff8012a6eb>{try_to_wake_up+555} 
<ffffffff80134375>{do_wait+3477} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 7fffffffffffffff     0  2013   1875  2015    2022  2004 
(NOTLB)
ffff8101fdc8bbe8 0000000000000082 0000000100000075 000000000000004a 
ffff810004a64f10 ffff810004a64130 ffff810004a643a8 ffff8101fff81600 
ffff8101feefb980 ffffffff8044bf77 
Call Trace:<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80145863>{prepare_to_wait+35} 
<ffffffff8044c5dd>{unix_stream_recvmsg+621} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff803d43c6>{sock_aio_read+278} 
<ffffffff802f574d>{__up_read+29} <ffffffff802a25b8>{xfs_iunlock+104} 
<ffffffff8016efad>{do_sync_read+173} <ffffffff801779c9>{cdev_get+9} 
<ffffffff80177b42>{chrdev_open+338} <ffffffff8016e566>{dentry_open+230} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8016e64e>{filp_open+62} 
<ffffffff8016f0b4>{vfs_read+212} <ffffffff8016f383>{sys_read+83} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S ffff8101053d2b80     0  2015   2013  2016               
(NOTLB)
ffff8101fdd03d88 0000000000000086 000000010000007b 0000000000000f48 
ffff8101ff538a60 ffff810004a64f10 ffff810004a65188 ffffffff805c9a80 
0000000000000000 0000000000000001 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032f130>{tty_poll+176} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
bash          S 000000f805c8e919     0  2016   2015  2042               
(NOTLB)
ffff8101fdd91e58 0000000000000082 0000000000000075 00000000000039af 
ffff8101ff538a60 ffff8101053d8030 ffff8101053d82a8 ffffffff8012a6eb 
0000000000000000 0000000000000001 
Call Trace:<ffffffff8012a6eb>{try_to_wake_up+555} 
<ffffffff80134375>{do_wait+3477} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 7fffffffffffffff     0  2022   1875  2024    2031  2013 
(NOTLB)
ffff8101fdd17be8 0000000000000086 0000000100000075 0000000000000042 
ffff810004a64820 ffff810004ae1640 ffff810004ae18b8 ffff8101ff6a3600 
ffff8101fef4d680 ffffffff8044bf77 
Call Trace:<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80145863>{prepare_to_wait+35} 
<ffffffff8044c5dd>{unix_stream_recvmsg+621} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff803d43c6>{sock_aio_read+278} 
<ffffffff802f574d>{__up_read+29} <ffffffff802a25b8>{xfs_iunlock+104} 
<ffffffff8016efad>{do_sync_read+173} <ffffffff801779c9>{cdev_get+9} 
<ffffffff80177b42>{chrdev_open+338} <ffffffff8016e566>{dentry_open+230} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8016e64e>{filp_open+62} 
<ffffffff8016f0b4>{vfs_read+212} <ffffffff8016f383>{sys_read+83} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 00000101f1a03a59     0  2024   2022  2025               
(NOTLB)
ffff8101fdda5d88 0000000000000082 0000000100000074 0000000000001df5 
ffff810004ae0860 ffff810004a64820 ffff810004a64a98 ffffffff805c9a80 
0000000000000000 0000000000000001 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032f130>{tty_poll+176} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
bash          S 000000fcb9e5834b     0  2025   2024  2045               
(NOTLB)
ffff8101fde17e58 0000000000000082 0000000000000074 00000000000029c0 
ffff8100f56f8920 ffff8101053d8e10 ffff8101053d9088 ffffffff8012a6eb 
0000000000000000 0000000000000001 
Call Trace:<ffffffff8012a6eb>{try_to_wake_up+555} 
<ffffffff80134375>{do_wait+3477} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 7fffffffffffffff     0  2031   1875  2033          2022 
(NOTLB)
ffff8101fde59be8 0000000000000082 0000000100000075 0000000000000040 
ffff810004ae0f50 ffff810004ae0170 ffff810004ae03e8 ffff8101ff6e1400 
ffff8101feefb980 ffffffff8044bf77 
Call Trace:<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80145863>{prepare_to_wait+35} 
<ffffffff8044c5dd>{unix_stream_recvmsg+621} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff803d43c6>{sock_aio_read+278} 
<ffffffff802f574d>{__up_read+29} <ffffffff802a25b8>{xfs_iunlock+104} 
<ffffffff8016efad>{do_sync_read+173} <ffffffff801779c9>{cdev_get+9} 
<ffffffff80177b42>{chrdev_open+338} <ffffffff8016e566>{dentry_open+230} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8016e64e>{filp_open+62} 
<ffffffff8016f0b4>{vfs_read+212} <ffffffff8016f383>{sys_read+83} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 000000f36435fbf4     0  2033   2031  2034               
(NOTLB)
ffff8101fde1dd88 0000000000000086 0000000100000286 00000000000009b5 
ffff81000c010e10 ffff810004ae0f50 ffff810004ae11c8 0000000000000000 
0000000000000000 0000000000000001 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032f130>{tty_poll+176} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
bash          S 000000f36435ca31     0  2034   2033                     
(NOTLB)
ffff8101fdeadd78 0000000000000086 0000000000000000 0000000000073c59 
ffffffff80512a80 ffff8101053a7580 ffff8101053a77f8 0000000000000001 
ffff810100143c30 ffffffff8014d16c 
Call Trace:<ffffffff8014d16c>{filemap_nopage+396} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8014573c>{add_wait_queue+28} <ffffffff80333c67>{read_chan+1143} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

md5sum        R  running task       0  2040   1998                     (NOTLB)
md5sum        R  running task       0  2041   2007                     (NOTLB)
bonnie++      R  running task       0  2042   2016                     (NOTLB)
su            S ffff8100f56f8a30     0  2045   2025  2046               
(NOTLB)
ffff8100f5261e58 0000000000000086 000000000000007d 000000000000095c 
ffff8101ff515540 ffff8100f56f8920 ffff8100f56f8b98 ffffffff8010c5bf 
0000000000000000 0000000000000000 
Call Trace:<ffffffff8010c5bf>{copy_thread+79} 
<ffffffff80141eaf>{attach_pid+47} 
<ffffffff80134375>{do_wait+3477} <ffffffff8012aab0>{finish_task_switch+64} 
<ffffffff8013db31>{do_sigaction+577} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8013dea1>{sys_rt_sigaction+113} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8010d4ca>{system_call+126} 
bash          R  running task       0  2046   2045                     (NOTLB)




After killall -9 bonnie++:



ffffffff801459d0>{autoremove_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff801588b0>{kswapd+0} <ffffffff8010e07b>{child_rip+0} 

kswapd0       S 0000010e4d18709e     0   294      1           303   293 
(L-TLB)
ffff8101ffe5bea8 0000000000000046 0000000000000073 0000000000021cf9 
ffff8101ffeef6c0 ffff8101ffe58f10 ffff8101ffe59188 0000000000000000 
0000000000000000 ffff8101ffe5bf10 
Call Trace:<ffffffff801589d5>{kswapd+293} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff801459d0>{autoremove_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff801588b0>{kswapd+0} <ffffffff8010e07b>{child_rip+0} 

jfsIO         S 0000000000000000     0   303      1           304   294 
(L-TLB)
ffff8100048bdeb8 0000000000000046 0000000000000075 00000000000001ad 
ffff81000c011500 ffff81000c0f7640 ffff81000c0f78b8 ffffffff805c03e0 
ffffffff805c03e8 0000000000000296 
Call Trace:<ffffffff8026878b>{jfsIOWait+283} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff80268670>{jfsIOWait+0} <ffffffff8010e07b>{child_rip+0} 

jfsCommit     S ffffffff806ec6a8     0   304      1           305   303 
(L-TLB)
ffff8101ffee5eb8 0000000000000046 0000000000000075 00000000000001ae 
ffff81000c011500 ffff81000c0f6f50 ffff81000c0f71c8 ffffffff805c03e0 
ffffffff805c03e8 0000000000000296 
Call Trace:<ffffffff8026b811>{jfs_lazycommit+593} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff8026b5c0>{jfs_lazycommit+0} <ffffffff8010e07b>{child_rip+0} 

jfsCommit     S 0000000000000000     0   305      1           306   304 
(L-TLB)
ffff8100048bfeb8 0000000000000046 0000000000000075 000000000000012f 
ffff81000c011500 ffff81000c0f6860 ffff81000c0f6ad8 ffffffff805c03e0 
ffffffff805c03e8 0000000000000296 
Call Trace:<ffffffff8026b811>{jfs_lazycommit+593} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff8026b5c0>{jfs_lazycommit+0} <ffffffff8010e07b>{child_rip+0} 

jfsSync       S 0000000000000001     0   306      1           311   305 
(L-TLB)
ffff8101ffee7ea8 0000000000000046 0000000000000075 0000000000000183 
ffff81000c011500 ffff81000c0f6170 ffff81000c0f63e8 ffffffff805c03e0 
ffffffff805c03e8 0000000000000296 
Call Trace:<ffffffff8026bc88>{jfs_sync+600} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff8026ba30>{jfs_sync+0} <ffffffff8010e07b>{child_rip+0} 

xfslogd/0     S ffff81000c0c3e00     0   307     13           308   296 
(L-TLB)
ffff8101ffee9e58 0000000000000046 0000000000000071 000000000000007c 
ffff8100048c0f90 ffff8100048c1680 ffff8100048c18f8 0000000000000000 
0000000000000000 0000000000010000 
Call Trace:<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff80141281>{worker_thread+305} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff801453a9>{kthread+217} <ffffffff8010e083>{child_rip+8} 
<ffffffff801453f0>{keventd_create_kthread+0} <ffffffff801452d0>{kthread+0} 
<ffffffff8010e07b>{child_rip+0} 
xfslogd/1     S ffff8100048e79b0     0   308     13           309   307 
(L-TLB)
ffff8100048c3e58 0000000000000046 000000010000007d 0000000000000378 
ffff8101ffeee1f0 ffff8100048c0f90 ffff8100048c1208 0000000000000001 
0000000000000096 0000000000000003 
Call Trace:<ffffffff8012c0e3>{__wake_up+67} 
<ffffffff802c4560>{pagebuf_iodone_work+0} 
<ffffffff802c4560>{pagebuf_iodone_work+0} 
<ffffffff80141281>{worker_thread+305} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff801453f0>{keventd_create_kthread+0} <ffffffff801453a9>{kthread+217} 
<ffffffff8010e083>{child_rip+8} <ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff801452d0>{kthread+0} <ffffffff8010e07b>{child_rip+0} 

xfsdatad/0    S ffff81000c0c3c00     0   309     13           310   308 
(L-TLB)
ffff8101ffeebe58 0000000000000046 0000000000000071 0000000000000064 
ffff8100048c01b0 ffff8100048c08a0 ffff8100048c0b18 0000000000000000 
0000000000000000 0000000000010000 
Call Trace:<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff80141281>{worker_thread+305} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff801453a9>{kthread+217} <ffffffff8010e083>{child_rip+8} 
<ffffffff801453f0>{keventd_create_kthread+0} <ffffffff801452d0>{kthread+0} 
<ffffffff8010e07b>{child_rip+0} 
xfsdatad/1    S 00000000018038d0     0   310     13                 309 
(L-TLB)
ffff8101ffeede58 0000000000000046 0000000100000000 0000000000000125 
ffff81000c010e10 ffff8100048c01b0 ffff8100048c0428 0000000000000001 
0000000000000000 0000000000010000 
Call Trace:<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff80141281>{worker_thread+305} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff80141150>{worker_thread+0} 
<ffffffff801453f0>{keventd_create_kthread+0} 
<ffffffff801453a9>{kthread+217} <ffffffff8010e083>{child_rip+8} 
<ffffffff801453f0>{keventd_create_kthread+0} <ffffffff801452d0>{kthread+0} 
<ffffffff8010e07b>{child_rip+0} 
xfsbufd       S 00000001000d6cfc     0   311      1           387   306 
(L-TLB)
ffff8100048c7e98 0000000000000046 000000000000007d 000000000000005e 
ffff8101ff515540 ffff8101ffeef6c0 ffff8101ffeef938 0000000000000010 
0000000000000292 0000000000000292 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff802c5a99>{pagebuf_daemon+153} 
<ffffffff8010e083>{child_rip+8} <ffffffff801182e0>{flat_send_IPI_mask+0} 
<ffffffff802c5a00>{pagebuf_daemon+0} <ffffffff8010e07b>{child_rip+0} 

kseriod       S 0000000002b6872e     0   387      1           460   311 
(L-TLB)
ffff8100048edeb8 0000000000000046 0000000000000077 00000000000001f8 
ffff8100f5795580 ffff8101ffeeefd0 ffff8101ffeef248 0000000000001158 
ffff8100f5795580 ffff8101ffeeefd0 
Call Trace:<ffffffff80354ce7>{serio_thread+455} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff801459d0>{autoremove_wake_function+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff80354b20>{serio_thread+0} <ffffffff8010e07b>{child_rip+0} 

xfssyncd      S 00000001000dcfe4     0   460      1           675   387 
(L-TLB)
ffff8101ffc79e88 0000000000000046 000000010000007d 0000000000000461 
ffff8101ffeee1f0 ffff8100f56f9700 ffff8100f56f9978 0000000000000000 
ffff8101051515d8 0000000000000296 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff802cac79>{xfssyncd+153} 
<ffffffff802cb1e0>{linvfs_fill_super+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff802cb1e0>{linvfs_fill_super+0} <ffffffff802b9cd0>{xfs_root+0} 
<ffffffff802cabe0>{xfssyncd+0} <ffffffff8010e07b>{child_rip+0} 

xfssyncd      S 00000001000d98d8     0   675      1           676   460 
(L-TLB)
ffff8101ff295e88 0000000000000046 000000010000007d 0000000000000417 
ffff8101ffeee1f0 ffff8101ff539150 ffff8101ff5393c8 0000000000000000 
ffff81010510ac98 0000000000000296 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff802cac79>{xfssyncd+153} 
<ffffffff802cb1e0>{linvfs_fill_super+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff802cb1e0>{linvfs_fill_super+0} <ffffffff802b9cd0>{xfs_root+0} 
<ffffffff802cabe0>{xfssyncd+0} <ffffffff8010e07b>{child_rip+0} 

xfssyncd      S 00000001000d99e8     0   676      1          1512   675 
(L-TLB)
ffff8101ff2b7e88 0000000000000046 000000010000007d 00000000000003ef 
ffff8101ffeee1f0 ffff8101053c03b0 ffff8101053c0628 0000000000000000 
ffff81010510a5d8 0000000000000296 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff802cac79>{xfssyncd+153} 
<ffffffff802cb1e0>{linvfs_fill_super+0} <ffffffff8010e083>{child_rip+8} 
<ffffffff802cb1e0>{linvfs_fill_super+0} <ffffffff802b9cd0>{xfs_root+0} 
<ffffffff802cabe0>{xfssyncd+0} <ffffffff8010e07b>{child_rip+0} 

syslog-ng     R  running task       0  1512      1          1728   676 (NOTLB)
ntpd          S ffff810004929380     0  1728      1          1822  1512 
(NOTLB)
ffff8101febc1d88 0000000000000086 000000010000007d 0000000000001127 
ffff8101ffeee1f0 ffff8101053d71d0 ffff8101053d7448 ffff8101053d71d0 
00000010fd1c6128 0000000000000286 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff803dabf3>{datagram_poll+35} <ffffffff80413b2f>{udp_poll+15} 
<ffffffff80182477>{do_select+999} <ffffffff80181fa0>{__pollwait+0} 
<ffffffff80182845>{sys_select+885} <ffffffff8010d2f9>{sys_rt_sigreturn+553} 
<ffffffff8010d4ca>{system_call+126} 
master        S 0000010f9dd79b07     0  1822      1  1839    1875  1728 
(NOTLB)
ffff8101fe0d5d88 0000000000000086 0000000100000074 00000000000019b2 
ffff8100f56f9010 ffff8101ff538370 ffff8101ff5385e8 0000000000000282 
0000000100000000 0000000000000296 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff8012c0e3>{__wake_up+67} 
<ffffffff80182845>{sys_select+885} <ffffffff8010d4ca>{system_call+126} 

pickup        S 00000001000ec74c     0  1839   1822          1840       
(NOTLB)
ffff8101fe5efd88 0000000000000082 000000010000007d 00000000000000a4 
ffff8101ffeee1f0 ffff8100f56f9010 ffff8100f56f9288 0000000000000000 
00000000000000d0 0000000000000296 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
qmgr          S 000000ef4b3774bc     0  1840   1822                1839 
(NOTLB)
ffff8101fe123d88 0000000000000082 0000000100000286 0000000000001609 
ffff81000c010e10 ffff8101053d78c0 ffff8101053d7b38 0000000000000000 
00000000000000d0 0000000000000296 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S ffff8101fdc0bc80     0  1875      1  1995    1915  1822 
(NOTLB)
ffff8101fdc3bd88 0000000000000082 0000000100000074 0000000000000717 
ffff810004ae0170 ffff8101053a67a0 ffff8101053a6a18 0000000000000000 
00000000000000d0 0000000000000286 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80150bce>{__get_free_pages+14} 
<ffffffff8014573c>{add_wait_queue+28} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
cron          S 00000001000d9882     0  1915      1          1932  1875 
(NOTLB)
ffff8101fe2d5ee8 0000000000000082 000000010000007d 0000000000001a70 
ffff8101ffeee1f0 ffff8101ff514760 ffff8101ff5149d8 00000000422989b1 
0000000000000000 0000000000000292 
Call Trace:<ffffffff8013921d>{__mod_timer+317} 
<ffffffff804a0c26>{schedule_timeout+166} 
<ffffffff80139de0>{process_timeout+0} <ffffffff80139ed2>{sys_nanosleep+194} 
<ffffffff8010d4ca>{system_call+126} 
agetty        S ffff8101ff314000     0  1932      1          1934  1915 
(NOTLB)
ffff81010520dd78 0000000000000082 0000000000000075 00000000000066f3 
ffff8101ff539840 ffff8101ffeee8e0 ffff8101ffeeeb58 0000000000000001 
00000000000000ff ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80130949>{release_console_sem+393} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff80333c67>{read_chan+1143} <ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

agetty        S ffff8101fe363000     0  1934      1          1935  1932 
(NOTLB)
ffff8101fefa7d78 0000000000000082 0000000100000075 0000000000003c4c 
ffff8101053a60b0 ffff8100f56f8230 ffff8100f56f84a8 0000000000000001 
00000000000000ff ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80130949>{release_console_sem+393} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff80333c67>{read_chan+1143} <ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

agetty        S ffff8101fe9c1000     0  1935      1          1936  1934 
(NOTLB)
ffff8101fe953d78 0000000000000082 0000000000000075 0000000000004254 
ffff8101ffeee8e0 ffff8101053d8720 ffff8101053d8998 0000000000000001 
00000000000000ff ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80130949>{release_console_sem+393} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff80333c67>{read_chan+1143} <ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

agetty        S 00000006ce68f5ba     0  1936      1          1937  1935 
(NOTLB)
ffff8101fe8c5d78 0000000000000082 0000000100000074 0000000000002e90 
ffff8101053a6e90 ffff8101053a60b0 ffff8101053a6328 0000000000000001 
00000000000000ff ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80130949>{release_console_sem+393} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff80333c67>{read_chan+1143} <ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

agetty        S 00000006ce6ced34     0  1937      1          1938  1936 
(NOTLB)
ffff8101fe95dd78 0000000000000086 0000000100000004 00000000000028c8 
ffff81000c010e10 ffff8101053a6e90 ffff8101053a7108 0000000000000001 
00000000000000ff ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80130949>{release_console_sem+393} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff80333c67>{read_chan+1143} <ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

agetty        S 00000006ce79c7c7     0  1938      1                1937 
(NOTLB)
ffff8101fe903d78 0000000000000086 0000000000000005 0000000000002440 
ffffffff80512a80 ffff8101ff539840 ffff8101ff539ab8 0000000000000000 
00000000000000ff ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80130949>{release_console_sem+393} 
<ffffffff8014573c>{add_wait_queue+28} 
<ffffffff80333c67>{read_chan+1143} <ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032e286>{tty_read+214} <ffffffff8016f0a1>{vfs_read+193} 
<ffffffff8016f383>{sys_read+83} <ffffffff8010d4ca>{system_call+126} 

sshd          S 7fffffffffffffff     0  1995   1875  1997    2004       
(NOTLB)
ffff8101fe391be8 0000000000000086 0000000100000075 000000000000003f 
ffff8101ff514e50 ffff8101ff514070 ffff8101ff5142e8 ffff8101ff6a3000 
ffff8100f550c4c0 ffffffff8044bf77 
Call Trace:<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80145863>{prepare_to_wait+35} 
<ffffffff8044c5dd>{unix_stream_recvmsg+621} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff803d43c6>{sock_aio_read+278} 
<ffffffff802f574d>{__up_read+29} <ffffffff802a25b8>{xfs_iunlock+104} 
<ffffffff8016efad>{do_sync_read+173} <ffffffff801779c9>{cdev_get+9} 
<ffffffff80177b42>{chrdev_open+338} <ffffffff8016e566>{dentry_open+230} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8016e64e>{filp_open+62} 
<ffffffff8016f0b4>{vfs_read+212} <ffffffff8016f383>{sys_read+83} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 000000f4d37eed09     0  1997   1995  1998               
(NOTLB)
ffff8101fe2edd88 0000000000000082 0000000100000073 0000000000000a23 
ffff8101053d6ae0 ffff8101ff514e50 ffff8101ff5150c8 ffffffff805c9a80 
0000000000000000 0000000000000001 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032f130>{tty_poll+176} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
bash          S 000000f4d3886297     0  1998   1997  2040               
(NOTLB)
ffff8101fdcade58 0000000000000082 0000000100000074 0000000000003b0c 
ffff8101ffeee1f0 ffff8101053d6ae0 ffff8101053d6d58 ffffffff8012a6eb 
0000000000000000 0000000000000001 
Call Trace:<ffffffff8012a6eb>{try_to_wake_up+555} 
<ffffffff80134375>{do_wait+3477} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 7fffffffffffffff     0  2004   1875  2006    2013  1995 
(NOTLB)
ffff8101fdc4bbe8 0000000000000086 0000000100000075 000000000000003e 
ffff8101053d63f0 ffff810004a65600 ffff810004a65878 ffff8101ff6e1c00 
ffff8101feed7a80 ffffffff8044bf77 
Call Trace:<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80145863>{prepare_to_wait+35} 
<ffffffff8044c5dd>{unix_stream_recvmsg+621} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff803d43c6>{sock_aio_read+278} 
<ffffffff802f574d>{__up_read+29} <ffffffff802a25b8>{xfs_iunlock+104} 
<ffffffff8016efad>{do_sync_read+173} <ffffffff801779c9>{cdev_get+9} 
<ffffffff80177b42>{chrdev_open+338} <ffffffff8016e566>{dentry_open+230} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8016e64e>{filp_open+62} 
<ffffffff8016f0b4>{vfs_read+212} <ffffffff8016f383>{sys_read+83} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S ffff8101053d2580     0  2006   2004  2007               
(NOTLB)
ffff8101fdca7d88 0000000000000086 000000010000007d 0000000000000e88 
ffff8101ffeee1f0 ffff8101053d63f0 ffff8101053d6668 ffffffff805c9a80 
0000000000000000 0000000000000001 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032f130>{tty_poll+176} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
bash          S 000000f5d3de228e     0  2007   2006  2041               
(NOTLB)
ffff8101fdd0be58 0000000000000082 0000000000000075 000000000000366c 
ffff8101ff515540 ffff8101053d9500 ffff8101053d9778 ffffffff8012a6eb 
0000000000000000 0000000000000001 
Call Trace:<ffffffff8012a6eb>{try_to_wake_up+555} 
<ffffffff80134375>{do_wait+3477} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 7fffffffffffffff     0  2013   1875  2015    2022  2004 
(NOTLB)
ffff8101fdc8bbe8 0000000000000082 0000000100000075 000000000000004a 
ffff810004a64f10 ffff810004a64130 ffff810004a643a8 ffff8101fff81600 
ffff8101feefb980 ffffffff8044bf77 
Call Trace:<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80145863>{prepare_to_wait+35} 
<ffffffff8044c5dd>{unix_stream_recvmsg+621} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff803d43c6>{sock_aio_read+278} 
<ffffffff802f574d>{__up_read+29} <ffffffff802a25b8>{xfs_iunlock+104} 
<ffffffff8016efad>{do_sync_read+173} <ffffffff801779c9>{cdev_get+9} 
<ffffffff80177b42>{chrdev_open+338} <ffffffff8016e566>{dentry_open+230} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8016e64e>{filp_open+62} 
<ffffffff8016f0b4>{vfs_read+212} <ffffffff8016f383>{sys_read+83} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S ffff8101053d2b80     0  2015   2013  2016               
(NOTLB)
ffff8101fdd03d88 0000000000000086 000000010000007d 00000000000028ce 
ffff8101ffeee1f0 ffff810004a64f10 ffff810004a65188 ffffffff805c9a80 
0000000000000000 0000000000000001 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032f130>{tty_poll+176} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
bash          S 000000f805c8e919     0  2016   2015  2042               
(NOTLB)
ffff8101fdd91e58 0000000000000082 0000000000000075 00000000000039af 
ffff8101ff538a60 ffff8101053d8030 ffff8101053d82a8 ffffffff8012a6eb 
0000000000000000 0000000000000001 
Call Trace:<ffffffff8012a6eb>{try_to_wake_up+555} 
<ffffffff80134375>{do_wait+3477} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 7fffffffffffffff     0  2022   1875  2024    2031  2013 
(NOTLB)
ffff8101fdd17be8 0000000000000086 0000000100000075 0000000000000042 
ffff810004a64820 ffff810004ae1640 ffff810004ae18b8 ffff8101ff6a3600 
ffff8101fef4d680 ffffffff8044bf77 
Call Trace:<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80145863>{prepare_to_wait+35} 
<ffffffff8044c5dd>{unix_stream_recvmsg+621} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff803d43c6>{sock_aio_read+278} 
<ffffffff802f574d>{__up_read+29} <ffffffff802a25b8>{xfs_iunlock+104} 
<ffffffff8016efad>{do_sync_read+173} <ffffffff801779c9>{cdev_get+9} 
<ffffffff80177b42>{chrdev_open+338} <ffffffff8016e566>{dentry_open+230} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8016e64e>{filp_open+62} 
<ffffffff8016f0b4>{vfs_read+212} <ffffffff8016f383>{sys_read+83} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 00000112092e5643     0  2024   2022  2025               
(NOTLB)
ffff8101fdda5d88 0000000000000082 0000000100000074 0000000000001db3 
ffff810004ae0860 ffff810004a64820 ffff810004a64a98 ffffffff805c9a80 
0000000000000000 0000000000000001 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032f130>{tty_poll+176} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
bash          S 000000fcb9e5834b     0  2025   2024  2045               
(NOTLB)
ffff8101fde17e58 0000000000000082 0000000000000074 00000000000029c0 
ffff8100f56f8920 ffff8101053d8e10 ffff8101053d9088 ffffffff8012a6eb 
0000000000000000 0000000000000001 
Call Trace:<ffffffff8012a6eb>{try_to_wake_up+555} 
<ffffffff80134375>{do_wait+3477} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S 7fffffffffffffff     0  2031   1875  2033          2022 
(NOTLB)
ffff8101fde59be8 0000000000000082 0000000100000075 0000000000000040 
ffff810004ae0f50 ffff810004ae0170 ffff810004ae03e8 ffff8101ff6e1400 
ffff8101feefb980 ffffffff8044bf77 
Call Trace:<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff80145863>{prepare_to_wait+35} 
<ffffffff8044c5dd>{unix_stream_recvmsg+621} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8044bf77>{unix_stream_sendmsg+711} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff803d43c6>{sock_aio_read+278} 
<ffffffff802f574d>{__up_read+29} <ffffffff802a25b8>{xfs_iunlock+104} 
<ffffffff8016efad>{do_sync_read+173} <ffffffff801779c9>{cdev_get+9} 
<ffffffff80177b42>{chrdev_open+338} <ffffffff8016e566>{dentry_open+230} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8016e64e>{filp_open+62} 
<ffffffff8016f0b4>{vfs_read+212} <ffffffff8016f383>{sys_read+83} 
<ffffffff8010d4ca>{system_call+126} 
sshd          S ffff8101fdd465c0     0  2033   2031  2034               
(NOTLB)
ffff8101fde1dd88 0000000000000086 000000010000007d 0000000000000da6 
ffff8101ffeee1f0 ffff810004ae0f50 ffff810004ae11c8 ffffffff805c9a80 
0000000000000000 0000000000000001 
Call Trace:<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff8032f130>{tty_poll+176} <ffffffff80182477>{do_select+999} 
<ffffffff80181fa0>{__pollwait+0} <ffffffff80182845>{sys_select+885} 
<ffffffff8010d4ca>{system_call+126} 
bash          S ffff8101fde7b000     0  2034   2033                     
(NOTLB)
ffff8101fdeadd78 0000000000000086 000000000000007d 000000000000fc66 
ffff8101ff515540 ffff8101053a7580 ffff8101053a77f8 ffff8101fde7b018 
0000000000000096 ffffffff8032de34 
Call Trace:<ffffffff8032de34>{tty_ldisc_deref+116} 
<ffffffff804a0b9e>{schedule_timeout+30} 
<ffffffff8014573c>{add_wait_queue+28} <ffffffff80333c67>{read_chan+1143} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8032de34>{tty_ldisc_deref+116} <ffffffff8032e286>{tty_read+214} 
<ffffffff8016f0a1>{vfs_read+193} <ffffffff8016f383>{sys_read+83} 
<ffffffff8010d4ca>{system_call+126} 
md5sum        R  running task       0  2040   1998                     (NOTLB)
md5sum        R  running task       0  2041   2007                     (NOTLB)
bonnie++      D ffff81010383f820     0  2042   2016                     
(NOTLB)
ffff8100f51d7248 0000000000000082 000000010000007d 000000000003bd42 
ffff8101ffeee1f0 ffff8101ff538a60 ffff8101ff538cd8 0000000000000292 
0000000000000292 0000000000000282 
Call Trace:<ffffffff804a0b11>{io_schedule+49} 
<ffffffff80365a8e>{get_request_wait+174} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8036697c>{__make_request+812} 
<ffffffff80366f82>{generic_make_request+546} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8014f1e4>{mempool_alloc+164} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff80367088>{submit_bio+232} <ffffffff80173ee7>{bio_alloc+359} 
<ffffffff804a1355>{_spin_unlock_irqrestore+5} 
<ffffffff80171bbb>{submit_bh+283} 
<ffffffff802c24d1>{xfs_submit_page+209} 
<ffffffff802c220b>{xfs_map_at_offset+123} 
<ffffffff802c2751>{xfs_convert_page+545} <ffffffff80367088>{submit_bio+232} 
<ffffffff8014c415>{find_trylock_page+85} 
<ffffffff802c302d>{xfs_page_state_convert+1501} 
<ffffffff80285890>{xfs_bmbt_get_startblock+0} 
<ffffffff802858d9>{xfs_bmbt_get_state+9} 
<ffffffff802c35c8>{linvfs_writepage+184} 
<ffffffff80192ea7>{mpage_writepages+535} 
<ffffffff802c3510>{linvfs_writepage+0} 
<ffffffff80191afb>{__writeback_single_inode+491} 
<ffffffff8019226c>{sync_sb_inodes+508} 
<ffffffff80192530>{writeback_inodes+144} 
<ffffffff80151d61>{balance_dirty_pages_ratelimited+225} 
<ffffffff8014de48>{generic_file_buffered_write+1160} 
<ffffffff80135415>{current_fs_time+85} <ffffffff802f5630>{__up_write+48} 
<ffffffff802c9f2e>{xfs_write+1854} <ffffffff8015069e>{buffered_rmqueue+654} 
<ffffffff802c5e18>{linvfs_aio_write+104} <ffffffff8016f1bd>{do_sync_write+173} 
<ffffffff8011b89c>{do_page_fault+1276} 
<ffffffff801459d0>{autoremove_wake_function+0} 
<ffffffff8019d9de>{dnotify_parent+46} <ffffffff8016f2b4>{vfs_write+196} 
<ffffffff8016f413>{sys_write+83} <ffffffff8010d4ca>{system_call+126} 

su            S ffff8100f56f8a30     0  2045   2025  2046               
(NOTLB)
ffff8100f5261e58 0000000000000086 000000000000007d 000000000000095c 
ffff8101ff515540 ffff8100f56f8920 ffff8100f56f8b98 ffffffff8010c5bf 
0000000000000000 0000000000000000 
Call Trace:<ffffffff8010c5bf>{copy_thread+79} 
<ffffffff80141eaf>{attach_pid+47} 
<ffffffff80134375>{do_wait+3477} <ffffffff8012aab0>{finish_task_switch+64} 
<ffffffff8013db31>{do_sigaction+577} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8013dea1>{sys_rt_sigaction+113} 
<ffffffff8012c020>{default_wake_function+0} 
<ffffffff8010d4ca>{system_call+126} 
bash          R  running task       0  2046   2045                     (NOTLB)


-- 
Simone Piunno, chief architect
Wireless Solutions SPA - DADA group
Europe HQ, via Castiglione 25 Bologna
web:www.dada-ws.com tel:+39512966811 fax:+39512966800
