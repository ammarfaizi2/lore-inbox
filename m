Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262818AbUKTBso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbUKTBso (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbUKTBsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:48:40 -0500
Received: from CPE-203-51-35-114.nsw.bigpond.net.au ([203.51.35.114]:5620 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S262838AbUKTBr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:47:28 -0500
Message-ID: <419EA1DD.2000004@eyal.emu.id.au>
Date: Sat, 20 Nov 2004 12:46:05 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Hunold <hunold@linuxtv.org>
CC: Gerd Knorr <kraxel@bytesex.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Hunold <hunold@convergence.de>
Subject: Re: Fw: Re: Linux 2.6.10-rc2 [dvb-bt8xx unload oops]
References: <20041116014350.54500549.akpm@osdl.org> <20041118130312.GE19568@bytesex> <419CD8BC.1080401@linuxtv.org>
In-Reply-To: <419CD8BC.1080401@linuxtv.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold wrote:
> Hi,
> 
> On 18.11.2004 14:03, Gerd Knorr wrote:
> 
>>> This is vanilla 2.6.10-rc2 on P4. This was a problem with -rc1 but
> 
> 
>> Yes, looks very simliar ...
> 
> 
>>> some patches off the list [attached] fixed it. I expected these to be
>>> in -rc2, I am not able to say which patch is missing.
> 
> 
>> Uhm, strange.  The bttv patches _are_ merged.
>> Not sure about any for dvb-bt8xx, Michael?
> 
> 
> Hm, I'm not sure either, because Eyal says that the problem does not 
> exist with rc2-mm1. But AFAIK all DVB stuff has been merged by Linus so 
> I'm clueless here... 8-(

I now managed to get the problem with rc2-mm1/2. They reaction is different
(I do not get a lockup) but the oops shows up. Here is one from rc2-mm2. The
system was still usable at this point.

I now think that the original problem I reported is not the same as this one
which happens with all kernels I tried.

Also, does anyone know how to switch to text console when X locks up (as
it does for me)? sysrq works but does not allow me to switch to another
console. Since the hard lock does not log the oops, and I cannot see the
text from sysrq, I cannot report the details.

Nov 19 23:37:44 eyal kernel: f90625f6
Nov 19 23:37:44 eyal kernel: PREEMPT SMP
Nov 19 23:37:44 eyal kernel: Modules linked in: tsdev psmouse mt352 sp887x v4l1_compat dvb_bt8xx dvb_core i810_audio ac97_codec sr_mod sg ide_scsi ide_cd cdrom it87 eeprom i2c_isa i2c_i801 i2c_sensor eth1394 ohci_hcd ohci1394 ieee1394 dc395x scsi_mod bt878 bttv tuner video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev e1000 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc soundcore i2c_core cfi_cmdset_0002 cfi_util mtdpart jedec_probe cfi_probe gen_probe ichxrom mtdcore chipreg map_funcs ehci_hcd uhci_hcd usbcore shpchp pci_hotplug intel_mch_agp intel_agp agpgart parport_pc parport 8250_pnp 8250 serial_core evdev nls_cp437 msdos fat dm_mod rtc unix
Nov 19 23:37:44 eyal kernel: CPU:    0
Nov 19 23:37:44 eyal kernel: EIP:    0060:[pg0+952432118/1069462528]    Not tainted VLI
Nov 19 23:37:44 eyal kernel: EFLAGS: 00210092   (2.6.10-rc2-mm2)
Nov 19 23:37:44 eyal kernel: EIP is at buffer_queue+0x33/0x6f [bttv]
Nov 19 23:37:44 eyal kernel: eax: d6573384   ebx: 00000000   ecx: e7507c80   edx: e7507ce4
Nov 19 23:37:44 eyal kernel: esi: d6572ecc   edi: e7507c80   ebp: f907ffa0   esp: d5980c58
Nov 19 23:37:44 eyal kernel: ds: 007b   es: 007b   ss: 0068
Nov 19 23:37:44 eyal kernel: Process mythbackend (pid: 5981, threadinfo=d5980000 task=eae58020)
Nov 19 23:37:44 eyal kernel: Stack: 00200246 f908035c f9063ca1 d6572e00 e7507c80 f906deb4 00000300 00000240
Nov 19 23:37:44 eyal kernel:        00000004 d6572e00 e7507c80 c01230a8 c011248c 00000000 c010e5b9 0000bae2
Nov 19 23:37:44 eyal kernel:        000dd3d6 00000005 c0103ad8 0000bae2 9347d376 00000361 000dd3d6 00000005
Nov 19 23:37:44 eyal kernel: Call Trace:
Nov 19 23:37:44 eyal kernel:  [pg0+952437921/1069462528] bttv_do_ioctl+0x4b4/0x17e4 [bttv]
Nov 19 23:37:44 eyal kernel:  [irq_exit+58/60] irq_exit+0x3a/0x3c
Nov 19 23:37:44 eyal kernel:  [smp_apic_timer_interrupt+105/222] smp_apic_timer_interrupt+0x69/0xde
Nov 19 23:37:44 eyal kernel:  [delay_pmtmr+13/21] delay_pmtmr+0xd/0x15
Nov 19 23:37:44 eyal kernel:  [apic_timer_interrupt+28/36] apic_timer_interrupt+0x1c/0x24
Nov 19 23:37:44 eyal kernel:  [exit_notify+551/2193] exit_notify+0x227/0x891
Nov 19 23:37:44 eyal kernel:  [delay_pmtmr+13/21] delay_pmtmr+0xd/0x15
Nov 19 23:37:44 eyal kernel:  [avc_alloc_node+28/358] avc_alloc_node+0x1c/0x166
Nov 19 23:37:44 eyal kernel:  [avc_latest_notif_update+62/124] avc_latest_notif_update+0x3e/0x7c
Nov 19 23:37:44 eyal kernel:  [avc_node_replace+48/57] avc_node_replace+0x30/0x39
Nov 19 23:37:44 eyal kernel:  [avc_insert+250/294] avc_insert+0xfa/0x126
Nov 19 23:37:44 eyal kernel:  [avc_has_perm_noaudit+121/338] avc_has_perm_noaudit+0x79/0x152
Nov 19 23:37:44 eyal kernel:  [avc_alloc_node+28/358] avc_alloc_node+0x1c/0x166
Nov 19 23:37:44 eyal kernel:  [avc_node_replace+48/57] avc_node_replace+0x30/0x39
Nov 19 23:37:44 eyal kernel:  [avc_has_perm+110/132] avc_has_perm+0x6e/0x84
Nov 19 23:37:44 eyal kernel:  [inode_has_perm+85/131] inode_has_perm+0x55/0x83
Nov 19 23:37:44 eyal kernel:  [avc_has_perm+110/132] avc_has_perm+0x6e/0x84
Nov 19 23:37:44 eyal kernel:  [selinux_file_ioctl+238/811] selinux_file_ioctl+0xee/0x32b
Nov 19 23:37:44 eyal kernel:  [inode_has_perm+85/131] inode_has_perm+0x55/0x83
Nov 19 23:37:44 eyal kernel:  [do_no_page+428/689] do_no_page+0x1ac/0x2b1
Nov 19 23:37:44 eyal kernel:  [copy_from_user+66/110] copy_from_user+0x42/0x6e
Nov 19 23:37:44 eyal kernel:  [pg0+946086937/1069462528] video_usercopy+0x7b/0x135 [videodev]
Nov 19 23:37:44 eyal kernel:  [do_mmap_pgoff+1119/1925] do_mmap_pgoff+0x45f/0x785
Nov 19 23:37:44 eyal kernel:  [pg0+952442898/1069462528] bttv_ioctl+0x41/0x64 [bttv]
Nov 19 23:37:44 eyal kernel:  [pg0+952436717/1069462528] bttv_do_ioctl+0x0/0x17e4 [bttv]
Nov 19 23:37:44 eyal kernel:  [sys_ioctl+217/539] sys_ioctl+0xd9/0x21b
Nov 19 23:37:44 eyal kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 19 23:37:44 eyal kernel: Code: 24 04 8b 44 24 0c 8b 80 d0 00 00 00 8b 4c 24 10 8b 30 8d 51 64 c7 41 20 02 00 00 00 8d 86 b8 04 00 00 8b 58 04 89 41 64 89 50 04 <89> 13 89 5a 04 8b 8e d4 04 00 00 85 c9 74 0b 8b 1c 24 8b 74 24
Nov 19 23:37:44 eyal kernel:  <6>note: mythbackend[5981] exited with preempt_count 2


And later I get

Nov 20 00:26:24 eyal kernel: 0240009a
Nov 20 00:26:24 eyal kernel: PREEMPT SMP
Nov 20 00:26:24 eyal kernel: Modules linked in: tsdev psmouse mt352 sp887x v4l1_compat dvb_bt8xx dvb_core i810_audio ac97_codec sr_mod sg ide_scsi ide_cd cdrom it87 eeprom i2c_isa i2c_i801 i2c_sensor eth1394 ohci_hcd ohci1394 ieee1394 dc395x scsi_mod bt878 bttv tuner video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev e1000 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc soundcore i2c_core cfi_cmdset_0002 cfi_util mtdpart jedec_probe cfi_probe gen_probe ichxrom mtdcore chipreg map_funcs ehci_hcd uhci_hcd usbcore shpchp pci_hotplug intel_mch_agp intel_agp agpgart parport_pc parport 8250_pnp 8250 serial_core evdev nls_cp437 msdos fat dm_mod rtc unix
Nov 20 00:26:24 eyal kernel: CPU:    0
Nov 20 00:26:24 eyal kernel: EIP:    0060:[phys_startup_32+36700314/-1073741824]    Not tainted VLI
Nov 20 00:26:24 eyal kernel: EFLAGS: 00010206   (2.6.10-rc2-mm2)
Nov 20 00:26:24 eyal kernel: EIP is at 0x240009a
Nov 20 00:26:24 eyal kernel: eax: e7507cf4   ebx: e7507ce4   ecx: 0240009a   edx: 0000007b
Nov 20 00:26:24 eyal kernel: esi: 00000000   edi: d6f8a380   ebp: e7507ce4   esp: d72e2f8c
Nov 20 00:26:24 eyal kernel: ds: 007b   es: 007b   ss: 0068
Nov 20 00:26:24 eyal kernel: Process mythbackend (pid: 16038, threadinfo=d72e2000 task=d6d42550)
Nov 20 00:26:24 eyal kernel: Stack: c0159c3d e7507ce4 00000008 d6f8a380 000000e2 d6f8a384 c0159cbf e7507ce4
Nov 20 00:26:24 eyal kernel:        d6f8a380 000000e2 000000e3 000003ff d72e2000 c01030db 000000e2 ffffffe0
Nov 20 00:26:24 eyal kernel:        b6bb2fcc 000000e3 000003ff bffffcf8 00000006 0000007b 0000007b 00000006
Nov 20 00:26:24 eyal kernel: Call Trace:
Nov 20 00:26:24 eyal kernel:  [filp_close+113/134] filp_close+0x71/0x86
Nov 20 00:26:24 eyal kernel:  [sys_close+109/143] sys_close+0x6d/0x8f
Nov 20 00:26:24 eyal kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 20 00:26:24 eyal kernel: Code:  Bad EIP value.

Nov 20 00:26:31 eyal kernel:  <1>Unable to handle kernel paging request at virtual address 0240009a
Nov 20 00:26:31 eyal kernel: 0240009a
Nov 20 00:26:31 eyal kernel: PREEMPT SMP
Nov 20 00:26:31 eyal kernel: Modules linked in: tsdev psmouse mt352 sp887x v4l1_compat dvb_bt8xx dvb_core i810_audio ac97_codec sr_mod sg ide_scsi ide_cd cdrom it87 eeprom i2c_isa i2c_i801 i2c_sensor eth1394 ohci_hcd ohci1394 ieee1394 dc395x scsi_mod bt878 bttv tuner video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev e1000 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc soundcore i2c_core cfi_cmdset_0002 cfi_util mtdpart jedec_probe cfi_probe gen_probe ichxrom mtdcore chipreg map_funcs ehci_hcd uhci_hcd usbcore shpchp pci_hotplug intel_mch_agp intel_agp agpgart parport_pc parport 8250_pnp 8250 serial_core evdev nls_cp437 msdos fat dm_mod rtc unix
Nov 20 00:26:31 eyal kernel: CPU:    0
Nov 20 00:26:31 eyal kernel: EIP:    0060:[phys_startup_32+36700314/-1073741824]    Not tainted VLI
Nov 20 00:26:31 eyal kernel: EFLAGS: 00010206   (2.6.10-rc2-mm2)
Nov 20 00:26:31 eyal kernel: EIP is at 0x240009a
Nov 20 00:26:31 eyal kernel: eax: e7507cf4   ebx: e7507ce4   ecx: 0240009a   edx: 0000007b
Nov 20 00:26:31 eyal kernel: esi: 00000000   edi: d6f8a580   ebp: e7507ce4   esp: d72e2f8c
Nov 20 00:26:31 eyal kernel: ds: 007b   es: 007b   ss: 0068
Nov 20 00:26:31 eyal kernel: Process mythbackend (pid: 16050, threadinfo=d72e2000 task=d6d42550)
Nov 20 00:26:31 eyal kernel: Stack: c0159c3d e7507ce4 00000008 d6f8a580 000000e2 d6f8a584 c0159cbf e7507ce4
Nov 20 00:26:31 eyal kernel:        d6f8a580 000000e2 000000e3 000003ff d72e2000 c01030db 000000e2 ffffffe0
Nov 20 00:26:31 eyal kernel:        b6bb2fcc 000000e3 000003ff bffffcf8 00000006 0000007b 0000007b 00000006
Nov 20 00:26:31 eyal kernel: Call Trace:
Nov 20 00:26:31 eyal kernel:  [filp_close+113/134] filp_close+0x71/0x86
Nov 20 00:26:31 eyal kernel:  [sys_close+109/143] sys_close+0x6d/0x8f
Nov 20 00:26:31 eyal kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 20 00:26:31 eyal kernel: Code:  Bad EIP value.


-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
