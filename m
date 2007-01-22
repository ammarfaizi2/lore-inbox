Return-Path: <linux-kernel-owner+w=401wt.eu-S1751895AbXAVDHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbXAVDHr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 22:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbXAVDHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 22:07:47 -0500
Received: from theorix.CeNTIE.NET.au ([202.9.6.84]:52137 "HELO
	theorix.centie.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751895AbXAVDHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 22:07:46 -0500
X-Greylist: delayed 1952 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 22:07:35 EST
Message-ID: <45B422D3.9040409@usherbrooke.ca>
Date: Mon, 22 Jan 2007 13:34:59 +1100
From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
User-Agent: Thunderbird 1.5.0.9 (X11/20070104)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Suspend to RAM generates oops and general protection fault
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just encountered the following oops and general protection fault
trying to suspend/resume my laptop. I've got a Dell D820 laptop with a 2
GHz Core 2 Duo CPU. It usually suspends/resumes fine but not always. The
relevant errors are below but the full dmesg log is at
http://people.xiph.org/~jm/suspend_resume_oops.txt and my config is in
http://people.xiph.org/~jm/config-2.6.20-rc5.txt

This happens when I'm running 2.6.20-rc5. The previous kernel version I
was using is 2.6.19-rc6 and was much more broken (second attempt
*always* failed), so it's probably not a regression.

Cheers,

	Jean-Marc

P.S. This is the same laptop I had at LCA for which Linus told me to
disable preemption and try the newest rc version.

[10746.449071] Unable to handle kernel NULL pointer dereference at
0000000000000038 RIP:
[10746.449080]  [<ffffffff8022b9c8>] iput+0x18/0x80
[10746.449092] PGD 3a607067 PUD 27b20067 PMD 0
[10746.449099] Oops: 0000 [1] SMP
[10746.449104] CPU 0
[10746.449107] Modules linked in: psmouse battery ac thermal fan button
ipw3945 ieee80211 tg3 arc4 ecb blkcipher ieee80211_crypt_wep
ieee80211_crypt binfmt_misc rfcomm l2cap bluetooth i915 drm
speedstep_centrino cpufreq_userspace cpufreq_powersave cpufreq_ondemand
cpufreq_stats freq_table cpufreq_conservative video sbs i2c_ec dock
asus_acpi backlight container ipv6 fuse sbp2 af_packet parport_pc lp
parport sg sr_mod cdrom snd_hda_intel snd_hda_codec tsdev snd_pcm_oss
snd_mixer_oss pcmcia snd_pcm snd_timer ata_generic snd shpchp
pci_hotplug soundcore snd_page_alloc serio_raw yenta_socket
rsrc_nonstatic pcmcia_core pcspkr evdev ext3 jbd mbcache ohci1394
ehci_hcd ieee1394 ide_generic uhci_hcd usbcore generic sd_mod processor
[10746.449190] Pid: 218, comm: kswapd0 Not tainted 2.6.20-rc5-x86-64 #1
[10746.449196] RIP: 0010:[<ffffffff8022b9c8>]  [<ffffffff8022b9c8>]
iput+0x18/0x80
[10746.449206] RSP: 0000:ffff810037f2dd50  EFLAGS: 00010283
[10746.449212] RAX: 0000000000000000 RBX: ffff81000003fcf0 RCX:
ffff81000003fd20
[10746.449219] RDX: 0000000000000001 RSI: 0000000000000286 RDI:
ffff81000003fcf0
[10746.449225] RBP: 0000000000000042 R08: 0000000000000000 R09:
0000000000000000
[10746.449232] R10: 28f5c28f5c28f5c3 R11: ffffffff8023ae90 R12:
0000000000000000
[10746.449239] R13: ffff810075721c70 R14: ffffffff805fa940 R15:
0000000000000000
[10746.449246] FS:  0000000000000000(0000) GS:ffffffff8058e000(0000)
knlGS:0000000000000000
[10746.449253] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[10746.449259] CR2: 0000000000000038 CR3: 000000001207f000 CR4:
00000000000006e0
[10746.449265] Process kswapd0 (pid: 218, threadinfo ffff810037f2c000,
task ffff810037a1b760)
[10746.449269] Stack:  ffff8100001ce2f0 ffffffff802ddaf8
ffff8100001ce3c0 ffff8100001ce2f0
[10746.449280]  0000000000000042 ffffffff8022f645 ffff810037f2dd80
000000000001cb60
[10746.449288]  0000000000000090 ffff81007daa0e00 00000000000000d0
ffffffff802ddb49
[10746.449296] Call Trace:
[10746.449305]  [<ffffffff802ddaf8>] prune_one_dentry+0x68/0xa0
[10746.449314]  [<ffffffff8022f645>] prune_dcache+0x145/0x1e0
[10746.449323]  [<ffffffff802ddb49>] shrink_dcache_memory+0x19/0x50
[10746.449331]  [<ffffffff802418a7>] shrink_slab+0x117/0x190
[10746.449342]  [<ffffffff8025a392>] kswapd+0x382/0x4e0
[10746.449356]  [<ffffffff802a13b0>] autoremove_wake_function+0x0/0x30
[10746.449370]  [<ffffffff8025a010>] kswapd+0x0/0x4e0
[10746.449376]  [<ffffffff802a11d0>] keventd_create_kthread+0x0/0x90
[10746.449383]  [<ffffffff802335a9>] kthread+0xd9/0x120
[10746.449394]  [<ffffffff80260ec8>] child_rip+0xa/0x12
[10746.449401]  [<ffffffff802a11d0>] keventd_create_kthread+0x0/0x90
[10746.449414]  [<ffffffff802334d0>] kthread+0x0/0x120
[10746.449421]  [<ffffffff80260ebe>] child_rip+0x0/0x12
[10746.449426]
[10746.449429]
[10746.449430] Code: 48 8b 40 38 75 04 0f 0b eb fe 48 85 c0 74 0b 48 8b
40 28 48
[10746.449449] RIP  [<ffffffff8022b9c8>] iput+0x18/0x80
[10746.449456]  RSP <ffff810037f2dd50>
[10746.449460] CR2: 0000000000000038
[10746.449463]  ACPI Exception (pci_bind-0299): AE_NOT_FOUND, Unable to
get data from device DCKS [20060707]


and later:


[    3.668009] SMP alternatives: switching to SMP code
[    3.668168] Booting processor 1/2 APIC 0x1
[    4.149691] Initializing CPU#1
[    4.229595] Calibrating delay using timer specific routine.. 3990.32
BogoMIPS (lpj=7980654)
[    4.229602] CPU: L1 I cache: 32K, L1 D cache: 32K
[    4.229604] CPU: L2 cache: 4096K
[    4.229606] CPU 1/1 -> Node 0
[    4.229608] CPU: Physical Processor ID: 0
[    4.229609] CPU: Processor Core ID: 1
[    4.230107] Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz stepping 06
[    4.233607] CPU 1: Syncing TSC to CPU 0.
[    3.762970] CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles,
maxerr 960 cycles)
[    3.764689] general protection fault: 0000 [2] SMP
[    3.764963] CPU 1
[    3.764983] Modules linked in: psmouse battery ac thermal fan button
arc4 ecb blkcipher ieee80211_crypt_wep ieee80211_crypt binfmt_misc
rfcomm l2cap bluetooth i915 drm speedstep_centrino cpufreq_userspace
cpufreq_powersave cpufreq_ondemand cpufreq_stats freq_table
cpufreq_conservative video sbs i2c_ec dock asus_acpi backlight container
ipv6 fuse sbp2 af_packet parport_pc lp parport sg sr_mod cdrom
snd_hda_intel snd_hda_codec tsdev snd_pcm_oss snd_mixer_oss pcmcia
snd_pcm snd_timer ata_generic snd shpchp pci_hotplug soundcore
snd_page_alloc serio_raw yenta_socket rsrc_nonstatic pcmcia_core pcspkr
evdev ext3 jbd mbcache ohci1394 ehci_hcd ieee1394 ide_generic uhci_hcd
usbcore generic sd_mod processor
[    3.765304] Pid: 7824, comm: sleep.sh Not tainted 2.6.20-rc5-x86-64 #1
[    3.765330] RIP: 0010:[<ffffffff80289c45>]  [<ffffffff80289c45>]
task_rq_lock+0x35/0x90
[    3.765379] RSP: 0018:ffff81001d291d28  EFLAGS: 00010086
[    3.765403] RAX: 6e696c7761726320 RBX: ffffffff805f88a0 RCX:
0000000000000000
[    3.765431] RDX: 0000000000000000 RSI: ffff81001d291db0 RDI:
ffff810037a1b760
[    3.765460] RBP: ffff81001d291d48 R08: 0000000000000000 R09:
0000000000000000
[    3.765488] R10: 0000000000000001 R11: 0000000000000000 R12:
ffffffff805f88a0
[    3.765516] R13: ffff810037a1b760 R14: ffff81001d291db0 R15:
ffff81000a9e3e80
[    3.765546] FS:  00002b1bcd567ae0(0000) GS:ffff810037ad1cc0(0000)
knlGS:0000000000000000
[    3.765589] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    3.765615] CR2: 0000000000000000 CR3: 000000001d4d0000 CR4:
00000000000006a0
[    3.765645] Process sleep.sh (pid: 7824, threadinfo ffff81001d290000,
task ffff8100661cf080)
[    3.765689] Stack:  ffff810037a1b760 0000000000000002
0000000000000003 0000000000000003
[    3.765739]  ffff81001d291dd8 ffffffff8028c454 0000000000000001
0000000000000003
[    3.765786]  0000000000000000 0000000000000002 ffffffff8058e4c0
0000000000000003
[    3.765822] Call Trace:
[    3.765861]  [<ffffffff8028c454>] set_cpus_allowed+0x24/0xc0
[    3.765890]  [<ffffffff8033cf3b>] kobject_register+0x3b/0x50
[    3.765919]  [<ffffffff80292850>] cpu_callback+0x50/0x70
[    3.765949]  [<ffffffff80269406>] notifier_call_chain+0x26/0x40
[    3.765980]  [<ffffffff802a704c>] _cpu_up+0xbc/0xf0
[    3.766005]  [<ffffffff802a70b2>] cpu_up+0x32/0x60
[    3.766030]  [<ffffffff802a712b>] enable_nonboot_cpus+0x4b/0xa0
[    3.766057]  [<ffffffff802aba8b>] enter_state+0x15b/0x1b0
[    3.766083]  [<ffffffff802abb5b>] state_store+0x7b/0xb0
[    3.766112]  [<ffffffff80306c09>] sysfs_write_file+0xd9/0x120
[    3.766143]  [<ffffffff8021653e>] vfs_write+0xde/0x1a0
[    3.766169]  [<ffffffff80217073>] sys_write+0x53/0x90
[    3.766197]  [<ffffffff8026011e>] system_call+0x7e/0x83
[    3.766228]
[    3.766247]
[    3.766248] Code: 8b 40 18 48 8b 04 c5 80 f2 59 80 48 03 58 08 48 89
df e8 54
[    3.766331] RIP  [<ffffffff80289c45>] task_rq_lock+0x35/0x90
[    3.766359]  RSP <ffff81001d291d28>
[    3.766650]  <6>ata1.00: configured for UDMA/133
