Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVDABhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVDABhB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 20:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVDABfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 20:35:42 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:42707 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262566AbVDABe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 20:34:27 -0500
Date: Thu, 31 Mar 2005 19:33:44 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: AMD64 Machine hardlocks when using memset
In-reply-to: <3O4tp-8tL-3@gated-at.bofh.it>
To: Philip Lawatsch <philip@lawatsch.at>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <424CA4F8.6030700@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3NZDp-4yY-7@gated-at.bofh.it> <3NZN4-4EZ-1@gated-at.bofh.it>
 <3O2rK-6MU-19@gated-at.bofh.it> <3O34n-7oN-19@gated-at.bofh.it>
 <3O4tp-8tL-3@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Lawatsch wrote:
> I've now tried the most conservative settings available. The 32 bit
> kernel now hangs after about 150000 Iterations (compared to about 16000
> before) but the 64 bit kernel still hangs after about 5000.

I'm still seeing this on my system as well, using the most conservative 
timings possible (DDR200, all delay parameters except the refresh time 
set to the largest possible value) as well as DDR333 with the same 
timings and DDR400 with everything set to auto. I also tried the kernel 
on the Fedora Core 3 rescue disc (same crash) and in single user mode 
(same crash).

So far, the crashes have consisted of either a hang, reboot or panic. 
One panic was a "spinlock already locked at kernel/module.c:2022" error. 
The other one is below, for what it's worth:

Mar 31 18:55:43 Newcastle kernel: Unable to handle kernel paging request 
at ffff8100588f5000 RIP:
Mar 31 18:55:43 Newcastle kernel: <ffffffff80236ac7>{clear_page+7}
Mar 31 18:55:43 Newcastle kernel: PGD 8063 PUD a063 PMD 0
Mar 31 18:55:43 Newcastle kernel: Oops: 0002 [1]
Mar 31 18:55:43 Newcastle kernel: CPU 0
Mar 31 18:55:43 Newcastle kernel: Modules linked in: md5(U) ipv6(U) 
parport_pc(U) lp(U) parport(U) autofs4(U) it87(U) i2c_sensor(U) 
i2c_isa(U) i2c_dev(U) i2c_core(U) sunrpc(U) pcmcia(U) yenta_socket(U) 
rsrc_nonstatic(U) pcmcia_core(U) joydev(U) nls_utf8(U) ntfs(U) vfat(U) 
fat(U) dm_mod(U) video(U) button(U) battery(U) ac(U) usb_storage(U) 
ohci1394(U) ieee1394(U) ohci_hcd(U) ehci_hcd(U) snd_ice1724(U) 
snd_ice17xx_ak4xxx(U) snd_ac97_codec(U) snd_pcm_oss(U) snd_mixer_oss(U) 
snd_pcm(U) snd_timer(U) snd_page_alloc(U) snd_ak4xxx_adda(U) 
snd_mpu401_uart(U) snd_rawmidi(U) snd_seq_device(U) snd(U) soundcore(U) 
forcedeth(U) floppy(U) ext3(U) jbd(U) sata_nv(U) libata(U) sd_mod(U) 
scsi_mod(U)
Mar 31 18:55:43 Newcastle kernel: Pid: 4928, comm: crashtest Not tainted 
2.6.11-1.7_FC3custom
Mar 31 18:55:43 Newcastle kernel: RIP: 0010:[<ffffffff80236ac7>] 
<ffffffff80236ac7>{clear_page+7}
Mar 31 18:55:43 Newcastle kernel: RSP: 0000:ffff810078299ca0  EFLAGS: 
00010246
Mar 31 18:55:43 Newcastle kernel: RAX: 0000000000000000 RBX: 
0000000000000001 RCX: 0000000000000200
Mar 31 18:55:43 Newcastle kernel: RDX: ffffffff80478940 RSI: 
0000000000000000 RDI: ffff8100588f5000
Mar 31 18:55:43 Newcastle kernel: RBP: ffff81000235f5d0 R08: 
0000000000000000 R09: 0000000000000000
Mar 31 18:55:43 Newcastle kernel: R10: 00000000000552fa R11: 
0000000000000000 R12: ffff810000000000
Mar 31 18:55:43 Newcastle kernel: R13: ffff81000235f598 R14: 
6db6db6db6db6db7 R15: 0000000000000000
Mar 31 18:55:43 Newcastle kernel: FS:  00002aaaaaabeb00(0000) 
GS:ffffffff80552300(0000) knlGS:0000000000000000
Mar 31 18:55:43 Newcastle kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
Mar 31 18:55:43 Newcastle kernel: CR2: ffff8100588f5000 CR3: 
00000000791b0000 CR4: 00000000000006e0
Mar 31 18:55:43 Newcastle kernel: Process crashtest (pid: 4928, 
threadinfo ffff810078298000, task ffff8100788d67e0)
Mar 31 18:55:43 Newcastle kernel: Stack: ffffffff80170bc2 
0000000000000019 0000000000000286 0000000000000000
Mar 31 18:55:43 Newcastle kernel:        000000000000000a 
000080d20000000a 0000000000000286 0000000000000256
Mar 31 18:55:43 Newcastle kernel:        ffffffff80478bc0 0000000000000000
Mar 31 18:55:43 Newcastle kernel: Call 
Trace:<ffffffff80170bc2>{buffered_rmqueue+1154} 
<ffffffff80170dac>{__alloc_pages+220}
Mar 31 18:55:43 Newcastle kernel: 
<ffffffff80181c52>{do_no_page+370} <ffffffff801825c0>{handle_mm_fault+560}
Mar 31 18:55:43 Newcastle kernel: 
<ffffffff80284f9c>{write_chan+860} <ffffffff80123834>{do_page_fault+1044}
Mar 31 18:55:43 Newcastle kernel: 
<ffffffff803a3699>{thread_return+41} <ffffffff8010f58d>{error_exit+0}
Mar 31 18:55:43 Newcastle kernel:
Mar 31 18:55:43 Newcastle kernel:
Mar 31 18:55:43 Newcastle kernel: Code: f3 48 ab c3 66 66 66 90 66 66 66 
90 66 66 66 90 66 66 66 90
Mar 31 18:55:43 Newcastle kernel: RIP <ffffffff80236ac7>{clear_page+7} 
RSP <ffff810078299ca0>
Mar 31 18:55:43 Newcastle kernel: CR2: ffff8100588f5000


-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


