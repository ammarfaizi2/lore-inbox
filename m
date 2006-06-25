Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWFYSxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWFYSxY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 14:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWFYSxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 14:53:24 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:14058 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932145AbWFYSxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 14:53:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZvAe8XnzO13Qx11OeF4uL35vSoe9hEGD08sgAsmH3F3C+9S32SiOjpseGCsM5mcqHOKMfp02LrYX85K9l6ksBScN6pBOem5L6key/ucxshinSUJO2nYf85aVDHeZ6l4TH90iyPd729hQyPRkYIxAqf/100x42mPWSKnl9GG3ZSE=
Message-ID: <a44ae5cd0606251153j1220f8f5rd5fc6ab85027e3d0@mail.gmail.com>
Date: Sun, 25 Jun 2006 11:53:22 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm2 -- Slab corruption, plus invalid opcode: 0000 [#1] -- 4K_STACKS PREEMPT -- last sysfs file: /block/md0/dev
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060624212940.ea8976ae.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0606241628u18fc9530g9dfbbfca441309fc@mail.gmail.com>
	 <20060624212940.ea8976ae.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> Do you have CONFIG_HOTPLUG_CPU=y?

I rebuilt with all the PCI hotplug stuff enabled.
dmesg output suggests I don't have this hardware:

pci_hotplug: PCI Hot Plug PCI Core version: 0.5
fakephp: Fake PCI Hot Plug Controller Driver
cpqphp: Compaq Hot Plug PCI Controller Driver version: 0.9.8
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
acpiphp_ibm: ibm_find_acpi_device:  Failed to get device
information<3>acpiphp_ibm: ibm_find_acpi_device:  Failed to get device
information<3>acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace
failed
cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
cpcihp_generic: not configured, disabling.
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4

I still get:

BUG: unable to handle kernel paging request at virtual address 9e82ee96
 printing eip:
c13d029f
*pde = 00000000
Oops: 0002 [#1]
4K_STACKS PREEMPT
last sysfs file: /block/md0/dev
Modules linked in: speedstep_centrino cpufreq_stats freq_table
cpufreq_powersave cpufreq_performance cpufreq_conservative video
thermal sony_acpi processor fan container button battery asus_acpi ac
vfat fat nls_utf8 ntfs dm_mod sr_mod sbp2 parport_pc lp parport
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss
snd_pcm snd_timer ipw2200 snd soundcore rtc ata_piix libata 8139cp
8139too mii ieee80211 ieee80211_crypt snd_page_alloc sdhci mmc_core
ohci1394 ieee1394 scsi_mod pcspkr ehci_hcd uhci_hcd joydev
CPU:    0
EIP:    0060:[<c13d029f>]    Not tainted VLI
EFLAGS: 00010203   (2.6.17-mm2 #4)
EIP is at cpufreq_register_driver+0x16/0x129
eax: f8acefe0   ebx: c1f9edbc   ecx: f76bd000   edx: 00000000
esi: f8acf380   edi: f8acf380   ebp: f76bded4   esp: f76bded0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2589, ti=f76bd000 task=f7bd4370 task.ti=f76bd000)
Stack: f8a97053 f76bdfb4 c1030e07 00000016 00000370 c1231564 c1231564 00000530
       00000000 00000003 f8acf380 f8c1a308 f8c1a1f0 f8c1a2e0 f7790b94 f8c1ae48
       00000017 00000015 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace:
 <c10036b9> show_stack_log_lvl+0x8b/0x96  <c1003807> show_registers+0x143/0x1af
 <c1003cb9> die+0x176/0x251  <c1010f7e> do_page_fault+0x3c2/0x4b4
 <c1002ec9> error_code+0x39/0x40  <c1030e07> sys_init_module+0x1425/0x1586
 <c1002c91> sysenter_past_esp+0x56/0x79
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00>
a5 c2 0f 17 a7 47 0e c1 a5 c2 0f 17 02 00 00 00 01 00 00 00
EIP: [<c13d029f>] cpufreq_register_driver+0x16/0x129 SS:ESP 0068:f76bded0
 acpi_processor-0758 [97] processor_preregister_: Error while parsing
_PSD domain information. Assuming no coordination
BUG: unable to handle kernel paging request at virtual address 9e7c2e96
 printing eip:
c13d029f
*pde = 00000000
Oops: 0002 [#2]
4K_STACKS PREEMPT
last sysfs file: /block/md0/dev
Modules linked in: acpi_cpufreq speedstep_centrino cpufreq_stats
freq_table cpufreq_powersave cpufreq_performance cpufreq_conservative
video thermal sony_acpi processor fan container button battery
asus_acpi ac vfat fat nls_utf8 ntfs dm_mod sr_mod sbp2 parport_pc lp
parport snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer ipw2200 snd soundcore rtc ata_piix
libata 8139cp 8139too mii ieee80211 ieee80211_crypt snd_page_alloc
sdhci mmc_core ohci1394 ieee1394 scsi_mod pcspkr ehci_hcd uhci_hcd
joydev
CPU:    0
EIP:    0060:[<c13d029f>]    Not tainted VLI
EFLAGS: 00010203   (2.6.17-mm2 #4)
EIP is at cpufreq_register_driver+0x16/0x129
eax: f8c1dd60   ebx: c1f9e9b0   ecx: f7651000   edx: 00000000
esi: f8c1de00   edi: f8c1de00   ebp: f7651ed4   esp: f7651ed0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2591, ti=f7651000 task=c1ed9930 task.ti=f7651000)
Stack: f8c2006f f7651fb4 c1030e07 00000017 00000398 c1231564 c1231564 00000500
       00000001 00000002 f8c1de00 f8c19e34 f8c19d1c f8c19e0c f75ef404 f8c1a7a4
       00000018 00000016 00000008 00000000 00000000 00000000 00000000 00000000
Call Trace:
 <c10036b9> show_stack_log_lvl+0x8b/0x96  <c1003807> show_registers+0x143/0x1af
 <c1003cb9> die+0x176/0x251  <c1010f7e> do_page_fault+0x3c2/0x4b4
 <c1002ec9> error_code+0x39/0x40  <c1030e07> sys_init_module+0x1425/0x1586
 <c1002c91> sysenter_past_esp+0x56/0x79
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00>
a5 c2 0f 17 a7 47 0e c1 a5 c2 0f 17 02 00 00 00 01 00 00 00
EIP: [<c13d029f>] cpufreq_register_driver+0x16/0x129 SS:ESP 0068:f7651ed0
