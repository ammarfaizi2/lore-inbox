Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVCVTnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVCVTnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVCVTnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:43:47 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:13833 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S261733AbVCVTlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:41:04 -0500
Message-ID: <424074EB.9020904@tuleriit.ee>
Date: Tue, 22 Mar 2005 21:41:31 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 1.0 (X11/20050215)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA bugs in list [was Re: 2.6.12-rc1-mm1]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@xxxxxxxxxxx> wrote:
 >
 >/ On Mon, 2005-03-21 at 12:41 -0800, Andrew Morton wrote:/
 >/ > From: bugme-daemon@xxxxxxxx/
 >/ > Subject: [Bug 4282] ALSA driver in Linux 2.6.11 causes a kernel 
panic when loading the EMU10K1 driver/
 >/ > /
 >/ /
 >/ This one is a real mystery. No one can reproduce it./

Not quite true. This bug was current till today in Mandrake's kernel, 
but with  2.6.11-5mdk they managed to get rid of it.
The problem is not with loading the driver but when alsactl tries to 
store/restore mixer settings.

I have tried again with 2.6.12-rc1-mm1 and it is still there (for 
example the Gnome won't start due to this).
Below the oops part from messages.

thanks,
Indrek



Mar 22 21:05:21 bedroom alsa:  succeeded
Mar 22 21:05:21 bedroom kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000000c
Mar 22 21:05:21 bedroom kernel:  printing eip:
Mar 22 21:05:21 bedroom kernel: dfa929e8
Mar 22 21:05:21 bedroom kernel: *pde = 00000000
Mar 22 21:05:21 bedroom kernel: Oops: 0000 [#1]
Mar 22 21:05:21 bedroom kernel: SMP
Mar 22 21:05:21 bedroom kernel: Modules linked in: snd_pcm_oss 
snd_mixer_oss snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec 
snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore 
af_packet eth1394 e100 mii ide_cd ohci1394 ieee1394 nls_iso8859_15 
nls_cp850 vfat fat intel_agp agpgart hw_random emu10k1_gp gameport 
ata_piix libata ehci_hcd uhci_hcd usbcore evdev
Mar 22 21:05:21 bedroom kernel: CPU:    0
Mar 22 21:05:21 bedroom kernel: EIP:    
0060:[pg0+527297000/1069851648]    Not tainted VLI
Mar 22 21:05:21 bedroom kernel: EIP:    0060:[<dfa929e8>]    Not tainted VLI
Mar 22 21:05:21 bedroom kernel: EFLAGS: 00010002   (2.6.12-r1m1)
Mar 22 21:05:21 bedroom kernel: EIP is at 
snd_emu10k1_efx_send_routing_put+0x98/0xd5 [snd_emu10k1]
Mar 22 21:05:21 bedroom kernel: eax: 00000000   ebx: dd6cb1a8   ecx: 
0000000c   edx: 00000004
Mar 22 21:05:21 bedroom kernel: esi: 00000004   edi: 00000000   ebp: 
dd6ca000   esp: dce73ed4
Mar 22 21:05:21 bedroom kernel: ds: 007b   es: 007b   ss: 0068
Mar 22 21:05:21 bedroom kernel: Process alsactl (pid: 5019, 
threadinfo=dce72000 task=decaa550)
Mar 22 21:05:21 bedroom kernel: Stack: 00000000 00000000 00000000 
dd6ca508 0000000f 00000001 00000246 ddc3c14c
Mar 22 21:05:21 bedroom kernel:        ddfe9200 de1a0440 ddc3c000 
dfa18e30 ddfe9200 de1a0400 00000000 00000000
Mar 22 21:05:21 bedroom kernel:        00000000 ddfe9200 c01b845c 
ddfe9200 fffffff3 decc1180 de1a0400 bf886950
Mar 22 21:05:21 bedroom kernel: Call Trace:
Mar 22 21:05:21 bedroom kernel:  [pg0+526798384/1069851648] 
snd_ctl_elem_write+0x126/0x177 [snd]
Mar 22 21:05:21 bedroom kernel:  [<dfa18e30>] 
snd_ctl_elem_write+0x126/0x177 [snd]
Mar 22 21:05:21 bedroom kernel:  [copy_from_user+70/126] 
copy_from_user+0x46/0x7e
Mar 22 21:05:21 bedroom kernel:  [<c01b845c>] copy_from_user+0x46/0x7e
Mar 22 21:05:21 bedroom kernel:  [pg0+526798563/1069851648] 
snd_ctl_elem_write_user+0x62/0xaf [snd]
Mar 22 21:05:21 bedroom kernel:  [<dfa18ee3>] 
snd_ctl_elem_write_user+0x62/0xaf [snd]
Mar 22 21:05:21 bedroom kernel:  [do_ioctl+154/169] do_ioctl+0x9a/0xa9
Mar 22 21:05:21 bedroom kernel:  [<c017352a>] do_ioctl+0x9a/0xa9
Mar 22 21:05:21 bedroom kernel:  [vfs_ioctl+101/481] vfs_ioctl+0x65/0x1e1
Mar 22 21:05:21 bedroom kernel:  [<c01736df>] vfs_ioctl+0x65/0x1e1
Mar 22 21:05:21 bedroom kernel:  [sys_ioctl+69/109] sys_ioctl+0x45/0x6d
Mar 22 21:05:21 bedroom kernel:  [<c01738a0>] sys_ioctl+0x45/0x6d
Mar 22 21:05:21 bedroom kernel:  [sysenter_past_esp+84/117] 
sysenter_past_esp+0x54/0x75
Mar 22 21:05:21 bedroom kernel:  [<c01030c7>] sysenter_past_esp+0x54/0x75
Mar 22 21:05:21 bedroom kernel: Code: 24 10 23 4c 90 44 0f b6 04 13 39 
c8 74 0b 88 0c 13 c7 44 24 14 01 00 00 00 83 c2 01 39 f2 7c da 8b 44 24 
14 85 c0 74 0b 8b 43 38 <8b> 44 b8 0c 85 c0 75 19 8b 44 24 0c 8b 54 24 
18 e8 c9 3c 83 e0

