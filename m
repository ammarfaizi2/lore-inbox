Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbUKOOid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbUKOOid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUKOOic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:38:32 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:1938 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261608AbUKOOfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:35:36 -0500
Message-ID: <61930.195.245.190.94.1100529227.squirrel@195.245.190.94>
Date: Mon, 15 Nov 2004 14:33:47 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
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
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       alsa-devel@lists.sourceforge.net
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041115143347_85895"
X-Priority: 3 (Normal)
Importance: Normal
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> 
               <20041025104023.GA1960@elte.hu>   
    <20041027001542.GA29295@elte.hu>            
    <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>       
         <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>   
             <20041109160544.GA28242@elte.hu>
    <20041111144414.GA8881@elte.hu>            
    <20041111215122.GA5885@elte.hu>
In-Reply-To: <20041111215122.GA5885@elte.hu>
X-OriginalArrivalTime: 15 Nov 2004 14:35:32.0441 (UTC) FILETIME=[5C7E9C90:01C4CB20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041115143347_85895
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Ingo Molnar wrote:
>
> i have released the -V0.7.25-1 Real-Time Preemption patch, which can be
> downloaded from the usual place:
>
>     http://redhat.com/~mingo/realtime-preempt/
>

Hi,

I've been running RT-0.7.26-3 already on both of my machines (P4/UP laptop
and P4/SMP-HT desktop) and I must say that overall stability seems to be
good.

However I still have some pending complaints ;) These are the ones that
are troubling my confidence:


  1) Almost everytime the P4/SMP box locks up while unloading the ALSA
modules e.g.on shutdown. This has been an issue for quite some time on the
latest RT patches, not exclusive to RT-V0.7.26-3. Probably it
started since the merge into -mm3, but not sure.

  One thing to note is that, when the nmi_watchdog=1 boot parameter is
set, this lockup behavior seem to be avoided.

  This isn't quite an issue on my other P4/UP (laptop), but it segfaults
sometimes too, while rmmod'ing the alsa modules. It doesn't lockup
thought, and the corresponding tracedump can be pasted from syslog (see
attachment). Unfortunately this is the only cross-evidence I could gather,
and hope it helps to a clue, just because...


  2) Serial console (or netconsole, if that matters) aren't showing
anything relevant for debugging; SysRq-T is just silent, only printing a
"Show State" one liner. No traces, no dumps.


  3) USB hotplugging is not working as it should be on my P4/UP laptop
(ohci_hcd), althought it seems to work on the P4/SMP-HT desktop
(uhci_hcd). USB devices are only recognized if and only if already plugged at
boot/init time; plugging in on a later time doesn't get listed by 'lsusb',
but a single 'wakeup' message shows _once_, and only once, on
syslog/dmesg.

  Unplugging and/or plugging in back again, gives you nothing not even
that 'wakeup' message. As reported a few days before, this really seem to
be introduced by -mm3 (and still an issue on -mm4, FWIW).

  I'm just asking for hints here, as one of the main uses of the RT kernel
on my laptop is about using a Tascam US-224 USB Audio/MIDI controller
interface, which is USB 1.1 based and have been quite successful with it,
at least until (and including) -mm2-RT-V0.7.11 .


OK. Just some last resort questions: is there any plans (or recipe) on
merging the RT patch(es) against the 2.6.10(-rc1) vanilla kernel? Or, at
least for my laptop's sake, on top of this late and "well" behaved -mm2 ?

Hope someone knows it better ;)

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


------=_20041115143347_85895
Content-Type: text/plain; name="messages.0-2.6.10-rc1-mm3-RT-V0.7.24"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
      filename="messages.0-2.6.10-rc1-mm3-RT-V0.7.24"

