Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWIPK0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWIPK0E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 06:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWIPK0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 06:26:03 -0400
Received: from fmmailgate09.web.de ([217.72.192.184]:34250 "EHLO
	fmmailgate09.web.de") by vger.kernel.org with ESMTP
	id S1751376AbWIPK0B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 06:26:01 -0400
Reveived: from web.de 
	by fmmailgate09.web.de (Postfix) with SMTP id 747471C15E0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2006 12:26:00 +0200 (CEST)
Date: Sat, 16 Sep 2006 12:25:58 +0200
Message-Id: <1312458165@web.de>
MIME-Version: 1.0
From: devzero@web.de
To: linux-kernel@vger.kernel.org
Subject: show all modules which taint the kernel ?
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

i wonder if there is a command which lets me determine at runtime, if there is any module loaded which taints the kernel. (not from dmesg)

i would have expected a special option to lsmod which shows this information with every module.

ok, there is modinfo which will tell me "supported : yes" for single modules , but output is somewhat inconsistent and i would need to write a little script which combines lsmod and modinfo to show appropriate information.

e.g. - this is a module delivered with the kernel package:

vserver2:/proc # modinfo ac
filename:       /lib/modules/2.6.8-24.24-default/kernel/drivers/acpi/ac.ko
author:         Paul Diefenbaugh
description:    ACPI AC Adapter Driver
license:        GPL
vermagic:       2.6.8-24.24-default 586 REGPARM gcc-3.3
supported:      yes  <- (!)
depends:


this is a module  compiled and installed afterwards:

vserver2:/proc # modinfo fuse
filename:       /lib/modules/2.6.8-24.24-default/kernel/fs/fuse/fuse.ko
alias:          char-major-10-229
author:         Miklos Szeredi <miklos@szeredi.hu>
description:    Filesystem in Userspace
license:        GPL
vermagic:       2.6.8-24.24-default 586 REGPARM gcc-3.3
depends:

i would have expected "supported:   no" or "attention, this module taints the kernel!", because when loading it gave:

"Sep 15 20:02:46 vserver2 kernel: fuse: module not supported by Novell, setting U taint flag."

how can i read that information "U taint"  AFTER loading a (binary...) module ?

i think it would be useful to have an easy way to list all modules which taint the kernel, so we can see quick, which crappy binary module is running inside a user`s kernel.

furthermore -  i came across a strange posting on the vmware forum:

a user complains about a kernel panic and there is a discussion if it`s due to bug in vmware kernel module or aacraid driver.

whoever is the evil one -  the kernel panic message shows every module with an "(U)" flag:

List corruption. next->prev should be f7481858, but was f748313c
------------[ cut here ]------------
kernel BUG at include/linux/list.h:185!
invalid opcode: 0000 [#1]
SMP
last sysfs file: /class/scsi_host/host0/proc_name
Modules linked in: radeon(U) drm(U) ipv6(U) autofs4(U) ppdev(U) lm85(U) w83781d
(U) hwmon_vid(U) hwmon(U) i2c_isa(U) vmnet(U) vmmon(U) sunrpc(U) vfat(U) fat
(U) dm_mirror(U) dm_mod(U) video(U) button(U) battery(U) ac(U) lp(U) parport_pc
(U) parport(U) snd_intel8x0(U) snd_ac97_codec(U) snd_ac97_bus(U) ftdi_sio(U)
snd_seq_dummy(U) usbserial(U) snd_seq_oss(U) snd_seq_midi_event(U) snd_seq(U)
snd_seq_device(U) snd_pcm_oss(U) snd_mixer_oss(U) 3c59x(U) snd_pcm(U) e1000(U)
mii(U) ohci1394(U) ieee1394(U) snd_timer(U) sg(U) snd(U) uhci_hcd(U) ehci_hcd
(U) i2c_i801(U) serio_raw(U) soundcore(U) e7xxx_edac(U) snd_page_alloc(U)
floppy(U) i2c_core(U) edac_mc(U) ext3(U) jbd(U) aacraid(U) sd_mod(U) scsi_mod
(U)
CPU: 1
EIP: 0060:[<f88704ce>] Tainted: P VLI
EFLAGS: 00013096 (2.6.17-vmhost #1)
EIP is at aac_intr_normal+0x1cc/0x267 [aacraid] 

i wonder how someone can have so many tainted modules loaded at the same time, so i`m unsure if (U) means "tainted" in this context.

can someone probably explain ?

regards
roland

__________________________________________________________________________
Erweitern Sie FreeMail zu einem noch leistungsstärkeren E-Mail-Postfach!		
Mehr Infos unter http://freemail.web.de/home/landingpad/?mc=021131

