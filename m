Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbUKFWxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbUKFWxz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 17:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbUKFWxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 17:53:55 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:6729 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261487AbUKFWxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 17:53:24 -0500
Message-ID: <32792.192.168.1.8.1099781557.squirrel@192.168.1.8>
In-Reply-To: <20041106155720.GA14950@elte.hu>
References: <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
    <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>
    <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu>
    <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu>
    <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu>
    <20041106155720.GA14950@elte.hu>
Date: Sat, 6 Nov 2004 22:52:37 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.18
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 06 Nov 2004 22:53:19.0480 (UTC) FILETIME=[68EB5780:01C4C453]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> i have released the -V0.7.18 Real-Time Preemption patch, which can be
> downloaded from:
>
>    http://redhat.com/~mingo/realtime-preempt/
>

I'm having trouble modprobe'ing the alsasound drivers ever since
RT-V0.7.11, to latest RT-V0.7.18, and I suspect this applies to -mm3 as
well.

The most evident trouble happens while unloading the modules, either on
shutdown or doing simple modprobe -r or rmmod. The system hangs
completely. On my P4/SMT machine it doesn't spit anything out to the
serial console. Nada. OTOH, on my P4/UP laptop, I found that it does
behave a litle more verbose, as the following syslog excerpt:


Nov  6 20:29:52 lambda alsa: Shutting down ALSA sound driver (version 1.0.6):
Nov  6 20:29:55 lambda kernel: usbcore: deregistering driver snd-usb-usx2y
Nov  6 20:29:55 lambda alsa: /etc/rc6.d/K70alsa: line 287: 15938
Segmentation fault      /sbin/rmmod `echo $line | cut -d ' ' -f 1`
>/dev/null 2>&1
Nov  6 20:29:55 lambda kernel: BUG: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Nov  6 20:29:55 lambda kernel:  printing eip:
Nov  6 20:29:55 lambda kernel: c012ae47
Nov  6 20:29:55 lambda kernel: *pde = 00000000
Nov  6 20:29:55 lambda kernel: Oops: 0000 [#1]
Nov  6 20:29:55 lambda kernel: PREEMPT
Nov  6 20:29:55 lambda kernel: Modules linked in: realtime commoncap
snd_usb_usx2y snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep snd_ali5451
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd soundcore prism2_cs
p80211 pcmcia yenta_socket pcmcia_core natsemi crc32 loop subfs evdev
pl2303 usbserial ohci_hcd usbcore
Nov  6 20:29:55 lambda kernel: CPU:    0
Nov  6 20:29:55 lambda kernel: EIP:    0060:[__up_write+109/721]    Not
tainted VLI
Nov  6 20:29:55 lambda kernel: EIP:    0060:[<c012ae47>]    Not tainted VLI
Nov  6 20:29:55 lambda kernel: EFLAGS: 00010083   (2.6.10-rc1-mm2-RT-V0.7.7)
Nov  6 20:29:55 lambda kernel: EIP is at __up_write+0x6d/0x2d1
Nov  6 20:29:55 lambda kernel: eax: 00000000   ebx: d6cb8000   ecx:
00000064   edx: 00000064
Nov  6 20:29:55 lambda alsa: /etc/rc6.d/K70alsa: line 287: 15965
Segmentation fault      /sbin/rmmod `echo $line | cut -d ' ' -f 1`
>/dev/null 2>&1
Nov  6 20:29:55 lambda kernel: esi: e011b5cc   edi: ddd7ce30   ebp:
e0061e78   esp: d6cb9eb8
Nov  6 20:29:55 lambda kernel: ds: 007b   es: 007b   ss: 0068   preempt:
00000004
Nov  6 20:29:55 lambda kernel: Process rmmod (pid: 15938,
threadinfo=d6cb8000 task=ded203b0)
Nov  6 20:29:55 lambda kernel: Stack: c015258f df760280 00000008 c013baa4
ddc02028 00000246 d6cb8000 00000246
Nov  6 20:29:55 lambda kernel:        df767400 00000000 d6cb8000 e011b5c8
e0061e68 e0061e78 c012b957 00000246
Nov  6 20:29:55 lambda kernel:        ded203b0 d6cb8000 00000246 c02ff3c0
de3db4e8 e011b5e8 c030ac28 c01b1cef
Nov  6 20:29:55 lambda kernel: Call Trace:
Nov  6 20:29:55 lambda kernel:  [invalidate_inode_buffers+26/240]
invalidate_inode_buffers+0x1a/0xf0 (4)
Nov  6 20:29:55 lambda kernel:  [<c015258f>]
invalidate_inode_buffers+0x1a/0xf0 (4)
Nov  6 20:29:55 lambda kernel:  [cache_flusharray+69/161]
cache_flusharray+0x45/0xa1 (12)
Nov  6 20:29:55 lambda kernel:  [<c013baa4>] cache_flusharray+0x45/0xa1 (12)
Nov  6 20:29:55 lambda kernel:  [up+80/173] up+0x50/0xad (44)
Nov  6 20:29:55 lambda kernel:  [<c012b957>] up+0x50/0xad (44)
Nov  6 20:29:55 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (36)
Nov  6 20:29:55 lambda kernel:  [<c01b1cef>] kobject_cleanup+0x8e/0x90 (36)
Nov  6 20:29:55 lambda kernel:  [kobject_release+0/8]
kobject_release+0x0/0x8 (8)
Nov  6 20:29:55 lambda kernel:  [<c01b1cf1>] kobject_release+0x0/0x8 (8)
Nov  6 20:29:55 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov  6 20:29:55 lambda kernel:  [<c01b2597>] kref_put+0x51/0xc2 (12)
Nov  6 20:29:55 lambda kernel:  [bus_remove_driver+63/72]
bus_remove_driver+0x3f/0x48 (36)
Nov  6 20:29:55 lambda kernel:  [<c01f79d2>] bus_remove_driver+0x3f/0x48 (36)
Nov  6 20:29:55 lambda kernel:  [driver_unregister+11/26]
driver_unregister+0xb/0x1a (8)
Nov  6 20:29:55 lambda kernel:  [<c01f7d44>] driver_unregister+0xb/0x1a (8)
Nov  6 20:29:55 lambda kernel:  [pg0+533397933/1069954048]
usb_deregister+0x31/0x3f [usbcore] (8)
Nov  6 20:29:55 lambda kernel:  [<e004b1ad>] usb_deregister+0x31/0x3f
[usbcore] (8)
Nov  6 20:29:55 lambda kernel:  [sys_delete_module+287/299]
sys_delete_module+0x11f/0x12b (20)
Nov  6 20:29:55 lambda kernel:  [<c012d91f>] sys_delete_module+0x11f/0x12b
(20)
Nov  6 20:29:55 lambda kernel:  [blk_queue_bounce+29/132]
blk_queue_bounce+0x1d/0x84 (20)
Nov  6 20:29:55 lambda kernel:  [<c0140079>] blk_queue_bounce+0x1d/0x84 (20)
Nov  6 20:29:55 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176
(12)
Nov  6 20:29:55 lambda kernel:  [<c0144f7a>] do_munmap+0x11a/0x176 (12)
Nov  6 20:29:55 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (36)
Nov  6 20:29:55 lambda kernel:  [<c014500e>] sys_munmap+0x38/0x45 (36)
Nov  6 20:29:55 lambda kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71 (12)
Nov  6 20:29:55 lambda kernel:  [<c0103bc1>] sysenter_past_esp+0x52/0x71 (12)
Nov  6 20:29:55 lambda kernel: Code: 75 0b 8b 46 04 85 c0 0f 84 71 01 00
00 b8 00 e0 ff ff 21 e0 83 40 14 01 8b 46 0c e8 d0 81 fe ff 8b 7e 0c 89 c2
8b 87 60 05 00 00 <8b> 08 0f 18 01 90 8d 9f 60 05 00 00 eb 10 8b 40 0c 39
d0 0f 4c
Nov  6 20:29:55 lambda kernel:  <6>note: rmmod[15938] exited with
preempt_count 3
Nov  6 20:29:55 lambda kernel: BUG: scheduling while atomic:
rmmod/0x00000003/15938
Nov  6 20:29:55 lambda kernel: caller is do_exit+0x289/0x4b2
Nov  6 20:29:55 lambda kernel:  [__schedule+1194/1525]
__sched_text_start+0x4aa/0x5f5 (8)
Nov  6 20:29:55 lambda kernel:  [<c02ac2fa>]
__sched_text_start+0x4aa/0x5f5 (8)
Nov  6 20:29:55 lambda kernel:  [exit_notify+1154/2290]
exit_notify+0x482/0x8f2 (24)
Nov  6 20:29:55 lambda kernel:  [<c01187ba>] exit_notify+0x482/0x8f2 (24)
Nov  6 20:29:55 lambda kernel:  [kmem_cache_free+72/197]
kmem_cache_free+0x48/0xc5 (24)
Nov  6 20:29:55 lambda kernel:  [<c013bd6d>] kmem_cache_free+0x48/0xc5 (24)
Nov  6 20:29:55 lambda kernel:  [do_exit+649/1202] do_exit+0x289/0x4b2 (32)
Nov  6 20:29:55 lambda kernel:  [<c0118eb3>] do_exit+0x289/0x4b2 (32)
Nov  6 20:29:55 lambda kernel:  [do_divide_error+0/330]
do_divide_error+0x0/0x14a (40)
Nov  6 20:29:55 lambda kernel:  [<c0104d83>] do_divide_error+0x0/0x14a (40)
Nov  6 20:29:55 lambda kernel:  [do_page_fault+920/1425]
do_page_fault+0x398/0x591 (64)
Nov  6 20:29:55 lambda kernel:  [<c0111313>] do_page_fault+0x398/0x591 (64)
Nov  6 20:29:55 lambda kernel:  [preempt_schedule+80/106]
preempt_schedule+0x50/0x6a (80)
Nov  6 20:29:55 lambda kernel:  [<c02ac5ab>] preempt_schedule+0x50/0x6a (80)
Nov  6 20:29:55 lambda kernel:  [queue_work+44/101] queue_work+0x2c/0x65 (20)
Nov  6 20:29:55 lambda kernel:  [<c0125d66>] queue_work+0x2c/0x65 (20)
Nov  6 20:29:55 lambda kernel:  [call_usermodehelper+274/316]
call_usermodehelper+0x112/0x13c (24)
Nov  6 20:29:55 lambda kernel:  [<c0125caa>]
call_usermodehelper+0x112/0x13c (24)
Nov  6 20:29:55 lambda kernel:  [__call_usermodehelper+0/72]
__call_usermodehelper+0x0/0x48 (20)
Nov  6 20:29:55 lambda kernel:  [<c0125b50>]
__call_usermodehelper+0x0/0x48 (20)
Nov  6 20:29:55 lambda kernel:  [do_page_fault+0/1425]
do_page_fault+0x0/0x591 (52)
Nov  6 20:29:55 lambda kernel:  [<c0110f7b>] do_page_fault+0x0/0x591 (52)
Nov  6 20:29:55 lambda kernel:  [error_code+45/56] error_code+0x2d/0x38 (8)
Nov  6 20:29:55 lambda kernel:  [<c010461d>] error_code+0x2d/0x38 (8)
Nov  6 20:29:55 lambda kernel:  [__up_write+109/721] __up_write+0x6d/0x2d1
(52)
Nov  6 20:29:55 lambda kernel:  [<c012ae47>] __up_write+0x6d/0x2d1 (52)
Nov  6 20:29:55 lambda kernel:  [invalidate_inode_buffers+26/240]
invalidate_inode_buffers+0x1a/0xf0 (12)
Nov  6 20:29:55 lambda kernel:  [<c015258f>]
invalidate_inode_buffers+0x1a/0xf0 (12)
Nov  6 20:29:55 lambda kernel:  [cache_flusharray+69/161]
cache_flusharray+0x45/0xa1 (12)
Nov  6 20:29:55 lambda kernel:  [<c013baa4>] cache_flusharray+0x45/0xa1 (12)
Nov  6 20:29:55 lambda kernel:  [up+80/173] up+0x50/0xad (44)
Nov  6 20:29:55 lambda kernel:  [<c012b957>] up+0x50/0xad (44)
Nov  6 20:29:55 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (36)
Nov  6 20:29:55 lambda kernel:  [<c01b1cef>] kobject_cleanup+0x8e/0x90 (36)
Nov  6 20:29:55 lambda kernel:  [kobject_release+0/8]
kobject_release+0x0/0x8 (8)
Nov  6 20:29:55 lambda kernel:  [<c01b1cf1>] kobject_release+0x0/0x8 (8)
Nov  6 20:29:55 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov  6 20:29:55 lambda kernel:  [<c01b2597>] kref_put+0x51/0xc2 (12)
Nov  6 20:29:55 lambda kernel:  [bus_remove_driver+63/72]
bus_remove_driver+0x3f/0x48 (36)
Nov  6 20:29:55 lambda kernel:  [<c01f79d2>] bus_remove_driver+0x3f/0x48 (36)
Nov  6 20:29:55 lambda kernel:  [driver_unregister+11/26]
driver_unregister+0xb/0x1a (8)
Nov  6 20:29:55 lambda kernel:  [<c01f7d44>] driver_unregister+0xb/0x1a (8)
Nov  6 20:29:55 lambda kernel:  [pg0+533397933/1069954048]
usb_deregister+0x31/0x3f [usbcore] (8)
Nov  6 20:29:55 lambda kernel:  [<e004b1ad>] usb_deregister+0x31/0x3f
[usbcore] (8)
Nov  6 20:29:55 lambda kernel:  [sys_delete_module+287/299]
sys_delete_module+0x11f/0x12b (20)
Nov  6 20:29:55 lambda kernel:  [<c012d91f>] sys_delete_module+0x11f/0x12b
(20)
Nov  6 20:29:55 lambda kernel:  [blk_queue_bounce+29/132]
blk_queue_bounce+0x1d/0x84 (20)
Nov  6 20:29:55 lambda kernel:  [<c0140079>] blk_queue_bounce+0x1d/0x84 (20)
Nov  6 20:29:55 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176
(12)
Nov  6 20:29:55 lambda kernel:  [<c0144f7a>] do_munmap+0x11a/0x176 (12)
Nov  6 20:29:55 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (36)
Nov  6 20:29:55 lambda kernel:  [<c014500e>] sys_munmap+0x38/0x45 (36)
Nov  6 20:29:55 lambda kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71 (12)
Nov  6 20:29:55 lambda kernel:  [<c0103bc1>] sysenter_past_esp+0x52/0x71 (12)
Nov  6 20:29:55 lambda kernel: ALI 5451 0000:00:06.0: Device was removed
without properly calling pci_disable_device(). This may need fixing.
Nov  6 20:29:55 lambda kernel: BUG: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Nov  6 20:29:55 lambda kernel:  printing eip:
Nov  6 20:29:55 lambda kernel: c012ae47
Nov  6 20:29:55 lambda kernel: *pde = 00000000
Nov  6 20:29:55 lambda kernel: Oops: 0000 [#2]
Nov  6 20:29:55 lambda kernel: PREEMPT
Nov  6 20:29:55 lambda kernel: Modules linked in: realtime commoncap
snd_usb_usx2y snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep snd_ali5451
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd soundcore prism2_cs
p80211 pcmcia yenta_socket pcmcia_core natsemi crc32 loop subfs evdev
pl2303 usbserial ohci_hcd usbcore
Nov  6 20:29:55 lambda kernel: CPU:    0
Nov  6 20:29:55 lambda kernel: EIP:    0060:[__up_write+109/721]    Not
tainted VLI
Nov  6 20:29:55 lambda kernel: EIP:    0060:[<c012ae47>]    Not tainted VLI
Nov  6 20:29:55 lambda kernel: EFLAGS: 00010083   (2.6.10-rc1-mm2-RT-V0.7.7)
Nov  6 20:29:55 lambda kernel: EIP is at __up_write+0x6d/0x2d1
Nov  6 20:29:55 lambda kernel: eax: 00000000   ebx: d6cb8000   ecx:
00000064   edx: 00000064
Nov  6 20:29:55 lambda kernel: esi: e00ef894   edi: ddd7ce30   ebp:
c0303198   esp: d6cb9ec4
Nov  6 20:29:55 lambda kernel: ds: 007b   es: 007b   ss: 0068   preempt:
00000004
Nov  6 20:29:55 lambda kernel: Process rmmod (pid: 15965,
threadinfo=d6cb8000 task=ded203b0)
Nov  6 20:29:55 lambda kernel: Stack: c015258f ded203b0 00000000 00000096
de536d84 00000246 d6cb8000 00000246
Nov  6 20:29:56 lambda kernel:        df767400 00000000 d6cb8000 e00ef890
c0303188 c0303198 c012b957 00000246
Nov  6 20:29:56 lambda kernel:        ded203b0 d6cb8000 00000246 c02ff3c0
deb50cc8 e00ef8b0 c030ac28 c01b1cef
Nov  6 20:29:56 lambda kernel: Call Trace:
Nov  6 20:29:56 lambda kernel:  [invalidate_inode_buffers+26/240]
invalidate_inode_buffers+0x1a/0xf0 (4)
Nov  6 20:29:56 lambda kernel:  [<c015258f>]
invalidate_inode_buffers+0x1a/0xf0 (4)
Nov  6 20:29:56 lambda kernel:  [up+80/173] up+0x50/0xad (56)
Nov  6 20:29:56 lambda kernel:  [<c012b957>] up+0x50/0xad (56)
Nov  6 20:29:56 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (36)
Nov  6 20:29:56 lambda kernel:  [<c01b1cef>] kobject_cleanup+0x8e/0x90 (36)
Nov  6 20:29:56 lambda kernel:  [kobject_release+0/8]
kobject_release+0x0/0x8 (8)
Nov  6 20:29:56 lambda kernel:  [<c01b1cf1>] kobject_release+0x0/0x8 (8)
Nov  6 20:29:56 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov  6 20:29:56 lambda kernel:  [<c01b2597>] kref_put+0x51/0xc2 (12)
Nov  6 20:29:56 lambda kernel:  [bus_remove_driver+63/72]
bus_remove_driver+0x3f/0x48 (36)
Nov  6 20:29:56 lambda kernel:  [<c01f79d2>] bus_remove_driver+0x3f/0x48 (36)
Nov  6 20:29:56 lambda kernel:  [driver_unregister+11/26]
driver_unregister+0xb/0x1a (8)
Nov  6 20:29:56 lambda kernel:  [<c01f7d44>] driver_unregister+0xb/0x1a (8)
Nov  6 20:29:56 lambda kernel:  [pci_unregister_driver+11/19]
pci_unregister_driver+0xb/0x13 (8)
Nov  6 20:29:56 lambda kernel:  [<c01b95e4>]
pci_unregister_driver+0xb/0x13 (8)
Nov  6 20:29:56 lambda kernel:  [sys_delete_module+287/299]
sys_delete_module+0x11f/0x12b (8)
Nov  6 20:29:56 lambda kernel:  [<c012d91f>] sys_delete_module+0x11f/0x12b
(8)
Nov  6 20:29:56 lambda kernel:  [unmap_vma_list+14/23]
unmap_vma_list+0xe/0x17 (20)
Nov  6 20:29:56 lambda kernel:  [<c0144c7d>] unmap_vma_list+0xe/0x17 (20)
Nov  6 20:29:56 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176
(12)
Nov  6 20:29:56 lambda kernel:  [<c0144f7a>] do_munmap+0x11a/0x176 (12)
Nov  6 20:29:56 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (36)
Nov  6 20:29:56 lambda kernel:  [<c014500e>] sys_munmap+0x38/0x45 (36)
Nov  6 20:29:56 lambda kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71 (12)
Nov  6 20:29:56 lambda kernel:  [<c0103bc1>] sysenter_past_esp+0x52/0x71 (12)
Nov  6 20:29:56 lambda kernel: Code: 75 0b 8b 46 04 85 c0 0f 84 71 01 00
00 b8 00 e0 ff ff 21 e0 83 40 14 01 8b 46 0c e8 d0 81 fe ff 8b 7e 0c 89 c2
8b 87 60 05 00 00 <8b> 08 0f 18 01 90 8d 9f 60 05 00 00 eb 10 8b 40 0c 39
d0 0f 4c
Nov  6 20:29:56 lambda kernel:  <6>note: rmmod[15965] exited with
preempt_count 3
Nov  6 20:29:56 lambda kernel: BUG: scheduling while atomic:
rmmod/0x10000003/15965
Nov  6 20:29:56 lambda kernel: caller is __cond_resched+0x36/0x41
Nov  6 20:29:56 lambda kernel:  [__schedule+1194/1525]
__sched_text_start+0x4aa/0x5f5 (8)
Nov  6 20:29:56 lambda kernel:  [<c02ac2fa>]
__sched_text_start+0x4aa/0x5f5 (8)
Nov  6 20:29:56 lambda kernel:  [__cond_resched+54/65]
__cond_resched+0x36/0x41 (80)
Nov  6 20:29:56 lambda kernel:  [<c0113715>] __cond_resched+0x36/0x41 (80)
Nov  6 20:29:56 lambda kernel:  [cond_resched+28/37]
cond_resched+0x1c/0x25 (12)
Nov  6 20:29:56 lambda kernel:  [<c02acedb>] cond_resched+0x1c/0x25 (12)
Nov  6 20:29:56 lambda kernel:  [unmap_vmas+374/385]
unmap_vmas+0x176/0x181 (8)
Nov  6 20:29:56 lambda kernel:  [<c0140cff>] unmap_vmas+0x176/0x181 (8)
Nov  6 20:29:56 lambda kernel:  [exit_mmap+79/268] exit_mmap+0x4f/0x10c (64)
Nov  6 20:29:56 lambda kernel:  [<c01452df>] exit_mmap+0x4f/0x10c (64)
Nov  6 20:29:56 lambda kernel:  [mmput+78/295] mmput+0x4e/0x127 (40)
Nov  6 20:29:56 lambda kernel:  [<c01141d7>] mmput+0x4e/0x127 (40)
Nov  6 20:29:56 lambda kernel:  [do_exit+304/1202] do_exit+0x130/0x4b2 (24)
Nov  6 20:29:56 lambda kernel:  [<c0118d5a>] do_exit+0x130/0x4b2 (24)
Nov  6 20:29:56 lambda kernel:  [do_divide_error+0/330]
do_divide_error+0x0/0x14a (40)
Nov  6 20:29:56 lambda kernel:  [<c0104d83>] do_divide_error+0x0/0x14a (40)
Nov  6 20:29:56 lambda kernel:  [do_page_fault+920/1425]
do_page_fault+0x398/0x591 (64)
Nov  6 20:29:56 lambda kernel:  [<c0111313>] do_page_fault+0x398/0x591 (64)
Nov  6 20:29:56 lambda kernel:  [preempt_schedule+80/106]
preempt_schedule+0x50/0x6a (80)
Nov  6 20:29:56 lambda kernel:  [<c02ac5ab>] preempt_schedule+0x50/0x6a (80)
Nov  6 20:29:56 lambda kernel:  [queue_work+44/101] queue_work+0x2c/0x65 (20)
Nov  6 20:29:56 lambda kernel:  [<c0125d66>] queue_work+0x2c/0x65 (20)
Nov  6 20:29:56 lambda kernel:  [call_usermodehelper+274/316]
call_usermodehelper+0x112/0x13c (24)
Nov  6 20:29:56 lambda kernel:  [<c0125caa>]
call_usermodehelper+0x112/0x13c (24)
Nov  6 20:29:56 lambda kernel:  [__call_usermodehelper+0/72]
__call_usermodehelper+0x0/0x48 (20)
Nov  6 20:29:56 lambda kernel:  [<c0125b50>]
__call_usermodehelper+0x0/0x48 (20)
Nov  6 20:29:56 lambda kernel:  [do_page_fault+0/1425]
do_page_fault+0x0/0x591 (52)
Nov  6 20:29:56 lambda kernel:  [<c0110f7b>] do_page_fault+0x0/0x591 (52)
Nov  6 20:29:56 lambda kernel:  [error_code+45/56] error_code+0x2d/0x38 (8)
Nov  6 20:29:56 lambda kernel:  [<c010461d>] error_code+0x2d/0x38 (8)
Nov  6 20:29:56 lambda kernel:  [__up_write+109/721] __up_write+0x6d/0x2d1
(52)
Nov  6 20:29:56 lambda kernel:  [<c012ae47>] __up_write+0x6d/0x2d1 (52)
Nov  6 20:29:56 lambda kernel:  [invalidate_inode_buffers+26/240]
invalidate_inode_buffers+0x1a/0xf0 (12)
Nov  6 20:29:56 lambda kernel:  [<c015258f>]
invalidate_inode_buffers+0x1a/0xf0 (12)
Nov  6 20:29:56 lambda kernel:  [up+80/173] up+0x50/0xad (56)
Nov  6 20:29:56 lambda kernel:  [<c012b957>] up+0x50/0xad (56)
Nov  6 20:29:56 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (36)
Nov  6 20:29:56 lambda kernel:  [<c01b1cef>] kobject_cleanup+0x8e/0x90 (36)
Nov  6 20:29:56 lambda kernel:  [kobject_release+0/8]
kobject_release+0x0/0x8 (8)
Nov  6 20:29:56 lambda kernel:  [<c01b1cf1>] kobject_release+0x0/0x8 (8)
Nov  6 20:29:56 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov  6 20:29:56 lambda kernel:  [<c01b2597>] kref_put+0x51/0xc2 (12)
Nov  6 20:29:56 lambda kernel:  [bus_remove_driver+63/72]
bus_remove_driver+0x3f/0x48 (36)
Nov  6 20:29:56 lambda kernel:  [<c01f79d2>] bus_remove_driver+0x3f/0x48 (36)
Nov  6 20:29:56 lambda kernel:  [driver_unregister+11/26]
driver_unregister+0xb/0x1a (8)
Nov  6 20:29:56 lambda kernel:  [<c01f7d44>] driver_unregister+0xb/0x1a (8)
Nov  6 20:29:56 lambda kernel:  [pci_unregister_driver+11/19]
pci_unregister_driver+0xb/0x13 (8)
Nov  6 20:29:56 lambda kernel:  [<c01b95e4>]
pci_unregister_driver+0xb/0x13 (8)
Nov  6 20:29:56 lambda kernel:  [sys_delete_module+287/299]
sys_delete_module+0x11f/0x12b (8)
Nov  6 20:29:56 lambda kernel:  [<c012d91f>] sys_delete_module+0x11f/0x12b
(8)
Nov  6 20:29:56 lambda kernel:  [unmap_vma_list+14/23]
unmap_vma_list+0xe/0x17 (20)
Nov  6 20:29:56 lambda kernel:  [<c0144c7d>] unmap_vma_list+0xe/0x17 (20)
Nov  6 20:29:56 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176
(12)
Nov  6 20:29:56 lambda kernel:  [<c0144f7a>] do_munmap+0x11a/0x176 (12)
Nov  6 20:29:56 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (36)
Nov  6 20:29:56 lambda kernel:  [<c014500e>] sys_munmap+0x38/0x45 (36)
Nov  6 20:29:56 lambda kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71 (12)
Nov  6 20:29:56 lambda kernel:  [<c0103bc1>] sysenter_past_esp+0x52/0x71 (12)
Nov  6 20:29:56 lambda kernel: BUG: scheduling while atomic:
rmmod/0x10000003/15965
Nov  6 20:29:56 lambda kernel: caller is __cond_resched+0x36/0x41
Nov  6 20:29:56 lambda kernel:  [__schedule+1194/1525]
__sched_text_start+0x4aa/0x5f5 (8)
Nov  6 20:29:56 lambda kernel:  [<c02ac2fa>]
__sched_text_start+0x4aa/0x5f5 (8)
Nov  6 20:29:56 lambda kernel:  [do_exit+328/1202] do_exit+0x148/0x4b2 (36)
Nov  6 20:29:56 lambda kernel:  [<c0118d72>] do_exit+0x148/0x4b2 (36)
Nov  6 20:29:56 lambda kernel:  [down_write_mutex+333/518]
down_write_mutex+0x14d/0x206 (4)
Nov  6 20:29:56 lambda kernel:  [<c02ad5f9>] down_write_mutex+0x14d/0x206 (4)
Nov  6 20:29:56 lambda kernel:  [remove_vm_struct+93/129]
remove_vm_struct+0x5d/0x81 (8)
Nov  6 20:29:56 lambda kernel:  [<c0143446>] remove_vm_struct+0x5d/0x81 (8)
Nov  6 20:29:56 lambda kernel:  [__cond_resched+54/65]
__cond_resched+0x36/0x41 (32)
Nov  6 20:29:56 lambda kernel:  [<c0113715>] __cond_resched+0x36/0x41 (32)
Nov  6 20:29:56 lambda kernel:  [cond_resched+28/37]
cond_resched+0x1c/0x25 (12)
Nov  6 20:29:56 lambda kernel:  [<c02acedb>] cond_resched+0x1c/0x25 (12)
Nov  6 20:29:56 lambda kernel:  [put_files_struct+146/269]
put_files_struct+0x92/0x10d (8)
Nov  6 20:29:56 lambda kernel:  [<c0117ec3>] put_files_struct+0x92/0x10d (8)
Nov  6 20:29:56 lambda kernel:  [do_exit+352/1202] do_exit+0x160/0x4b2 (32)
Nov  6 20:29:56 lambda kernel:  [<c0118d8a>] do_exit+0x160/0x4b2 (32)
Nov  6 20:29:56 lambda kernel:  [do_divide_error+0/330]
do_divide_error+0x0/0x14a (40)
Nov  6 20:29:56 lambda kernel:  [<c0104d83>] do_divide_error+0x0/0x14a (40)
Nov  6 20:29:56 lambda kernel:  [do_page_fault+920/1425]
do_page_fault+0x398/0x591 (64)
Nov  6 20:29:56 lambda kernel:  [<c0111313>] do_page_fault+0x398/0x591 (64)
Nov  6 20:29:56 lambda kernel:  [preempt_schedule+80/106]
preempt_schedule+0x50/0x6a (80)
Nov  6 20:29:56 lambda kernel:  [<c02ac5ab>] preempt_schedule+0x50/0x6a (80)
Nov  6 20:29:56 lambda kernel:  [queue_work+44/101] queue_work+0x2c/0x65 (20)
Nov  6 20:29:56 lambda kernel:  [<c0125d66>] queue_work+0x2c/0x65 (20)
Nov  6 20:29:56 lambda kernel:  [call_usermodehelper+274/316]
call_usermodehelper+0x112/0x13c (24)
Nov  6 20:29:56 lambda kernel: aa>] call_usermodehelper+0x112/0x13c (24)
Nov  6 20:29:56 lambda kernel:  [__call_usermodehelper+0/72]
__call_usermodehelper+0x0/0x48 (20)
Nov  6 20:29:56 lambda kernel:  [<c0125b50>]
__call_usermodehelper+0x0/0x48 (20)
Nov  6 20:29:56 lambda kernel:  [do_page_fault+0/1425]
do_page_fault+0x0/0x591 (52)
Nov  6 20:29:56 lambda kernel:  [<c0110f7b>] do_page_fault+0x0/0x591 (52)
Nov  6 20:29:56 lambda kernel:  [error_code+45/56] error_code+0x2d/0x38 (8)
Nov  6 20:29:56 lambda kernel:  [<c010461d>] error_code+0x2d/0x38 (8)
Nov  6 20:29:56 lambda kernel:  [__up_write+109/721] __up_write+0x6d/0x2d1
(52)
Nov  6 20:29:56 lambda kernel:  [<c012ae47>] __up_write+0x6d/0x2d1 (52)
Nov  6 20:29:56 lambda kernel:  [invalidate_inode_buffers+26/240]
invalidate_inode_buffers+0x1a/0xf0 (12)
Nov  6 20:29:56 lambda kernel:  [<c015258f>]
invalidate_inode_buffers+0x1a/0xf0 (12)
Nov  6 20:29:56 lambda kernel:  [up+80/173] up+0x50/0xad (56)
Nov  6 20:29:56 lambda kernel:  [<c012b957>] up+0x50/0xad (56)
Nov  6 20:29:56 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (36)
Nov  6 20:29:56 lambda kernel:  [<c01b1cef>] kobject_cleanup+0x8e/0x90 (36)
Nov  6 20:29:56 lambda kernel:  [kobject_release+0/8]
kobject_release+0x0/0x8 (8)
Nov  6 20:29:56 lambda kernel:  [<c01b1cf1>] kobject_release+0x0/0x8 (8)
Nov  6 20:29:56 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov  6 20:29:56 lambda kernel:  [<c01b2597>] kref_put+0x51/0xc2 (12)
Nov  6 20:29:56 lambda kernel:  [bus_remove_driver+63/72]
bus_remove_driver+0x3f/0x48 (36)
Nov  6 20:29:56 lambda kernel:  [<c01f79d2>] bus_remove_driver+0x3f/0x48 (36)
Nov  6 20:29:56 lambda kernel:  [driver_unregister+11/26]
driver_unregister+0xb/0x1a (8)
Nov  6 20:29:56 lambda kernel:  [<c01f7d44>] driver_unregister+0xb/0x1a (8)
Nov  6 20:29:56 lambda kernel:  [pci_unregister_driver+11/19]
pci_unregister_driver+0xb/0x13 (8)
Nov  6 20:29:56 lambda kernel:  [<c01b95e4>]
pci_unregister_driver+0xb/0x13 (8)
Nov  6 20:29:56 lambda kernel:  [sys_delete_module+287/299]
sys_delete_module+0x11f/0x12b (8)
Nov  6 20:29:56 lambda kernel:  [<c012d91f>] sys_delete_module+0x11f/0x12b
(8)
Nov  6 20:29:56 lambda kernel:  [unmap_vma_list+14/23]
unmap_vma_list+0xe/0x17 (20)
Nov  6 20:29:56 lambda kernel:  [<c0144c7d>] unmap_vma_list+0xe/0x17 (20)
Nov  6 20:29:56 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176
(12)
Nov  6 20:29:56 lambda kernel:  [<c0144f7a>] do_munmap+0x11a/0x176 (12)
Nov  6 20:29:56 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (36)
Nov  6 20:29:56 lambda kernel:  [<c014500e>] sys_munmap+0x38/0x45 (36)
Nov  6 20:29:56 lambda kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71 (12)
Nov  6 20:29:56 lambda kernel:  [<c0103bc1>] sysenter_past_esp+0x52/0x71 (12)
Nov  6 20:29:56 lambda kernel: BUG: scheduling while atomic:
rmmod/0x00000003/15965
Nov  6 20:29:56 lambda kernel: caller is do_exit+0x289/0x4b2
Nov  6 20:29:56 lambda kernel:  [__schedule+1194/1525]
__sched_text_start+0x4aa/0x5f5 (8)
Nov  6 20:29:56 lambda kernel:  [<c02ac2fa>]
__sched_text_start+0x4aa/0x5f5 (8)
Nov  6 20:29:56 lambda kernel:  [exit_notify+1154/2290]
exit_notify+0x482/0x8f2 (24)
Nov  6 20:29:56 lambda kernel:  [<c01187ba>] exit_notify+0x482/0x8f2 (24)
Nov  6 20:29:56 lambda kernel:  [kmem_cache_free+72/197]
kmem_cache_free+0x48/0xc5 (24)
Nov  6 20:29:56 lambda kernel:  [<c013bd6d>] kmem_cache_free+0x48/0xc5 (24)
Nov  6 20:29:56 lambda kernel:  [do_exit+649/1202] do_exit+0x289/0x4b2 (32)
Nov  6 20:29:56 lambda kernel:  [<c0118eb3>] do_exit+0x289/0x4b2 (32)
Nov  6 20:29:56 lambda kernel:  [do_divide_error+0/330]
do_divide_error+0x0/0x14a (40)
Nov  6 20:29:56 lambda kernel:  [<c0104d83>] do_divide_error+0x0/0x14a (40)
Nov  6 20:29:56 lambda kernel:  [do_page_fault+920/1425]
do_page_fault+0x398/0x591 (64)
Nov  6 20:29:56 lambda kernel:  [<c0111313>] do_page_fault+0x398/0x591 (64)
Nov  6 20:29:56 lambda kernel:  [preempt_schedule+80/106]
preempt_schedule+0x50/0x6a (80)
Nov  6 20:29:56 lambda kernel:  [<c02ac5ab>] preempt_schedule+0x50/0x6a (80)
Nov  6 20:29:56 lambda kernel:  [queue_work+44/101] queue_work+0x2c/0x65 (20)
Nov  6 20:29:56 lambda kernel:  [<c0125d66>] queue_work+0x2c/0x65 (20)
Nov  6 20:29:56 lambda kernel:  [call_usermodehelper+274/316]
call_usermodehelper+0x112/0x13c (24)
Nov  6 20:29:56 lambda kernel:  [<c0125caa>]
call_usermodehelper+0x112/0x13c (24)
Nov  6 20:29:56 lambda kernel:  [__call_usermodehelper+0/72]
__call_usermodehelper+0x0/0x48 (20)
Nov  6 20:29:56 lambda kernel:  [<c0125b50>]
__call_usermodehelper+0x0/0x48 (20)
Nov  6 20:29:56 lambda kernel:  [do_page_fault+0/1425]
do_page_fault+0x0/0x591 (52)
Nov  6 20:29:56 lambda kernel:  [<c0110f7b>] do_page_fault+0x0/0x591 (52)
Nov  6 20:29:56 lambda kernel:  [error_code+45/56] error_code+0x2d/0x38 (8)
Nov  6 20:29:56 lambda kernel:  [<c010461d>] error_code+0x2d/0x38 (8)
Nov  6 20:29:56 lambda kernel:  [__up_write+109/721] __up_write+0x6d/0x2d1
(52)
Nov  6 20:29:56 lambda kernel:  [<c012ae47>] __up_write+0x6d/0x2d1 (52)
Nov  6 20:29:56 lambda kernel:  [invalidate_inode_buffers+26/240]
invalidate_inode_buffers+0x1a/0xf0 (12)
Nov  6 20:29:56 lambda kernel:  [<c015258f>]
invalidate_inode_buffers+0x1a/0xf0 (12)
Nov  6 20:29:56 lambda kernel:  [up+80/173] up+0x50/0xad (56)
Nov  6 20:29:56 lambda kernel:  [<c012b957>] up+0x50/0xad (56)
Nov  6 20:29:56 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (36)
Nov  6 20:29:56 lambda kernel:  [<c01b1cef>] kobject_cleanup+0x8e/0x90 (36)
Nov  6 20:29:56 lambda kernel:  [kobject_release+0/8]
kobject_release+0x0/0x8 (8)
Nov  6 20:29:56 lambda kernel:  [<c01b1cf1>] kobject_release+0x0/0x8 (8)
Nov  6 20:29:56 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov  6 20:29:56 lambda kernel:  [<c01b2597>] kref_put+0x51/0xc2 (12)
Nov  6 20:29:56 lambda kernel:  [bus_remove_driver+63/72]
bus_remove_driver+0x3f/0x48 (36)
Nov  6 20:29:56 lambda kernel:  [<c01f79d2>] bus_remove_driver+0x3f/0x48 (36)
Nov  6 20:29:56 lambda kernel:  [driver_unregister+11/26]
driver_unregister+0xb/0x1a (8)
Nov  6 20:29:56 lambda kernel:  [<c01f7d44>] driver_unregister+0xb/0x1a (8)
Nov  6 20:29:56 lambda kernel:  [pci_unregister_driver+11/19]
pci_unregister_driver+0xb/0x13 (8)
Nov  6 20:29:56 lambda kernel:  [<c01b95e4>]
pci_unregister_driver+0xb/0x13 (8)
Nov  6 20:29:56 lambda kernel:  [sys_delete_module+287/299]
sys_delete_module+0x11f/0x12b (8)
Nov  6 20:29:56 lambda kernel:  [<c012d91f>] sys_delete_module+0x11f/0x12b
(8)
Nov  6 20:29:56 lambda kernel:  [unmap_vma_list+14/23]
unmap_vma_list+0xe/0x17 (20)
Nov  6 20:29:56 lambda kernel:  [<c0144c7d>] unmap_vma_list+0xe/0x17 (20)
Nov  6 20:29:56 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176
(12)
Nov  6 20:29:56 lambda kernel:  [<c0144f7a>] do_munmap+0x11a/0x176 (12)
Nov  6 20:29:56 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (36)
Nov  6 20:29:56 lambda kernel:  [<c014500e>] sys_munmap+0x38/0x45 (36)
Nov  6 20:29:56 lambda kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71 (12)
Nov  6 20:29:56 lambda kernel:  [<c0103bc1>] sysenter_past_esp+0x52/0x71 (12)
Nov  6 20:29:56 lambda alsa:  succeeded
Nov  6 20:29:56 lambda rc: Stopping alsa:  succeeded

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