Nov 11 12:39:43 lambda alsa: Shutting down ALSA sound driver (version 1.0.6): 
Nov 11 12:39:46 lambda kernel: usbcore: deregistering driver snd-usb-usx2y
Nov 11 12:39:46 lambda alsa: /etc/rc6.d/K70alsa: line 287:  6663 Segmentation fault      /sbin/rmmod `echo $line | cut -d ' ' -f 1` >/dev/null 2>&1
Nov 11 12:39:46 lambda kernel: BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Nov 11 12:39:46 lambda kernel:  printing eip:
Nov 11 12:39:46 lambda kernel: c012adc5
Nov 11 12:39:46 lambda kernel: *pde = 00000000
Nov 11 12:39:46 lambda kernel: Oops: 0000 [#1]
Nov 11 12:39:46 lambda kernel: PREEMPT 
Nov 11 12:39:46 lambda kernel: Modules linked in: nls_iso8859_15 nls_cp860 vfat fat nls_base realtime commoncap snd_usb_usx2y snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep snd_ali5451 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd soundcore pcmcia yenta_socket pcmcia_core natsemi crc32 loop subfs evdev ohci_hcd usbcore
Nov 11 12:39:46 lambda kernel: CPU:    0
Nov 11 12:39:46 lambda kernel: EIP:    0060:[__up_mutex+59/353]    Not tainted VLI
Nov 11 12:39:46 lambda kernel: EIP:    0060:[<c012adc5>]    Not tainted VLI
Nov 11 12:39:46 lambda kernel: EFLAGS: 00010083   (2.6.10-rc1-mm3-RT-V0.7.24) 
Nov 11 12:39:46 lambda kernel: EIP is at __up_mutex+0x3b/0x161
Nov 11 12:39:46 lambda kernel: eax: 00000000   ebx: de444000   ecx: 00000064   edx: 00000064
Nov 11 12:39:46 lambda alsa: /etc/rc6.d/K70alsa: line 287:  6690 Segmentation fault      /sbin/rmmod `echo $line | cut -d ' ' -f 1` >/dev/null 2>&1
Nov 11 12:39:46 lambda kernel: esi: df384aa0   edi: e010a58c   ebp: e0062130   esp: de445ee4
Nov 11 12:39:46 lambda kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Nov 11 12:39:46 lambda kernel: Process rmmod (pid: 6663, threadinfo=de444000 task=d7582550)
Nov 11 12:39:46 lambda kernel: Stack: 00000296 c013b72c 00000286 00000296 c01b0f08 00000000 de444000 c0304a88 
Nov 11 12:39:46 lambda kernel:        e0062120 e0062130 c012b4c0 e010a59c c01b0f08 e010a5b4 c01b0f0a bfffd3e0 
Nov 11 12:39:46 lambda kernel:        de444000 c01b1817 e010a59c 00000000 bfffd3e0 de444000 e010a59c 00000000 
Nov 11 12:39:46 lambda kernel: Call Trace:
Nov 11 12:39:46 lambda kernel:  [kmem_cache_free+74/199] kmem_cache_free+0x4a/0xc7 (8)
Nov 11 12:39:46 lambda kernel:  [<c013b72c>] kmem_cache_free+0x4a/0xc7 (8)
Nov 11 12:39:46 lambda kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90 (12)
Nov 11 12:39:46 lambda kernel:  [<c01b0f08>] kobject_cleanup+0x8e/0x90 (12)
Nov 11 12:39:46 lambda kernel:  [up+53/61] up+0x35/0x3d (24)
Nov 11 12:39:46 lambda kernel:  [<c012b4c0>] up+0x35/0x3d (24)
Nov 11 12:39:46 lambda kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90 (8)
Nov 11 12:39:46 lambda kernel:  [<c01b0f08>] kobject_cleanup+0x8e/0x90 (8)
Nov 11 12:39:46 lambda kernel:  [kobject_release+0/8] kobject_release+0x0/0x8 (8)
Nov 11 12:39:46 lambda kernel:  [<c01b0f0a>] kobject_release+0x0/0x8 (8)
Nov 11 12:39:46 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov 11 12:39:46 lambda kernel:  [<c01b1817>] kref_put+0x51/0xc2 (12)
Nov 11 12:39:46 lambda kernel:  [bus_remove_driver+63/72] bus_remove_driver+0x3f/0x48 (36)
Nov 11 12:39:46 lambda kernel:  [<c01f6f47>] bus_remove_driver+0x3f/0x48 (36)
Nov 11 12:39:46 lambda kernel:  [driver_unregister+11/26] driver_unregister+0xb/0x1a (8)
Nov 11 12:39:46 lambda kernel:  [<c01f72e0>] driver_unregister+0xb/0x1a (8)
Nov 11 12:39:46 lambda kernel:  [pg0+533426599/1069982720] usb_deregister+0x31/0x3f [usbcore] (8)
Nov 11 12:39:46 lambda kernel:  [<e004b1a7>] usb_deregister+0x31/0x3f [usbcore] (8)
Nov 11 12:39:46 lambda kernel:  [sys_delete_module+292/304] sys_delete_module+0x124/0x130 (20)
Nov 11 12:39:46 lambda kernel:  [<c012d368>] sys_delete_module+0x124/0x130 (20)
Nov 11 12:39:46 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176 (32)
Nov 11 12:39:46 lambda kernel:  [<c014499b>] do_munmap+0x11a/0x176 (32)
Nov 11 12:39:46 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (12)
Nov 11 12:39:46 lambda kernel:  [<c0144a2f>] sys_munmap+0x38/0x45 (12)
Nov 11 12:39:46 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (24)
Nov 11 12:39:46 lambda kernel:  [<c0144a2f>] sys_munmap+0x38/0x45 (24)
Nov 11 12:39:46 lambda kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71 (12)
Nov 11 12:39:46 lambda kernel:  [<c0103bc1>] sysenter_past_esp+0x52/0x71 (12)
Nov 11 12:39:46 lambda kernel: Code: 10 9c 8f 44 24 08 fa 9c 58 b8 00 e0 ff ff 21 e0 83 40 14 01 83 40 14 01 8b 47 08 e8 f6 81 fe ff 8b 77 08 89 c2 8b 86 38 05 00 00 <8b> 08 0f 18 01 90 8d 9e 38 05 00 00 eb 10 8b 40 0c 39 d0 0f 4c 
Nov 11 12:39:46 lambda kernel:  <6>note: rmmod[6663] exited with preempt_count 3
Nov 11 12:39:46 lambda kernel: BUG: scheduling while atomic: rmmod/0x00000003/6663
Nov 11 12:39:46 lambda kernel: caller is do_exit+0x28d/0x4b6
Nov 11 12:39:46 lambda kernel:  [__schedule+1194/1525] __sched_text_start+0x4aa/0x5f5 (8)
Nov 11 12:39:46 lambda kernel:  [<c02a973a>] __sched_text_start+0x4aa/0x5f5 (8)
Nov 11 12:39:46 lambda kernel:  [exit_notify+1154/2290] exit_notify+0x482/0x8f2 (24)
Nov 11 12:39:46 lambda kernel:  [<c01188be>] exit_notify+0x482/0x8f2 (24)
Nov 11 12:39:46 lambda kernel:  [do_exit+653/1206] do_exit+0x28d/0x4b6 (56)
Nov 11 12:39:46 lambda kernel:  [<c0118fbb>] do_exit+0x28d/0x4b6 (56)
Nov 11 12:39:46 lambda kernel:  [do_divide_error+0/320] do_divide_error+0x0/0x140 (44)
Nov 11 12:39:46 lambda kernel:  [<c0104d79>] do_divide_error+0x0/0x140 (44)
Nov 11 12:39:46 lambda kernel:  [do_page_fault+865/1341] do_page_fault+0x361/0x53d (64)
Nov 11 12:39:46 lambda kernel:  [<c0111344>] do_page_fault+0x361/0x53d (64)
Nov 11 12:39:46 lambda kernel:  [call_usermodehelper+346/364] call_usermodehelper+0x15a/0x16c (72)
Nov 11 12:39:46 lambda kernel:  [<c0125d6a>] call_usermodehelper+0x15a/0x16c (72)
Nov 11 12:39:46 lambda kernel:  [kmem_cache_free+74/199] kmem_cache_free+0x4a/0xc7 (8)
Nov 11 12:39:46 lambda kernel:  [<c013b72c>] kmem_cache_free+0x4a/0xc7 (8)
Nov 11 12:39:46 lambda kernel:  [__kfree_skb+118/263] __kfree_skb+0x76/0x107 (32)
Nov 11 12:39:46 lambda kernel:  [<c025d1dd>] __kfree_skb+0x76/0x107 (32)
Nov 11 12:39:46 lambda kernel:  [__call_usermodehelper+0/72] __call_usermodehelper+0x0/0x48 (16)
Nov 11 12:39:46 lambda kernel:  [<c0125bc8>] __call_usermodehelper+0x0/0x48 (16)
Nov 11 12:39:46 lambda kernel:  [__down_mutex+73/322] __down_mutex+0x49/0x142 (16)
Nov 11 12:39:46 lambda kernel:  [<c02aa833>] __down_mutex+0x49/0x142 (16)
Nov 11 12:39:46 lambda kernel:  [dput+121/657] dput+0x79/0x291 (4)
Nov 11 12:39:46 lambda kernel:  [<c0166519>] dput+0x79/0x291 (4)
Nov 11 12:39:46 lambda kernel:  [kfree+81/237] kfree+0x51/0xed (28)
Nov 11 12:39:46 lambda kernel:  [<c013b85e>] kfree+0x51/0xed (28)
Nov 11 12:39:46 lambda kernel:  [do_page_fault+0/1341] do_page_fault+0x0/0x53d (28)
Nov 11 12:39:46 lambda kernel:  [<c0110fe3>] do_page_fault+0x0/0x53d (28)
Nov 11 12:39:46 lambda kernel:  [error_code+43/48] error_code+0x2b/0x30 (8)
Nov 11 12:39:46 lambda kernel:  [<c0104627>] error_code+0x2b/0x30 (8)
Nov 11 12:39:46 lambda kernel:  [vfs_rename+259/936] vfs_rename+0x103/0x3a8 (32)
Nov 11 12:39:46 lambda kernel:  [<c016007b>] vfs_rename+0x103/0x3a8 (32)
Nov 11 12:39:46 lambda kernel:  [__up_mutex+59/353] __up_mutex+0x3b/0x161 (12)
Nov 11 12:39:46 lambda kernel:  [<c012adc5>] __up_mutex+0x3b/0x161 (12)
Nov 11 12:39:46 lambda kernel:  [kmem_cache_free+74/199] kmem_cache_free+0x4a/0xc7 (16)
Nov 11 12:39:46 lambda kernel:  [<c013b72c>] kmem_cache_free+0x4a/0xc7 (16)
Nov 11 12:39:46 lambda kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90 (12)
Nov 11 12:39:46 lambda kernel:  [<c01b0f08>] kobject_cleanup+0x8e/0x90 (12)
Nov 11 12:39:46 lambda kernel:  [up+53/61] up+0x35/0x3d (24)
Nov 11 12:39:46 lambda kernel:  [<c012b4c0>] up+0x35/0x3d (24)
Nov 11 12:39:46 lambda kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90 (8)
Nov 11 12:39:46 lambda kernel:  [<c01b0f08>] kobject_cleanup+0x8e/0x90 (8)
Nov 11 12:39:46 lambda kernel:  [kobject_release+0/8] kobject_release+0x0/0x8 (8)
Nov 11 12:39:46 lambda kernel:  [<c01b0f0a>] kobject_release+0x0/0x8 (8)
Nov 11 12:39:46 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov 11 12:39:46 lambda kernel:  [<c01b1817>] kref_put+0x51/0xc2 (12)
Nov 11 12:39:46 lambda kernel:  [bus_remove_driver+63/72] bus_remove_driver+0x3f/0x48 (36)
Nov 11 12:39:46 lambda kernel:  [<c01f6f47>] bus_remove_driver+0x3f/0x48 (36)
Nov 11 12:39:46 lambda kernel:  [driver_unregister+11/26] driver_unregister+0xb/0x1a (8)
Nov 11 12:39:46 lambda kernel:  [<c01f72e0>] driver_unregister+0xb/0x1a (8)
Nov 11 12:39:46 lambda kernel:  [pg0+533426599/1069982720] usb_deregister+0x31/0x3f [usbcore] (8)
Nov 11 12:39:46 lambda kernel:  [<e004b1a7>] usb_deregister+0x31/0x3f [usbcore] (8)
Nov 11 12:39:46 lambda kernel:  [sys_delete_module+292/304] sys_delete_module+0x124/0x130 (20)
Nov 11 12:39:46 lambda kernel:  [<c012d368>] sys_delete_module+0x124/0x130 (20)
Nov 11 12:39:46 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176 (32)
Nov 11 12:39:46 lambda kernel:  [<c014499b>] do_munmap+0x11a/0x176 (32)
Nov 11 12:39:46 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (12)
Nov 11 12:39:46 lambda kernel:  [<c0144a2f>] sys_munmap+0x38/0x45 (12)
Nov 11 12:39:46 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (24)
Nov 11 12:39:46 lambda kernel:  [<c0144a2f>] sys_munmap+0x38/0x45 (24)
Nov 11 12:39:46 lambda kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71 (12)
Nov 11 12:39:46 lambda kernel:  [<c0103bc1>] sysenter_past_esp+0x52/0x71 (12)
Nov 11 12:39:46 lambda kernel: ALI 5451 0000:00:06.0: Device was removed without properly calling pci_disable_device(). This may need fixing.
Nov 11 12:39:46 lambda kernel: BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Nov 11 12:39:46 lambda kernel:  printing eip:
Nov 11 12:39:46 lambda kernel: c012adc5
Nov 11 12:39:46 lambda kernel: *pde = 00000000
Nov 11 12:39:46 lambda kernel: Oops: 0000 [#2]
Nov 11 12:39:46 lambda kernel: PREEMPT 
Nov 11 12:39:46 lambda kernel: Modules linked in: nls_iso8859_15 nls_cp860 vfat fat nls_base realtime commoncap snd_usb_usx2y snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep snd_ali5451 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd soundcore pcmcia yenta_socket pcmcia_core natsemi crc32 loop subfs evdev ohci_hcd usbcore
Nov 11 12:39:46 lambda kernel: CPU:    0
Nov 11 12:39:46 lambda kernel: EIP:    0060:[__up_mutex+59/353]    Not tainted VLI
Nov 11 12:39:46 lambda kernel: EIP:    0060:[<c012adc5>]    Not tainted VLI
Nov 11 12:39:46 lambda kernel: EFLAGS: 00010083   (2.6.10-rc1-mm3-RT-V0.7.24) 
Nov 11 12:39:46 lambda kernel: EIP is at __up_mutex+0x3b/0x161
Nov 11 12:39:46 lambda kernel: eax: 00000000   ebx: de444000   ecx: 00000064   edx: 00000064
Nov 11 12:39:46 lambda kernel: esi: df384aa0   edi: e00f4894   ebp: c02fd3b0   esp: de445ef0
Nov 11 12:39:46 lambda kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Nov 11 12:39:46 lambda kernel: Process rmmod (pid: 6690, threadinfo=de444000 task=d7582550)
Nov 11 12:39:46 lambda kernel: Stack: 00000282 c013b72c 00000286 00000282 c01b0f08 00000000 de444000 c0304a88 
Nov 11 12:39:46 lambda kernel:        c02fd3a0 c02fd3b0 c012b4c0 e00f48a4 c01b0f08 e00f48bc c01b0f0a bfffd3e0 
Nov 11 12:39:46 lambda kernel:        de444000 c01b1817 e00f48a4 00000000 bfffd3e0 de444000 e00f48a4 00000000 
Nov 11 12:39:46 lambda kernel: Call Trace:
Nov 11 12:39:46 lambda kernel:  [kmem_cache_free+74/199] kmem_cache_free+0x4a/0xc7 (8)
Nov 11 12:39:46 lambda kernel:  [<c013b72c>] kmem_cache_free+0x4a/0xc7 (8)
Nov 11 12:39:46 lambda kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90 (12)
Nov 11 12:39:46 lambda kernel:  [<c01b0f08>] kobject_cleanup+0x8e/0x90 (12)
Nov 11 12:39:46 lambda kernel:  [up+53/61] up+0x35/0x3d (24)
Nov 11 12:39:46 lambda kernel:  [<c012b4c0>] up+0x35/0x3d (24)
Nov 11 12:39:46 lambda kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90 (8)
Nov 11 12:39:46 lambda kernel:  [<c01b0f08>] kobject_cleanup+0x8e/0x90 (8)
Nov 11 12:39:46 lambda kernel:  [kobject_release+0/8] kobject_release+0x0/0x8 (8)
Nov 11 12:39:46 lambda kernel:  [<c01b0f0a>] kobject_release+0x0/0x8 (8)
Nov 11 12:39:46 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov 11 12:39:46 lambda kernel:  [<c01b1817>] kref_put+0x51/0xc2 (12)
Nov 11 12:39:46 lambda kernel:  [bus_remove_driver+63/72] bus_remove_driver+0x3f/0x48 (36)
Nov 11 12:39:46 lambda kernel:  [<c01f6f47>] bus_remove_driver+0x3f/0x48 (36)
Nov 11 12:39:46 lambda kernel:  [driver_unregister+11/26] driver_unregister+0xb/0x1a (8)
Nov 11 12:39:46 lambda kernel:  [<c01f72e0>] driver_unregister+0xb/0x1a (8)
Nov 11 12:39:46 lambda kernel:  [pci_unregister_driver+11/19] pci_unregister_driver+0xb/0x13 (8)
Nov 11 12:39:46 lambda kernel:  [<c01b8816>] pci_unregister_driver+0xb/0x13 (8)
Nov 11 12:39:46 lambda kernel:  [sys_delete_module+292/304] sys_delete_module+0x124/0x130 (8)
Nov 11 12:39:46 lambda kernel:  [<c012d368>] sys_delete_module+0x124/0x130 (8)
Nov 11 12:39:46 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176 (32)
Nov 11 12:39:46 lambda kernel:  [<c014499b>] do_munmap+0x11a/0x176 (32)
Nov 11 12:39:46 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (12)
Nov 11 12:39:46 lambda kernel:  [<c0144a2f>] sys_munmap+0x38/0x45 (12)
Nov 11 12:39:46 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (24)
Nov 11 12:39:46 lambda kernel:  [<c0144a2f>] sys_munmap+0x38/0x45 (24)
Nov 11 12:39:46 lambda kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71 (12)
Nov 11 12:39:46 lambda kernel:  [<c0103bc1>] sysenter_past_esp+0x52/0x71 (12)
Nov 11 12:39:46 lambda kernel: Code: 10 9c 8f 44 24 08 fa 9c 58 b8 00 e0 ff ff 21 e0 83 40 14 01 83 40 14 01 8b 47 08 e8 f6 81 fe ff 8b 77 08 89 c2 8b 86 38 05 00 00 <8b> 08 0f 18 01 90 8d 9e 38 05 00 00 eb 10 8b 40 0c 39 d0 0f 4c 
Nov 11 12:39:46 lambda kernel:  <6>note: rmmod[6690] exited with preempt_count 3
Nov 11 12:39:46 lambda kernel: BUG: scheduling while atomic: rmmod/0x00000003/6690
Nov 11 12:39:46 lambda kernel: caller is do_exit+0x28d/0x4b6
Nov 11 12:39:46 lambda kernel:  [__schedule+1194/1525] __sched_text_start+0x4aa/0x5f5 (8)
Nov 11 12:39:46 lambda kernel:  [<c02a973a>] __sched_text_start+0x4aa/0x5f5 (8)
Nov 11 12:39:46 lambda kernel:  [exit_notify+1154/2290] exit_notify+0x482/0x8f2 (24)
Nov 11 12:39:46 lambda kernel:  [<c01188be>] exit_notify+0x482/0x8f2 (24)
Nov 11 12:39:46 lambda kernel:  [do_exit+653/1206] do_exit+0x28d/0x4b6 (56)
Nov 11 12:39:46 lambda kernel:  [<c0118fbb>] do_exit+0x28d/0x4b6 (56)
Nov 11 12:39:46 lambda kernel:  [do_divide_error+0/320] do_divide_error+0x0/0x140 (44)
Nov 11 12:39:46 lambda kernel:  [<c0104d79>] do_divide_error+0x0/0x140 (44)
Nov 11 12:39:46 lambda kernel:  [do_page_fault+865/1341] do_page_fault+0x361/0x53d (64)
Nov 11 12:39:46 lambda kernel:  [<c0111344>] do_page_fault+0x361/0x53d (64)
Nov 11 12:39:46 lambda kernel:  [call_usermodehelper+346/364] call_usermodehelper+0x15a/0x16c (72)
Nov 11 12:39:46 lambda kernel:  [<c0125d6a>] call_usermodehelper+0x15a/0x16c (72)
Nov 11 12:39:46 lambda kernel:  [kmem_cache_free+74/199] kmem_cache_free+0x4a/0xc7 (8)
Nov 11 12:39:46 lambda kernel:  [<c013b72c>] kmem_cache_free+0x4a/0xc7 (8)
Nov 11 12:39:46 lambda kernel:  [__kfree_skb+118/263] __kfree_skb+0x76/0x107 (32)
Nov 11 12:39:46 lambda kernel:  [<c025d1dd>] __kfree_skb+0x76/0x107 (32)
Nov 11 12:39:46 lambda kernel:  [__call_usermodehelper+0/72] __call_usermodehelper+0x0/0x48 (16)
Nov 11 12:39:46 lambda kernel:  [<c0125bc8>] __call_usermodehelper+0x0/0x48 (16)
Nov 11 12:39:46 lambda kernel:  [__down_mutex+73/322] __down_mutex+0x49/0x142 (16)
Nov 11 12:39:46 lambda kernel:  [<c02aa833>] __down_mutex+0x49/0x142 (16)
Nov 11 12:39:46 lambda kernel:  [dput+121/657] dput+0x79/0x291 (4)
Nov 11 12:39:46 lambda kernel:  [<c0166519>] dput+0x79/0x291 (4)
Nov 11 12:39:46 lambda kernel:  [kfree+81/237] kfree+0x51/0xed (28)
Nov 11 12:39:46 lambda kernel:  [<c013b85e>] kfree+0x51/0xed (28)
Nov 11 12:39:46 lambda kernel:  [do_page_fault+0/1341] do_page_fault+0x0/0x53d (28)
Nov 11 12:39:46 lambda kernel:  [<c0110fe3>] do_page_fault+0x0/0x53d (28)
Nov 11 12:39:46 lambda kernel:  [error_code+43/48] error_code+0x2b/0x30 (8)
Nov 11 12:39:46 lambda kernel:  [<c0104627>] error_code+0x2b/0x30 (8)
Nov 11 12:39:46 lambda kernel:  [vfs_rename+259/936] vfs_rename+0x103/0x3a8 (32)
Nov 11 12:39:46 lambda kernel:  [<c016007b>] vfs_rename+0x103/0x3a8 (32)
Nov 11 12:39:46 lambda kernel:  [__up_mutex+59/353] __up_mutex+0x3b/0x161 (12)
Nov 11 12:39:46 lambda kernel:  [<c012adc5>] __up_mutex+0x3b/0x161 (12)
Nov 11 12:39:46 lambda kernel:  [kmem_cache_free+74/199] kmem_cache_free+0x4a/0xc7 (16)
Nov 11 12:39:46 lambda kernel:  [<c013b72c>] kmem_cache_free+0x4a/0xc7 (16)
Nov 11 12:39:46 lambda kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90 (12)
Nov 11 12:39:46 lambda kernel:  [<c01b0f08>] kobject_cleanup+0x8e/0x90 (12)
Nov 11 12:39:46 lambda kernel:  [up+53/61] up+0x35/0x3d (24)
Nov 11 12:39:46 lambda kernel:  [<c012b4c0>] up+0x35/0x3d (24)
Nov 11 12:39:46 lambda kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90 (8)
Nov 11 12:39:46 lambda kernel:  [<c01b0f08>] kobject_cleanup+0x8e/0x90 (8)
Nov 11 12:39:46 lambda kernel:  [kobject_release+0/8] kobject_release+0x0/0x8 (8)
Nov 11 12:39:46 lambda kernel:  [<c01b0f0a>] kobject_release+0x0/0x8 (8)
Nov 11 12:39:46 lambda kernel:  [kref_put+81/194] kref_put+0x51/0xc2 (12)
Nov 11 12:39:46 lambda kernel:  [<c01b1817>] kref_put+0x51/0xc2 (12)
Nov 11 12:39:46 lambda kernel:  [bus_remove_driver+63/72] bus_remove_driver+0x3f/0x48 (36)
Nov 11 12:39:46 lambda kernel:  [<c01f6f47>] bus_remove_driver+0x3f/0x48 (36)
Nov 11 12:39:46 lambda kernel:  [driver_unregister+11/26] driver_unregister+0xb/0x1a (8)
Nov 11 12:39:46 lambda kernel:  [<c01f72e0>] driver_unregister+0xb/0x1a (8)
Nov 11 12:39:46 lambda kernel:  [pci_unregister_driver+11/19] pci_unregister_driver+0xb/0x13 (8)
Nov 11 12:39:46 lambda kernel:  [<c01b8816>] pci_unregister_driver+0xb/0x13 (8)
Nov 11 12:39:46 lambda kernel:  [sys_delete_module+292/304] sys_delete_module+0x124/0x130 (8)
Nov 11 12:39:46 lambda kernel:  [<c012d368>] sys_delete_module+0x124/0x130 (8)
Nov 11 12:39:46 lambda kernel:  [do_munmap+282/374] do_munmap+0x11a/0x176 (32)
Nov 11 12:39:46 lambda kernel:  [<c014499b>] do_munmap+0x11a/0x176 (32)
Nov 11 12:39:46 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (12)
Nov 11 12:39:46 lambda kernel:  [<c0144a2f>] sys_munmap+0x38/0x45 (12)
Nov 11 12:39:46 lambda kernel:  [sys_munmap+56/69] sys_munmap+0x38/0x45 (24)
Nov 11 12:39:46 lambda kernel:  [<c0144a2f>] sys_munmap+0x38/0x45 (24)
Nov 11 12:39:46 lambda kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71 (12)
Nov 11 12:39:46 lambda kernel:  [<c0103bc1>] sysenter_past_esp+0x52/0x71 (12)
Nov 11 12:39:47 lambda alsa:  succeeded
------=_20041115143347_85895--


