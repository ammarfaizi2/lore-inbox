Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031007AbWKPRRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031007AbWKPRRb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 12:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031113AbWKPRRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 12:17:31 -0500
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:49641 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1031007AbWKPRRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 12:17:30 -0500
Date: Thu, 16 Nov 2006 18:17:15 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org, stefanr@s5r6.in-berlin.de
Subject: Re: 2.6.19-rc5-mm2
Message-ID: <20061116171715.GA3645@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	bcollins@debian.org, stefanr@s5r6.in-berlin.de
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.19-rc5-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

got the following when removing ohci1394 (also happens in -mm1), config
and full dmesg are here:
http://oioio.altervista.org/linux/config-2.6.19-rc5-mm2-1
http://oioio.altervista.org/linux/config-2.6.19-rc5-mm1-4
http://oioio.altervista.org/linux/oops_rmmod_ohci-2.6.19-rc5-mm2
http://oioio.altervista.org/linux/oops_rmmod_ohci-2.6.19-rc5-mm1

ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[080046030227e7bb]
ieee1394: Node removed: ID:BUS[20754571-38:0391]  GUID[00000000f8eb5067]
BUG: unable to handle kernel NULL pointer dereference at virtual address 000000a4
 printing eip:
c0238c60
*pde = 00000000
Oops: 0000 [#1]
SMP 
last sysfs file: /devices/pci0000:00/0000:00:1c.1/0000:06:00.0/cmd
Modules linked in: ipv6 cpufreq_ondemand acpi_cpufreq freq_table thermal fan button processor ac battery ipt_MASQUERADE iptable_nat ip_nat xt_tcpudp xt_state ip_conntrack nfnetlink iptable_filter ip_tables x_tables dm_snapshot dm_mirror dm_mod sonypi sony_acpi backlight loop hci_usb bluetooth eth1394 usb_storage pcmcia snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss ipw3945 snd_pcm ieee80211 ieee80211_crypt i2c_i801 intel_agp ohci1394 ide_cd firmware_class yenta_socket rsrc_nonstatic pcmcia_core sky2 tifm_7xx1 tifm_core agpgart rtc uhci_hcd psmouse tpm_infineon tpm tpm_bios ieee1394 snd_timer evdev usbcore pcspkr cdrom snd soundcore snd_page_alloc
CPU:    0
EIP:    0060:[<c0238c60>]    Not tainted VLI
EFLAGS: 00010246   (2.6.19-rc5-mm2-1 #9)
EIP is at class_device_remove_attrs+0xd/0x34
eax: f7f7938c   ebx: 00000000   ecx: c012013a   edx: 00000000
esi: 00000000   edi: f7f7938c   ebp: f71a7df4   esp: f71a7de8
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 2398, ti=f71a6000 task=c1974030 task.ti=f71a6000)
Stack: f7f7938c f7f79394 00000000 f71a7e10 c0238d47 00000000 f7f791f4 f7f7938c 
       f7f79230 00000000 f71a7e1c c0238d82 f7f791f4 f71a7e44 f8d49ea9 f8d4f495 
       013cb08b 00000026 00000187 f8eb5067 00000000 00000000 f8d49ebe f71a7e4c 
Call Trace:
 [<c0238d47>] class_device_del+0xc0/0xf0
 [<c0238d82>] class_device_unregister+0xb/0x15
 [<f8d49ea9>] nodemgr_remove_ne+0x64/0x79 [ieee1394]
 [<f8d49ec9>] __nodemgr_remove_host_dev+0xb/0xf [ieee1394]
 [<c02366dc>] device_for_each_child+0x1d/0x46
 [<f8d49f9a>] nodemgr_remove_host+0x33/0x90 [ieee1394]
 [<f8d47500>] __unregister_host+0x1b/0x9b [ieee1394]
 [<f8d47716>] highlevel_remove_host+0x24/0x47 [ieee1394]
 [<f8d4715e>] hpsb_remove_host+0x3b/0x5d [ieee1394]
 [<f8dca212>] ohci1394_pci_remove+0x47/0x1c7 [ohci1394]
 [<c01dd619>] pci_device_remove+0x19/0x39
 [<c02383f7>] __device_release_driver+0x71/0x86
 [<c023885f>] driver_detach+0x83/0xc4
 [<c023802b>] bus_remove_driver+0x5a/0x76
 [<c02388c7>] driver_unregister+0xb/0x18
 [<c01dd787>] pci_unregister_driver+0xf/0x5b
 [<f8dcd2de>] ohci1394_cleanup+0xd/0xf [ohci1394]
 [<c013b193>] sys_delete_module+0x18c/0x1b5
 [<c0102d66>] sysenter_past_esp+0x5f/0x85
DWARF2 unwinder stuck at sysenter_past_esp+0x5f/0x85
Leftover inexact backtrace:
 =======================
Code: c0 08 e8 fb f2 f5 ff 89 c1 5d 89 c8 c3 55 85 c0 89 e5 74 08 83 c0 08 e8 6b d9 f5 ff 5d c3 55 89 e5 57 89 c7 56 53 31 db 8b 70 48 <83> be a4 00 00 00 00 75 09 eb 17 89 f8 e8 d0 ff ff ff 89 da 83 
EIP: [<c0238c60>] class_device_remove_attrs+0xd/0x34 SS:ESP 0068:f71a7de8


-- 
mattia
:wq!
