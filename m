Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbUKPAaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUKPAaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 19:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUKPAaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 19:30:22 -0500
Received: from CPE-203-51-35-114.nsw.bigpond.net.au ([203.51.35.114]:46322
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S261726AbUKPAaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 19:30:12 -0500
Message-ID: <419949EB.5000503@eyal.emu.id.au>
Date: Tue, 16 Nov 2004 11:29:31 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2 [dvb-bt8xx unload oops]
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, the -rc2 changes are almost as big as the -rc1 changes, and we should 
> now calm down, so I do not want to see anything but bug-fixes until 2.6.10 
> is released. Otherwise we'll never get there.
> 
> A lot of driver updates, many of them of the small and trivial kind,
> others less so. USB, ALSA, fbdev, IDE, i2c, v4l, you name it. With a

Did you say 'v4l'? The following crash is a result of unloading the dvb system using:
         modprobe -r mt352
         modprobe -r sp887x
         modprobe -r dvb-bt8xx
         modprobe -r bt878
         modprobe -r bttv
         modprobe -r dvb-core
I assume it is the third unload that triggered this oops.

This is vanilla 2.6.10-rc2 on P4. This was a problem with -rc1 but some patches off the list
[attached] fixed it. I expected these to be in -rc2, I am not able to say which patch is
missing.

Nov 16 11:13:00 eyal kernel: xxx detach
Nov 16 11:13:00 eyal kernel: xxx detach
Nov 16 11:13:00 eyal kernel: f899f3ea
Nov 16 11:13:00 eyal kernel: PREEMPT SMP
Nov 16 11:13:00 eyal kernel: Modules linked in: tsdev psmouse v4l1_compat dvb_bt8xx dvb_core i810_audio ac97_codec sr_mod sg ide_scsi ide_cd cdrom it87 eeprom i2c_isa i2c_i801 i2c_sensor eth1394 ohci1394 ieee1394 dc395x scsi_mod snd_bt87x bt878 bttv tuner video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc i2c_core videodev e1000 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore cfi_cmdset_0002 cfi_util mtdpart jedec_probe cfi_probe gen_probe ichxrom mtdcore chipreg ehci_hcd uhci_hcd usbcore shpchp pciehp pci_hotplug intel_mch_agp intel_agp agpgart parport_pc parport 8250_pnp 8250 serial_core evdev nls_cp437 msdos fat dm_mod rtc unix
Nov 16 11:13:00 eyal kernel: CPU:    0
Nov 16 11:13:00 eyal kernel: EIP:    0060:[pg0+945243114/1069364224]    Not tainted VLI
Nov 16 11:13:00 eyal kernel: EFLAGS: 00010282   (2.6.9-d)
Nov 16 11:13:00 eyal kernel: EIP is at dvb_bt8xx_remove+0x89/0xc3 [dvb_bt8xx]
Nov 16 11:13:00 eyal kernel: eax: 00000000   ebx: ce3eb438   ecx: f9d0edf8   edx: 00000000
Nov 16 11:13:00 eyal kernel: esi: ce3eb400   edi: 00000000   ebp: f899f4a0   esp: d6130ef8
Nov 16 11:13:00 eyal kernel: ds: 007b   es: 007b   ss: 0068
Nov 16 11:13:00 eyal kernel: Process modprobe (pid: 3959, threadinfo=d6130000 task=eff88330)
Nov 16 11:13:00 eyal kernel: Stack: ecb907c0 ce3eb68c f7c6d980 f89a0620 c022507e f7c6d980 f7c6d9a8 f7c6d590
Nov 16 11:13:00 eyal kernel:        f89a0670 c02250a0 f7c6d980 f89a0620 c03168c4 c02254b4 f89a0620 f89a0620
Nov 16 11:13:00 eyal kernel:        f89a0620 c03168c4 c0225980 f89a0620 f89a0700 f9b93858 f89a0620 f899f4af
Nov 16 11:13:00 eyal kernel: Call Trace:
Nov 16 11:13:00 eyal kernel:  [device_release_driver+100/102] device_release_driver+0x64/0x66
Nov 16 11:13:00 eyal kernel:  [driver_detach+32/46] driver_detach+0x20/0x2e
Nov 16 11:13:00 eyal kernel:  [bus_remove_driver+77/134] bus_remove_driver+0x4d/0x86
Nov 16 11:13:00 eyal kernel:  [driver_unregister+19/42] driver_unregister+0x13/0x2a
Nov 16 11:13:00 eyal kernel:  [pg0+964069464/1069364224] bttv_sub_unregister+0xf/0x15 [bttv]
Nov 16 11:13:00 eyal kernel:  [pg0+945243311/1069364224] dvb_bt8xx_exit+0xf/0x13 [dvb_bt8xx]
Nov 16 11:13:00 eyal kernel:  [sys_delete_module+343/396] sys_delete_module+0x157/0x18c
Nov 16 11:13:00 eyal kernel:  [sys_munmap+81/118] sys_munmap+0x51/0x76
Nov 16 11:13:00 eyal kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 16 11:13:00 eyal kernel: Code: 24 04 ff 56 78 8d 86 34 02 00 00 89 04 24 e8 f8 e2 35 01 89 1c 24 e8 32 00 36 01 8b 46 2c 89 04 24 e8 27 c3 35 01 8b 06 8b 56 04 <89> 50 04 89 02 c7 46 04 00 02 20 00 c7 06 00 01 10 00 89 34 24

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
