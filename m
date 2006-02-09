Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422770AbWBISeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbWBISeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWBISeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:34:25 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:27525 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S965247AbWBISeY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:34:24 -0500
From: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
Reply-To: bernd-schubert@gmx.de
To: "Linux Kernel ML" <linux-kernel@vger.kernel.org>
Subject: a couple of oopses with 2.6.14
Date: Thu, 9 Feb 2006 19:34:20 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602091934.20732.bernd.schubert@pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here's a machine that works perfectly with 2.6.11, but gives oopes during the 
boot process with 2.6.14. Unfortunately its everytime another oops. Usually I 
would assume its a memory issue, but the machine really works perfectly with 
2.6.11.
We will run a memory test over the weekend, but so far I don't believe it will 
find anything.

------------- example 1 ------------------------------------------------------

[4294676.669000] scsi0 : ata_piix
[4294676.831000] ATA: abnormal status 0x7F on port 0xE407
[4294676.831000] scsi1 : ata_piix
[4294676.833000] scheduling while atomic: ksoftirqd/0/0x00000101/3
[4294676.833000]  [<c03feddf>] schedule+0xcff/0xd10
[4294676.833000]  [<c011af27>] complete+0x27/0x40
[4294676.833000]  [<c03ffd27>] __down+0x87/0xf0
[4294676.833000]  [<c011adc0>] default_wake_function+0x0/0x20
[4294676.833000]  [<c03fdce0>] klist_release+0x0/0x50
[4294676.833000]  [<c023734a>] kref_put+0x2a/0x80
[4294676.833000]  [<c03fe07f>] __down_failed+0x7/0xc
[4294676.833000]  [<c02aaad6>] .text.lock.main+0x28/0x42
[4294676.833000]  [<c02a6585>] device_del+0x35/0x60
[4294676.833000]  [<c031edf6>] scsi_target_reap+0x86/0xb0
[4294676.833000]  [<c03206f7>] scsi_device_dev_release+0xc7/0x120
[4294676.833000]  [<c02a6165>] device_release+0x45/0x50
[4294676.833000]  [<c0236a97>] kobject_cleanup+0x67/0x70
[4294676.833000]  [<c0236aa0>] kobject_release+0x0/0x10
[4294676.833000]  [<c023734a>] kref_put+0x2a/0x80
[4294676.833000]  [<c0236ac6>] kobject_put+0x16/0x20
[4294676.833000]  [<c0236aa0>] kobject_release+0x0/0x10
[4294676.834000]  [<c031cf91>] scsi_next_command+0x11/0x20
[4294676.834000]  [<c031d086>] scsi_end_request+0xa6/0xc0
[4294676.834000]  [<c031d40a>] scsi_io_completion+0x22a/0x490
[4294676.834000]  [<c031d899>] scsi_generic_done+0x29/0x40
[4294676.834000]  [<c0318251>] scsi_finish_command+0x81/0xc0
[4294676.834000]  [<c0318136>] scsi_softirq+0xc6/0x130
[4294676.834000]  [<c0123dc6>] __do_softirq+0xc6/0xe0
[4294676.834000]  [<c0123e15>] do_softirq+0x35/0x40
[4294676.834000]  [<c0124319>] ksoftirqd+0x89/0x100
[4294676.834000]  [<c0124290>] ksoftirqd+0x0/0x100
[4294676.834000]  [<c0132337>] kthread+0xa7/0xb0
[4294676.834000]  [<c0132290>] kthread+0x0/0xb0
[4294676.834000]  [<c01010cd>] kernel_thread_helper+0x5/0x18
[4294676.834000] Unable to handle kernel NULL pointer dereference at virtual 
address 00000000
[4294676.834000]  printing eip:
[4294676.834000] c031ce82
[4294676.834000] *pde = 00000000
[4294676.834000] Oops: 0000 [#1]
[4294676.834000] PREEMPT SMP
[4294676.834000] Modules linked in:
[4294676.834000] CPU:    0
[4294676.834000] EIP:    0f20:[<c031ce82>]    Not tainted VLI
[4294676.834000] EFLAGS: 00010246   (2.6.14.5-tc3)
[4294676.834000] EIP is at scsi_run_queue+0x12/0xc0
[4294676.834000] eax: 00000000   ebx: dfcddd9c   ecx: dfd8009c   edx: c0236aa0
[4294676.834000] esi: dfcd9c80   edi: dfcc9b84   ebp: 00000202   esp: c1da5ed0
[4294676.834000] ds: 0f3b   es: 0f3b   ss: 0f28
[4294676.834000] Process ksoftirqd/0 (pid: 3, threadinfo=c1da4000 
task=c1d5aa50)
[4294676.834000] Stack: dfcc9b84 dfcddd9c dfcd9c80 dfcc9b84 00000202 c031d086 
dfcc9b84 dfcddd9c
[4294676.834000]        dfcd9c80 00000024 dfffe800 00000024 c031d40a dfcd9c80 
00000000 00000024
[4294676.834000]        00000001 00000000 00000000 00000000 dfcc9b84 00000024 
00040000 00000000
[4294676.834000] Call Trace:
[4294676.834000]  [<c031d086>] scsi_end_request+0xa6/0xc0
[4294676.834000]  [<c031d40a>] scsi_io_completion+0x22a/0x490
[4294676.834000]  [<c031d899>] scsi_generic_done+0x29/0x40
[4294676.834000]  [<c0318251>] scsi_finish_command+0x81/0xc0
[4294676.834000]  [<c0318136>] scsi_softirq+0xc6/0x130
[4294676.834000]  [<c0123dc6>] __do_softirq+0xc6/0xe0
[4294676.834000]  [<c0123e15>] do_softirq+0x35/0x40
[4294676.834000]  [<c0124319>] ksoftirqd+0x89/0x100
[4294676.834000]  [<c0124290>] ksoftirqd+0x0/0x100
[4294676.834000]  [<c0132337>] kthread+0xa7/0xb0
[4294676.834000]  [<c0132290>] kthread+0x0/0xb0
[4294676.834000]  [<c01010cd>]<7>ieee1394: Initialized config rom entry 
`ip1394'
[4294676.834000]  kernel_thread_helper+0x5/0x18
[4294676.834000] Code: 00 89 44 24 04 53 e8 <6>ieee1394: raw1394: /dev/raw1394 
device initialized
[4294676.834000] 2e b6 ff <6>MC: drivers/edac/edac_mc.c version MC $Revision: 
1.1.2.1 $
[4294676.834000] ff 58 5a eb aa 8d 76 00 8d bc 27 00 00 00 00 55 57 56 53 51 
8b 44 24 18 89 04 24 8b 80 f8 00 00 00 <8b> 38 f6 80 7d 01 00 00 80 0f 85 87 
00 00 00 <6>mice: PS/2 mouse device common for all mice
[4294676.834000] 8b 47 34 8d 6f 24
[4294676.834000]  <0>Kernel panic - not syncing: Fatal exception in interrupt
[4294676.837000]  [4294667.296000] Linux version 2.6.14.5-tc3 
(bernd@hamilton1) (gcc version 3.3.5 (Debian 1:3.3.5

------------- example 2 ------------------------------------------------------
[4294708.516000] Unable to handle kernel paging request at virtual address 
8d2311c4
[4294708.516000]  printing eip:
[4294708.516000] c03fe70c
[4294708.516000] *pde = 00000000
[4294708.516000] Oops: 0000 [#1]
[4294708.516000] PREEMPT SMP
[4294708.516000] Modules linked in:
[4294708.516000] CPU:    1
[4294708.516000] EIP:    0f20:[<c03fe70c>]    Not tainted VLI
[4294708.516000] EFLAGS: 00010083   (2.6.14.5-tc3)
[4294708.516000] EIP is at schedule+0x62c/0xd10
[4294667.296000] Linux version 2.6.14.5-tc3 (bernd@hamilton1) (gcc version 
3.3.5 (Debian 1:3.3.5-13)) #3 SMP PREEM

------------- example 3 ------------------------------------------------------
[4294728.634000] Unable to handle kernel paging request------------[ cut 
here ]------------
[4294728.634000] kernel BUG at arch/i386/mm/highmem.c:15!
[4294728.634000] invalid operand: 0000 [#1]
[4294728.634000] PREEMPT SMP
[4294728.634000] Modules linked in: usbhid snd_intel8x0 snd_ac97_codec 
snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer i2c_i801 snd 
i2c_core snd_page_alloc ehci_hcd uhci_hcd usbcore intel_agp agpgart
[4294728.634000] CPU:    1
[4294728.634000] EIP:    0f20:[<c0118644>]    Not tainted VLI
[4294728.634000] EFLAGS: 00010206   (2.6.14.5-tc3)
[4294728.634000] EIP is at kunmap+0x14/0x40
[4294728.634000] eax: f75e2000   ebx: 0000003a   ecx: c1beabc0   edx: ffffffff
[4294728.634000] esi: 0001ff39   edi: ff932eff   ebp: 00000000   esp: f75e3f48
[4294728.634000] ds: 0f3b   es: 0f3b   ss: 0f28
[4294728.634000] Process net.agent (pid: 3301, threadinfo=f75e2000 
task=f771a030)
[4294728.634000] Stack: c0164282 c1beabc0 ff932eff c1beabc0 00000000 0001ff39 
080f71c2 00000000
[4294728.634000]        ff932000 c1beabc0 f743f200 00000000 f75e2000 080f7868 
c0165781 ffffffff
[4294728.634000]        080f7008 f743f200 080f7008 f761e000 f761e000 f75e2000 
c01019ee f761e000
[4294728.634000] Call Trace:
[4294728.634000]  [<c0164282>] copy_strings+0x1d2/0x220
[4294728.634000]  [<c0165781>] do_execve+0x131/0x1f0
[4294728.634000]  [<c01019ee>] sys_execve+0x2e/0x90
[4294728.634000]  [<c0102e71>] sysenter_past_esp+0x5a/0x89
[4294728.634000]  [<c0100f3b>] mwait_idle+0x3b/0x50
[4294728.634000] Code: 00 00 39 c2 74 05 e9 1c 13 03 00 89 c8 e9 55 0b 03 00 
90 8d 74 26 00 b8 00 e0 ff ff 8b 4c 24 04 21 e0 f7 40 14 00 ff ff 0f 74 08 
<0f> 0b 0f 00 24 12 42 c0 8b 01 c1 e8 1e 8b 14 85 dc 95 52 c0 8b
[4294728.634000]  <6>note: net.agent[3301] exited with preempt_count -1
[4294728.634000]  at virtual address 08a8f771
[4294728.634000]  printing eip:
[4294728.634000] c03fe74b
[4294728.634000] *pde = 00000000
[4294728.634000] Oops: 0002 [#2]
[4294728.634000] PREEMPT SMP
[4294728.634000] Modules linked in: usbhid snd_intel8x0 snd_ac97_codec 
snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer i2c_i801 snd 
i2c_core snd_page_alloc ehci_hcd uhci_hcd usbcore intel_agp agpgart
[4294728.634000] CPU:    1
[4294728.634000] EIP:    0f20:[<c03fe74b>]    Not tainted VLI
[4294728.634000] EFLAGS: 00010286   (2.6.14.5-tc3)
[4294728.634000] EIP is at schedule+0x66b/0xd10
[4294728.634000] eax: 00000000   ebx: c1d56030   ecx: f771a030   edx: 00010001
[4294728.634000] esi: f75e2000   edi: 00000000   ebp: c03fe767   esp: f75e3ac4
[4294728.634000] ds: 0f3b   es: 0f3b   ss: 0f28
[4294728.634000] Process net.agent (pid: 3301, threadinfo=f75e2000 
task=f771a030)
[4294728.634000] Stack: f75e2000 c0000000 f7b7e360 00000000 c037cda5 00000000 
f75e3b3c 00000060
[4294728.634000]        f75e3b14 f775b030 00000013 dff81780 f7773d00 f775b030 
00000000 c1c13d80
[4294728.634000]        c1c13420 00000001 00000000 6e93a040 000f4208 c1c138dc 
f771a030 f771a158
[4294728.634000] Call Trace:
[4294728.634000]  [<c037cda5>] kernel_sendmsg+0x35/0x40
[4294728.634000]  [<c0343633>] sym_wide_nego+0xa3/0x130
[4294728.634000]  [<c0313530>] cdrom_end_request+0x70/0xf0
[4294728.634000]  [<c011ae90>] __wake_up_locked+0x10/0x20
[4294728.634000]  [<c0238aef>] __down_trylock+0x2f/0x50
[4294728.634000]  [<c03fe097>] __down_failed_trylock+0x7/0xc
[4294728.634000]  [<c011f5b1>] vprintk+0x1d1/0x280
[4294728.634000]  [<c023962c>] vsnprintf+0x25c/0x520
[4294728.634000]  [<c02399a9>] sprintf+0x19/0x20
[4294728.634000]  [<c011f3cf>] printk+0xf/0x20
[4294728.634000]  [<c013a096>] __print_symbol+0x66/0xb0
[4294728.634000]  [<c013a096>] __print_symbol+0x66/0xb0
[4294728.634000]  [<c023962c>] vsnprintf+0x25c/0x520
[4294728.634000]  [<c02d738d>] boomerang_interrupt+0x22d/0x400
[4294728.634000]  [<f8909731>] snd_intel8x0_interrupt+0x51/0x220 
[snd_intel8x0]
[4294728.634000]  [<c014a68e>] zap_pte_range+0x3e/0x290
[4294728.634000]  [<c014a77e>] zap_pte_range+0x12e/0x290
[4294728.634000]  [<c0103ecc>] invalidate_interrupt+0x1c/0x30
[4294728.634000]  [<c0112ec3>] flush_tlb_others+0x83/0xd0
[4294728.634000]  [<c0112fc9>] flush_tlb_mm+0x59/0xb0
[4294728.634000]  [<c014abe0>] unmap_vmas+0x250/0x290
[4294728.634000]  [<c014f100>] exit_mmap+0x80/0x160
[4294728.634000]  [<c011cd14>] mmput+0x24/0x80
[4294728.634000]  [<c01216d5>] do_exit+0xe5/0x420
[4294728.634000]  [<c0104706>] die+0x166/0x170
[4294728.634000]  [<c01048c0>] do_invalid_op+0x0/0x90
[4294728.634000]  [<c010493a>] do_invalid_op+0x7a/0x90
[4294728.634000]  [<c0118644>] kunmap+0x14/0x40
[4294728.634000]  [<c01499d0>] page_address+0x90/0xa0
[4294728.634000]  [<c01499d0>] page_address+0x90/0xa0
[4294728.634000]  [<c0149199>] kmap_high+0x19/0x190
[4294728.634000]  [<c0149298>] kmap_high+0x118/0x190
[4294728.634000]  [<c0141232>] __alloc_pages+0x3c2/0x400
[4294728.634000]  [<c0141114>] __alloc_pages+0x2a4/0x400
[4294728.634000]  [<c010402f>] error_code+0x4f/0x60
[4294728.634000]  [<c0118644>] kunmap+0x14/0x40
[4294728.634000]  [<c0164282>] copy_strings+0x1d2/0x220
[4294728.634000]  [<c0165781>] do_execve+0x131/0x1f0
[4294728.634000]  [<c01019ee>] sys_execve+0x2e/0x90
[4294728.634000]  [<c0102e71>] sysenter_past_esp+0x5a/0x89
[4294728.634000]  [<c0100f3b>] mwait_idle+0x3b/0x50
[4294728.634000] Code: 00 85 f6 74 0b f0 ff 4e 28 0f 94 c0 84 c0 75 4d 83 e7 
08 75 34 be 00 e0 ff ff 21 e6 8b 0e 89 4d e4 8b 41 14 85 c0 79 1a 8b 46 08 
<30> a0 71 f7 a8 08 89 7e 14 0f 85 bc f9 ff ff 8d 65 f4 5b 5e 5f
[4294728.634000]  <1>Fixing recursive fault but reboot is needed!
[4294728.634000] scheduling while atomic: net.agent/0x00000002/3301
[4294728.634000]  [<c03feddf>] schedule+0xcff/0xd10
[4294728.634000]  [<c011f572>] vprintk+0x192/0x280
[4294728.634000]  [<c0123dc6>] __do_softirq+0xc6/0xe0
[4294728.634000]  [<c0123ef5>] irq_exit+0x45/0x50
[4294728.634000]  [<c0103f2c>] apic_timer_interrupt+0x1c/0x30
[4294728.634000]  [<c012199d>] do_exit+0x3ad/0x420
[4294728.634000]  [<c0104706>] die+0x166/0x170
[4294728.634000]  [<c03fe74b>] schedule+0x66b/0xd10
[4294728.634000]  [<c03fe74b>] schedule+0x66b/0xd10
[4294728.634000]  [<c0400c8c>] do_page_fault+0x28c/0x595
[4294728.634000]  [<c0400a00>] do_page_fault+0x0/0x595
[4294728.634000]  [<c03fe767>] schedule+0x687/0xd10
[4294728.634000]  [<c010402f>] error_code+0x4f/0x60
[4294728.634000]  [<c03fe767>] schedule+0x687/0xd10
[4294728.634000]  [<c03fe74b>] schedule+0x66b/0xd10
[4294728.634000]  [<c037cda5>] kernel_sendmsg+0x35/0x40
[4294728.634000]  [<c0343633>] sym_wide_nego+0xa3/0x130
[4294728.634000]  [<c0313530>] cdrom_end_request+0x70/0xf0
[4294728.634000]  [<c011ae90>] __wake_up_locked+0x10/0x20
[4294728.634000]  [<c0238aef>] __down_trylock+0x2f/0x50
[4294728.634000]  [<c03fe097>] __down_failed_trylock+0x7/0xc
[4294728.634000]  [<c011f5b1>] vprintk+0x1d1/0x280
[4294728.634000]  [<c023962c>] vsnprintf+0x25c/0x520
[4294728.634000]  [<c02399a9>] sprintf+0x19/0x20
[4294728.634000]  [<c011f3cf>] printk+0xf/0x20
[4294728.634000]  [<c013a096>] __print_symbol+0x66/0xb0
[4294728.634000]  [<c013a096>] __print_symbol+0x66/0xb0
[4294728.634000]  [<c023962c>] vsnprintf+0x25c/0x520
[4294728.634000]  [<c02d738d>] boomerang_interrupt+0x22d/0x400
[4294728.634000]  [<f8909731>] snd_intel8x0_interrupt+0x51/0x220 
[snd_intel8x0]
[4294728.634000]  [<c014a68e>] zap_pte_range+0x3e/0x290
[4294728.634000]  [<c014a77e>] zap_pte_range+0x12e/0x290
[4294728.634000]  [<c0103ecc>] invalidate_interrupt+0x1c/0x30
[4294728.634000]  [<c0112ec3>] flush_tlb_others+0x83/0xd0
[4294728.634000]  [<c0112fc9>] flush_tlb_mm+0x59/0xb0
[4294728.634000]  [<c014abe0>] unmap_vmas+0x250/0x290
[4294728.634000]  [<c014f100>] exit_mmap+0x80/0x160
[4294728.634000]  [<c011cd14>] mmput+0x24/0x80
[4294728.634000]  [<c01216d5>] do_exit+0xe5/0x420
[4294728.634000]  [<c0104706>] die+0x166/0x170
[4294728.634000]  [<c01048c0>] do_invalid_op+0x0/0x90
[4294728.634000]  [<c010493a>] do_invalid_op+0x7a/0x90
[4294728.634000]  [<c0118644>] kunmap+0x14/0x40
[4294728.634000]  [<c01499d0>] page_address+0x90/0xa0
[4294728.634000]  [<c01499d0>] page_address+0x90/0xa0
[4294728.634000]  [<c0149199>] kmap_high+0x19/0x190
[4294728.634000]  [<c0149298>] kmap_high+0x118/0x190
[4294728.634000]  [<c0141232>] __alloc_pages+0x3c2/0x400
[4294728.634000]  [<c0141114>] __alloc_pages+0x2a4/0x400
[4294728.634000]  [<c010402f>] error_code+0x4f/0x60
[4294728.634000]  [<c0118644>] kunmap+0x14/0x40
[4294728.634000]  [<c0164282>] copy_strings+0x1d2/0x220
[4294728.634000]  [<c0165781>] do_execve+0x131/0x1f0
[4294728.634000]  [<c01019ee>] sys_execve+0x2e/0x90
[4294728.634000]  [<c0102e71>] sysenter_past_esp+0x5a/0x89
[4294728.634000]  [<c0100f3b>] mwait_idle+0x3b/0x50
[4294728.634000] Unable to handle kernel paging request at virtual address 
08a8f771
[4294728.634000]  printing eip:
[4294728.634000] c03fe74b
[4294728.634000] *pde = 00000000
[4294728.634000] Oops: 0002 [#3]
[4294728.634000] PREEMPT SMP
[4294728.634000] Modules linked in: usbhid snd_intel8x0 snd_ac97_codec 
snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer i2c_i801 snd 
i2c_core snd_page_alloc ehci_hcd uhci_hcd usbcore intel_agp agpgart
[4294728.634000] CPU:    1
[4294728.634000] EIP:    0f20:[<c03fe74b>]    Not tainted VLI
[4294728.634000] EFLAGS: 00010286   (2.6.14.5-tc3)
[4294728.634000] EIP is at schedule+0x66b/0xd10
[4294728.634000] eax: 00000000   ebx: f771a030   ecx: c1d5fa50   edx: 00000001
[4294728.634000] esi: c1dca000   edi: 00000000   ebp: c1dcbfb4   esp: c1dcbf40
[4294728.634000] ds: 0f3b   es: 0f3b   ss: 0f28
[4294728.634000] Process ksoftirqd/1 (pid: 6, threadinfo=c1dca000 
task=c1d5fa50)
[4294728.634000] Stack: 00004074 dfd96c80 c031d899 dfd96c80 00000000 00000024 
c0318251 dfd96c80
[4294728.634000]        00002002 dfd96c80 00004074 c1dcbf78 c0318136 dfd96c80 
c1dcbf78 c1dcbf78
[4294728.634000]        c1c13420 00000001 00000000 bf9f1680 000f41ff c0123dc6 
c1d5fa50 c1d5fb78
[4294728.634000] Call Trace:
[4294728.634000]  [<c031d899>] scsi_generic_done+0x29/0x40
[4294728.634000]  [<c0318251>] scsi_finish_command+0x81/0xc0
[4294728.634000]  [<c0318136>] scsi_softirq+0xc6/0x130
[4294728.634000]  [<c0123dc6>] __do_softirq+0xc6/0xe0
[4294728.634000]  [<c012436e>] ksoftirqd+0xde/0x100
[4294728.634000]  [<c0124290>] ksoftirqd+0x0/0x100
[4294728.634000]  [<c0132337>] kthread+0xa7/0xb0
[4294728.634000]  [<c0132290>] kthread+0x0/0xb0
[4294728.634000]  [<c01010cd>] kernel_thread_helper+0x5/0x18
[4294728.634000] Code: 00 85 f6 74 0b f0 ff 4e 28 0f 94 c0 84 c0 75 4d 83 e7 
08 75 34 be 00 e0 ff ff 21 e6 8b 0e 89 4d e4 8b 41 14 85 c0 79 1a 8b 46 08 
<30> a0 71 f7 a8 08 89 7e 14 0f 85 bc f9 ff ff 8d 65 f4 5b 5e 5f
[4294728.634000]  <6>note: ksoftirqd/1[6] exited with preempt_count 1
[4294728.634000] Unable to handle kernel paging request at virtual address 
08a8f771
[4294728.634000]  printing eip:
[4294728.634000] c03fe74b
[4294728.634000] *pde = 00000000
[4294728.634000] Oops: 0002 [#4]
[4294728.634000] PREEMPT SMP
[4294728.634000] Modules linked in: usbhid snd_intel8x0 snd_ac97_codec 
snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer i2c_i801 snd 
i2c_core snd_page_alloc ehci_hcd uhci_hcd usbcore intel_agp agpgart
[4294728.634000] CPU:    1
[4294728.634000] EIP:    0f20:[<c03fe74b>]    Not tainted VLI
[4294728.634000] EFLAGS: 00010286   (2.6.14.5-tc3)
[4294728.634000] EIP is at schedule+0x66b/0xd10
[4294728.634000] eax: 00000000   ebx: c1d5fa50   ecx: c1d56540   edx: 10000001

------------- example 4 ------------------------------------------------------
[4294724.723000] scheduling while atomic: S35quota/0xffffffff/3508
[4294724.723000] Unable to handle kernel NULL pointer dereference at virtual 
address 0000005b
[4294724.723000]  printing eip:
[4294724.723000] c03fe74b
[4294724.723000] *pde = 00000000
[4294724.723000] Oops: 0002 [#1]
[4294724.723000] PREEMPT SMP
[4294724.723000] Modules linked in: dm_mod eeprom lm85 hwmon_vid i2c_isa 
usbhid snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss 
snd_pcm uhci_hcd snd_timer i2c_i801 intel_agp ehci_hcd snd i2c_core 
snd_page_alloc usbcore agpgart
[4294724.723000] CPU:    1
[4294724.723000] EIP:    0f20:[<c03fe74b>]    Not tainted VLI
[4294724.723000] EFLAGS: 00010286   (2.6.14.5-tc3)
[4294724.723000] EIP is at schedule+0x66b/0xd10
[4294724.723000] eax: 00000000   ebx: c1d56030   ecx: f75b6030   edx: 00010001
[4294724.723000] esi: f70f4000   edi: 00000000   ebp: c03fe767   esp: f70f5ac4
[4294724.723000] ds: 0f3b   es: 0f3b   ss: 0f28
[4294724.723000] Process S35quota (pid: 3508, threadinfo=f70f4000 
task=f75b6030)
[4294724.723000] Stack: f70f4000 c0000000 f7b536bc 00000000 c037cda5 f7b54380 
f70f5b3c 00000060
[4294724.723000]        f70f5b14 00000000 c03f4618 f7b54380 f70f5b3c f70f5b14 
00000001 00000060
[4294724.723000]        c1c0b420 00000000 00000000 8585c2c0 000f4207 00000206 
f75b6030 f75b6158
[4294724.723000] Call Trace:
[4294724.723000]  [<c037cda5>] kernel_sendmsg+0x35/0x40
[4294724.723000]  [<c03f4618>] xdr_sendpages+0xa8/0x280
[4294724.723000]  [<c011ae68>] __wake_up+0x28/0x40
[4294724.724000]  [<c013fb78>] mempool_free+0x78/0x80
[4294724.724000]  [<c03ee5db>] rpc_default_free_task+0x1b/0x40
[4294724.724000]  [<c012a884>] sigprocmask+0x64/0x100
[4294724.724000]  [<c012a884>] sigprocmask+0x64/0x100
[4294724.724000]  [<c03e9fbe>] rpc_clnt_sigunmask+0xe/0x20
[4294724.724000]  [<c01ff761>] nfs3_rpc_wrapper+0x61/0x70
[4294724.724000]  [<c01406e8>] prep_new_page+0x58/0x60
[4294724.724000]  [<c0140c9c>] buffered_rmqueue+0x11c/0x230
[4294724.724000]  [<c0141232>] __alloc_pages+0x3c2/0x400
[4294724.724000]  [<c0141114>] __alloc_pages+0x2a4/0x400
[4294724.724000]  [<c0143e01>] kmem_getpages+0x61/0x80
[4294724.724000]  [<c0144b55>] cache_grow+0xd5/0x140
[4294724.724000]  [<c0144b94>] cache_grow+0x114/0x140
[4294724.724000]  [<c0144d0a>] cache_alloc_refill+0x14a/0x1f0
[4294724.724000]  [<c0144cdb>] cache_alloc_refill+0x11b/0x1f0
[4294724.724000]  [<c0145023>] __kmalloc+0x63/0x70
[4294724.724000]  [<c0380e49>] __alloc_skb+0x49/0x130
[4294724.724000]  [<c02d6baf>] boomerang_start_xmit+0x13f/0x350
[4294724.724000]  [<c0295dd1>] scrup+0xb1/0xc0
[4294724.724000]  [<c0246964>] vgacon_cursor+0x144/0x190
[4294724.724000]  [<c029734d>] lf+0x3d/0x50
[4294724.724000]  [<c0299369>] vt_console_print+0x1c9/0x280
[4294724.724000]  [<c011f139>] __call_console_drivers+0x49/0x50
[4294724.724000]  [<c011f22c>] call_console_drivers+0x7c/0x110
[4294724.724000]  [<c011f722>] release_console_sem+0x42/0xb0
[4294724.724000]  [<c011f572>] vprintk+0x192/0x280
[4294724.724000]  [<c02d723a>] boomerang_interrupt+0xda/0x400
[4294724.724000]  [<c02d738d>] boomerang_interrupt+0x22d/0x400
[4294724.724000]  [<f88f2731>] snd_intel8x0_interrupt+0x51/0x220 
[snd_intel8x0]
[4294724.724000]  [<c011f3cf>] printk+0xf/0x20
[4294724.724000]  [<c03fedda>] schedule+0xcfa/0xd10
[4294724.724000]  [<c0123dc6>] __do_softirq+0xc6/0xe0
[4294724.724000]  [<c0102d77>] do_notify_resume2+0x17/0x20
[4294724.724000]  [<c0102f00>] restore_all2+0x0/0x18
[4294724.724000]  [<c0110f3b>] machine_emergency_restart+0x4b/0xe0
[4294724.724000]  [<c03fef45>] wait_for_completion+0x85/0xd0
[4294724.724000]  [<c011adc0>][ 


------------- Full log ----------------------------------------------
[4294667.296000] Linux version 2.6.14.5-tc3 (bernd@hamilton1) (gcc version 
3.3.5 (Debian 1:3.3.5-13)) #3 SMP PREEMPT Thu Jan 5 16:50:57 CET 2006
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[4294667.296000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000005fe30000 (usable)
[4294667.296000]  BIOS-e820: 000000005fe30000 - 000000005fe3e20b (ACPI NVS)
[4294667.296000]  BIOS-e820: 000000005fe3e20b - 000000005ff30000 (usable)
[4294667.296000]  BIOS-e820: 000000005ff30000 - 000000005ff40000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000005ff40000 - 000000005fff0000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 000000005fff0000 - 0000000060000000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
[4294667.296000] 639MB HIGHMEM available.
[4294667.296000] 896MB LOWMEM available.
[4294667.296000] found SMP MP-table at 000ff780
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: PM-Timer IO Port: 0x408
[4294667.296000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[4294667.296000] Processor #0 15:2 APIC version 20
[4294667.296000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[4294667.296000] Processor #1 15:2 APIC version 20
[4294667.296000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[4294667.296000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[4294667.296000] Using ACPI for processor (LAPIC) configuration information
[4294667.296000] Intel MultiProcessor Specification v1.4
[4294667.296000]     Virtual Wire compatibility mode.
[4294667.296000] OEM ID:  Product ID: Springdale-G APIC at: 0xFEE00000
[4294667.296000] I/O APIC #2 Version 32 at 0xFEC00000.
[4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[4294667.296000] Processors: 2
[4294667.296000] Allocating PCI resources starting at 70000000 (gap: 
60000000:9ecf0000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: initrd=client_initrd-l26.unfs3 
root=/dev/ram0 rw apm=power-off mce pci=noacpi 
netconsole=4444@129.206.21.51/eth0,5555@129.206.21.136/00:04:75:BF:B9:4A 
BOOT_IMAGE=linux-2.6.14.5-tc3 
ip=129.206.21.51:129.206.21.201:129.206.21.1:255.255.255.0
[4294667.296000] netconsole: local port 4444
[4294667.296000] netconsole: local IP 129.206.21.51
[4294667.296000] netconsole: interface eth0
[4294667.296000] netconsole: remote port 5555
[4294667.296000] netconsole: remote IP 129.206.21.136
[4294667.296000] netconsole: remote ethernet address 00:04:75:bf:b9:4a
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[4294667.296000] Detected 2594.205 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour VGA+ 80x25
[4294670.096000] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes)
[4294670.096000] Inode-cache hash table entries: 65536 (order: 6, 262144 
bytes)
[4294670.162000] Memory: 1548480k/1572032k available (3078k kernel code, 
22316k reserved, 1183k data, 236k init, 654468k highmem)
[4294670.162000] Checking if this processor honours the WP bit even in 
supervisor mode... Ok.
[4294670.222000] Calibrating delay using timer specific routine.. 5190.56 
BogoMIPS (lpj=2595281)
[4294670.222000] Mount-cache hash table entries: 512
[4294670.222000] CPU: Trace cache: 12K uops, L1 D cache: 8K
[4294670.222000] CPU: L2 cache: 512K
[4294670.222000] CPU: Physical Processor ID: 0
[4294670.222000] Intel machine check architecture supported.
[4294670.222000] Intel machine check reporting enabled on CPU#0.
[4294670.222000] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
[4294670.222000] CPU0: Thermal monitoring enabled
[4294670.222000] mtrr: v2.0 (20020519)
[4294670.222000] Enabling fast FPU save and restore... done.
[4294670.222000] Enabling unmasked SIMD FPU exception support... done.
[4294670.222000] Checking 'hlt' instruction... OK.
[4294670.227000]  tbxface-0109 [02] load_tables           : ACPI Tables 
successfully acquired
[4294670.234000] Parsing all Control 
Methods:..................................................................................................................................................................................
[4294670.249000] Table [DSDT](id 0005) - 633 Objects with 51 Devices 178 
Methods 22 Regions
[4294670.249000] ACPI Namespace successfully loaded at root c058bfd8
[4294670.249000] evxfevnt-0091 [03] enable                : Transition to ACPI 
mode successful
[4294670.249000] CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
[4294670.249000] Booting processor 1/1 eip 2000
[4294670.259000] Initializing CPU#1
[4294670.321000] Calibrating delay using timer specific routine.. 5186.27 
BogoMIPS (lpj=2593135)
[4294670.321000] CPU: Trace cache: 12K uops, L1 D cache: 8K
[4294670.321000] CPU: L2 cache: 512K
[4294670.321000] CPU: Physical Processor ID: 0
[4294670.321000] Intel machine check architecture supported.
[4294670.321000] Intel machine check reporting enabled on CPU#1.
[4294670.321000] CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
[4294670.321000] CPU1: Thermal monitoring enabled
[4294670.321000] CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
[4294670.321000] Total of 2 processors activated (10376.83 BogoMIPS).
[4294670.321000] ENABLING IO-APIC IRQs
[4294670.321000] ..TIMER: vector=0x31 pin1=2 pin2=0
[4294670.432000] checking TSC synchronization across 2 CPUs: passed.
[4294670.432000] softlockup thread 0 started up.
[4294670.433000] Brought up 2 CPUs
[4294670.433000] softlockup thread 1 started up.
[4294670.433000] checking if image is initramfs...it isn't (bad gzip magic 
numbers); looks like an initrd
[4294670.438000] Freeing initrd memory: 4096k freed
[4294670.439000] NET: Registered protocol family 16
[4294670.439000] ACPI: bus type pci registered
[4294670.440000] PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
[4294670.440000] PCI: Using configuration type 1
[4294670.440000] ACPI: Subsystem revision 20050902
[4294670.446000] evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 1F 
[_GPE] 4 regs on int 0x9
[4294670.447000] evgpeblk-0996 [06] ev_create_gpe_block   : Found 9 Wake, 
Enabled 0 Runtime GPEs in this block
[4294670.448000] Completing Region/Field/Buffer/Package 
initialization:......................................................................................................................
[4294670.457000] Initialized 21/22 Regions 29/29 Fields 47/47 Buffers 21/21 
Packages (642 nodes)
[4294670.457000] Executing all Device _STA and_INI 
methods:.......................................................
[4294670.465000] 55 Devices found containing: 55 _STA, 1 _INI methods
[4294670.465000] ACPI: Interpreter enabled
[4294670.465000] ACPI: Using PIC for interrupt routing
[4294670.484000] ACPI: Power Resource [URP1] (off)
[4294670.484000] ACPI: Power Resource [FDDP] (off)
[4294670.485000] ACPI: Power Resource [LPTP] (off)
[4294670.494000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294670.494000] SCSI subsystem initialized
[4294670.494000] PCI: Probing PCI hardware
[4294670.494000] PCI: Probing PCI hardware (bus 00)
[4294670.501000] PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
[4294670.501000] PCI quirk: region 0500-053f claimed by ICH4 GPIO
[4294670.501000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[4294670.502000] PCI: Transparent bridge - 0000:00:1e.0
[4294670.520000] PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
[4294670.520000] PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 16
[4294670.520000] PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 19
[4294670.520000] PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 18
[4294670.520000] PCI->APIC IRQ transform: 0000:00:1d.3[A] -> IRQ 16
[4294670.520000] PCI->APIC IRQ transform: 0000:00:1d.7[D] -> IRQ 23
[4294670.520000] PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 18
[4294670.520000] PCI->APIC IRQ transform: 0000:00:1f.2[A] -> IRQ 18
[4294670.520000] PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
[4294670.520000] PCI->APIC IRQ transform: 0000:00:1f.5[B] -> IRQ 17
[4294670.520000] PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
[4294670.520000] PCI->APIC IRQ transform: 0000:02:02.0[A] -> IRQ 17
[4294670.527000] PCI: Bridge: 0000:00:01.0
[4294670.527000]   IO window: disabled.
[4294670.527000]   MEM window: fd900000-fe9fffff
[4294670.527000]   PREFETCH window: f1800000-f57fffff
[4294670.527000] PCI: Bridge: 0000:00:1e.0
[4294670.527000]   IO window: b000-bfff
[4294670.527000]   MEM window: fea00000-feafffff
[4294670.527000]   PREFETCH window: 70000000-700fffff
[4294670.527000] Machine check exception polling timer started.
[4294670.527000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[4294670.527000] apm: overridden by ACPI.
[4294670.530000] highmem bounce pool size: 64 pages
[4294670.530000] Total HugeTLB memory allocated, 0
[4294670.530000] VFS: Disk quotas dquot_6.5.1
[4294670.530000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[4294670.530000] Initializing Cryptographic API
[4294670.530000] ACPI: Power Button (FF) [PWRF]
[4294670.530000] ACPI: Sleep Button (CM) [SLPB]
[4294670.531000] ACPI: CPU0 (power states: C1[C1])
[4294670.531000] ACPI: Processor [CPU1] (supports 8 throttling states)
[4294670.531000] ACPI: CPU1 (power states: C1[C1])
[4294670.531000] ACPI: Processor [CPU2] (supports 8 throttling states)
[4294670.531000] isapnp: Scanning for PnP cards...
[4294670.888000] isapnp: No Plug & Play device found
[4294670.911000] Real Time Clock Driver v1.12
[4294670.911000] hw_random hardware driver 1.0.0 loaded
[4294670.911000] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 
seconds, margin is 60 seconds).
[4294670.911000] Hangcheck: Using monotonic_clock().
[4294670.912000] PNP: No PS/2 controller found. Probing ports directly.
[4294670.914000] serio: i8042 AUX port at 0x60,0x64 irq 12
[4294670.914000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294670.914000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ 
sharing disabled
[4294670.915000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294670.915000] io scheduler noop registered
[4294670.915000] io scheduler anticipatory registered
[4294670.915000] io scheduler deadline registered
[4294670.915000] io scheduler cfq registered
[4294670.915000] Floppy drive(s): fd0 is 1.44M
[4294670.932000] FDC 0 is a National Semiconductor PC87306
[4294670.933000] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 
blocksize
[4294670.933000] pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and 
petero2@telia.com
[4294670.933000] Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
[4294670.933000] Copyright (c) 1999-2005 Intel Corporation.
[4294670.934000] 3c59x: Donald Becker and others. 
www.scyld.com/network/vortex.html
[4294670.934000] 0000:02:02.0: 3Com PCI 3c905C Tornado at 0xbc00. Vers 
LK1.1.19
[4294670.956000] e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
[4294670.956000] e100: Copyright(c) 1999-2005 Intel Corporation
[4294670.956000] netconsole: device eth0 not up yet, forcing it
[4294670.956000] netconsole: carrier detect appears untrustworthy, waiting 4 
seconds
[4294674.965000] netconsole: network logging started
[4294674.965000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294674.965000] ide: Assuming 33MHz system bus speed for PIO modes; override 
with idebus=xx
[4294674.965000] ICH5: IDE controller at PCI slot 0000:00:1f.1
[4294674.965000] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[4294674.965000] ICH5: chipset revision 2
[4294674.965000] ICH5: not 100% native mode: will probe irqs later
[4294674.966000]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, 
hdb:pio
[4294674.966000]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, 
hdd:pio
[4294675.230000] hda: ST3120026A, ATA DISK drive
[4294675.843000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294676.515000] hdc: PLEXTOR CD-R PX-W5224A, ATAPI CD/DVD-ROM drive
[4294676.821000] ide1 at 0x170-0x177,0x376 on irq 15
[4294676.822000] hda: max request size: 1024KiB
[4294676.822000] hda: 234441648 sectors (120034 MB) w/8192KiB Cache, 
CHS=16383/255/63, UDMA(100)
[4294676.823000] hda: cache flushes supported
[4294676.823000]  hda: hda1 hda2 < hda5 hda6 hda7 >
[4294676.867000] hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[4294676.867000] Uniform CD-ROM driver Revision: 3.20
[4294676.871000] ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 
irq 18
[4294676.871000] ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 
irq 18
[4294677.033000] ATA: abnormal status 0x7F on port 0xEC07
[4294677.033000] scsi0 : ata_piix
[4294677.195000] ATA: abnormal status 0x7F on port 0xE407
[4294677.195000] scsi1 : ata_piix
[4294677.198000] ieee1394: raw1394: /dev/raw1394 device initialized
[4294677.198000] MC: drivers/edac/edac_mc.c version MC $Revision: 1.1.2.1 $
[4294677.198000] mice: PS/2 mouse device common for all mice
[4294677.199000] input: PC Speaker
[4294677.199000] NET: Registered protocol family 2
[4294677.214000] IP route cache hash table entries: 65536 (order: 6, 262144 
bytes)
[4294677.214000] TCP established hash table entries: 262144 (order: 9, 3145728 
bytes)
[4294677.217000] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
[4294677.218000] TCP: Hash tables configured (established 262144 bind 65536)
[4294677.218000] TCP reno registered
[4294677.218000] ip_tables: (C) 2000-2002 Netfilter core team
[4294677.249000] ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
[4294677.249000] arp_tables: (C) 2002 David S. Miller
[4294677.261000] TCP bic registered
[4294677.261000] NET: Registered protocol family 1
[4294677.261000] NET: Registered protocol family 17
[4294677.262000] acpi_processor-0181 [03] processor_get_performa: Invalid _PCT 
data
[4294677.262000] acpi_processor-0181 [03] processor_get_performa: Invalid _PCT 
data
[4294677.262000] Starting balanced_irq
[4294677.262000] Using IPI Shortcut mode
[4294677.262000] RAMDISK: ext2 filesystem found at block 0
[4294677.262000] RAMDISK: Loading 4096KiB [1 disk] into ram disk... done.
[4294677.282000] EXT2-fs warning: checktime reached, running e2fsck is 
recommended
[4294677.282000] VFS: Mounted root (ext2 filesystem).
[4294677.282000] Freeing unused kernel memory: 236k freed
[4294677.384000] input: AT Translated Set 2 keyboard on isa0060/serio0
[4294711.121000] Linux agpgart interface v0.101 (c) Dave Jones
[4294711.140000] usbcore: registered new driver usbfs
[4294711.142000] usbcore: registered new driver hub
[4294711.165000] acpi_bus-0200 [01] bus_set_power         : Device is not 
power manageable
[4294711.165000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[4294711.165000] ehci_hcd 0000:00:1d.7: debug port 1
[4294711.166000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus 
number 1
[4294711.166000] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfebffc00
[4294711.171000] agpgart: Detected an Intel 865 Chipset.
[4294711.174000] ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 
10 Dec 2004
[4294711.174000] usb usb1: Product: EHCI Host Controller
[4294711.174000] usb usb1: Manufacturer: Linux 2.6.14.5-tc3 ehci_hcd
[4294711.174000] usb usb1: SerialNumber: 0000:00:1d.7
[4294711.175000] agpgart: AGP aperture is 64M @ 0xf8000000
[4294711.185000] hub 1-0:1.0: USB hub found
[4294711.185000] hub 1-0:1.0: 8 ports detected
[4294711.246000] USB Universal Host Controller Interface driver v2.3
[4294711.247000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[4294711.247000] uhci_hcd 0000:00:1d.0: detected 2 ports
[4294711.289000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus 
number 2
[4294711.289000] uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000cc00
[4294711.289000] usb usb2: Product: UHCI Host Controller
[4294711.289000] usb usb2: Manufacturer: Linux 2.6.14.5-tc3 uhci_hcd
[4294711.289000] usb usb2: SerialNumber: 0000:00:1d.0
[4294711.295000] hub 2-0:1.0: USB hub found
[4294711.295000] hub 2-0:1.0: 2 ports detected
[4294711.396000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[4294711.396000] uhci_hcd 0000:00:1d.1: detected 2 ports
[4294711.397000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus 
number 3
[4294711.397000] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d000
[4294711.398000] usb usb3: Product: UHCI Host Controller
[4294711.398000] usb usb3: Manufacturer: Linux 2.6.14.5-tc3 uhci_hcd
[4294711.398000] usb usb3: SerialNumber: 0000:00:1d.1
[4294711.399000] hub 3-0:1.0: USB hub found
[4294711.399000] hub 3-0:1.0: 2 ports detected
[4294711.502000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[4294711.502000] uhci_hcd 0000:00:1d.2: detected 2 ports
[4294711.504000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus 
number 4
[4294711.504000] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000d400
[4294711.504000] usb usb4: Product: UHCI Host Controller
[4294711.504000] usb usb4: Manufacturer: Linux 2.6.14.5-tc3 uhci_hcd
[4294711.504000] usb usb4: SerialNumber: 0000:00:1d.2
[4294711.507000] hub 4-0:1.0: USB hub found
[4294711.507000] hub 4-0:1.0: 2 ports detected
[4294711.608000] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[4294711.608000] uhci_hcd 0000:00:1d.3: detected 2 ports
[4294711.610000] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus 
number 5
[4294711.610000] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000d800
[4294711.610000] usb usb5: Product: UHCI Host Controller
[4294711.611000] usb usb5: Manufacturer: Linux 2.6.14.5-tc3 uhci_hcd
[4294711.611000] usb usb5: SerialNumber: 0000:00:1d.3
[4294711.613000] hub 5-0:1.0: USB hub found
[4294711.613000] hub 5-0:1.0: 2 ports detected
[4294711.649000] usb 2-2: new low speed USB device using uhci_hcd and address 
2
[4294711.810000] usb 2-2: Product: USB-PS/2 Optical Mouse
[4294711.810000] usb 2-2: Manufacturer: Logitech
[4294712.030000] intel8x0_measure_ac97_clock: measured 51171 usecs
[4294712.030000] intel8x0: clocking to 48000
[4294712.570000] usbcore: registered new driver hiddev
[4294712.594000] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] 
on usb-0000:00:1d.0-2
[4294712.594000] usbcore: registered new driver usbhid
[4294712.594000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[4294713.984000] Adding 1951856k swap on /dev/hda5.  Priority:-1 extents:1 
across:1951856k
[4294717.697000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: 
dm-devel@redhat.com
[4294717.990000] ReiserFS: hda6: found reiserfs format "3.6" with standard 
journal
[4294723.311000] ReiserFS: hda6: using ordered data mode
[4294723.337000] ReiserFS: hda6: journal params: device hda6, size 8192, 
journal first block 18, max trans len 1024, max batch 900, max commit age 30, 
max trans age 30
[4294723.337000] ReiserFS: hda6: checking transaction log (hda6)
[4294723.348000] ReiserFS: hda6: replayed 2 transactions in 0 seconds
[4294723.356000] ReiserFS: hda6: Using r5 hash to sort names
[4294723.442000] ReiserFS: hda7: found reiserfs format "3.6" with standard 
journal
[4294724.024000] ReiserFS: hda7: using ordered data mode
[4294724.040000] ReiserFS: hda7: journal params: device hda7, size 8192, 
journal first block 18, max trans len 1024, max batch 900, max commit age 30, 
max trans age 30
[4294724.041000] ReiserFS: hda7: checking transaction log (hda7)
[4294724.051000] ReiserFS: hda7: replayed 2 transactions in 0 seconds
[4294724.069000] ReiserFS: hda7: Using r5 hash to sort names
[Oops 4]


-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
