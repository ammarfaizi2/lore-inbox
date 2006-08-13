Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWHMWos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWHMWos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 18:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWHMWor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 18:44:47 -0400
Received: from us.cactii.net ([66.160.141.151]:20241 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S1751700AbWHMWor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 18:44:47 -0400
Date: Mon, 14 Aug 2006 00:44:13 +0200
From: Ben Buxton <kernel@bb.cactii.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: 2.6.18-rc4-mm1
Message-ID: <20060813224413.GA21959@cactii.net>
References: <20060813012454.f1d52189.akpm@osdl.org> <44DF10DF.5070307@gmail.com> <20060813121126.b1dc22ee.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813121126.b1dc22ee.akpm@osdl.org>
X-PGP-Key: 3CD061AD
X-PGP-Fingerprint: E092 32CA 6196 7C11 0692  BE43 AEDA 4D47 3CD0 61AD
Jabber-ID: bb@cactii.net
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> uttered the following thing:
> On Sun, 13 Aug 2006 13:45:35 +0200
> Maciej Rutecki <maciej.rutecki@gmail.com> wrote:
> 
> > Andrew Morton napisa??(a):
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> > 
> > I have problem with my keyboard. I have no error in dmesg and syslog,
> > but it doesn't work. I read google and try "i8042.nomux", but it didn't
> > help.
> > 
> > I enclose dmesg with "i8042.debug=1" option and my config.
> > 
> > Maybe I forgot something in config?
> > 
> 
> 
> Could be i8042-get-rid-of-polling-timer-v4.patch.  Please try the below
> reversion patch, on top of rc4-mm1, thanks.

Acking the same issue. Applied the revert patch and my keyboard now
works. Also, it turns out that my keyboard is now the only thing that
failed to resume from S3 on my HP Nc6400, but adding "irqpoll" has fixed
that for now.

Also, to two other things I spotted with cpufreq. Running
speedstep-centrino on a Core Duo T2400 (1.83GHz) I see the
"cpuinfo_max_freq" is 1833000, but "scaling_max_freq" is fixed at 1333000,
regardless of the governor, and I cannot change it.

Also, whenever I echo anything to "scaling_governor", I get the
following kernel message:

[  734.156000] BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
[  734.156000]  [<c013c3ec>] lock_cpu_hotplug+0x7c/0x90
[  734.156000]  [<c01327f4>] __create_workqueue+0x44/0x140
[  734.156000]  [<c02dcf7b>] mutex_lock+0xb/0x20
[  734.156000]  [<e01f2665>] cpufreq_governor_dbs+0x2b5/0x310
[cpufreq_ondemand]
[  734.156000]  [<c012f6a5>] notifier_call_chain+0x25/0x40
[  734.156000]  [<c0274b06>] __cpufreq_governor+0x46/0xe0
[  734.156000]  [<c0274c84>] __cpufreq_set_policy+0xe4/0x130
[  734.156000]  [<c0275ae4>] store_scaling_governor+0xd4/0x210
[  734.160000]  [<c02756a0>] handle_update+0x0/0x10
[  734.160000]  [<c01e2000>] kobject_get+0x0/0x20
[  734.160000]  [<c0275a10>] store_scaling_governor+0x0/0x210
[  734.160000]  [<c027521d>] store+0x3d/0x60
[  734.160000]  [<c01a2e0c>] sysfs_write_file+0x9c/0xf0
[  734.160000]  [<c016a8c6>] vfs_write+0xa6/0x160
[  734.160000]  [<c01a2d70>] sysfs_write_file+0x0/0xf0
[  734.160000]  [<c016b001>] sys_write+0x41/0x70
[  734.160000]  [<c0103115>] sysenter_past_esp+0x56/0x79

It seems that scaling still works, but this message is a bit unnerving.

BB

