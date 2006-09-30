Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWI3SGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWI3SGG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 14:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWI3SGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 14:06:05 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6069 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751383AbWI3SGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 14:06:01 -0400
Subject: Re: 2.6.18-rt1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060920141907.GA30765@elte.hu>
References: <20060920141907.GA30765@elte.hu>
Content-Type: text/plain
Date: Sat, 30 Sep 2006 14:06:04 -0400
Message-Id: <1159639564.4067.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 16:19 +0200, Ingo Molnar wrote:
> I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded 
> from the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/

I got this Oops with -rt3, looks RCU related.  Apologies in advance if
it's already known.

Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
 [<ffffffff802aafa7>] __rcu_read_unlock+0x2e/0x82
PGD 46a3067 PUD 4e27067 PMD 0 
Oops: 0002 [1] PREEMPT SMP 
CPU 1 
Modules linked in: rfcomm hidp l2cap bluetooth nfsd exportfs lockd nfs_acl sunrpc powernow_k8 cpufreq_userspace cpufreq_stats freq_table cpufreq_powersave cpufreq_ondemand cpufreq_conservative video button battery container ac asus_acpi dm_mod md_mod sr_mod sbp2 lp psmouse serio_raw sg evdev floppy parport_pc parport pcspkr i2c_nforce2 i2c_core shpchp pci_hotplug ext3 jbd mbcache ohci_hcd ehci_hcd ohci1394 ieee1394 forcedeth ide_generic ide_cd cdrom sd_mod sata_nv libata scsi_mod generic amd74xx ide_core thermal processor fan
Pid: 21372, comm: fixdep Not tainted 2.6.18-rt3-smp-noipv6 #1
RIP: 0010:[<ffffffff802aafa7>]  [<ffffffff802aafa7>] __rcu_read_unlock+0x2e/0x82
RSP: 0018:ffff8100045dbbf0  EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff810015a63070 RCX: 0000000000000246
RDX: 0000000000000000 RSI: ffff8100188bf007 RDI: ffff810015a63078
RBP: ffff810015a63070 R08: 0000000000000000 R09: ffff81001212d6c0
R10: ffff81001b9c0d48 R11: ffffffff8022ae94 R12: ffff810015a63078
R13: ffff8100119da4b0 R14: ffff8100045dbca8 R15: 0000000071bf92cd
FS:  00002b7fb742d6d0(0000) GS:ffff81001b9178c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000194c3000 CR4: 00000000000006e0
Process fixdep (pid: 21372, threadinfo ffff8100045da000, task ffff81001622d800)
Stack:  ffffffff80208db8 0000000100000105 0000000700000001 ffff8100188bf000
 00000000000041ed ffff8100045dbea8 ffff8100119f5180 ffff810001232480
 ffff8100045dbea8 ffff8100045dbca8 ffffffff8020c353 ffff81001b9c0d00
Call Trace:
 [<ffffffff80208db8>] __d_lookup+0x10b/0x11d
 [<ffffffff8020c353>] do_lookup+0x2a/0x173
 [<ffffffff80209179>] __link_path_walk+0x3af/0xf5c
 [<ffffffff8020c537>] file_read_actor+0x0/0xce
 [<ffffffff80299575>] _atomic_dec_and_spin_lock+0x2b/0x33
 [<ffffffff8020dc2c>] link_path_walk+0x5c/0xe5
 [<ffffffff8029955e>] _atomic_dec_and_spin_lock+0x14/0x33
 [<ffffffff80213fe4>] get_unused_fd+0xf9/0x107
 [<ffffffff802117be>] filemap_nopage+0x1cb/0x39b
 [<ffffffff8020c201>] do_path_lookup+0x26c/0x290
 [<ffffffff8029a09b>] __rt_rwlock_init+0x9/0x12
 [<ffffffff80221a87>] __path_lookup_intent_open+0x56/0x97
 [<ffffffff8021909c>] open_namei+0x6d/0x6a4
 [<ffffffff8021ca81>] free_pgtables+0xe6/0x172
 [<ffffffff802bbada>] __cache_free+0x51/0x1f2
 [<ffffffff80225776>] do_filp_open+0x1c/0x3d
 [<ffffffff8029955e>] _atomic_dec_and_spin_lock+0x14/0x33
 [<ffffffff80213fe4>] get_unused_fd+0xf9/0x107
 [<ffffffff80217e96>] do_sys_open+0x44/0xc5
 [<ffffffff8025b1ce>] system_call+0x7e/0x83


Code: f0 ff 08 65 48 8b 04 25 00 00 00 00 48 c7 80 a8 00 00 00 00 
RIP  [<ffffffff802aafa7>] __rcu_read_unlock+0x2e/0x82
 RSP <ffff8100045dbbf0>
CR2: 0000000000000000
 


