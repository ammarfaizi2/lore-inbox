Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWGMUp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWGMUp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWGMUp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:45:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57777 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030375AbWGMUp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:45:27 -0400
Date: Thu, 13 Jul 2006 16:45:20 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: BUG() in exit.c triggers in -git5
Message-ID: <20060713204520.GB3482@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw this yesterday too, but was running a slightly older kernel.
It's got the usual Fedora patches in there too, but I can't think
of anything that would cause this off the top of my head.
(Due to those patches the line number is skewed, it's
actually pointing at..

          tsk->flags |= PF_DEAD;
    
          schedule();
this->    BUG();
          /* Avoid "noreturn function does return".  */
          for (;;) ;

at line 954 in Linus' tree.

		Dave

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at kernel/exit.c:876
invalid opcode: 0000 [1] SMP 
last sysfs file: /block/sda/sda1/size
CPU 2 
Modules linked in: autofs4 hidp l2cap bluetooth nfs lockd nfs_acl sunrpc acpi_cpufreq vfat fat video sbs i2c_ec button battery asus_acpi ac radeon drm ipv6 parport_pc lp parport snd_intel8x0 snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec floppy usb_storage snd_ac97_bus sg snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm emu10k1_gp snd_seq_device ide_cd e752x_edac snd_timer e1000 gameport edac_mc i2c_i801 snd_page_alloc pcspkr i2c_core cdrom snd_util_mem uhci_hcd snd_hwdep ehci_hcd snd soundcore dm_snapshot dm_zero dm_mirror dm_mod ata_piix libata sd_mod scsi_mod ext3 jbd
Pid: 8155, comm: formail Not tainted 2.6.17-1.2384.fc6 #1
RIP: 0010:[<ffffffff802168fd>]  [<ffffffff802168fd>] do_exit+0x906/0x912
RSP: 0018:ffff81000f265ef8  EFLAGS: 00010246
RAX: 0000000000000080 RBX: 0000000000000010 RCX: 0000000000000000
RDX: ffffffff80269b52 RSI: 0000000000000000 RDI: ffff81000f271040
RBP: ffff81000f265f38 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: ffff810002627418 R12: ffff81000f271040
R13: ffff810037ffda60 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff81003fe3b560(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaaac7000 CR3: 0000000000201000 CR4: 00000000000006e0
Process formail (pid: 8155, threadinfo ffff81000f264000, task ffff81000f271040)
Stack:  ffff81003fe1e040 ffff81000f271178 0000000000000000 00002aaaab28b878
 0000000000000000 00007fffcb88c420 0000000000000000 0000000000000000
 ffff81000f265f68 ffffffff8024c2ed 0000000000000000 00002aaaab28b878
Call Trace:
 [<ffffffff8024c2ed>] debug_mutex_init+0x0/0x43

Code: 0f 0b 68 4c fb 49 80 c2 6c 03 eb fe 55 ba 40 00 00 00 89 f0 
RIP  [<ffffffff802168fd>] do_exit+0x906/0x912
 RSP <ffff81000f265ef8>
 <1>Fixing recursive fault but reboot is needed!


-- 
http://www.codemonkey.org.uk
