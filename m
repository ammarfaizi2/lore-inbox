Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVADW7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVADW7E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVADW6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:58:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:15308 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262067AbVADW44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:56:56 -0500
Message-ID: <41DB1C92.7060501@osdl.org>
Date: Tue, 04 Jan 2005 14:45:38 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Konrad Wojas <wojas@vvtp.tudelft.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 oops in poll()?
References: <20050103161556.GD31250@vvtp.tudelft.nl>
In-Reply-To: <20050103161556.GD31250@vvtp.tudelft.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Wojas wrote:
> My stock debian kernel (2.6.9-1-686) crashed this morning while running
> bittornado (btlaunchmanycurses). At that moment only one torrent was
> being downloaded. It looks to me like the problem is somewhere in poll()
> in combination with threading.
> 
> I haven't tested it using 2.6.10 as I don't even know if I can reproduce
> this using 2.6.9. If I do, I'll let you know.
> 
> I've included the raw oops and the output of ksymoops below. I'm not 
> subscribed to lkml.

I don't see the Oops primary error/reason/fault message.
Can you dig it up?

And it looks like you need to use
   ksymoops -k /proc/kallsyms
to get the addresses converted to symbols.
Can you redo ksymoops like that, please?


> ===================== RAW ======================
> 
> Jan  3 07:07:26 wojas kernel: c02b5513
> Jan  3 07:07:26 wojas kernel: PREEMPT 
> Jan 3 07:07:26 wojas kernel: Modules linked in: sch_ingress cls_u32
> sch_sfq sch_cbq ip6table_filter ip6t_LOG ip6_tables ipt_limit lp msr
> cpuid ipt_state ipt_MASQUERADE ipt_LOG iptable_mangle iptable_filter
> dummy af_packet es1371 ac97_codec pci_hotplug intel_agp floppy pcspkr
> rtc sd_mod reiserfs ext2 dm_mod capability commoncap tsdev mousedev
> joydev evdev wacom usbhid psmouse usb_storage uhci_hcd usbcore eeprom
> lm75 i2c_sensor i2c_dev i2c_piix4 i2c_core aha152x ipv6 binfmt_misc
> ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack mga agpgart
> snd_pcm_oss snd_mixer_oss snd_ens1371 snd_rawmidi snd_seq_device
> snd_pcm snd_timer snd_page_alloc snd_ac97_codec snd gameport ipt_REJECT
> ip_tables ne2k_pci 8390 via_rhine mii crc32 sound soundcore sg
> scsi_mod parport_pc parport ide_cd cdrom ext3 jbd mbcache ide_generic
> piix ide_disk ide_core unix fbcon font vesafb cfbcopyarea cfbimgblt
> cfbfillrect
> Jan  3 07:07:26 wojas kernel: CPU:    0
> Jan  3 07:07:26 wojas kernel: EIP:    0060:[__func__.4+64363/135712]    Not tainted VLI
> Jan  3 07:07:26 wojas kernel: EFLAGS: 00010246   (2.6.9-1-686) 
> Jan  3 07:07:26 wojas kernel: EIP is at 0xc02b5513
> Jan  3 07:07:26 wojas kernel: eax: 00000000   ebx: c0325c00   ecx: c61e57e0   edx: d35b85e0
> Jan  3 07:07:26 wojas kernel: esi: c46082b9   edi: c61e57e4   ebp: 00000056   esp: d5f35f1c
> Jan  3 07:07:26 wojas kernel: ds: 007b   es: 007b   ss: 0068
> Jan  3 07:07:26 wojas kernel: Process python (pid: 30488, threadinfo=d5f34000 task=c0f0faa0)
> Jan  3 07:07:26 wojas kernel: Stack: c022db99 c61e57e0 d35b85e0 00000000 00000145 c016c995 c61e57e0 00000000 
> Jan  3 07:07:26 wojas kernel:        c4608000 d5f35f64 d5f35f68 0000001a c016ca0a 00000063 c4608008 d5f35f64 
> Jan  3 07:07:26 wojas kernel:        d5f35f68 d5f34000 00000000 00000002 00000000 c4608000 000001ff 082b0d90 
> Jan  3 07:07:26 wojas kernel: Call Trace:
> Jan  3 07:07:26 wojas kernel:  [sock_poll+41/64] sock_poll+0x29/0x40
> Jan  3 07:07:26 wojas kernel:  [do_pollfd+149/160] do_pollfd+0x95/0xa0
> Jan  3 07:07:26 wojas kernel:  [do_poll+106/208] do_poll+0x6a/0xd0
> Jan  3 07:07:26 wojas kernel:  [sys_poll+353/576] sys_poll+0x161/0x240
> Jan  3 07:07:26 wojas kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
> Jan  3 07:07:26 wojas kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Jan  3 07:07:26 wojas kernel: Code: 79 70 74 6f 2f 63 69 70 68 65 72 2e 63 00 69 6e 63 6c 75 64 65 2f 6c 69 6e 75 78 2f 63 72 79 70 74 6f 2e 68 00 6e 61 6d 65 20 20 <20> 20 20 20 20 20 20 3a 20 25 73 0a 00 6d 6f 64 75 6c 65 20 20 
> 
> ===================== KSYMOOPS  ======================
> 
> ksymoops 2.4.9 on i686 2.6.9-1-686.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.6.9-1-686/ (default)
>      -m /boot/System.map-2.6.9-1-686 (default)
> 
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> Jan  3 07:07:26 wojas kernel: c02b5513
> Jan  3 07:07:26 wojas kernel: CPU:    0
> Jan  3 07:07:26 wojas kernel: EIP:    0060:[__func__.4+64363/135712]    Not tainted VLI
> Jan  3 07:07:26 wojas kernel: EFLAGS: 00010246   (2.6.9-1-686) 
> Jan  3 07:07:26 wojas kernel: eax: 00000000   ebx: c0325c00   ecx: c61e57e0   edx: d35b85e0
> Jan  3 07:07:26 wojas kernel: esi: c46082b9   edi: c61e57e4   ebp: 00000056   esp: d5f35f1c
> Jan  3 07:07:26 wojas kernel: ds: 007b   es: 007b   ss: 0068
> Jan  3 07:07:26 wojas kernel: Stack: c022db99 c61e57e0 d35b85e0 00000000 00000145 c016c995 c61e57e0 00000000 
> Jan  3 07:07:26 wojas kernel:        c4608000 d5f35f64 d5f35f68 0000001a c016ca0a 00000063 c4608008 d5f35f64 
> Jan  3 07:07:26 wojas kernel:        d5f35f68 d5f34000 00000000 00000002 00000000 c4608000 000001ff 082b0d90 
> Jan  3 07:07:26 wojas kernel: Call Trace:
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> 
> 
>>>ebx; c0325c00 <devinet_sysctl+460/4e0>
>>>ecx; c61e57e0 <pg0+5e3b7e0/3fc54400>
>>>edx; d35b85e0 <pg0+1320e5e0/3fc54400>
>>>esi; c46082b9 <pg0+425e2b9/3fc54400>
>>>edi; c61e57e4 <pg0+5e3b7e4/3fc54400>
>>>esp; d5f35f1c <pg0+15b8bf1c/3fc54400>


-- 
~Randy
