Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbUKROt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbUKROt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 09:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUKROtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 09:49:31 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:51593 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262108AbUKROsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 09:48:53 -0500
Message-ID: <49222.195.245.190.94.1100789179.squirrel@195.245.190.94>
In-Reply-To: <20041118123521.GA29091@elte.hu>
References: <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu>
    <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu>
    <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu>
    <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu>
    <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
    <20041118123521.GA29091@elte.hu>
Date: Thu, 18 Nov 2004 14:46:19 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 18 Nov 2004 14:48:50.0522 (UTC) FILETIME=[B76D5BA0:01C4CD7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> i have released the -V0.7.28-1 Real-Time Preemption patch, which can be
> downloaded from the usual place:
>
> 	http://redhat.com/~mingo/realtime-preempt/
>
> this should fix the lockup bug reported by Florian Schmidt.
>


I'm still seeing this sometimes (not everytime) on my P4/UP laptop while
shutting down ALSA modules. This isn't the same as the lockup I've been
reporting lately (that happens on my P4/SMT desktop) but may be remotely
related.


Nov 18 12:22:21 lambda kernel: BUG: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Nov 18 12:22:21 lambda kernel:  printing eip:
Nov 18 12:22:21 lambda kernel: c0129a4b
Nov 18 12:22:21 lambda kernel: *pde = 00000000
Nov 18 12:22:21 lambda kernel: Oops: 0000 [#1]
Nov 18 12:22:21 lambda kernel: PREEMPT
Nov 18 12:22:21 lambda kernel: Modules linked in: realtime commoncap
snd_ali5451 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd soundcore
pcmcia yenta_socket pcmcia_core natsemi crc32 loop evdev ohci_hcd usbcore
Nov 18 12:22:21 lambda kernel: CPU:    0
Nov 18 12:22:21 lambda kernel: EIP:    0060:[__up_mutex+59/384]    Not
tainted VLI
Nov 18 12:22:21 lambda kernel: EIP:    0060:[<c0129a4b>]    Not tainted VLI
Nov 18 12:22:21 lambda kernel: EFLAGS: 00010006  
(2.6.10-rc2-mm1-RT-V0.7.28-1)
Nov 18 12:22:21 lambda kernel: EIP is at __up_mutex+0x3b/0x180
Nov 18 12:22:21 lambda kernel: eax: 00000000   ebx: d70c2000   ecx:
de2510d0   edx: 00000063
Nov 18 12:22:21 lambda kernel: esi: de2510d0   edi: e00f2894   ebp:
c02fa090   esp: d70c3ef0
Nov 18 12:22:21 lambda kernel: ds: 007b   es: 007b   ss: 0068   preempt:
00000004
Nov 18 12:22:21 lambda kernel: Process rmmod (pid: 6836,
threadinfo=d70c2000 task=dca7ad70)
Nov 18 12:22:21 lambda kernel: Stack: 00000282 c0139cdc 00000286 00000282
c01ad4cb 00000000 d70c2000 c0301908
Nov 18 12:22:21 lambda kernel:        c02fa080 c02fa090 c012a165 e00f28a4
c01ad4cb e00f28bc c01ad4cd bfffd3f0
Nov 18 12:22:21 lambda kernel:        d70c2000 c01adadf e00f28a4 00000000
bfffd3f0 d70c2000 e00f28a4 00000000
Nov 18 12:22:21 lambda kernel: Call Trace:
Nov 18 12:22:21 lambda kernel:  [kmem_cache_free+74/199]
kmem_cache_free+0x4a/0xc7 (8)
Nov 18 12:22:21 lambda kernel:  [<c0139cdc>] kmem_cache_free+0x4a/0xc7 (8)
Nov 18 12:22:21 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (12)
Nov 18 12:22:21 lambda kernel:  [<c01ad4cb>] kobject_cleanup+0x8e/0x90 (12)
Nov 18 12:22:21 lambda kernel:  [up+53/61] up+0x35/0x3d (24)
Nov 18 12:22:21 lambda kernel:  [<c012a165>] up+0x35/0x3d (24)
Nov 18 12:22:21 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (8)
Nov 18 12:22:21 lambda kernel:  [<c01ad4cb>] kobject_cleanup+0x8e/0x90 (8)
Nov 18 12:22:21 lambda kernel:  [kobject_release+0/8]
kobject_release+0x0/0x8 (8)
Nov 18 12:22:21 lambda kernel:  [<c01ad4cd>] kobject_release+0x0/0x8 (8)
Nov 18 12:22:21 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov 18 12:22:21 lambda kernel:  [<c01adadf>] kref_put+0x51/0xc2 (12)
Nov 18 12:22:21 lambda kernel:  [bus_remove_driver+63/72]
bus_remove_driver+0x3f/0x48 (36)
Nov 18 12:22:21 lambda kernel:  [<c01f3aff>] bus_remove_driver+0x3f/0x48 (36)
Nov 18 12:22:21 lambda kernel:  [driver_unregister+11/26]
driver_unregister+0xb/0x1a (8)
Nov 18 12:22:21 lambda kernel:  [<c01f3e98>] driver_unregister+0xb/0x1a (8)
Nov 18 12:22:21 lambda kernel:  [pci_unregister_driver+11/19]
pci_unregister_driver+0xb/0x13 (8)
Nov 18 12:22:21 lambda kernel:  [<c01b4b10>]
pci_unregister_driver+0xb/0x13 (8)
Nov 18 12:22:21 lambda kernel:  [sys_delete_module+292/304]
sys_delete_module+0x124/0x130 (8)
Nov 18 12:22:21 lambda kernel:  [<c012c044>] sys_delete_module+0x124/0x130
(8)
Nov 18 12:22:21 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176
(32)
Nov 18 12:22:21 lambda kernel:  [<c01431b3>] do_munmap+0x11a/0x176 (32)
Nov 18 12:22:21 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (12)
Nov 18 12:22:21 lambda kernel:  [<c0143247>] sys_munmap+0x38/0x45 (12)
Nov 18 12:22:21 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (24)
Nov 18 12:22:21 lambda kernel:  [<c0143247>] sys_munmap+0x38/0x45 (24)
Nov 18 12:22:21 lambda kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71 (12)
Nov 18 12:22:21 lambda kernel:  [<c01023f1>] sysenter_past_esp+0x52/0x71 (12)
Nov 18 12:22:21 lambda kernel: Code: 10 9c 8f 44 24 08 fa 9c 58 b8 00 e0
ff ff 21 e0 83 40 14 01 83 40 14 01 8b 47 08 e8 50 7f fe ff 8b 77 08 89 c2
8b 86 48 05 00 00 <8b> 08 0f 18 01 90 8d 9e 48 05 00 00 eb 10 8b 40 0c 39
d0 0f 4c
Nov 18 12:22:21 lambda kernel:  <6>note: rmmod[6836] exited with
preempt_count 3
Nov 18 12:22:21 lambda kernel: BUG: scheduling while atomic:
rmmod/0x00000003/6836
Nov 18 12:22:21 lambda kernel: caller is do_exit+0x2a5/0x4ce
Nov 18 12:22:21 lambda kernel:  [__schedule+1155/1484]
__sched_text_start+0x483/0x5cc (8)
Nov 18 12:22:21 lambda kernel:  [<c02a6507>]
__sched_text_start+0x483/0x5cc (8)
Nov 18 12:22:21 lambda kernel:  [exit_notify+1154/2281]
exit_notify+0x482/0x8e9 (24)
Nov 18 12:22:21 lambda kernel:  [<c011743a>] exit_notify+0x482/0x8e9 (24)
Nov 18 12:22:21 lambda kernel:  [do_exit+677/1230] do_exit+0x2a5/0x4ce (56)
Nov 18 12:22:21 lambda kernel:  [<c0117b46>] do_exit+0x2a5/0x4ce (56)
Nov 18 12:22:21 lambda kernel:  [do_divide_error+0/320]
do_divide_error+0x0/0x140 (48)
Nov 18 12:22:21 lambda kernel:  [<c01035a9>] do_divide_error+0x0/0x140 (48)
Nov 18 12:22:21 lambda kernel:  [do_page_fault+865/1341]
do_page_fault+0x361/0x53d (64)
Nov 18 12:22:21 lambda kernel:  [<c010fc18>] do_page_fault+0x361/0x53d (64)
Nov 18 12:22:21 lambda kernel:  [call_usermodehelper+346/364]
call_usermodehelper+0x15a/0x16c (72)
Nov 18 12:22:21 lambda kernel:  [<c012493e>]
call_usermodehelper+0x15a/0x16c (72)
Nov 18 12:22:21 lambda kernel:  [__call_usermodehelper+0/72]
__call_usermodehelper+0x0/0x48 (56)
Nov 18 12:22:21 lambda kernel:  [<c012479c>]
__call_usermodehelper+0x0/0x48 (56)
Nov 18 12:22:21 lambda kernel:  [__down_mutex+73/322]
__down_mutex+0x49/0x142 (16)
Nov 18 12:22:21 lambda kernel:  [<c02a7600>] __down_mutex+0x49/0x142 (16)
Nov 18 12:22:21 lambda kernel:  [dput+121/657] dput+0x79/0x291 (4)
Nov 18 12:22:21 lambda kernel:  [<c0165899>] dput+0x79/0x291 (4)
Nov 18 12:22:21 lambda kernel:  [kfree+81/237] kfree+0x51/0xed (28)
Nov 18 12:22:21 lambda kernel:  [<c0139e0e>] kfree+0x51/0xed (28)
Nov 18 12:22:21 lambda kernel:  [do_page_fault+0/1341]
do_page_fault+0x0/0x53d (28)
Nov 18 12:22:21 lambda kernel:  [<c010f8b7>] do_page_fault+0x0/0x53d (28)
Nov 18 12:22:21 lambda kernel:  [error_code+43/48] error_code+0x2b/0x30 (8)
Nov 18 12:22:21 lambda kernel:  [<c0102e57>] error_code+0x2b/0x30 (8)
Nov 18 12:22:21 lambda kernel:  [locate_fd+56/137] locate_fd+0x38/0x89 (32)
Nov 18 12:22:21 lambda kernel:  [<c016007b>] locate_fd+0x38/0x89 (32)
Nov 18 12:22:21 lambda kernel:  [__up_mutex+59/384] __up_mutex+0x3b/0x180
(12)
Nov 18 12:22:21 lambda kernel:  [<c0129a4b>] __up_mutex+0x3b/0x180 (12)
Nov 18 12:22:21 lambda kernel:  [kmem_cache_free+74/199]
kmem_cache_free+0x4a/0xc7 (16)
Nov 18 12:22:21 lambda kernel:  [<c0139cdc>] kmem_cache_free+0x4a/0xc7 (16)
Nov 18 12:22:21 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (12)
Nov 18 12:22:21 lambda kernel:  [<c01ad4cb>] kobject_cleanup+0x8e/0x90 (12)
Nov 18 12:22:21 lambda kernel:  [up+53/61] up+0x35/0x3d (24)
Nov 18 12:22:21 lambda kernel:  [<c012a165>] up+0x35/0x3d (24)
Nov 18 12:22:21 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (8)
Nov 18 12:22:21 lambda kernel:  [<c01ad4cb>] kobject_cleanup+0x8e/0x90 (8)
Nov 18 12:22:21 lambda kernel:  [kobject_release+0/8]
kobject_release+0x0/0x8 (8)
Nov 18 12:22:21 lambda kernel:  [<c01ad4cd>] kobject_release+0x0/0x8 (8)
Nov 18 12:22:21 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov 18 12:22:21 lambda kernel:  [<c01adadf>] kref_put+0x51/0xc2 (12)
Nov 18 12:22:21 lambda kernel:  [bus_remove_driver+63/72]
bus_remove_driver+0x3f/0x48 (36)
Nov 18 12:22:21 lambda kernel:  [<c01f3aff>] bus_remove_driver+0x3f/0x48 (36)
Nov 18 12:22:21 lambda kernel:  [driver_unregister+11/26]
driver_unregister+0xb/0x1a (8)
Nov 18 12:22:21 lambda kernel:  [<c01f3e98>] driver_unregister+0xb/0x1a (8)
Nov 18 12:22:21 lambda kernel:  [pci_unregister_driver+11/19]
pci_unregister_driver+0xb/0x13 (8)
Nov 18 12:22:21 lambda kernel:  [<c01b4b10>]
pci_unregister_driver+0xb/0x13 (8)
Nov 18 12:22:21 lambda kernel:  [sys_delete_module+292/304]
sys_delete_module+0x124/0x130 (8)
Nov 18 12:22:21 lambda kernel:  [<c012c044>] sys_delete_module+0x124/0x130
(8)
Nov 18 12:22:21 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176
(32)
Nov 18 12:22:21 lambda kernel:  [<c01431b3>] do_munmap+0x11a/0x176 (32)
Nov 18 12:22:21 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (12)
Nov 18 12:22:21 lambda kernel:  [<c0143247>] sys_munmap+0x38/0x45 (12)
Nov 18 12:22:21 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (24)
Nov 18 12:22:21 lambda kernel:  [<c0143247>] sys_munmap+0x38/0x45 (24)
Nov 18 12:22:21 lambda kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71 (12)
Nov 18 12:22:21 lambda kernel:  [<c01023f1>] sysenter_past_esp+0x52/0x71 (12)
Nov 18 12:22:21 lambda kernel: Kernel logging (proc) stopped.
Nov 18 12:22:21 lambda kernel: Kernel log daemon terminating.
Nov 18 12:22:22 lambda exiting on signal 15


Another one, a couple of times later:

Nov 18 13:21:59 lambda alsa: Shutting down ALSA sound driver (version 1.0.7):
Nov 18 13:22:01 lambda kernel: usbcore: deregistering driver snd-usb-usx2y
Nov 18 13:22:01 lambda alsa: /etc/rc0.d/K70alsa: line 287:  5700
Segmentation fault      /sbin/rmmod `echo $line | cut -d ' ' -f 1`
>/dev/null 2>&1
Nov 18 13:22:03 lambda kernel: BUG: Unable to handle kernel paging request
at virtual address f39d2483
Nov 18 13:22:03 lambda kernel:  printing eip:
Nov 18 13:22:03 lambda kernel: c0129a4b
Nov 18 13:22:03 lambda kernel: *pde = 00000000
Nov 18 13:22:03 lambda kernel: Oops: 0000 [#1]
Nov 18 13:22:03 lambda kernel: PREEMPT
Nov 18 13:22:03 lambda kernel: Modules linked in: realtime commoncap
snd_usb_usx2y snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep snd_ali5451
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd soundcore prism2_cs
p80211 pcmcia pcmcia_core natsemi crc32 loop subfs evdev ohci_hcd usbcore
Nov 18 13:22:03 lambda kernel: CPU:    0
Nov 18 13:22:03 lambda kernel: EIP:    0060:[__up_mutex+59/384]    Not
tainted VLI
Nov 18 13:22:03 lambda kernel: EIP:    0060:[<c0129a4b>]    Not tainted VLI
Nov 18 13:22:03 lambda kernel: EFLAGS: 00010093  
(2.6.10-rc2-mm1-RT-V0.7.28-1)
Nov 18 13:22:03 lambda kernel: EIP is at __up_mutex+0x3b/0x180
Nov 18 13:22:03 lambda kernel: eax: f39d2483   ebx: deb66000   ecx:
deaae1b0   edx: a1a407da
Nov 18 13:22:03 lambda kernel: esi: deaae1b0   edi: e010b58c   ebp:
e00609b0   esp: deb67ee4
Nov 18 13:22:03 lambda kernel: ds: 007b   es: 007b   ss: 0068   preempt:
00000004
Nov 18 13:22:03 lambda kernel: Process rmmod (pid: 5700,
threadinfo=deb66000 task=de5c5450)
Nov 18 13:22:03 lambda kernel: Stack: 00000296 c0139cdc 00000286 00000296
c01ad4cb 00000000 deb66000 c0301908
Nov 18 13:22:03 lambda kernel:        e00609a0 e00609b0 c012a165 e010b59c
c01ad4cb e010b5b4 c01ad4cd bfffd3f0
Nov 18 13:22:03 lambda kernel:        deb66000 c01adadf e010b59c 00000000
bfffd3f0 deb66000 e010b59c 00000000
Nov 18 13:22:03 lambda kernel: Call Trace:
Nov 18 13:22:03 lambda kernel:  [kmem_cache_free+74/199]
kmem_cache_free+0x4a/0xc7 (8)
Nov 18 13:22:03 lambda kernel:  [<c0139cdc>] kmem_cache_free+0x4a/0xc7 (8)
Nov 18 13:22:03 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (12)
Nov 18 13:22:03 lambda kernel:  [<c01ad4cb>] kobject_cleanup+0x8e/0x90 (12)
Nov 18 13:22:03 lambda kernel:  [up+53/61] up+0x35/0x3d (24)
Nov 18 13:22:03 lambda kernel:  [<c012a165>] up+0x35/0x3d (24)
Nov 18 13:22:03 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (8)
Nov 18 13:22:03 lambda kernel:  [<c01ad4cb>] kobject_cleanup+0x8e/0x90 (8)
Nov 18 13:22:03 lambda kernel:  [kobject_release+0/8]
kobject_release+0x0/0x8 (8)
Nov 18 13:22:03 lambda kernel:  [<c01ad4cd>] kobject_release+0x0/0x8 (8)
Nov 18 13:22:03 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov 18 13:22:03 lambda kernel:  [<c01adadf>] kref_put+0x51/0xc2 (12)
Nov 18 13:22:03 lambda kernel:  [bus_remove_driver+63/72]
bus_remove_driver+0x3f/0x48 (36)
Nov 18 13:22:03 lambda kernel:  [<c01f3aff>] bus_remove_driver+0x3f/0x48 (36)
Nov 18 13:22:03 lambda kernel:  [driver_unregister+11/26]
driver_unregister+0xb/0x1a (8)
Nov 18 13:22:03 lambda kernel:  [<c01f3e98>] driver_unregister+0xb/0x1a (8)
Nov 18 13:22:03 lambda kernel:  [pg0+533373460/1069945856]
usb_deregister+0x31/0x3f [usbcore] (8)
Nov 18 13:22:03 lambda kernel:  [<e0047214>] usb_deregister+0x31/0x3f
[usbcore] (8)
Nov 18 13:22:03 lambda kernel:  [sys_delete_module+292/304]
sys_delete_module+0x124/0x130 (20)
Nov 18 13:22:03 lambda kernel:  [<c012c044>] sys_delete_module+0x124/0x130
(20)
Nov 18 13:22:03 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176
(32)
Nov 18 13:22:03 lambda kernel:  [<c01431b3>] do_munmap+0x11a/0x176 (32)
Nov 18 13:22:03 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (12)
Nov 18 13:22:03 lambda kernel:  [<c0143247>] sys_munmap+0x38/0x45 (12)
Nov 18 13:22:03 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (24)
Nov 18 13:22:03 lambda kernel:  [<c0143247>] sys_munmap+0x38/0x45 (24)
Nov 18 13:22:03 lambda kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71 (12)
Nov 18 13:22:03 lambda kernel:  [<c01023f1>] sysenter_past_esp+0x52/0x71 (12)
Nov 18 13:22:03 lambda kernel: Code: 10 9c 8f 44 24 08 fa 9c 58 b8 00 e0
ff ff 21 e0 83 40 14 01 83 40 14 01 8b 47 08 e8 50 7f fe ff 8b 77 08 89 c2
8b 86 48 05 00 00 <8b> 08 0f 18 01 90 8d 9e 48 05 00 00 eb 10 8b 40 0c 39
d0 0f 4c
Nov 18 13:22:03 lambda kernel:  <6>note: rmmod[5700] exited with
preempt_count 3
Nov 18 13:22:03 lambda kernel: BUG: scheduling while atomic:
rmmod/0x00000003/5700
Nov 18 13:22:03 lambda kernel: caller is do_exit+0x2a5/0x4ce
Nov 18 13:22:03 lambda kernel:  [__schedule+1155/1484]
__sched_text_start+0x483/0x5cc (8)
Nov 18 13:22:03 lambda kernel:  [<c02a6507>]
__sched_text_start+0x483/0x5cc (8)
Nov 18 13:22:03 lambda kernel:  [exit_notify+1154/2281]
exit_notify+0x482/0x8e9 (24)
Nov 18 13:22:03 lambda kernel:  [<c011743a>] exit_notify+0x482/0x8e9 (24)
Nov 18 13:22:03 lambda kernel:  [do_exit+677/1230] do_exit+0x2a5/0x4ce (56)
Nov 18 13:22:03 lambda kernel:  [<c0117b46>] do_exit+0x2a5/0x4ce (56)
Nov 18 13:22:03 lambda kernel:  [do_divide_error+0/320]
do_divide_error+0x0/0x140 (48)
Nov 18 13:22:03 lambda kernel:  [<c01035a9>] do_divide_error+0x0/0x140 (48)
Nov 18 13:22:03 lambda kernel:  [do_page_fault+865/1341]
do_page_fault+0x361/0x53d (64)
Nov 18 13:22:03 lambda kernel:  [<c010fc18>] do_page_fault+0x361/0x53d (64)
Nov 18 13:22:03 lambda kernel:  [call_usermodehelper+346/364]
call_usermodehelper+0x15a/0x16c (72)
Nov 18 13:22:03 lambda kernel:  [<c012493e>]
call_usermodehelper+0x15a/0x16c (72)
Nov 18 13:22:03 lambda kernel:  [__schedule+662/1484]
__sched_text_start+0x296/0x5cc (40)
Nov 18 13:22:03 lambda kernel:  [<c02a631a>]
__sched_text_start+0x296/0x5cc (40)
Nov 18 13:22:03 lambda kernel:  [__call_usermodehelper+0/72]
__call_usermodehelper+0x0/0x48 (16)
Nov 18 13:22:03 lambda kernel:  [<c012479c>]
__call_usermodehelper+0x0/0x48 (16)
Nov 18 13:22:03 lambda kernel:  [__down_mutex+73/322]
__down_mutex+0x49/0x142 (16)
Nov 18 13:22:03 lambda kernel:  [<c02a7600>] __down_mutex+0x49/0x142 (16)
Nov 18 13:22:03 lambda kernel:  [dput+121/657] dput+0x79/0x291 (4)
Nov 18 13:22:03 lambda kernel:  [<c0165899>] dput+0x79/0x291 (4)
Nov 18 13:22:03 lambda kernel:  [kfree+81/237] kfree+0x51/0xed (28)
Nov 18 13:22:03 lambda kernel:  [<c0139e0e>] kfree+0x51/0xed (28)
Nov 18 13:22:03 lambda kernel:  [do_page_fault+0/1341]
do_page_fault+0x0/0x53d (28)
Nov 18 13:22:03 lambda kernel:  [<c010f8b7>] do_page_fault+0x0/0x53d (28)
Nov 18 13:22:03 lambda kernel:  [error_code+43/48] error_code+0x2b/0x30 (8)
Nov 18 13:22:03 lambda kernel:  [<c0102e57>] error_code+0x2b/0x30 (8)
Nov 18 13:22:03 lambda kernel:  [locate_fd+56/137] locate_fd+0x38/0x89 (32)
Nov 18 13:22:03 lambda kernel:  [<c016007b>] locate_fd+0x38/0x89 (32)
Nov 18 13:22:03 lambda kernel:  [__up_mutex+59/384] __up_mutex+0x3b/0x180
(12)
Nov 18 13:22:03 lambda kernel:  [<c0129a4b>] __up_mutex+0x3b/0x180 (12)
Nov 18 13:22:03 lambda kernel:  [kmem_cache_free+74/199]
kmem_cache_free+0x4a/0xc7 (16)
Nov 18 13:22:03 lambda kernel:  [<c0139cdc>] kmem_cache_free+0x4a/0xc7 (16)
Nov 18 13:22:03 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (12)
Nov 18 13:22:03 lambda kernel:  [<c01ad4cb>] kobject_cleanup+0x8e/0x90 (12)
Nov 18 13:22:03 lambda kernel:  [up+53/61] up+0x35/0x3d (24)
Nov 18 13:22:03 lambda kernel:  [<c012a165>] up+0x35/0x3d (24)
Nov 18 13:22:03 lambda kernel:  [kobject_cleanup+142/144]
kobject_cleanup+0x8e/0x90 (8)
Nov 18 13:22:03 lambda kernel:  [<c01ad4cb>] kobject_cleanup+0x8e/0x90 (8)
Nov 18 13:22:03 lambda kernel:  [kobject_release+0/8]
kobject_release+0x0/0x8 (8)
Nov 18 13:22:03 lambda kernel:  [<c01ad4cd>] kobject_release+0x0/0x8 (8)
Nov 18 13:22:03 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov 18 13:22:03 lambda kernel:  [<c01adadf>] kref_put+0x51/0xc2 (12)
Nov 18 13:22:03 lambda kernel:  [bus_remove_driver+63/72]
bus_remove_driver+0x3f/0x48 (36)
Nov 18 13:22:03 lambda kernel:  [<c01f3aff>] bus_remove_driver+0x3f/0x48 (36)
Nov 18 13:22:03 lambda kernel:  [driver_unregister+11/26]
driver_unregister+0xb/0x1a (8)
Nov 18 13:22:03 lambda kernel:  [<c01f3e98>] driver_unregister+0xb/0x1a (8)
Nov 18 13:22:03 lambda kernel:  [pg0+533373460/1069945856]
usb_deregister+0x31/0x3f [usbcore] (8)
Nov 18 13:22:03 lambda kernel:  [<e0047214>] usb_deregister+0x31/0x3f
[usbcore] (8)
Nov 18 13:22:03 lambda kernel:  [sys_delete_module+292/304]
sys_delete_module+0x124/0x130 (20)
Nov 18 13:22:03 lambda kernel:  [<c012c044>] sys_delete_module+0x124/0x130
(20)
Nov 18 13:22:03 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176
(32)
Nov 18 13:22:03 lambda kernel:  [<c01431b3>] do_munmap+0x11a/0x176 (32)
Nov 18 13:22:03 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (12)
Nov 18 13:22:03 lambda kernel:  [<c0143247>] sys_munmap+0x38/0x45 (12)
Nov 18 13:22:03 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (24)
Nov 18 13:22:03 lambda kernel:  [<c0143247>] sys_munmap+0x38/0x45 (24)
Nov 18 13:22:03 lambda kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71 (12)
Nov 18 13:22:03 lambda kernel:  [<c01023f1>] sysenter_past_esp+0x52/0x71 (12)
Nov 18 13:22:03 lambda kernel: Kernel logging (proc) stopped.
Nov 18 13:22:03 lambda kernel: Kernel log daemon terminating.
Nov 18 13:22:04 lambda exiting on signal 15


Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

