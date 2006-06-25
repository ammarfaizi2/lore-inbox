Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWFYTAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWFYTAf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWFYTAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:00:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51870 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932439AbWFYTAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:00:30 -0400
Date: Sun, 25 Jun 2006 12:00:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: 2.6.17-mm2 -- Slab corruption, plus invalid opcode: 0000 [#1]
 -- 4K_STACKS PREEMPT -- last sysfs file: /block/md0/dev
Message-Id: <20060625120026.513a6076.akpm@osdl.org>
In-Reply-To: <a44ae5cd0606251153j1220f8f5rd5fc6ab85027e3d0@mail.gmail.com>
References: <a44ae5cd0606241628u18fc9530g9dfbbfca441309fc@mail.gmail.com>
	<20060624212940.ea8976ae.akpm@osdl.org>
	<a44ae5cd0606251153j1220f8f5rd5fc6ab85027e3d0@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 11:53:22 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

> Hi Andrew,
> 
> > Do you have CONFIG_HOTPLUG_CPU=y?
> 
> I rebuilt with all the PCI hotplug stuff enabled.
> dmesg output suggests I don't have this hardware:
> 
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> fakephp: Fake PCI Hot Plug Controller Driver
> cpqphp: Compaq Hot Plug PCI Controller Driver version: 0.9.8
> acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> acpiphp_ibm: ibm_find_acpi_device:  Failed to get device
> information<3>acpiphp_ibm: ibm_find_acpi_device:  Failed to get device
> information<3>acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace
> failed
> cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
> cpcihp_generic: not configured, disabling.
> shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> 
> I still get:
> 
> BUG: unable to handle kernel paging request at virtual address 9e82ee96
>  printing eip:
> c13d029f
> *pde = 00000000
> Oops: 0002 [#1]
> 4K_STACKS PREEMPT
> last sysfs file: /block/md0/dev
> Modules linked in: speedstep_centrino cpufreq_stats freq_table
> cpufreq_powersave cpufreq_performance cpufreq_conservative video
> thermal sony_acpi processor fan container button battery asus_acpi ac
> vfat fat nls_utf8 ntfs dm_mod sr_mod sbp2 parport_pc lp parport
> snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss
> snd_pcm snd_timer ipw2200 snd soundcore rtc ata_piix libata 8139cp
> 8139too mii ieee80211 ieee80211_crypt snd_page_alloc sdhci mmc_core
> ohci1394 ieee1394 scsi_mod pcspkr ehci_hcd uhci_hcd joydev
> CPU:    0
> EIP:    0060:[<c13d029f>]    Not tainted VLI
> EFLAGS: 00010203   (2.6.17-mm2 #4)
> EIP is at cpufreq_register_driver+0x16/0x129

Do you have
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/hot-fixes/cpufreq_register_driver-section-fix.patch
applied?
