Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbTGKT3z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbTGKT0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:26:49 -0400
Received: from mail-7.tiscali.it ([195.130.225.153]:42304 "EHLO
	mail-7.tiscali.it") by vger.kernel.org with ESMTP id S265145AbTGKTX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:23:58 -0400
Date: Fri, 11 Jul 2003 21:36:11 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: acpi-support@lists.sourceforge.net, pavel@suse.cz
Subject: [2.5.75] S3 and S4
Message-ID: <20030711193611.GA824@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mail-Followup-To: linux-kernel@vger.kernel.org,
	acpi-support@lists.sourceforge.net, pavel@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I've been playing with ACPI and software suspend.

I have an AthlonXP on a KT333 motherboard. Kernel UP with preemption.

S3 doesn't work with FB (well, I  can suspend the machine but the screen
isn't restored on resume. I can blindly  login and reboot) but I read on
fbdev that this is a WIP.  Without FB the system goes to sleep with some
warnings (we call local_bh_enable with interrupts disabled):

Stopping tasks: klogd entered refrigerator
=init entered refrigerator
=pdflush entered refrigerator
=pdflush entered refrigerator
=kswapd0 entered refrigerator
=kseriod entered refrigerator
=devfsd entered refrigerator
=xfs_syncd entered refrigerator
=xfs_syncd entered refrigerator
=acpid entered refrigerator
=syslogd entered refrigerator
=xinetd entered refrigerator
=named entered refrigerator
=named entered refrigerator
=named entered refrigerator
=named entered refrigerator
=named entered refrigerator
=rc.news entered refrigerator
=squid entered refrigerator
=squid entered refrigerator
=unlinkd entered refrigerator
=sshd entered refrigerator
=lpd entered refrigerator
=crond entered refrigerator
=atd entered refrigerator
=master entered refrigerator
=pickup entered refrigerator
=qmgr entered refrigerator
=gpm entered refrigerator
=portsentry entered refrigerator
=portsentry entered refrigerator
=tail entered refrigerator
=agetty entered refrigerator
=agetty entered refrigerator
=agetty entered refrigerator
=agetty entered refrigerator
=agetty entered refrigerator
=agetty entered refrigerator
=agetty entered refrigerator
=innwatch entered refrigerator
=sleep entered refrigerator
=|
Suspending devices
Suspending devices
hdd: start_power_step(step: 0)
hdd: completing PM request, suspend
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hdb: start_power_step(step: 0)
hdb: start_power_step(step: 1)
hdb: complete_power_step(step: 1, stat: 50, err: 0)
hdb: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
Suspending devices
Badness in local_bh_enable at kernel/softirq.c:113
Call Trace:
 [<c0130078>] local_bh_enable+0x88/0x90
 [<f0a44fa4>] e100_do_wol+0x14/0x60 [e100]
 [<f0a461ee>] e100_suspend+0x3e/0xa0 [e100]
 [<f0a461b0>] e100_suspend+0x0/0xa0 [e100]
 [<c0212577>] pci_device_suspend+0x47/0x70
 [<c029bc99>] device_suspend+0xd9/0x100
 [<c023e047>] acpi_system_save_state+0x42/0x8c
 [<c023e153>] acpi_suspend+0x5e/0xb3
 [<c023e394>] acpi_system_write_sleep+0xe3/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:113
Call Trace:
 [<c0130078>] local_bh_enable+0x88/0x90
 [<f0a46995>] e100_config+0x1b5/0x280 [e100]
 [<c0130078>] local_bh_enable+0x88/0x90
 [<f0a44fac>] e100_do_wol+0x1c/0x60 [e100]
 [<f0a461ee>] e100_suspend+0x3e/0xa0 [e100]
 [<f0a461b0>] e100_suspend+0x0/0xa0 [e100]
 [<c0212577>] pci_device_suspend+0x47/0x70
 [<c029bc99>] device_suspend+0xd9/0x100
 [<c023e047>] acpi_system_save_state+0x42/0x8c
 [<c023e153>] acpi_suspend+0x5e/0xb3
 [<c023e394>] acpi_system_write_sleep+0xe3/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:113
Call Trace:
 [<c0130078>] local_bh_enable+0x88/0x90
 [<f0a427fc>] e100_exec_non_cu_cmd+0x49c/0x790 [e100]
 [<c010be7e>] dump_stack+0x1e/0x20
 [<f0a469a4>] e100_config+0x1c4/0x280 [e100]
 [<c0130078>] local_bh_enable+0x88/0x90
 [<f0a44fac>] e100_do_wol+0x1c/0x60 [e100]
 [<f0a461ee>] e100_suspend+0x3e/0xa0 [e100]
 [<f0a461b0>] e100_suspend+0x0/0xa0 [e100]
 [<c0212577>] pci_device_suspend+0x47/0x70
 [<c029bc99>] device_suspend+0xd9/0x100
 [<c023e047>] acpi_system_save_state+0x42/0x8c
 [<c023e153>] acpi_suspend+0x5e/0xb3
 [<c023e394>] acpi_system_write_sleep+0xe3/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

 hwsleep-0257 [10] acpi_enter_sleep_state: Entering sleep state [S3]


And then the resume:
 
Enabling SEP on CPU 0
Back to C!
Devices Resumed
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue c0461a3c, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdb: Wakeup request inited, waiting for !BSY...
hdb: start_power_step(step: 1000)
blk: queue c0461dfc, I/O limit 4095Mb (mask 0xffffffff)
hdb: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
hdd: Wakeup request inited, waiting for !BSY...
hdd: start_power_step(step: 1000)
hdd: completing PM request, resume
Devices Resumed
Restarting tasks... done
init left refrigerator
pdflush left refrigerator
pdflush left refrigerator
kswapd0 left refrigerator
kseriod left refrigerator
devfsd left refrigerator
xfs_syncd left refrigerator
xfs_syncd left refrigerator
acpid left refrigerator
syslogd left refrigerator
klogd left refrigerator
xinetd left refrigerator
named left refrigerator
named left refrigerator
named left refrigerator
named left refrigerator
named left refrigerator
rc.news left refrigerator
squid left refrigerator
squid left refrigerator
unlinkd left refrigerator
sshd left refrigerator
lpd left refrigerator
crond left refrigerator
atd left refrigerator
master left refrigerator
pickup left refrigerator
qmgr left refrigerator
gpm left refrigerator
portsentry left refrigerator
portsentry left refrigerator
tail left refrigerator
agetty left refrigerator
agetty left refrigerator
agetty left refrigerator
agetty left refrigerator
agetty left refrigerator
agetty left refrigerator
agetty left refrigerator
innwatch left refrigerator
sleep left refrigerator
e100: eth0 NIC Link is Up 10 Mbps Half duplex
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 0: d46ee00000007fee
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: f713eeedb75ae7fd
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 2: f60000000000feff
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 3: fc0000000000ffef

I'm a bit  worried about these MCEs, but the  machine seems stable after
resume (btw,  I remeber that Alan  once posted a MCE  decoder, but can't
find it - any clue?).

S4  suspends fine,  but  it seems  that it  doesn't  like preemption  on
resume:

......[lots of dots]......[nosave c041c000]Enabling SEP on CPU 0
Freeing prev allocated pagedir
bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c02ded7b>] pci_read+0x3b/0x40
 [<c01358e8>] schedule_timeout+0x88/0xe0
 [<c02dedbc>] pci_write+0x3c/0x40
 [<c0135850>] process_timeout+0x0/0x10
 [<c020f9e4>] pci_set_power_state+0xe4/0x190
 [<f0a46278>] e100_resume+0x28/0x70 [e100]
 [<c02125cd>] pci_device_resume+0x2d/0x30
 [<c029bd76>] device_resume+0xb6/0xd0
 [<c014e60c>] drivers_resume+0x8c/0xa0
 [<c014ea15>] do_magic_resume_2+0xc5/0x170
 [<c011d410>] restore_processor_state+0x70/0x90
 [<c011ff5f>] do_magic+0x11f/0x140
 [<c014ef1d>] do_software_suspend+0x6d/0xa0
 [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c015522e>] __alloc_pages+0x8e/0x330
 [<c01262fd>] sys_sched_yield+0x13d/0x210
 [<f0a42801>] e100_exec_non_cu_cmd+0x4a1/0x790 [e100]
 [<f0a41ce0>] e100_setup_iaaddr+0x50/0x80 [e100]
 [<f0a43088>] e100_configure_device+0xa8/0x100 [e100]
 [<f0a431bc>] e100_deisolate_driver+0xdc/0x100 [e100]
 [<f0a462b2>] e100_resume+0x62/0x70 [e100]
 [<c02125cd>] pci_device_resume+0x2d/0x30
 [<c029bd76>] device_resume+0xb6/0xd0
 [<c014e60c>] drivers_resume+0x8c/0xa0
 [<c014ea15>] do_magic_resume_2+0xc5/0x170
 [<c011d410>] restore_processor_state+0x70/0x90
 [<c011ff5f>] do_magic+0x11f/0x140
 [<c014ef1d>] do_software_suspend+0x6d/0xa0
 [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c015522e>] __alloc_pages+0x8e/0x330
 [<c01262fd>] sys_sched_yield+0x13d/0x210
 [<f0a42801>] e100_exec_non_cu_cmd+0x4a1/0x790 [e100]
 [<f0a3fff2>] e100_set_multi_exec+0x92/0xc0 [e100]
 [<f0a430aa>] e100_configure_device+0xca/0x100 [e100]
 [<f0a431bc>] e100_deisolate_driver+0xdc/0x100 [e100]
 [<f0a462b2>] e100_resume+0x62/0x70 [e100]
 [<c02125cd>] pci_device_resume+0x2d/0x30
 [<c029bd76>] device_resume+0xb6/0xd0
 [<c014e60c>] drivers_resume+0x8c/0xa0
 [<c014ea15>] do_magic_resume_2+0xc5/0x170
 [<c011d410>] restore_processor_state+0x70/0x90
 [<c011ff5f>] do_magic+0x11f/0x140
 [<c014ef1d>] do_software_suspend+0x6d/0xa0
 [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c010bd42>] show_trace+0x42/0x90
 [<c015522e>] __alloc_pages+0x8e/0x330
 [<c01262fd>] sys_sched_yield+0x13d/0x210
 [<f0a42801>] e100_exec_non_cu_cmd+0x4a1/0x790 [e100]
 [<f0a469a4>] e100_config+0x1c4/0x280 [e100]
 [<f0a46739>] e100_force_config+0x109/0x1b0 [e100]
 [<f0a430cf>] e100_configure_device+0xef/0x100 [e100]
 [<f0a431bc>] e100_deisolate_driver+0xdc/0x100 [e100]
 [<f0a462b2>] e100_resume+0x62/0x70 [e100]
 [<c02125cd>] pci_device_resume+0x2d/0x30
 [<c029bd76>] device_resume+0xb6/0xd0
 [<c014e60c>] drivers_resume+0x8c/0xa0
 [<c014ea15>] do_magic_resume_2+0xc5/0x170
 [<c011d410>] restore_processor_state+0x70/0x90
 [<c011ff5f>] do_magic+0x11f/0x140
 [<c014ef1d>] do_software_suspend+0x6d/0xa0
 [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue c0461a3c, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdb: Wakeup request inited, waiting for !BSY...
hdb: start_power_step(step: 1000)
blk: queue c0461dfc, I/O limit 4095Mb (mask 0xffffffff)
hdb: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
hdd: Wakeup request inited, waiting for !BSY...
hdd: start_power_step(step: 1000)
hdd: completing PM request, resume
Devices Resumed
Devices Resumed
bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c015522e>] __alloc_pages+0x8e/0x330
 [<c01262fd>] sys_sched_yield+0x13d/0x210
 [<f0a42801>] e100_exec_non_cu_cmd+0x4a1/0x790 [e100]
 [<f0a41ce0>] e100_setup_iaaddr+0x50/0x80 [e100]
 [<f0a43088>] e100_configure_device+0xa8/0x100 [e100]
 [<f0a431bc>] e100_deisolate_driver+0xdc/0x100 [e100]
 [<f0a462b2>] e100_resume+0x62/0x70 [e100]
 [<c0214206>] pci_pm_resume_device+0x26/0x30
 [<c021433b>] pci_pm_resume_bus+0x2b/0x70
 [<c0214451>] pci_pm_resume+0x31/0x40
 [<c021449d>] pci_pm_callback+0x3d/0x60
 [<c014d119>] pm_send+0x69/0x90
 [<c014d216>] pm_send_all+0x86/0xc0
 [<c014e5b6>] drivers_resume+0x36/0xa0
 [<c014ea15>] do_magic_resume_2+0xc5/0x170
 [<c011d410>] restore_processor_state+0x70/0x90
 [<c011ff5f>] do_magic+0x11f/0x140
 [<c014ef1d>] do_software_suspend+0x6d/0xa0
 [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c015522e>] __alloc_pages+0x8e/0x330
 [<c01262fd>] sys_sched_yield+0x13d/0x210
 [<f0a42801>] e100_exec_non_cu_cmd+0x4a1/0x790 [e100]
 [<f0a3fff2>] e100_set_multi_exec+0x92/0xc0 [e100]
 [<f0a430aa>] e100_configure_device+0xca/0x100 [e100]
 [<f0a431bc>] e100_deisolate_driver+0xdc/0x100 [e100]
 [<f0a462b2>] e100_resume+0x62/0x70 [e100]
 [<c0214206>] pci_pm_resume_device+0x26/0x30
 [<c021433b>] pci_pm_resume_bus+0x2b/0x70
 [<c0214451>] pci_pm_resume+0x31/0x40
 [<c021449d>] pci_pm_callback+0x3d/0x60
 [<c014d119>] pm_send+0x69/0x90
 [<c014d216>] pm_send_all+0x86/0xc0
 [<c014e5b6>] drivers_resume+0x36/0xa0
 [<c014ea15>] do_magic_resume_2+0xc5/0x170
 [<c011d410>] restore_processor_state+0x70/0x90
 [<c011ff5f>] do_magic+0x11f/0x140
 [<c014ef1d>] do_software_suspend+0x6d/0xa0
 [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c010bd42>] show_trace+0x42/0x90
 [<c015522e>] __alloc_pages+0x8e/0x330
 [<c01262fd>] sys_sched_yield+0x13d/0x210
 [<f0a42801>] e100_exec_non_cu_cmd+0x4a1/0x790 [e100]
 [<f0a469a4>] e100_config+0x1c4/0x280 [e100]
 [<f0a46739>] e100_force_config+0x109/0x1b0 [e100]
 [<f0a430cf>] e100_configure_device+0xef/0x100 [e100]
 [<f0a431bc>] e100_deisolate_driver+0xdc/0x100 [e100]
 [<f0a462b2>] e100_resume+0x62/0x70 [e100]
 [<c0214206>] pci_pm_resume_device+0x26/0x30
 [<c021433b>] pci_pm_resume_bus+0x2b/0x70
 [<c0214451>] pci_pm_resume+0x31/0x40
 [<c021449d>] pci_pm_callback+0x3d/0x60
 [<c014d119>] pm_send+0x69/0x90
 [<c014d216>] pm_send_all+0x86/0xc0
 [<c014e5b6>] drivers_resume+0x36/0xa0
 [<c014ea15>] do_magic_resume_2+0xc5/0x170
 [<c011d410>] restore_processor_state+0x70/0x90
 [<c011ff5f>] do_magic+0x11f/0x140
 [<c014ef1d>] do_software_suspend+0x6d/0xa0
 [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

Fixing swap signatures... <3>bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c02a219d>] generic_make_request+0x17d/0x210
 [<c01272d0>] autoremove_wake_function+0x0/0x50
 [<c012641e>] io_schedule+0xe/0x20
 [<c0150522>] wait_on_page_bit+0xa2/0xd0
 [<c01272d0>] autoremove_wake_function+0x0/0x50
 [<c01272d0>] autoremove_wake_function+0x0/0x50
 [<c017194b>] swap_readpage+0x5b/0x80
 [<c0171a2a>] rw_swap_page_sync+0xba/0x110
 [<c014d8be>] mark_swapfiles+0x7e/0x1b0
 [<c014ea35>] do_magic_resume_2+0xe5/0x170
 [<c011d410>] restore_processor_state+0x70/0x90
 [<c011ff5f>] do_magic+0x11f/0x140
 [<c014ef1d>] do_software_suspend+0x6d/0xa0
 [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c012641e>] io_schedule+0xe/0x20
 [<c0150522>] wait_on_page_bit+0xa2/0xd0
 [<c01272d0>] autoremove_wake_function+0x0/0x50
 [<c01272d0>] autoremove_wake_function+0x0/0x50
 [<c0171780>] end_swap_bio_write+0x0/0x50
 [<c0171a2a>] rw_swap_page_sync+0xba/0x110
 [<c014d931>] mark_swapfiles+0xf1/0x1b0
 [<c014ea35>] do_magic_resume_2+0xe5/0x170
 [<c011d410>] restore_processor_state+0x70/0x90
 [<c011ff5f>] do_magic+0x11f/0x140
 [<c014ef1d>] do_software_suspend+0x6d/0xa0
 [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
 [<c0177de0>] filp_open+0x60/0x70
 [<c017952d>] vfs_write+0xad/0x120
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

ok
Restarting processes...
Restarting tasks... done
bad: scheduling while atomic!
Call Trace:
 [<c012419e>] schedule+0x6ce/0x6e0
 [<c017963f>] sys_write+0x3f/0x60
 [<c010b136>] work_resched+0x5/0x16

init left refrigerator
pdflush left refrigerator
kswapd0 left refrigerator
xfs_syncd left refrigerator
agetty left refrigerator
agetty left refrigerator
agetty left refrigerator
agetty left refrigerator
agetty left refrigerator
agetty left refrigerator
agetty left refrigerator
Unable to handle kernel paging request at virtual address 40107114
 printing eip:
40107114
*pde = 2dbf6067
*pte = 00000000
Oops: 0004 [#1]
CPU:    0
EIP:    0073:[<40107114>]    Not tainted
EFLAGS: 00010202
EIP is at 0x40107114
eax: ffffffea   ebx: 00000001   ecx: 080d440c   edx: 00000002
esi: 00000002   edi: 080d440c   ebp: bffffae8   esp: bffffab8
ds: 007b   es: 007b   ss: 007b
Process bash (pid: 484, threadinfo=ed776000 task=ef1e40c0)
 <6>note: bash[484] exited with preempt_count 1
pdflush left refrigerator
e100: eth0 NIC Link is Up 10 Mbps Half duplex


ksymoops says:

Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; 40107114 Before first symbol   <=====

>>eax; ffffffea <__kernel_rt_sigreturn+1baa/????>



This is my dmesg:

Linux version 2.5.75 (root@dreamland) (gcc version 3.2.3) #40 Fri Jul 11 16:37:24 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
 BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
767MB LOWMEM available.
On node 0 totalpages: 196592
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192496 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 VIA694                     ) @ 0x000f75b0
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x2fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x2fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=linux-2.5.75 ro root=305 BOOT_FILE=/bzImage-2.5.75 video=radeonfb:640x480-8@60
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1470.676 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2891.77 BogoMIPS
Memory: 774064k/786368k available (2441k kernel code, 11536k reserved, 840k data, 164k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1700+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1469.0806 MHz.
..... host bus clock speed is 267.0237 MHz.
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030619
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...................................................................................................................
Table [DSDT](id F004) - 464 Objects with 38 Devices 115 Methods 31 Regions
ACPI Namespace successfully loaded at root c04728bc
spurious 8259A interrupt: IRQ7.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 0000000000004020 on int 9
Completing Region/Field/Buffer/Package initialization:.............................................................................
Initialized 31/31 Regions 13/13 Fields 20/20 Buffers 13/13 Packages (472 nodes)
Executing all Device _STA and_INI methods:.......................................
39 Devices found containing: 39 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.96 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf40, dseg 0xf0000
pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: match found with the PnP device '00:08' and the driver 'system'
pnp: match found with the PnP device '00:0b' and the driver 'system'
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=12, xclk=27000 defaults
radeonfb: probed SDR SGRAM 131072k videoram
radeon_get_moninfo: bios 4 scratch = 2000002
radeonfb: ATI Radeon 9700 NE SDR SGRAM 128 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
hStart = 664, hEnd = 760, hTotal = 800
vStart = 491, vEnd = 493, vTotal = 525
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c02a2
v_total_disp = 0x1df020c	   vsync_strt_wid = 0x8201ea
post div = 0x8
fb_div = 0x59
ppll_div_3 = 0x30059
ron = 784, roff = 19320
vclk_freq = 2503, per = 690
Console: switching to colour frame buffer device 80x30
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
Enabling SEP on CPU 0
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (56 C)
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro KT266/KT333 chipset
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: AGP aperture is 128M @ 0xd0000000
[drm] Initialized radeon 1.8.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:0c' and the driver 'serial'
pnp: match found with the PnP device '00:10' and the driver 'serial'
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:0f' and the driver 'parport_pc'
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y120L0, ATA DISK drive
hdb: QUANTUM FIREBALLlct10 10, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CRD-8520B, ATAPI CD/DVD-ROM drive
hdd: WAITEC ALADAR/1, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63, UDMA(133)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
hdb: max request size: 128KiB
hdb: host protected area => 1
hdb: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=19885/16/63
 /dev/ide/host0/bus0/target1/lun0: p1 p2
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(33)
Console: switching to colour frame buffer device 80x30
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 37449)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
ACPI: (supports S0 S3 S4 S5)
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 164k freed
Adding 265064k swap on /dev/hdb2.  Priority:9 extents:1
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda7) for (hda7)
Using r5 hash to sort names
SGI XFS for Linux 2.5.75 with no debug enabled
XFS mounting filesystem hda6
Ending clean XFS mount for filesystem: hda6
XFS mounting filesystem hda8
Ending clean XFS mount for filesystem: hda8
NTFS driver 2.1.4 [Flags: R/O DEBUG MODULE].
NTFS volume version 3.1.
FAT: Unrecognized mount option mode
Real Time Clock Driver v1.11
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
Intel(R) PRO/100 Network Driver - version 2.3.13-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection

CBQ: class 00010001 has bad quantum==0, repaired.
e100: eth0 NIC Link is Up 10 Mbps Half duplex
PCI: Setting latency timer of device 0000:00:11.5 to 64
registering 0-0290


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Do, or do not. There is no try.
