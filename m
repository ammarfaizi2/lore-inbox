Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752444AbWCFV5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbWCFV5L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbWCFV5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:57:11 -0500
Received: from mxout1.netvision.net.il ([194.90.9.20]:29249 "EHLO
	mxout1.netvision.net.il") by vger.kernel.org with ESMTP
	id S1752439AbWCFV5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:57:07 -0500
Date: Mon, 06 Mar 2006 23:57:27 +0300
From: Maxim Kozover <maximkoz@netvision.net.il>
Subject: Re: Re: problems with scsi_transport_fc and qla2xxx
In-reply-to: <20060306212835.GO6278@andrew-vasquezs-powerbook-g4-15.local>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Mike Snitzer <snitzer@gmail.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Reply-to: Maxim Kozover <maximkoz@netvision.net.il>
Message-id: <30237301.20060306235727@netvision.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Priority: 3 (Normal)
References: <1413265398.20060227150526@netvision.net.il>
 <978150825.20060227210552@netvision.net.il>
 <20060228221422.282332ef.akpm@osdl.org> <4406034B.9030105@madness.at>
 <20060301210802.GA7288@spe2> <957728045.20060302193248@netvision.net.il>
 <170fa0d20603061200y38315a62uf143258c79659381@mail.gmail.com>
 <1119462161.20060306230951@netvision.net.il>
 <20060306212835.GO6278@andrew-vasquezs-powerbook-g4-15.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!
AV> I also noticed that scsi_transport_fc.c::fc_user_scan() is not called
AV> with the host_lock held... hmm..  could you try out the patch I sent
AV> earlier and provide the results.

AV> Also, could you send the "echo t > /proc/..." output after the cable
AV> has been reinserted, but, before the 'echo "- - -" > /sys/class' scan
AV> is initiated.

AV> thanks,
AV> av

Here's sysrq output after reconnecting cable without manual disk
rescan. Before applying a patch.
The same lock exists:
#001:             [ffff81006ee20080] {scsi_host_alloc}
.. held by:         scsi_wq_4: 4255 [ffff81006f9147b0, 110]
... acquired at:               scsi_scan_target+0x51/0x87 [scsi_mod]

Thanks,

Maxim.

SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S ffff81007fdd3d78     0     1      0     2               (NOTLB)
ffff81007fdd3d78 0000000000000000 0000000000000282 0000000000000000
       ffff81007f6126d8 0000000000000000 0000000000000000 000000000000cc00
       ffff81007fdc4770 0000000000000ee6
Call Trace: <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff8018189c>{do_select+944}
       <ffffffff80181431>{__pollwait+0} <ffffffff80181b7a>{sys_select+651}
       <ffffffff8010a70a>{system_call+126}
migration/0   S ffff81007fdd7ec8     0     2      1             3       (L-TLB)
ffff81007fdd7ec8 000000017ead3830 ffff810003018b00 ffff81000301f800
       0000000000000002 0000000000000000 0000000000000000 0000000000000096
       ffff81007fdc4040 0000000000000d38
Call Trace: <ffffffff801255b3>{__wake_up_common+67}
       <ffffffff8012687c>{migration_thread+360} <ffffffff80126714>{migration_thread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013dd23>{kthread+0} <ffffffff8010b83e>{child_rip+0}
ksoftirqd/0   S ffff81007fddbf08     0     3      1             4     2 (L-TLB)
ffff81007fddbf08 ffff81007ebd1080 000000008031dafb 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 000000000000c6b5
       ffff81007fdc67b0 00000000000000b9
Call Trace: <ffffffff801309a5>{ksoftirqd+0} <ffffffff801309dd>{ksoftirqd+56}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013dd23>{kthread+0} <ffffffff8010b83e>{child_rip+0}
watchdog/0    S ffff81007fdddea8     0     4      1             5     3 (L-TLB)
ffff81007fdddea8 ffffffff8038f000 0000000000000000 ffff81007fddde68
       0000000000000200 0000000000000000 0000000000000000 000000007fdddf08
       ffff81007fdc6080 0000000000000789
Call Trace: <ffffffff801339a1>{lock_timer_base+27} <ffffffff8014cb3d>{watchdog+0}
       <ffffffff8031e54a>{schedule_timeout+138} <ffffffff8013435d>{process_timeout+0}
       <ffffffff80134645>{msleep_interruptible+46} <ffffffff8014cb8c>{watchdog+79}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013dd23>{kthread+0} <ffffffff8010b83e>{child_rip+0}
migration/1   S ffff81007fddfec8     0     5      1             6     4 (L-TLB)
ffff81007fddfec8 000000007a26c080 ffff810003020b00 ffff810003017800
       0000000000000002 0000000000000000 0000000000000001 0000000100000096
       ffff81007fdc77f0 00000000000010bc
Call Trace: <ffffffff801255b3>{__wake_up_common+67}
       <ffffffff8012687c>{migration_thread+360} <ffffffff80126714>{migration_thread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013dd23>{kthread+0} <ffffffff8010b83e>{child_rip+0}
ksoftirqd/1   S ffff810003363f08     0     6      1             7     5 (L-TLB)
ffff810003363f08 ffff81007ed8e7f0 000000008031dafb 0000000000000000
       0000000000000000 0000000100000000 0000000000000001 00000001000014e5
       ffff81007fdc70c0 0000000000000075
Call Trace: <ffffffff801309a5>{ksoftirqd+0} <ffffffff801309dd>{ksoftirqd+56}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013dd23>{kthread+0} <ffffffff8010b83e>{child_rip+0}
watchdog/1    S ffff81007fd85ea8     0     7      1             8     6 (L-TLB)
ffff81007fd85ea8 ffff810003364100 0000000000000000 ffff81007fd85e68
       0000000000000200 0000000000000000 0000000000000001 000000017fd85f08
       ffff810003364830 000000000000008d
Call Trace: <ffffffff801339a1>{lock_timer_base+27} <ffffffff8014cb3d>{watchdog+0}
       <ffffffff8031e54a>{schedule_timeout+138} <ffffffff8013435d>{process_timeout+0}
       <ffffffff80134645>{msleep_interruptible+46} <ffffffff8014cb8c>{watchdog+79}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013dd23>{kthread+0} <ffffffff8010b83e>{child_rip+0}
events/0      S ffff810037f3de98     0     8      1             9     7 (L-TLB)
ffff810037f3de98 0000000000000286 ffffffff801339a1 0000000000000286
       0000000000000286 0000000300000000 0000000000000000 0000000000000000
       ffff810037fef870 0000000000002478
Call Trace: <ffffffff801339a1>{lock_timer_base+27} <ffffffff8013ad6e>{worker_thread+0}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ae41>{worker_thread+211}
       <ffffffff80125562>{default_wake_function+0} <ffffffff80125562>{default_wake_function+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013dd23>{kthread+0} <ffffffff8010b83e>{child_rip+0}
events/1      S ffff810037e57e98     0     9      1            10     8 (L-TLB)
ffff810037e57e98 0000000000000246 0000000000000246 ffff81007e992800
       000000007e9929e8 0000000000000000 ffff810037e46520 0000000100000000
       ffff810037fef140 0000000000000134
Call Trace: <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ad6e>{worker_thread+0}
       <ffffffff8013ae41>{worker_thread+211} <ffffffff80125562>{default_wake_function+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013ddeb>{kthread+200}
       <ffffffff8010b846>{child_rip+8} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
khelper       S ffff810037f39e98     0    10      1            11     9 (L-TLB)
ffff810037f39e98 ffff81006ee95b80 0000000000000001 ffff81006ee95b98
       0000000000000000 0000000000000000 ffff810037e46420 0000000000000000
       ffff810037fee770 00000000000001c2
Call Trace: <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ad6e>{worker_thread+0}
       <ffffffff8013ae41>{worker_thread+211} <ffffffff80125562>{default_wake_function+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013ddeb>{kthread+200}
       <ffffffff8010b846>{child_rip+8} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
kthread       S ffff810037c2de98     0    11      1    15     181    10 (L-TLB)
ffff810037c2de98 ffff81006fbe5b68 0000000000000001 ffff81006fbe5b80
       0000000000000000 0000000300000000 0000000000000001 0000000100000000
       ffff810037fee040 0000000000000151
Call Trace: <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ad6e>{worker_thread+0}
       <ffffffff8013ae41>{worker_thread+211} <ffffffff80125562>{default_wake_function+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013ddeb>{kthread+200}
       <ffffffff8010b846>{child_rip+8} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
kblockd/0     S ffff810037dc3e98     0    15     11            16       (L-TLB)
ffff810037dc3e98 ffff81007f99c000 ffff81007f618ce8 ffff81007f618ce8
       ffffffff801dd758 0000000300000000 0000000000000000 0000000000000000
       ffff81007f580830 0000000000001488
Call Trace: <ffffffff801dd758>{elv_next_request+62}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ae41>{worker_thread+211}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
kblockd/1     S ffff810037dc7e98     0    16     11            17    15 (L-TLB)
ffff810037dc7e98 ffff81007f99c000 ffff81007f618ce8 ffff81007f618ce8
       ffffffff801dd758 0000000300000000 0000000000000001 0000000100000000
       ffff81007f580100 000000000000142c
Call Trace: <ffffffff801dd758>{elv_next_request+62}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ae41>{worker_thread+211}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
kacpid        S ffff810037de7e98     0    17     11           115    16 (L-TLB)
ffff810037de7e98 0000000000000000 0000000000000006 00000000000006cc
       0000000000000000 0000000000000000 0000000000000001 0000000137de7e28
       ffff810003369870 00000000000001cc
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8031f92f>{_spin_unlock_irq+7}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ae41>{worker_thread+211}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
khubd         S ffff810037dede28     0   115     11           179    17 (L-TLB)
ffff810037dede28 0000000000000001 800001807f5107b0 ffff81007e4af800
       0000000000100100 0000000000000000 00000000ffffffff 00000001ffffffff
       ffff81007f5107b0 00000000000006a4
Call Trace: <ffffffff80287ff6>{hub_port_status+83} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8028921a>{hub_thread+0} <ffffffff80289d06>{hub_thread+2796}
       <ffffffff8031dafb>{thread_return+100} <ffffffff8013e39e>{autoremove_wake_function+0}
       <ffffffff801255b3>{__wake_up_common+67} <ffffffff8013e39e>{autoremove_wake_function+0}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8028921a>{hub_thread+0}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013ddeb>{kthread+200}
       <ffffffff8010b846>{child_rip+8} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013dd23>{kthread+0} <ffffffff8010b83e>{child_rip+0}
pdflush       S ffff81007f773ec8     0   179     11           180   115 (L-TLB)
ffff81007f773ec8 ffff81007f773e28 ffff810037fee040 0000000000000000
       000000007f505870 0000000000000000 0000000000000292 000000010301f800
       ffff81007f505870 00000000000000d2
Call Trace: <ffffffff80125835>{set_user_nice+261} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80153f7f>{pdflush+220} <ffffffff80153ea3>{pdflush+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
pdflush       S ffff81007f76fec8     0   180     11           182   179 (L-TLB)
ffff81007f76fec8 ffffffff8039aaa0 ffffffff80133a6a 0000000000000286
       00000000000035c8 0000000000000000 ffff81007fdd3dc8 00000001fffffffc
       ffff81007f517140 0000000000000652
Call Trace: <ffffffff80133a6a>{__mod_timer+168} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80153f7f>{pdflush+220} <ffffffff80153ea3>{pdflush+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
aio/0         S ffff81007f659e98     0   182     11           183   180 (L-TLB)
ffff81007f659e98 ffff81007f51a9c0 0000000000000009 00000000000009ba
       0000000000000002 ffff81007fdd4088 0000000000000000 000000007f659e28
       ffff81007f7240c0 0000000000000239
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8031f92f>{_spin_unlock_irq+7}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ae41>{worker_thread+211}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
kswapd0       S ffff81007f4fdeb8     0   181      1           431    11 (L-TLB)
ffff81007f4fdeb8 ffff81007f4fddf8 0000000000000001 0000000000000001
       0000000000000000 0000000000000000 0000000000000296 000000010301f800
       ffff81007f540080 00000000000002fa
Call Trace: <ffffffff801363fb>{do_notify_parent+404}
       <ffffffff8015769b>{kswapd+247} <ffffffff8013e39e>{autoremove_wake_function+0}
       <ffffffff8012e510>{do_exit+2116} <ffffffff8013e39e>{autoremove_wake_function+0}
       <ffffffff8010b846>{child_rip+8} <ffffffff801575a4>{kswapd+0}
       <ffffffff8010b83e>{child_rip+0}
aio/1         S ffff81007f6f9e98     0   183     11           258   182 (L-TLB)
ffff81007f6f9e98 ffff81007f6cd660 0000000000000009 00000000000009ba
       0000000000000002 ffff81007fdd4088 0000000000000001 000000017f6f9e28
       ffff81007f687100 000000000000015c
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8031f92f>{_spin_unlock_irq+7}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ae41>{worker_thread+211}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
kseriod       S ffff81007f6dbe88     0   258     11           316   183 (L-TLB)
ffff81007f6dbe88 ffff81007f78cda0 ffffffff8031ed71 0000000000000000
       0000000000000000 0000000000008080 0000000000000000 00000000803ce7f0
       ffff81007f682770 000000000000062d
Call Trace: <ffffffff8031ed71>{__mutex_unlock_slowpath+476}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8025133b>{serio_thread+664}
       <ffffffff8013e39e>{autoremove_wake_function+0} <ffffffff8013e39e>{autoremove_wake_function+0}
       <ffffffff802510a3>{serio_thread+0} <ffffffff8013ddeb>{kthread+200}
       <ffffffff8010b846>{child_rip+8} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013dd23>{kthread+0} <ffffffff8010b83e>{child_rip+0}
kpsmoused     S ffff81007f7e3e98     0   316     11           337   258 (L-TLB)
ffff81007f7e3e98 ffff81007ff59ba0 0000000000000009 00000000000009ba
       0000000000000002 ffff81007fdd4088 0000000000000000 000000007f7e3e28
       ffff81007f564040 000000000000024c
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8031f92f>{_spin_unlock_irq+7}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ae41>{worker_thread+211}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
ata/0         S ffff81007ec65e98     0   337     11           338   316 (L-TLB)
ffff81007ec65e98 0000000000000000 0000000000000006 00000000000006cc
       0000000000000000 0000000000000000 0000000000000000 000000007ec65e28
       ffff81007f64e7b0 00000000000002ed
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8031f92f>{_spin_unlock_irq+7}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ae41>{worker_thread+211}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
ata/1         S ffff81007ec67e98     0   338     11           344   337 (L-TLB)
ffff81007ec67e98 ffffffff8031f917 0000000000000010 0000000000000246
       000000007ec67df8 0000000000000000 ffff81007f6b7ae0 0000000100000000
       ffff81007f682040 00000000000051f3
Call Trace: <ffffffff8031f917>{_spin_unlock_irqrestore+11}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ae41>{worker_thread+211}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
scsi_eh_0     S ffff81007ec73e98     0   344     11           345   338 (L-TLB)
ffff81007ec73e98 0000000000000000 0000000000000006 00000000000006cc
       0000000000000000 0000000000000000 0000000000000001 000000017ec73e28
       ffff81007f64e080 00000000000000c6
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8031dafb>{thread_return+100}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff88005dac>{:scsi_mod:scsi_error_handler+0}
       <ffffffff88005e10>{:scsi_mod:scsi_error_handler+100}
       <ffffffff801255b3>{__wake_up_common+67} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff88005dac>{:scsi_mod:scsi_error_handler+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
scsi_eh_1     S ffff81007ec13e98     0   345     11           382   344 (L-TLB)
ffff81007ec13e98 0000000100000001 0000000000000006 00000000000006cc
       0000000000000001 0000000000000001 0000000000000001 000000017ec13e28
       ffff81007f60e7b0 00000000000000ba
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff88005dac>{:scsi_mod:scsi_error_handler+0} <ffffffff88005e10>{:scsi_mod:scsi_error_handler+100}
       <ffffffff801255b3>{__wake_up_common+67} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff88005dac>{:scsi_mod:scsi_error_handler+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
scsi_eh_3     S ffff81007ec1fe98     0   382     11           385   345 (L-TLB)
ffff81007ec1fe98 0000000000000000 0000000000000009 00000000000009ba
       00000000732f0000 0000000000000000 0000000000000001 000000017ec1fe28
       ffff81007f7247f0 00000000000000a3
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8031dafb>{thread_return+100}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff88005dac>{:scsi_mod:scsi_error_handler+0}
       <ffffffff88005e10>{:scsi_mod:scsi_error_handler+100}
       <ffffffff801255b3>{__wake_up_common+67} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff88005dac>{:scsi_mod:scsi_error_handler+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
scsi_wq_3     S ffff81007f58fe98     0   385     11           417   382 (L-TLB)
ffff81007f58fe98 2222222222222222 2222222222222222 2222222222222222
       2222222222222222 0000000300000000 0000000000000001 0000000100000000
       ffff81007f7dc870 0000000000000843
Call Trace: <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ae41>{worker_thread+211}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
kmirrord      S ffff81007ef15e98     0   417     11          1935   385 (L-TLB)
ffff81007ef15e98 0000000000000011 ffff81007ef15eb8 ffff81007ef0e320
       ffff81007edc7870 0000000000000282 0000000000000001 0000000100000100
       ffff81007edc7870 00000000000004d0
Call Trace: <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ae41>{worker_thread+211}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
kjournald     S ffff81007ede1e88     0   431      1          1358   181 (L-TLB)
ffff81007ede1e88 ffff81007edc95f8 ffffffff88087585 00000fdc00000000
       000000006ebc6024 0000000000000000 ffff81007f62a000 000000017278ddf0
       ffff81007ed8e7f0 00000000000001b6
Call Trace: <ffffffff88087585>{:jbd:journal_commit_transaction+4225}
       <ffffffff88089467>{:jbd:kjournald+466} <ffffffff8013e39e>{autoremove_wake_function+0}
       <ffffffff8013e39e>{autoremove_wake_function+0} <ffffffff8012e510>{do_exit+2116}
       <ffffffff88089290>{:jbd:commit_timeout+0} <ffffffff8010b846>{child_rip+8}
       <ffffffff88089295>{:jbd:kjournald+0} <ffffffff8010b83e>{child_rip+0}
udevd         S ffff81007da91d78     0  1358      1          2104   431 (NOTLB)
ffff81007da91d78 0000000000000206 0000000000000206 0000000000000001
       0000004400000001 ffff81000000cc00 0000000000000001 0000000100000286
       ffff81007edc8100 0000000000001f20
Call Trace: <ffffffff80151fd1>{__alloc_pages+102} <ffffffff8031e4de>{schedule_timeout+30}
       <ffffffff8013e1d6>{add_wait_queue+18} <ffffffff802bc43c>{datagram_poll+42}
       <ffffffff802bc412>{datagram_poll+0} <ffffffff8018189c>{do_select+944}
       <ffffffff801a5313>{proc_delete_inode+0} <ffffffff80181431>{__pollwait+0}
       <ffffffff8031f883>{_spin_lock_irqsave+11} <ffffffff80181b7a>{sys_select+651}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8016fddd>{sys_read+69}
       <ffffffff8010a70a>{system_call+126}
kauditd       S ffff81007d5f7ea8     0  1935     11          2043   417 (L-TLB)
ffff81007d5f7ea8 00000000000009ba 0000000000000002 ffff81007f70e908
       0000000000000001 ffff81007d5f7e28 0000000000000000 0000000000000000
       ffff81007e562140 0000000000000140
Call Trace: <ffffffff80149c98>{kauditd_thread+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80149c98>{kauditd_thread+0} <ffffffff80149dd7>{kauditd_thread+319}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
kmpathd/0     S ffff81007d031e98     0  2043     11          2044  1935 (L-TLB)
ffff81007d031e98 2d18130000000006 0000000000000008 00000000000008c0
       00000000000000db 0000000000000000 0000000000000001 000000007d031e28
       ffff81007e58d7b0 000000000000011c
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8031dafb>{thread_return+100}
       <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8013ad6e>{worker_thread+0}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013ad6e>{worker_thread+0}
       <ffffffff8013ae41>{worker_thread+211} <ffffffff80125562>{default_wake_function+0}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff80125562>{default_wake_function+0}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013ddeb>{kthread+200}
       <ffffffff8010b846>{child_rip+8} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013dd23>{kthread+0} <ffffffff8010b83e>{child_rip+0}
kmpathd/1     S ffff81007d027e98     0  2044     11          4224  2043 (L-TLB)
ffff81007d027e98 0000000000000000 0000000000000008 00000000000008c0
       000000007da3a890 0000000000000000 0000000000000001 000000017d027e28
       ffff81007ead57f0 00000000000001b8
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8031dafb>{thread_return+100}
       <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8013ad6e>{worker_thread+0}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013ad6e>{worker_thread+0}
       <ffffffff8013ae41>{worker_thread+211} <ffffffff80125562>{default_wake_function+0}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff80125562>{default_wake_function+0}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013ddeb>{kthread+200}
       <ffffffff8010b846>{child_rip+8} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013dd23>{kthread+0} <ffffffff8010b83e>{child_rip+0}
kjournald     S ffff81007a0a9e88     0  2104      1          2716  1358 (L-TLB)
ffff81007a0a9e88 0000003000000010 ffff81007a0a9e98 ffff81007a0a9dd8
       0000000079fcfb28 0000000000000000 0000000000000005 0000000100000000
       ffff81007e9de080 0000000000000922
Call Trace: <ffffffff88089467>{:jbd:kjournald+466} <ffffffff8013e39e>{autoremove_wake_function+0}
       <ffffffff8013e39e>{autoremove_wake_function+0} <ffffffff8031f92f>{_spin_unlock_irq+7}
       <ffffffff88089290>{:jbd:commit_timeout+0} <ffffffff8010b846>{child_rip+8}
       <ffffffff88089295>{:jbd:kjournald+0} <ffffffff8010b83e>{child_rip+0}
dhclient      S ffff810079229d78     0  2716      1          2760  2104 (NOTLB)
ffff810079229d78 0000000000000000 0000004400000001 ffff81000000cc00
       000200d00000015c 0000000000000282 0000000000000000 00000000000000d0
       ffff81007a0d9040 0000000000001125
Call Trace: <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff802bc412>{datagram_poll+0}
       <ffffffff8018189c>{do_select+944} <ffffffff80181431>{__pollwait+0}
       <ffffffff80181b7a>{sys_select+651} <ffffffff8010a70a>{system_call+126}
syslogd       R  running task       0  2760      1          2764  2716 (NOTLB)
klogd         S ffff81007906fbd8     0  2764      1          2775  2760 (NOTLB)
ffff81007906fbd8 ffff81007edc8830 ffff810037fdac80 ffff810037c1e690
       0000000078715000 000000005b169863 0000000000000000 000000007906fbf8
       ffff81007ebd1080 00000000000004c0
Call Trace: <ffffffff80123eda>{try_to_wake_up+1035}
       <ffffffff8031e4de>{schedule_timeout+30} <ffffffff8031f883>{_spin_lock_irqsave+11}
       <ffffffff8013e2f6>{prepare_to_wait_exclusive+21} <ffffffff803177cf>{unix_wait_for_peer+163}
       <ffffffff8013e39e>{autoremove_wake_function+0} <ffffffff80125609>{__wake_up+54}
       <ffffffff8013e39e>{autoremove_wake_function+0} <ffffffff803182c8>{unix_dgram_sendmsg+950}
       <ffffffff802b5561>{do_sock_write+196} <ffffffff802b56b1>{sock_aio_write+79}
       <ffffffff8031dafb>{thread_return+100} <ffffffff8016fbe9>{do_sync_write+201}
       <ffffffff8013e39e>{autoremove_wake_function+0} <ffffffff8013e39e>{autoremove_wake_function+0}
       <ffffffff8016fd0d>{vfs_write+231} <ffffffff8016fe4b>{sys_write+69}
       <ffffffff8010a70a>{system_call+126}
irqbalance    S ffff8100791f1e98     0  2775      1          2787  2764 (NOTLB)
ffff8100791f1e98 00000002540be400 ffffffff8013031b 00000000440caf80
       000000000005b900 0000000000019a0c 0000000000000001 00000001bbf35151
       ffff81007e484040 0000000000011881
Call Trace: <ffffffff8013031b>{getnstimeofday+16} <ffffffff8014059e>{enqueue_hrtimer+93}
       <ffffffff801406ac>{hrtimer_start+195} <ffffffff8031f1fd>{schedule_hrtimer+36}
       <ffffffff80140933>{hrtimer_nanosleep+91} <ffffffff80137877>{do_sigaction+568}
       <ffffffff80136d74>{sigprocmask+216} <ffffffff80140a2d>{sys_nanosleep+85}
       <ffffffff8010a70a>{system_call+126}
portmap       S ffff810079063e78     0  2787      1          2807  2775 (NOTLB)
ffff810079063e78 0000000000000001 0000004400000001 ffff81000000cc00
       00000000802b4b33 0000000000000000 ffff81000000cc00 00000001000000d0
       ffff81007eece0c0 000000000000098b
Call Trace: <ffffffff8031f883>{_spin_lock_irqsave+11}
       <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff80181f2c>{do_sys_poll+610}
       <ffffffff80181431>{__pollwait+0} <ffffffff80182049>{sys_poll+74}
       <ffffffff8010a70a>{system_call+126}
rpc.statd     S ffff81007958bd78     0  2807      1          2846  2787 (NOTLB)
ffff81007958bd78 0000000000000001 0000004400000001 ffff81000000cc00
       000200d0802b516e 0000000000000286 0000000000000001 00000001000000d0
       ffff81007e4f0100 00000000000019d8
Call Trace: <ffffffff8031e4de>{schedule_timeout+30}
       <ffffffff8013e1d6>{add_wait_queue+18} <ffffffff802e4789>{tcp_poll+42}
       <ffffffff8018189c>{do_select+944} <ffffffff80181431>{__pollwait+0}
       <ffffffff8013e451>{bit_waitqueue+53} <ffffffff80181b7a>{sys_select+651}
       <ffffffff8010a70a>{system_call+126}
rpc.idmapd    S ffff810078d43e88     0  2846      1          2937  2807 (NOTLB)
ffff810078d43e88 ffff81007e5300c0 ffffffff80160d90 ffff810002e3bf90
       000000008015b7f2 0000000000000000 0000000000000001 0000000100000246
       ffff81007ec83870 0000000000000816
Call Trace: <ffffffff80160d90>{page_add_file_rmap+36}
       <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff801953e9>{sys_epoll_wait+400}
       <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff80125562>{default_wake_function+0}
       <ffffffff8010a70a>{system_call+126}
acpid         S ffff810078849d78     0  2937      1          2968  2846 (NOTLB)
ffff810078849d78 ffff810078849e88 ffffffff8014fef4 0000000000000000
       0000000000000286 0000000000000001 0000000000000001 0000000100000001
       ffff81007ec71100 0000000000005e59
Call Trace: <ffffffff8014fef4>{__generic_file_aio_write_nolock+873}
       <ffffffff80151fd1>{__alloc_pages+102} <ffffffff8031e4de>{schedule_timeout+30}
       <ffffffff8031f883>{_spin_lock_irqsave+11} <ffffffff8013e1d6>{add_wait_queue+18}
       <ffffffff8018189c>{do_select+944} <ffffffff80181431>{__pollwait+0}
       <ffffffff80181b7a>{sys_select+651} <ffffffff8016fe4b>{sys_write+69}
       <ffffffff8010a70a>{system_call+126}
cupsd         S ffff810078a9bd78     0  2968      1          3073  2937 (NOTLB)
ffff810078a9bd78 0000000000000000 0000000000000282 0000000000000014
       ffffffff802b4ff1 0000000000000000 0000000000000000 000000000000cc00
       ffff81007e58d080 0000000000000865
Call Trace: <ffffffff802b4ff1>{sock_sendmsg+265} <ffffffff801339a1>{lock_timer_base+27}
       <ffffffff8031e54a>{schedule_timeout+138} <ffffffff8013435d>{process_timeout+0}
       <ffffffff8018189c>{do_select+944} <ffffffff80181431>{__pollwait+0}
       <ffffffff80181b7a>{sys_select+651} <ffffffff8010a70a>{system_call+126}
sshd          S ffff8100761bbd78     0  3073      1          3094  2968 (NOTLB)
ffff8100761bbd78 0000000000000000 0000000000000286 0000000000000005
       ffff81007da0f480 0000000000000001 0000000000000001 000000010000cc00
       ffff81007edc7140 0000000000003c68
Call Trace: <ffffffff8031e4de>{schedule_timeout+30}
       <ffffffff8013e1d6>{add_wait_queue+18} <ffffffff802e4789>{tcp_poll+42}
       <ffffffff8018189c>{do_select+944} <ffffffff80181431>{__pollwait+0}
       <ffffffff80181b7a>{sys_select+651} <ffffffff8010a70a>{system_call+126}
xinetd        S ffff81007626dd78     0  3094      1          3113  3073 (NOTLB)
ffff81007626dd78 0000000000000000 0000000000000282 0000000000000046
       00000000802b4ff1 0000000000000000 0000004400000001 000000000000cc00
       ffff81007ed1b7b0 00000000000007c9
Call Trace: <ffffffff80151fd1>{__alloc_pages+102} <ffffffff8031e4de>{schedule_timeout+30}
       <ffffffff8013e1d6>{add_wait_queue+18} <ffffffff802e4789>{tcp_poll+42}
       <ffffffff8018189c>{do_select+944} <ffffffff80181431>{__pollwait+0}
       <ffffffff80181b7a>{sys_select+651} <ffffffff8031f92f>{_spin_unlock_irq+7}
       <ffffffff8010a70a>{system_call+126}
sendmail      S ffff8100769b5d78     0  3113      1          3121  3094 (NOTLB)
ffff8100769b5d78 0000000000000000 0000000000000286 0000000000000033
       000000006ed12014 0000000000000000 0000004400000001 000000010000cc00
       ffff81007e5300c0 0000000000002cfd
Call Trace: <ffffffff8031f883>{_spin_lock_irqsave+11}
       <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff8018189c>{do_select+944}
       <ffffffff80181431>{__pollwait+0} <ffffffff80181b7a>{sys_select+651}
       <ffffffff8010a70a>{system_call+126}
sendmail      S ffff810076c6ff68     0  3121      1          3170  3113 (NOTLB)
ffff810076c6ff68 0000000000000000 0000000000030002 0000000000000000
       00000000440caeea 0000000000000000 0000000000000001 00000001798e6698
       ffff81007e614870 000000000000fcc1
Call Trace: <ffffffff80137caa>{sys_pause+23} <ffffffff8010a70a>{system_call+126}
gpm           S ffff8100771b1d78     0  3170      1          3229  3121 (NOTLB)
ffff8100771b1d78 ffff81007232c830 ffff81007f763568 0000000000000000
       0000000000000282 0000000000000000 0000000000000000 0000000000000000
       ffff81007f53c040 0000000000000149
Call Trace: <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff8018189c>{do_select+944}
       <ffffffff80181431>{__pollwait+0} <ffffffff80181b7a>{sys_select+651}
       <ffffffff802b4d59>{sock_map_fd+305} <ffffffff8010a70a>{system_call+126}
htt           S ffff810076f63ea8     0  3229      1  3230    3242  3170 (NOTLB)
ffff810076f63ea8 0000000000000000 ffff81000337b0c0 0000000001200011
       0000000000000000 0000000000000000 ffffffff8013b8c1 0000000076aae010
       ffff81000337b0c0 00000000000024e9
Call Trace: <ffffffff8013b8c1>{attach_pid+28} <ffffffff801ed478>{__up_read+16}
       <ffffffff8032163c>{do_page_fault+1000} <ffffffff8012f1ef>{do_wait+2585}
       <ffffffff80125562>{default_wake_function+0} <ffffffff80125562>{default_wake_function+0}
       <ffffffff8010a70a>{system_call+126}
htt_server    S ffff810077227e78     0  3230   3229                     (NOTLB)
ffff810077227e78 0000000000000000 0000000000000000 0000000000000000
       0000000000000282 0000000000000000 ffffffff8015b7f2 0000000000000000
       ffff81007e310140 0000000000000f32
Call Trace: <ffffffff8015b7f2>{__handle_mm_fault+1372}
       <ffffffff8031f883>{_spin_lock_irqsave+11} <ffffffff801339a1>{lock_timer_base+27}
       <ffffffff8031e54a>{schedule_timeout+138} <ffffffff8013435d>{process_timeout+0}
       <ffffffff80181f2c>{do_sys_poll+610} <ffffffff80181431>{__pollwait+0}
       <ffffffff80182049>{sys_poll+74} <ffffffff8010a70a>{system_call+126}
cannaserver   S ffff810076733d78     0  3242      1          3254  3229 (NOTLB)
ffff810076733d78 ffffffff8038f000 0000000000000000 0000000000000000
       0000000000000282 ffff810076733d88 0000000000000000 0000000000000000
       ffff81007e739100 0000000000000633
Call Trace: <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff8018189c>{do_select+944}
       <ffffffff80181431>{__pollwait+0} <ffffffff80181b7a>{sys_select+651}
       <ffffffff8010a70a>{system_call+126}
crond         S ffff810073dbfe98     0  3254      1          3295  3242 (NOTLB)
ffff810073dbfe98 0000000df8475800 ffffffff8013031b 00000000440caf79
       00000000000d47d4 0000000000018d58 0000000000000000 00000000bbf35151
       ffff81007e6997f0 000000000000130f
Call Trace: <ffffffff8013031b>{getnstimeofday+16} <ffffffff8014059e>{enqueue_hrtimer+93}
       <ffffffff801406ac>{hrtimer_start+195} <ffffffff8031f1fd>{schedule_hrtimer+36}
       <ffffffff80140933>{hrtimer_nanosleep+91} <ffffffff80137877>{do_sigaction+568}
       <ffffffff80136d74>{sigprocmask+216} <ffffffff80140a2d>{sys_nanosleep+85}
       <ffffffff8010a70a>{system_call+126}
xfs           S ffff810073641d78     0  3295      1          3314  3254 (NOTLB)
ffff810073641d78 ffff810003364100 0000000000000001 0000000000000000
       0000000000000282 0000000000000000 0000000000000001 0000000100000000
       ffff81007e5247f0 00000000000003d1
Call Trace: <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff8018189c>{do_select+944}
       <ffffffff80181431>{__pollwait+0} <ffffffff80181b7a>{sys_select+651}
       <ffffffff8010a70a>{system_call+126}
atd           S ffff8100737f1e98     0  3314      1          3333  3295 (NOTLB)
ffff8100737f1e98 00000045d964b800 ffffffff8013031b 00000000440caeed
       0000000000077199 0000000000007b32 0000000000000000 00000000bbf35151
       ffff81007f60e080 00000000000036c3
Call Trace: <ffffffff8013031b>{getnstimeofday+16} <ffffffff8014059e>{enqueue_hrtimer+93}
       <ffffffff801406ac>{hrtimer_start+195} <ffffffff8031f1fd>{schedule_hrtimer+36}
       <ffffffff80140933>{hrtimer_nanosleep+91} <ffffffff80137877>{do_sigaction+568}
       <ffffffff80136d74>{sigprocmask+216} <ffffffff80140a2d>{sys_nanosleep+85}
       <ffffffff8010a70a>{system_call+126}
dbus-daemon-1 S ffff810072a7de78     0  3333      1          3343  3314 (NOTLB)
ffff810072a7de78 ffff810000000000 ffff810072a7ddd8 0000000000000000
       0000000000000286 0000000000000000 0000000000000001 0000000100000001
       ffff810079e48040 00000000000013d2
Call Trace: <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff80181f2c>{do_sys_poll+610}
       <ffffffff80181431>{__pollwait+0} <ffffffff80182049>{sys_poll+74}
       <ffffffff8010a70a>{system_call+126}
cups-config-d S ffff810072b33e78     0  3343      1          3363  3333 (NOTLB)
ffff810072b33e78 0000000000000000 0000000000000000 0000000000000000
       0000000000000282 ffff810002cbf750 0000000000000000 0000000000000000
       ffff81007e549140 00000000000045c9
Call Trace: <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff80181f2c>{do_sys_poll+610}
       <ffffffff80181431>{__pollwait+0} <ffffffff80182049>{sys_poll+74}
       <ffffffff8010a70a>{system_call+126}
login         S ffff810072bc5ea8     0  3363      1  3967    3364  3343 (NOTLB)
ffff810072bc5ea8 0000000000000000 ffff81007a26c7b0 0000000001200011
       0000000000000000 ffff810072bc5e18 0000000000000000 000000007ede2ff8
       ffff81007a26c7b0 0000000000000b53
Call Trace: <ffffffff801ed478>{__up_read+16} <ffffffff8032163c>{do_page_fault+1000}
       <ffffffff8012f1ef>{do_wait+2585} <ffffffff80125562>{default_wake_function+0}
       <ffffffff80137b93>{sys_rt_sigaction+97} <ffffffff80125562>{default_wake_function+0}
       <ffffffff8010a70a>{system_call+126}
mingetty      S ffff8100726bfda8     0  3364      1          3365  3363 (NOTLB)
ffff8100726bfda8 0000000000000020 0000000000000004 0000000000000410
       0000000000000246 0000000000000000 0000000000000001 00000000726bfd38
       ffff81007e549870 000000000001a64c
Call Trace: <ffffffff80123eda>{try_to_wake_up+1035}
       <ffffffff8031e4de>{schedule_timeout+30} <ffffffff8031f883>{_spin_lock_irqsave+11}
       <ffffffff8013e1d6>{add_wait_queue+18} <ffffffff80236612>{read_chan+990}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8031f47f>{__down_failed+53}
       <ffffffff80125562>{default_wake_function+0} <ffffffff80231317>{tty_read+136}
       <ffffffff8016fa82>{vfs_read+209} <ffffffff8016fddd>{sys_read+69}
       <ffffffff8010a70a>{system_call+126}
mingetty      S ffff810072babda8     0  3365      1          3368  3364 (NOTLB)
ffff810072babda8 0000000000000020 ffff81007e2e1800 0000000000000246
       0000000000000246 0000000000000000 ffffffff8012bce6 0000000100000246
       ffff81007e0eb770 00000000000054ec
Call Trace: <ffffffff8012bce6>{release_console_sem+377}
       <ffffffff8031e4de>{schedule_timeout+30} <ffffffff8031f883>{_spin_lock_irqsave+11}
       <ffffffff8013e1d6>{add_wait_queue+18} <ffffffff80236612>{read_chan+990}
       <ffffffff80125562>{default_wake_function+0} <ffffffff80125562>{default_wake_function+0}
       <ffffffff80230fce>{tty_ldisc_deref+101} <ffffffff80231317>{tty_read+136}
       <ffffffff8016fa82>{vfs_read+209} <ffffffff8016fddd>{sys_read+69}
       <ffffffff8010a70a>{system_call+126}
mingetty      S ffff810072badda8     0  3368      1          3369  3365 (NOTLB)
ffff810072badda8 0000000000000020 ffff81007e2e1000 0000000000000246
       0000000000000246 0000000000000000 ffffffff8012bce6 0000000100000246
       ffff810079df1770 0000000000008895
Call Trace: <ffffffff8012bce6>{release_console_sem+377}
       <ffffffff8031e4de>{schedule_timeout+30} <ffffffff8031f883>{_spin_lock_irqsave+11}
       <ffffffff8013e1d6>{add_wait_queue+18} <ffffffff80236612>{read_chan+990}
       <ffffffff80125562>{default_wake_function+0} <ffffffff80125562>{default_wake_function+0}
       <ffffffff80230fce>{tty_ldisc_deref+101} <ffffffff80231317>{tty_read+136}
       <ffffffff8016fa82>{vfs_read+209} <ffffffff8016fddd>{sys_read+69}
       <ffffffff8010a70a>{system_call+126}
mingetty      S ffff810072bbbda8     0  3369      1          3371  3368 (NOTLB)
ffff810072bbbda8 0000000000000020 ffff81007e288c00 0000000000000246
       0000000000000246 0000000000000000 ffffffff8012bce6 0000000100000246
       ffff810079c90100 0000000000008342
Call Trace: <ffffffff8012bce6>{release_console_sem+377}
       <ffffffff8031e4de>{schedule_timeout+30} <ffffffff8031f883>{_spin_lock_irqsave+11}
       <ffffffff8013e1d6>{add_wait_queue+18} <ffffffff80236612>{read_chan+990}
       <ffffffff80125562>{default_wake_function+0} <ffffffff80125562>{default_wake_function+0}
       <ffffffff80230fce>{tty_ldisc_deref+101} <ffffffff80231317>{tty_read+136}
       <ffffffff8016fa82>{vfs_read+209} <ffffffff8016fddd>{sys_read+69}
       <ffffffff8010a70a>{system_call+126}
mingetty      S ffff810072bc7da8     0  3371      1          3581  3369 (NOTLB)
ffff810072bc7da8 0000000000000020 ffff81007e288000 0000000000000246
       0000000000000246 0000000000004e7d 0000000000000000 0000000000000246
       ffff81007eece7f0 0000000000004fa0
Call Trace: <ffffffff8031e4de>{schedule_timeout+30}
       <ffffffff8031f883>{_spin_lock_irqsave+11} <ffffffff8013e1d6>{add_wait_queue+18}
       <ffffffff80236612>{read_chan+990} <ffffffff80125562>{default_wake_function+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff80230fce>{tty_ldisc_deref+101}
       <ffffffff80231317>{tty_read+136} <ffffffff8016fa82>{vfs_read+209}
       <ffffffff8016fddd>{sys_read+69} <ffffffff8010a70a>{system_call+126}
mingetty      S ffff8100721e7da8     0  3581      1          3584  3371 (NOTLB)
ffff8100721e7da8 0000000000000020 ffff81007e49fa00 0000000000000246
       0000000000000246 0000000000004e7d 0000000000000000 0000000000000246
       ffff81007ead3100 000000000000be06
Call Trace: <ffffffff8031e4de>{schedule_timeout+30}
       <ffffffff8031f883>{_spin_lock_irqsave+11} <ffffffff8013e1d6>{add_wait_queue+18}
       <ffffffff80236612>{read_chan+990} <ffffffff80125562>{default_wake_function+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff80230fce>{tty_ldisc_deref+101}
       <ffffffff80231317>{tty_read+136} <ffffffff8016fa82>{vfs_read+209}
       <ffffffff8016fddd>{sys_read+69} <ffffffff8010a70a>{system_call+126}
gdm-binary    S ffff810072337e78     0  3584      1  3845    4253  3581 (NOTLB)
ffff810072337e78 0000000000000000 0000000000000282 0000000000000001
       0000000003017800 0000000000000000 0000004400000001 000000000000cc00
       ffff8100721bb830 0000000000000518
Call Trace: <ffffffff8031f883>{_spin_lock_irqsave+11}
       <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff80181f2c>{do_sys_poll+610}
       <ffffffff80181431>{__pollwait+0} <ffffffff80182049>{sys_poll+74}
       <ffffffff8010a70a>{system_call+126}
gdm-binary    S ffff81007215dde8     0  3845   3584  3846               (NOTLB)
ffff81007215dde8 000000003ad45f4e 0000000000000020 0000000000000000
       0000000000000009 000000000000099c 0000000000000001 0000000171bcc0f8
       ffff81007ede3040 0000000000000519
Call Trace: <ffffffff8017ad22>{pipe_wait+118} <ffffffff8013e39e>{autoremove_wake_function+0}
       <ffffffff8013e39e>{autoremove_wake_function+0} <ffffffff8017b086>{pipe_readv+658}
       <ffffffff8017b130>{pipe_read+26} <ffffffff8016fa82>{vfs_read+209}
       <ffffffff8016fddd>{sys_read+69} <ffffffff8010a70a>{system_call+126}
X             S ffff81007206bd78     0  3846   3845          3966       (NOTLB)
ffff81007206bd78 ffffffff8038f000 ffff81007206bdc8 0000000000000000
       0000000000000282 0000000000000000 0000000000000000 000000007ea25800
       ffff81007232c830 000000000000a27d
Call Trace: <ffffffff8031f883>{_spin_lock_irqsave+11}
       <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff8018189c>{do_select+944}
       <ffffffff80181431>{__pollwait+0} <ffffffff80181b7a>{sys_select+651}
       <ffffffff8010a70a>{system_call+126}
gdmgreeter    S ffff810070303e78     0  3966   3845                3846 (NOTLB)
ffff810070303e78 ffff81007232c830 ffff810070303dd8 0000000000000000
       0000000000000282 0000000000000000 0000000000000000 0000000000000000
       ffff810079894870 000000000000015a
Call Trace: <ffffffff801339a1>{lock_timer_base+27} <ffffffff8031e54a>{schedule_timeout+138}
       <ffffffff8013435d>{process_timeout+0} <ffffffff80181f2c>{do_sys_poll+610}
       <ffffffff80181431>{__pollwait+0} <ffffffff80182049>{sys_poll+74}
       <ffffffff8010a70a>{system_call+126}
bash          R  running task       0  3967   3363                     (NOTLB)
scsi_eh_4     S ffff81006ee2be98     0  4224     11          4255  2044 (L-TLB)
ffff81006ee2be98 0000000000000000 0000000000000008 00000000000008c0
       0000000000000000 0000000000000000 0000000000000000 000000006ee2be28
       ffff81007f5407b0 0000000000000121
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff88005dac>{:scsi_mod:scsi_error_handler+0} <ffffffff88005e10>{:scsi_mod:scsi_error_handler+100}
       <ffffffff801255b3>{__wake_up_common+67} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff88005dac>{:scsi_mod:scsi_error_handler+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
qla2xxx_4_dpc S ffff81007f4ede18     0  4253      1          4408  3584 (L-TLB)
ffff81007f4ede18 0000000000004000 ffff81007f985a00 0000000000000000
       0000000000200200 00000000ffffdb57 0000000000000000 000000006ee234e8
       ffff81006fbf9830 00000000000a624e
Call Trace: <ffffffff8031f7b7>{__down_interruptible+203}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013ab66>{__queue_work+78}
       <ffffffff8031f4b9>{__down_failed_interruptible+53} <ffffffff881b952c>{:qla2xxx:.text.lock.qla_os+15}
       <ffffffff8010b846>{child_rip+8} <ffffffff881b8cb8>{:qla2xxx:qla2x00_do_dpc+0}
       <ffffffff8010b83e>{child_rip+0}
scsi_wq_4     D ffff81006ee95a88     0  4255     11          4264  4224 (L-TLB)
ffff81006ee95a88 0001122000011220 0000000000011220 ffff81007628a780
       ffff81007f985a00 ffff81007f9d8580 0000000000000000 0000000000000246
       ffff81006f9147b0 0000000000001045
Call Trace: <ffffffff8031dc2a>{wait_for_completion+165}
       <ffffffff80125562>{default_wake_function+0} <ffffffff80125562>{default_wake_function+0}
       <ffffffff801e025d>{blk_execute_rq+242} <ffffffff80174151>{bio_alloc_bioset+198}
       <ffffffff801deb05>{blk_recount_segments+124} <ffffffff88006cf9>{:scsi_mod:scsi_execute+216}
       <ffffffff88006d96>{:scsi_mod:scsi_execute_req+120} <ffffffff88009411>{:scsi_mod:scsi_probe_and_add_lun+523}
       <ffffffff88009160>{:scsi_mod:scsi_alloc_target+512}
       <ffffffff88009d1d>{:scsi_mod:__scsi_scan_target+196}
       <ffffffff8031ea88>{__mutex_lock_slowpath+768} <ffffffff8800a2ea>{:scsi_mod:scsi_scan_target+111}
       <ffffffff88046aac>{:scsi_transport_fc:fc_scsi_scan_rport+0}
       <ffffffff8013ad24>{run_workqueue+161} <ffffffff8013ad6e>{worker_thread+0}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013ae73>{worker_thread+261}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
scsi_eh_5     S ffff81006eef5e98     0  4264     11          4410  4255 (L-TLB)
ffff81006eef5e98 0000000000000005 0000000000000009 00000000000009ba
       0000000000000002 0000000000000000 0000000000000001 000000016eef5e28
       ffff81007e739830 000000000000012c
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8031dafb>{thread_return+100}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff88005dac>{:scsi_mod:scsi_error_handler+0}
       <ffffffff88005e10>{:scsi_mod:scsi_error_handler+100}
       <ffffffff801255b3>{__wake_up_common+67} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff88005dac>{:scsi_mod:scsi_error_handler+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}
qla2xxx_5_dpc S ffff81006fa1fe18     0  4408      1                4253 (L-TLB)
ffff81006fa1fe18 ffffffff8038f000 0000000000000000 000000000000004c
       00000000722a8980 0000000000000000 ffff8100722a8980 0000000000000000
       ffff81007e5240c0 0000000000000182
Call Trace: <ffffffff80123600>{activate_task+140} <ffffffff80123eda>{try_to_wake_up+1035}
       <ffffffff8031f7b7>{__down_interruptible+203} <ffffffff80125562>{default_wake_function+0}
       <ffffffff8031f4b9>{__down_failed_interruptible+53} <ffffffff881b952c>{:qla2xxx:.text.lock.qla_os+15}
       <ffffffff8010b846>{child_rip+8} <ffffffff881b8cb8>{:qla2xxx:qla2x00_do_dpc+0}
       <ffffffff8010b83e>{child_rip+0}
scsi_wq_5     S ffff81006fa99e98     0  4410     11                4264 (L-TLB)
ffff81006fa99e98 00005555556a41d8 0000000000000009 00000000000009ba
       00002b693ef0b820 00002b693ef0b810 0000000000000001 000000016fa99e28
       ffff81007e6990c0 0000000000000174
Call Trace: <ffffffff8031f92f>{_spin_unlock_irq+7} <ffffffff8031f92f>{_spin_unlock_irq+7}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ad6e>{worker_thread+0} <ffffffff8013ae41>{worker_thread+211}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff80125562>{default_wake_function+0} <ffffffff8013de14>{keventd_create_kthread+0}
       <ffffffff8013ddeb>{kthread+200} <ffffffff8010b846>{child_rip+8}
       <ffffffff8013de14>{keventd_create_kthread+0} <ffffffff8013dd23>{kthread+0}
       <ffffffff8010b83e>{child_rip+0}

Showing all blocking locks in the system:
S            init:    1 [ffff81007fdc4770, 116] (not blocked on mutex)
S     migration/0:    2 [ffff81007fdc4040,   0] (not blocked on mutex)
S     ksoftirqd/0:    3 [ffff81007fdc67b0, 135] (not blocked on mutex)
S      watchdog/0:    4 [ffff81007fdc6080,   0] (not blocked on mutex)
S     migration/1:    5 [ffff81007fdc77f0,   0] (not blocked on mutex)
S     ksoftirqd/1:    6 [ffff81007fdc70c0, 134] (not blocked on mutex)
S      watchdog/1:    7 [ffff810003364830,   0] (not blocked on mutex)
S        events/0:    8 [ffff810037fef870, 110] (not blocked on mutex)
S        events/1:    9 [ffff810037fef140, 110] (not blocked on mutex)
S         khelper:   10 [ffff810037fee770, 110] (not blocked on mutex)
S         kthread:   11 [ffff810037fee040, 110] (not blocked on mutex)
S       kblockd/0:   15 [ffff81007f580830, 110] (not blocked on mutex)
S       kblockd/1:   16 [ffff81007f580100, 110] (not blocked on mutex)
S          kacpid:   17 [ffff810003369870, 114] (not blocked on mutex)
S           khubd:  115 [ffff81007f5107b0, 110] (not blocked on mutex)
S         pdflush:  179 [ffff81007f505870, 120] (not blocked on mutex)
S         pdflush:  180 [ffff81007f517140, 115] (not blocked on mutex)
S           aio/0:  182 [ffff81007f7240c0, 110] (not blocked on mutex)
S         kswapd0:  181 [ffff81007f540080, 117] (not blocked on mutex)
S           aio/1:  183 [ffff81007f687100, 111] (not blocked on mutex)
S         kseriod:  258 [ffff81007f682770, 110] (not blocked on mutex)
S       kpsmoused:  316 [ffff81007f564040, 111] (not blocked on mutex)
S           ata/0:  337 [ffff81007f64e7b0, 114] (not blocked on mutex)
S           ata/1:  338 [ffff81007f682040, 110] (not blocked on mutex)
S       scsi_eh_0:  344 [ffff81007f64e080, 114] (not blocked on mutex)
S       scsi_eh_1:  345 [ffff81007f60e7b0, 114] (not blocked on mutex)
S       scsi_eh_3:  382 [ffff81007f7247f0, 111] (not blocked on mutex)
S       scsi_wq_3:  385 [ffff81007f7dc870, 111] (not blocked on mutex)
S        kmirrord:  417 [ffff81007edc7870, 115] (not blocked on mutex)
S       kjournald:  431 [ffff81007ed8e7f0, 115] (not blocked on mutex)
S           udevd: 1358 [ffff81007edc8100, 111] (not blocked on mutex)
S         kauditd: 1935 [ffff81007e562140, 110] (not blocked on mutex)
S       kmpathd/0: 2043 [ffff81007e58d7b0, 112] (not blocked on mutex)
S       kmpathd/1: 2044 [ffff81007ead57f0, 112] (not blocked on mutex)
S       kjournald: 2104 [ffff81007e9de080, 119] (not blocked on mutex)
S        dhclient: 2716 [ffff81007a0d9040, 116] (not blocked on mutex)
R         syslogd: 2760 [ffff81007edc8830, 116] (not blocked on mutex)
S           klogd: 2764 [ffff81007ebd1080, 115] (not blocked on mutex)
S      irqbalance: 2775 [ffff81007e484040, 116] (not blocked on mutex)
S         portmap: 2787 [ffff81007eece0c0, 116] (not blocked on mutex)
S       rpc.statd: 2807 [ffff81007e4f0100, 122] (not blocked on mutex)
S      rpc.idmapd: 2846 [ffff81007ec83870, 116] (not blocked on mutex)
S           acpid: 2937 [ffff81007ec71100, 119] (not blocked on mutex)
S           cupsd: 2968 [ffff81007e58d080, 116] (not blocked on mutex)
S            sshd: 3073 [ffff81007edc7140, 117] (not blocked on mutex)
S          xinetd: 3094 [ffff81007ed1b7b0, 115] (not blocked on mutex)
S        sendmail: 3113 [ffff81007e5300c0, 116] (not blocked on mutex)
S        sendmail: 3121 [ffff81007e614870, 119] (not blocked on mutex)
S             gpm: 3170 [ffff81007f53c040, 115] (not blocked on mutex)
S             htt: 3229 [ffff81000337b0c0, 121] (not blocked on mutex)
S      htt_server: 3230 [ffff81007e310140, 117] (not blocked on mutex)
S     cannaserver: 3242 [ffff81007e739100, 116] (not blocked on mutex)
S           crond: 3254 [ffff81007e6997f0, 116] (not blocked on mutex)
S             xfs: 3295 [ffff81007e5247f0, 116] (not blocked on mutex)
S             atd: 3314 [ffff81007f60e080, 118] (not blocked on mutex)
S   dbus-daemon-1: 3333 [ffff810079e48040, 116] (not blocked on mutex)
S cups-config-dae: 3343 [ffff81007e549140, 119] (not blocked on mutex)
S           login: 3363 [ffff81007a26c7b0, 116] (not blocked on mutex)
S        mingetty: 3364 [ffff81007e549870, 118] (not blocked on mutex)
S        mingetty: 3365 [ffff81007e0eb770, 120] (not blocked on mutex)
S        mingetty: 3368 [ffff810079df1770, 121] (not blocked on mutex)
S        mingetty: 3369 [ffff810079c90100, 121] (not blocked on mutex)
S        mingetty: 3371 [ffff81007eece7f0, 118] (not blocked on mutex)
S        mingetty: 3581 [ffff81007ead3100, 122] (not blocked on mutex)
S      gdm-binary: 3584 [ffff8100721bb830, 115] (not blocked on mutex)
?      gdm-binary: 3845 [ffff81007ede3040, 117] (not blocked on mutex)
S               X: 3846 [ffff81007232c830, 115] (not blocked on mutex)
S      gdmgreeter: 3966 [ffff810079894870, 115] (not blocked on mutex)
R            bash: 3967 [ffff81000337b7f0, 116] (not blocked on mutex)
S       scsi_eh_4: 4224 [ffff81007f5407b0, 112] (not blocked on mutex)
S   qla2xxx_4_dpc: 4253 [ffff81006fbf9830, 100] (not blocked on mutex)
D       scsi_wq_4: 4255 [ffff81006f9147b0, 110] (not blocked on mutex)
S       scsi_eh_5: 4264 [ffff81007e739830, 111] (not blocked on mutex)
S   qla2xxx_5_dpc: 4408 [ffff81007e5240c0, 100] (not blocked on mutex)
S       scsi_wq_5: 4410 [ffff81007e6990c0, 111] (not blocked on mutex)

---------------------------
| showing all locks held: |
---------------------------

#001:             [ffff81006ee20080] {scsi_host_alloc}
.. held by:         scsi_wq_4: 4255 [ffff81006f9147b0, 110]
... acquired at:               scsi_scan_target+0x51/0x87 [scsi_mod]

=============================================


