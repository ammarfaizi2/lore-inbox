Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751937AbWCNTFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWCNTFH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 14:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbWCNTFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 14:05:07 -0500
Received: from macferrin.com ([65.98.32.91]:31749 "EHLO macferrin.com")
	by vger.kernel.org with ESMTP id S1751937AbWCNTFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 14:05:04 -0500
Message-ID: <441713A8.9060009@macferrin.com>
Date: Tue, 14 Mar 2006 12:04:08 -0700
From: Ken MacFerrin <lists@macferrin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Thunderbird/1.0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ken MacFerrin <lists@macferrin.com>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Dave Spring <dspring@acm.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
References: <43E0FC55.6080503@acm.org> <43EBD67E.9020308@acm.org> <200602100013.15276.s0348365@sms.ed.ac.uk> <43ED48AD.6060106@macferrin.com> <4415C104.4000600@macferrin.com>
In-Reply-To: <4415C104.4000600@macferrin.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken MacFerrin wrote:
> Ken MacFerrin wrote:
> 
>> Alistair John Strachan wrote:
>>
>>> On Thursday 09 February 2006 23:55, Dave Spring wrote:
>>>
>>>> Just for closure's sake:
>>>> This turned out to be a hardware problem.
>>>> Memtest86+ http://www.memtest.org/ found an intermittent and
>>>> pattern-sensitive memory error,
>>>> and only appearing at one or two random locations within the 256M 
>>>> module.
>>>> Replacing the dodgy RAM module did the trick.
>>>
>>>
>>>
>>>
>>> Thanks Dave. Any update on your problem Ken? I'm keen to hear whether 
>>> you had crashes without the NVIDIA driver loaded.
>>>
>>
>> Sorry, I got called out of town last weekend so I didn't get a chance 
>> to try this out yet..
>> -Ken
> 
> 
> As a follow-up to close out this thread.  I only had a chance to test 
> the nv driver for a short time before needing to go back to the xinerama 
> capabilities of the Nvidia driver again.  I subsequently had a severe 
> crash that beat up the filesystem pretty badly so I did a data backup 
> and a clean install of Gentoo/KDE3.5 (kernel 2.6.15-r1) along with the 
> binary Nvidia driver (1.0.8178-r3) and have not had the problem re-occur 
> since.  The new install is using the same hardware and kernel config 
> which has been stable for over a week of uptime now.  This would lead me 
> to believe my previous install suffered from some evil filesystem 
> gremlin that had snuck in from an earlier crash and continued to pop up 
> to cause havok versus a genuine kernel bug.
> 
> I appreciate the help and feedback in trying to get this figured out.
> 
> Thanks,
> Ken

It would appear I spoke just a day too soon...  I had the following 
crash this morning with several kernel bugs as listed below.
-Ken

mm-home1 ~ # uname -a
Linux mm-home1 2.6.15-gentoo-r1 #1 SMP PREEMPT Thu Mar 9 16:05:55 MST 
2006 i686 Intel(R) Pentium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux


----------- /var/log/messages --------------
Mar 14 09:18:12 mm-home1 Unable to handle kernel paging request at 
virtual address 00610000
Mar 14 09:18:12 mm-home1 printing eip:
Mar 14 09:18:12 mm-home1 c0141abd
Mar 14 09:18:12 mm-home1 *pde = 00000000
Mar 14 09:18:12 mm-home1 Oops: 0000 [#1]
Mar 14 09:18:12 mm-home1 PREEMPT SMP
Mar 14 09:18:12 mm-home1 Modules linked in: lp vmnet vmmon snd_seq_midi 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event 
snd_seq eth1394 nls_utf8 rfcomm bnep l2cap snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus 
snd_page_alloc snd_util_mem snd_hwdep dv1394 video1394 raw1394 ohci1394 
ieee1394 w83627hf hwmon_vid i2c_isa eeprom i2c_dev i2c_i801 3c59x loop 
nvidia ntfs rtc dm_mod hci_usb bluetooth tsdev
Mar 14 09:18:12 mm-home1 CPU:    0
Mar 14 09:18:12 mm-home1 EIP:    0060:[<c0141abd>]    Tainted: PF     VLI
Mar 14 09:18:12 mm-home1 EFLAGS: 00013006   (2.6.15-gentoo-r1)
Mar 14 09:18:12 mm-home1 EIP is at find_get_page+0x2e/0x4d
Mar 14 09:18:12 mm-home1 eax: 00610000   ebx: 00610000   ecx: 00000000 
  edx: 00610000
Mar 14 09:18:12 mm-home1 esi: f595e1d8   edi: f595e110   ebp: 00020ac6 
  esp: f6773e8c
Mar 14 09:18:12 mm-home1 ds: 007b   es: 007b   ss: 0068
Mar 14 09:18:12 mm-home1 Process vmware-vmx (pid: 9484, 
threadinfo=f6772000 task=f7afaa70)
Mar 14 09:18:12 mm-home1 Stack: f595e1cc 00020ac6 00030000 00000000 
c0142b86 f595e1c8 00020ac6 00020ab0
Mar 14 09:18:12 mm-home1 00000020 d2b7b544 00000002 00000000 f7072bcc 
f595e1c8 f7072b80 c0142ad5
Mar 14 09:18:12 mm-home1 f6773f08 acfc6000 d2b7b544 c0152f1e d2b7b544 
acfc6000 f6773f08 d2b7b56c
Mar 14 09:18:12 mm-home1 Call Trace:
Mar 14 09:18:12 mm-home1 [<c0142b86>] filemap_nopage+0xb1/0x375
Mar 14 09:18:12 mm-home1 [<c0142ad5>] filemap_nopage+0x0/0x375
Mar 14 09:18:12 mm-home1 [<c0152f1e>] do_no_page+0x85/0x2ba
Mar 14 09:18:12 mm-home1 [<c0142ad5>] filemap_nopage+0x0/0x375
Mar 14 09:18:12 mm-home1 [<c0153460>] __handle_mm_fault+0x263/0x302
Mar 14 09:18:12 mm-home1 [<c0115738>] do_page_fault+0x1b7/0x557
Mar 14 09:18:12 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:18:12 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:18:12 mm-home1 Code: ec 08 8b 5c 24 14 8d 73 10 83 c3 04 89 f0 
e8 c3 97 2f 00 8b 44 24 18 89 1c 24 89 44 24 04 e8 7a 2c 17 00 85 c0 89 
c3 74 0d 89 c2 <8b> 00 f6 c4 40 75 13 f0 ff 42 04 89 f0 e8 76 99 2f 00 
89 d8 83
Mar 14 09:18:12 mm-home1 <6>note: vmware-vmx[9484] exited with 
preempt_count 1
Mar 14 09:18:50 mm-home1 syslog-ng[8497]: Connection broken to 
AF_INET(localhost:5149), reopening in 60 seconds
Mar 14 09:18:56 mm-home1 smartd[9805]: Device: /dev/hda, SMART Usage 
Attribute: 194 Temperature_Celsius changed from 128 to 117
Mar 14 09:19:51 mm-home1 syslog-ng[8497]: Connection broken to 
AF_INET(localhost:5149), reopening in 60 seconds
Mar 14 09:20:01 mm-home1 cron[1181]: (root) CMD (test -x 
/usr/sbin/run-crons && /usr/sbin/run-crons )
Mar 14 09:30:01 mm-home1 cron[17880]: (root) CMD (test -x 
/usr/sbin/run-crons && /usr/sbin/run-crons )
Mar 14 09:35:05 mm-home1 Bad page state at prep_new_page (in process 
'superkaramba', page c2069230)
Mar 14 09:35:05 mm-home1 flags:0xc0000000 mapping:00000000 mapcount:1 
count:1
Mar 14 09:35:05 mm-home1 Backtrace:
Mar 14 09:35:05 mm-home1 [<c01458e8>] bad_page+0x84/0xbc
Mar 14 09:35:05 mm-home1 [<c0145d4d>] prep_new_page+0x27/0x80
Mar 14 09:35:05 mm-home1 [<c0146354>] buffered_rmqueue+0x11f/0x275
Mar 14 09:35:05 mm-home1 [<c014661e>] get_page_from_freelist+0xa7/0xbf
Mar 14 09:35:05 mm-home1 [<c014668c>] __alloc_pages+0x56/0x300
Mar 14 09:35:05 mm-home1 [<c0103944>] apic_timer_interrupt+0x1c/0x24
Mar 14 09:35:05 mm-home1 [<c0115188>] pte_alloc_one+0x11/0x12
Mar 14 09:35:05 mm-home1 [<c015094f>] __pte_alloc+0x2b/0xb6
Mar 14 09:35:05 mm-home1 [<c0150deb>] copy_pte_range+0x2d8/0x2ec
Mar 14 09:35:05 mm-home1 [<c0150ebe>] copy_page_range+0xbf/0x112
Mar 14 09:35:05 mm-home1 [<c011bb10>] copy_mm+0x28d/0x38f
Mar 14 09:35:05 mm-home1 [<c011c57a>] copy_process+0x458/0xed0
Mar 14 09:35:05 mm-home1 [<c011d0f2>] do_fork+0x74/0x1bd
Mar 14 09:35:05 mm-home1 [<c02b7324>] copy_to_user+0x42/0x5c
Mar 14 09:35:05 mm-home1 [<c0101a6e>] sys_clone+0x3e/0x42
Mar 14 09:35:05 mm-home1 [<c0102e8f>] sysenter_past_esp+0x54/0x75
Mar 14 09:35:05 mm-home1 Trying to fix it up, but a reboot is needed
Mar 14 09:35:05 mm-home1 ------------[ cut here ]------------
Mar 14 09:35:05 mm-home1 kernel BUG at mm/rmap.c:486!
Mar 14 09:35:05 mm-home1 invalid operand: 0000 [#2]
Mar 14 09:35:05 mm-home1 PREEMPT SMP
Mar 14 09:35:05 mm-home1 Modules linked in: lp vmnet vmmon snd_seq_midi 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event 
snd_seq eth1394 nls_utf8 rfcomm bnep l2cap snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus 
snd_page_alloc snd_util_mem snd_hwdep dv1394 video1394 raw1394 ohci1394 
ieee1394 w83627hf hwmon_vid i2c_isa eeprom i2c_dev i2c_i801 3c59x loop 
nvidia ntfs rtc dm_mod hci_usb bluetooth tsdev
Mar 14 09:35:05 mm-home1 CPU:    0
Mar 14 09:35:05 mm-home1 EIP:    0060:[<c0158335>]    Tainted: PF   B VLI
Mar 14 09:35:05 mm-home1 EFLAGS: 00010286   (2.6.15-gentoo-r1)
Mar 14 09:35:05 mm-home1 EIP is at page_remove_rmap+0x33/0x3d
Mar 14 09:35:05 mm-home1 eax: ffffffff   ebx: fffb5548   ecx: c2069230 
  edx: c2069230
Mar 14 09:35:05 mm-home1 esi: b6152000   edi: c2069230   ebp: cdbffdd4 
  esp: cdbffd30
Mar 14 09:35:05 mm-home1 ds: 007b   es: 007b   ss: 0068
Mar 14 09:35:05 mm-home1 Process superkaramba (pid: 26323, 
threadinfo=cdbfe000 task=dab25a70)
Mar 14 09:35:05 mm-home1 Stack: c1fc9558 cdbffdd4 c0151105 c2069230 
b6152000 74b2c045 74b2c045 c192e548
Mar 14 09:35:05 mm-home1 fffffffc ffffffff de784580 b6156000 cdad9b60 
b6156000 cdbffdd4 c01512b9
Mar 14 09:35:05 mm-home1 c220e900 e1eae544 cdad9b60 b614e000 b6156000 
cdbffdd4 00000000 b6155fff
Mar 14 09:35:05 mm-home1 Call Trace:
Mar 14 09:35:05 mm-home1 [<c0151105>] zap_pte_range+0x1f4/0x2f4
Mar 14 09:35:05 mm-home1 [<c01512b9>] unmap_page_range+0xb4/0x13a
Mar 14 09:35:05 mm-home1 [<c015142a>] unmap_vmas+0xeb/0x24c
Mar 14 09:35:05 mm-home1 [<c015649a>] exit_mmap+0x93/0x13e
Mar 14 09:35:05 mm-home1 [<c011b564>] mmput+0x38/0x9b
Mar 14 09:35:05 mm-home1 [<c016df32>] exec_mmap+0xfd/0x1f1
Mar 14 09:35:05 mm-home1 [<c016e5d4>] flush_old_exec+0x50c/0x898
Mar 14 09:35:05 mm-home1 [<c01629ec>] vfs_read+0x162/0x1b3
Mar 14 09:35:05 mm-home1 [<c016de26>] kernel_read+0x50/0x5f
Mar 14 09:35:05 mm-home1 [<c0192506>] load_elf_binary+0x3ae/0xd10
Mar 14 09:35:05 mm-home1 [<c014ff49>] page_address+0xa6/0xc7
Mar 14 09:35:05 mm-home1 [<c014f874>] kunmap_high+0x7c/0xa0
Mar 14 09:35:05 mm-home1 [<c0192158>] load_elf_binary+0x0/0xd10
Mar 14 09:35:05 mm-home1 [<c016ec6e>] search_binary_handler+0xd3/0x2fd
Mar 14 09:35:05 mm-home1 [<c016f036>] do_execve+0x19e/0x240
Mar 14 09:35:05 mm-home1 [<c0101af3>] sys_execve+0x46/0x93
Mar 14 09:35:05 mm-home1 [<c0102e8f>] sysenter_past_esp+0x54/0x75
Mar 14 09:35:05 mm-home1 Code: 83 42 08 ff 0f 98 c0 84 c0 74 1c 8b 42 08 
83 c0 01 78 18 c7 44 24 04 ff ff ff ff c7 04 24 10 00 00 00 e8 ab e9 fe 
ff 83 c4 08 c3 <0f> 0b e6 01 c2 b1 45 c0 eb de 83 ec 2c 89 7c 24 24 89 
5c 24 1c
Mar 14 09:35:05 mm-home1 <6>note: superkaramba[26323] exited with 
preempt_count 3
Mar 14 09:35:44 mm-home1 Unable to handle kernel paging request at 
virtual address 00100104
Mar 14 09:35:44 mm-home1 printing eip:
Mar 14 09:35:44 mm-home1 c01462a4
Mar 14 09:35:44 mm-home1 *pde = 00000000
Mar 14 09:35:44 mm-home1 Oops: 0002 [#3]
Mar 14 09:35:44 mm-home1 PREEMPT SMP
Mar 14 09:35:44 mm-home1 Modules linked in: lp vmnet vmmon snd_seq_midi 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event 
snd_seq eth1394 nls_utf8 rfcomm bnep l2cap snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus 
snd_page_alloc snd_util_mem snd_hwdep dv1394 video1394 raw1394 ohci1394 
ieee1394 w83627hf hwmon_vid i2c_isa eeprom i2c_dev i2c_i801 3c59x loop 
nvidia ntfs rtc dm_mod hci_usb bluetooth tsdev
Mar 14 09:35:44 mm-home1 CPU:    0
Mar 14 09:35:44 mm-home1 EIP:    0060:[<c01462a4>]    Tainted: PF   B VLI
Mar 14 09:35:44 mm-home1 EFLAGS: 00010002   (2.6.15-gentoo-r1)
Mar 14 09:35:44 mm-home1 EIP is at buffered_rmqueue+0x6f/0x275
Mar 14 09:35:44 mm-home1 eax: c206924c   ebx: c04baa80   ecx: c04bab10 
  edx: 00100100
Mar 14 09:35:44 mm-home1 esi: c04bab00   edi: e237e000   ebp: 00000246 
  esp: e237fe6c
Mar 14 09:35:44 mm-home1 ds: 007b   es: 007b   ss: 0068
Mar 14 09:35:44 mm-home1 Process amarokapp (pid: 16519, 
threadinfo=e237e000 task=f7b10030)
Mar 14 09:35:44 mm-home1 Stack: e237e000 00000400 00000000 c0142677 
effc0314 f7efcdcc 00000000 c2069230
Mar 14 09:35:44 mm-home1 c04bb128 00000044 00000000 00000003 c014661e 
c04baa80 00000000 000280d2
Mar 14 09:35:44 mm-home1 00000003 00000044 c04bb128 f7b10030 000280d2 
c04baa80 c014668c 000280d2
Mar 14 09:35:44 mm-home1 Call Trace:
Mar 14 09:35:44 mm-home1 [<c0142677>] __generic_file_aio_read+0x1bf/0x227
Mar 14 09:35:44 mm-home1 [<c014661e>] get_page_from_freelist+0xa7/0xbf
Mar 14 09:35:44 mm-home1 [<c014668c>] __alloc_pages+0x56/0x300
Mar 14 09:35:44 mm-home1 [<c0152d4a>] do_anonymous_page+0x50/0x19f
Mar 14 09:35:44 mm-home1 [<c0153307>] __handle_mm_fault+0x10a/0x302
Mar 14 09:35:44 mm-home1 [<c0115738>] do_page_fault+0x1b7/0x557
Mar 14 09:35:44 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:35:44 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:35:44 mm-home1 Code: 8d b3 80 00 00 00 9c 5d fa 8b 83 80 00 00 
00 3b 46 04 0f 8e 23 01 00 00 85 c0 74 28 8b 46 10 8d 48 e4 89 4c 24 1c 
8b 48 04 8b 10 <89> 4a 04 89 11 c7 40 04 00 02 20 00 c7 00 00 01 10 00 
83 ab 80
Mar 14 09:35:44 mm-home1 <6>note: amarokapp[16519] exited with 
preempt_count 1
Mar 14 09:35:54 mm-home1 syslog-ng[8497]: Connection broken to 
AF_INET(localhost:5149), reopening in 60 seconds
Mar 14 09:36:25 mm-home1 Unable to handle kernel paging request at 
virtual address 00100104
Mar 14 09:36:25 mm-home1 printing eip:
Mar 14 09:36:25 mm-home1 c01462a4
Mar 14 09:36:25 mm-home1 *pde = 00000000
Mar 14 09:36:25 mm-home1 Oops: 0002 [#4]
Mar 14 09:36:25 mm-home1 PREEMPT SMP
Mar 14 09:36:25 mm-home1 Modules linked in: lp vmnet vmmon snd_seq_midi 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event 
snd_seq eth1394 nls_utf8 rfcomm bnep l2cap snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus 
snd_page_alloc snd_util_mem snd_hwdep dv1394 video1394 raw1394 ohci1394 
ieee1394 w83627hf hwmon_vid i2c_isa eeprom i2c_dev i2c_i801 3c59x loop 
nvidia ntfs rtc dm_mod hci_usb bluetooth tsdev
Mar 14 09:36:25 mm-home1 CPU:    0
Mar 14 09:36:25 mm-home1 EIP:    0060:[<c01462a4>]    Tainted: PF   B VLI
Mar 14 09:36:25 mm-home1 EFLAGS: 00010002   (2.6.15-gentoo-r1)
Mar 14 09:36:25 mm-home1 EIP is at buffered_rmqueue+0x6f/0x275
Mar 14 09:36:25 mm-home1 eax: c206924c   ebx: c04baa80   ecx: c04bab10 
  edx: 00100100
Mar 14 09:36:25 mm-home1 esi: c04bab00   edi: e28fc000   ebp: 00000246 
  esp: e28fde6c
Mar 14 09:36:25 mm-home1 ds: 007b   es: 007b   ss: 0068
Mar 14 09:36:25 mm-home1 Process mlnet (pid: 16435, threadinfo=e28fc000 
task=c0e1d550)
Mar 14 09:36:25 mm-home1 Stack: eab6e090 00000000 e28fdf38 cb8c16b8 
c01cfd53 eab6e090 00000000 c2069230
Mar 14 09:36:25 mm-home1 c04bb128 00000044 00000000 00000003 c014661e 
c04baa80 00000000 000280d2
Mar 14 09:36:25 mm-home1 00000003 00000044 c04bb128 c0e1d550 000280d2 
c04baa80 c014668c 000280d2
Mar 14 09:36:25 mm-home1 Call Trace:
Mar 14 09:36:25 mm-home1 [<c01cfd53>] reiserfs_permission+0x27/0x2b
Mar 14 09:36:25 mm-home1 [<c014661e>] get_page_from_freelist+0xa7/0xbf
Mar 14 09:36:25 mm-home1 [<c014668c>] __alloc_pages+0x56/0x300
Mar 14 09:36:25 mm-home1 [<c0152d4a>] do_anonymous_page+0x50/0x19f
Mar 14 09:36:25 mm-home1 [<c0161c9c>] nameidata_to_filp+0x37/0x4f
Mar 14 09:36:25 mm-home1 [<c0153307>] __handle_mm_fault+0x10a/0x302
Mar 14 09:36:25 mm-home1 [<c0115738>] do_page_fault+0x1b7/0x557
Mar 14 09:36:25 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:36:25 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:36:25 mm-home1 Code: 8d b3 80 00 00 00 9c 5d fa 8b 83 80 00 00 
00 3b 46 04 0f 8e 23 01 00 00 85 c0 74 28 8b 46 10 8d 48 e4 89 4c 24 1c 
8b 48 04 8b 10 <89> 4a 04 89 11 c7 40 04 00 02 20 00 c7 00 00 01 10 00 
83 ab 80
Mar 14 09:36:25 mm-home1 <6>note: mlnet[16435] exited with preempt_count 1
Mar 14 09:36:54 mm-home1 syslog-ng[8497]: Connection broken to 
AF_INET(localhost:5149), reopening in 60 seconds
Mar 14 09:37:55 mm-home1 syslog-ng[8497]: Connection broken to 
AF_INET(localhost:5149), reopening in 60 seconds
Mar 14 09:38:55 mm-home1 syslog-ng[8497]: Connection broken to 
AF_INET(localhost:5149), reopening in 60 seconds
Mar 14 09:39:19 mm-home1 ------------[ cut here ]------------
Mar 14 09:39:19 mm-home1 kernel BUG at mm/page_alloc.c:761!
Mar 14 09:39:19 mm-home1 invalid operand: 0000 [#5]
Mar 14 09:39:19 mm-home1 PREEMPT SMP
Mar 14 09:39:19 mm-home1 Modules linked in: lp vmnet vmmon snd_seq_midi 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event 
snd_seq eth1394 nls_utf8 rfcomm bnep l2cap snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus 
snd_page_alloc snd_util_mem snd_hwdep dv1394 video1394 raw1394 ohci1394 
ieee1394 w83627hf hwmon_vid i2c_isa eeprom i2c_dev i2c_i801 3c59x loop 
nvidia ntfs rtc dm_mod hci_usb bluetooth tsdev
Mar 14 09:39:19 mm-home1 CPU:    0
Mar 14 09:39:19 mm-home1 EIP:    0060:[<c0146486>]    Tainted: PF   B VLI
Mar 14 09:39:19 mm-home1 EFLAGS: 00010202   (2.6.15-gentoo-r1)
Mar 14 09:39:19 mm-home1 EIP is at buffered_rmqueue+0x251/0x275
Mar 14 09:39:19 mm-home1 eax: 00000001   ebx: c04baa80   ecx: 00038000 
  edx: 00000001
Mar 14 09:39:19 mm-home1 esi: c04bab00   edi: ddb92000   ebp: 00000246 
  esp: ddb93e6c
Mar 14 09:39:19 mm-home1 ds: 007b   es: 007b   ss: 0068
Mar 14 09:39:19 mm-home1 Process thunderbird-bin (pid: 26335, 
threadinfo=ddb92000 task=f786fa70)
Mar 14 09:39:19 mm-home1 Stack: c04baa80 c04baaf4 00000000 c0142677 
00000000 00000001 00000000 c04baaf4
Mar 14 09:39:19 mm-home1 c04bb128 00000044 00000000 00000003 c014661e 
c04baa80 00000000 000280d2
Mar 14 09:39:19 mm-home1 00000003 00000044 c04bb128 f786fa70 000280d2 
c04baa80 c014668c 000280d2
Mar 14 09:39:19 mm-home1 Call Trace:
Mar 14 09:39:19 mm-home1 [<c0142677>] __generic_file_aio_read+0x1bf/0x227
Mar 14 09:39:19 mm-home1 [<c014661e>] get_page_from_freelist+0xa7/0xbf
Mar 14 09:39:19 mm-home1 [<c014668c>] __alloc_pages+0x56/0x300
Mar 14 09:39:19 mm-home1 [<c0154869>] vma_adjust+0x1ff/0x38a
Mar 14 09:39:19 mm-home1 [<c0152d4a>] do_anonymous_page+0x50/0x19f
Mar 14 09:39:19 mm-home1 [<c0153307>] __handle_mm_fault+0x10a/0x302
Mar 14 09:39:19 mm-home1 [<c0115738>] do_page_fault+0x1b7/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:19 mm-home1 Code: 3c 00 40 00 00 0f 84 42 ff ff ff 8b 44 24 
38 8b 54 24 1c 89 44 24 04 89 14 24 e8 a6 f4 ff ff 8b 44 24 1c 83 c4 20 
5b 5e 5f 5d c3 <0f> 0b f9 02 aa ab 45 c0 e9 63 fe ff ff e8 bf 3a 2f 00 
e9 31 fe
Mar 14 09:39:19 mm-home1 <1>Unable to handle kernel paging request at 
virtual address 00100104
Mar 14 09:39:19 mm-home1 printing eip:
Mar 14 09:39:19 mm-home1 c01461a9
Mar 14 09:39:19 mm-home1 *pde = 00000000
Mar 14 09:39:19 mm-home1 Oops: 0002 [#6]
Mar 14 09:39:19 mm-home1 PREEMPT SMP
Mar 14 09:39:19 mm-home1 Modules linked in: lp vmnet vmmon snd_seq_midi 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event 
snd_seq eth1394 nls_utf8 rfcomm bnep l2cap snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus 
snd_page_alloc snd_util_mem snd_hwdep dv1394 video1394 raw1394 ohci1394 
ieee1394 w83627hf hwmon_vid i2c_isa eeprom i2c_dev i2c_i801 3c59x loop 
nvidia ntfs rtc dm_mod hci_usb bluetooth tsdev
Mar 14 09:39:19 mm-home1 CPU:    0
Mar 14 09:39:19 mm-home1 EIP:    0060:[<c01461a9>]    Tainted: PF   B VLI
Mar 14 09:39:19 mm-home1 EFLAGS: 00010082   (2.6.15-gentoo-r1)
Mar 14 09:39:19 mm-home1 EIP is at free_hot_cold_page+0xe6/0x161
Mar 14 09:39:19 mm-home1 eax: 00100100   ebx: c21e28c4   ecx: c04bab10 
  edx: c21e28e0
Mar 14 09:39:19 mm-home1 esi: c04baa80   edi: ddb92000   ebp: c04bab00 
  esp: ddb93bd8
Mar 14 09:39:19 mm-home1 ds: 007b   es: 007b   ss: 0068
Mar 14 09:39:19 mm-home1 Process thunderbird-bin (pid: 26335, 
threadinfo=ddb92000 task=f786fa70)
Mar 14 09:39:19 mm-home1 Stack: 00000034 00000001 01cb3f60 000000b7 
00000282 c04baa80 00000001 ddb93c14
Mar 14 09:39:19 mm-home1 c04baa80 00000008 c01469dc 00000002 c04baa80 
c014c689 ddb93c14 00000002
Mar 14 09:39:19 mm-home1 00000000 c1fc393c c21e28c4 7f2e9067 c1ee422c 
ffffffff 00000000 d51e5d00
Mar 14 09:39:19 mm-home1 Call Trace:
Mar 14 09:39:19 mm-home1 [<c01469dc>] __pagevec_free+0x16/0x1e
Mar 14 09:39:19 mm-home1 [<c014c689>] release_pages+0x161/0x176
Mar 14 09:39:19 mm-home1 [<c01512b9>] unmap_page_range+0xb4/0x13a
Mar 14 09:39:19 mm-home1 [<c0159d90>] free_pages_and_swap_cache+0x5d/0x83
Mar 14 09:39:19 mm-home1 [<c0151553>] unmap_vmas+0x214/0x24c
Mar 14 09:39:19 mm-home1 [<c015649a>] exit_mmap+0x93/0x13e
Mar 14 09:39:19 mm-home1 [<c011b564>] mmput+0x38/0x9b
Mar 14 09:39:19 mm-home1 [<c01205e2>] do_exit+0xfc/0x41d
Mar 14 09:39:19 mm-home1 [<c011e04a>] printk+0x17/0x1b
Mar 14 09:39:19 mm-home1 [<c010414a>] do_trap+0x0/0x11d
Mar 14 09:39:19 mm-home1 [<c01044a4>] do_invalid_op+0x0/0xab
Mar 14 09:39:19 mm-home1 [<c0104546>] do_invalid_op+0xa2/0xab
Mar 14 09:39:19 mm-home1 [<c0146486>] buffered_rmqueue+0x251/0x275
Mar 14 09:39:19 mm-home1 [<c014244c>] file_read_actor+0x92/0xfe
Mar 14 09:39:19 mm-home1 [<c01422e4>] do_generic_mapping_read+0x4b7/0x58d
Mar 14 09:39:19 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:19 mm-home1 [<c014007b>] audit_avc_path+0x93/0x9b
Mar 14 09:39:19 mm-home1 [<c0146486>] buffered_rmqueue+0x251/0x275
Mar 14 09:39:19 mm-home1 [<c0142677>] __generic_file_aio_read+0x1bf/0x227
Mar 14 09:39:19 mm-home1 [<c014661e>] get_page_from_freelist+0xa7/0xbf
Mar 14 09:39:19 mm-home1 [<c014668c>] __alloc_pages+0x56/0x300
Mar 14 09:39:19 mm-home1 [<c0154869>] vma_adjust+0x1ff/0x38a
Mar 14 09:39:19 mm-home1 [<c0152d4a>] do_anonymous_page+0x50/0x19f
Mar 14 09:39:19 mm-home1 [<c0153307>] __handle_mm_fault+0x10a/0x302
Mar 14 09:39:19 mm-home1 [<c0115738>] do_page_fault+0x1b7/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:19 mm-home1 Code: 8d 14 76 c1 e0 07 03 44 24 14 8d 34 d0 8d 
ae 80 00 00 00 9c 8f 44 24 10 fa 8b 86 90 00 00 00 8d 53 1c 8d 8e 90 00 
00 00 89 43 1c <89> 50 04 89 4a 04 89 96 90 00 00 00 8b 86 80 00 00 00 
83 c0 01
Mar 14 09:39:19 mm-home1 <1>Fixing recursive fault but reboot is needed!
Mar 14 09:39:19 mm-home1 scheduling while atomic: 
thunderbird-bin/0x00000002/26335
Mar 14 09:39:19 mm-home1 [<c0439c45>] schedule+0xa21/0xd33
Mar 14 09:39:19 mm-home1 [<c01231f3>] tasklet_action+0x63/0xc2
Mar 14 09:39:19 mm-home1 [<c0122e73>] __do_softirq+0x6b/0xd8
Mar 14 09:39:19 mm-home1 [<c012088e>] do_exit+0x3a8/0x41d
Mar 14 09:39:19 mm-home1 [<c011007b>] __acpi_map_table+0xb/0xd6
Mar 14 09:39:19 mm-home1 [<c010414a>] do_trap+0x0/0x11d
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0115912>] do_page_fault+0x391/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:19 mm-home1 [<c01461a9>] free_hot_cold_page+0xe6/0x161
Mar 14 09:39:19 mm-home1 [<c01469dc>] __pagevec_free+0x16/0x1e
Mar 14 09:39:19 mm-home1 [<c014c689>] release_pages+0x161/0x176
Mar 14 09:39:19 mm-home1 [<c01512b9>] unmap_page_range+0xb4/0x13a
Mar 14 09:39:19 mm-home1 [<c0159d90>] free_pages_and_swap_cache+0x5d/0x83
Mar 14 09:39:19 mm-home1 [<c0151553>] unmap_vmas+0x214/0x24c
Mar 14 09:39:19 mm-home1 [<c015649a>] exit_mmap+0x93/0x13e
Mar 14 09:39:19 mm-home1 [<c011b564>] mmput+0x38/0x9b
Mar 14 09:39:19 mm-home1 [<c01205e2>] do_exit+0xfc/0x41d
Mar 14 09:39:19 mm-home1 [<c011e04a>] printk+0x17/0x1b
Mar 14 09:39:19 mm-home1 [<c010414a>] do_trap+0x0/0x11d
Mar 14 09:39:19 mm-home1 [<c01044a4>] do_invalid_op+0x0/0xab
Mar 14 09:39:19 mm-home1 [<c0104546>] do_invalid_op+0xa2/0xab
Mar 14 09:39:19 mm-home1 [<c0146486>] buffered_rmqueue+0x251/0x275
Mar 14 09:39:19 mm-home1 [<c014244c>] file_read_actor+0x92/0xfe
Mar 14 09:39:19 mm-home1 [<c01422e4>] do_generic_mapping_read+0x4b7/0x58d
Mar 14 09:39:19 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:19 mm-home1 [<c014007b>] audit_avc_path+0x93/0x9b
Mar 14 09:39:19 mm-home1 [<c0146486>] buffered_rmqueue+0x251/0x275
Mar 14 09:39:19 mm-home1 [<c0142677>] __generic_file_aio_read+0x1bf/0x227
Mar 14 09:39:19 mm-home1 [<c014661e>] get_page_from_freelist+0xa7/0xbf
Mar 14 09:39:19 mm-home1 [<c014668c>] __alloc_pages+0x56/0x300
Mar 14 09:39:19 mm-home1 [<c0154869>] vma_adjust+0x1ff/0x38a
Mar 14 09:39:19 mm-home1 [<c0152d4a>] do_anonymous_page+0x50/0x19f
Mar 14 09:39:19 mm-home1 [<c0153307>] __handle_mm_fault+0x10a/0x302
Mar 14 09:39:19 mm-home1 [<c0115738>] do_page_fault+0x1b7/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:19 mm-home1 Unable to handle kernel paging request at 
virtual address 00100104
Mar 14 09:39:19 mm-home1 printing eip:
Mar 14 09:39:19 mm-home1 c014629f
Mar 14 09:39:19 mm-home1 *pde = 00000000
Mar 14 09:39:19 mm-home1 Oops: 0000 [#7]
Mar 14 09:39:19 mm-home1 PREEMPT SMP
Mar 14 09:39:19 mm-home1 Modules linked in: lp vmnet vmmon snd_seq_midi 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event 
snd_seq eth1394 nls_utf8 rfcomm bnep l2cap snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus 
snd_page_alloc snd_util_mem snd_hwdep dv1394 video1394 raw1394 ohci1394 
ieee1394 w83627hf hwmon_vid i2c_isa eeprom i2c_dev i2c_i801 3c59x loop 
nvidia ntfs rtc dm_mod hci_usb bluetooth tsdev
Mar 14 09:39:19 mm-home1 CPU:    0
Mar 14 09:39:19 mm-home1 EIP:    0060:[<c014629f>]    Tainted: PF   B VLI
Mar 14 09:39:19 mm-home1 EFLAGS: 00010002   (2.6.15-gentoo-r1)
Mar 14 09:39:19 mm-home1 EIP is at buffered_rmqueue+0x6a/0x275
Mar 14 09:39:19 mm-home1 eax: 00100100   ebx: c04baa80   ecx: 001000e4 
  edx: c04baa80
Mar 14 09:39:19 mm-home1 esi: c04bab00   edi: e2706000   ebp: 00000246 
  esp: e2707e6c
Mar 14 09:39:19 mm-home1 ds: 007b   es: 007b   ss: 0068
Mar 14 09:39:19 mm-home1 Process kicker (pid: 16457, threadinfo=e2706000 
task=c0e50a70)
Mar 14 09:39:19 mm-home1 Stack: 000200d0 00000000 c0e50a70 c0132eb2 
e2707e7c e2707e7c 00000000 001000e4
Mar 14 09:39:19 mm-home1 c04bb128 00000044 00000000 00000003 c014661e 
c04baa80 00000000 000284d2
Mar 14 09:39:19 mm-home1 00000003 00000044 c04bb128 c0e50a70 000084d2 
c04baa80 c014668c 000284d2
Mar 14 09:39:19 mm-home1 Call Trace:
Mar 14 09:39:19 mm-home1 [<c0132eb2>] autoremove_wake_function+0x0/0x57
Mar 14 09:39:19 mm-home1 [<c014661e>] get_page_from_freelist+0xa7/0xbf
Mar 14 09:39:19 mm-home1 [<c014668c>] __alloc_pages+0x56/0x300
Mar 14 09:39:19 mm-home1 [<c0154869>] vma_adjust+0x1ff/0x38a
Mar 14 09:39:19 mm-home1 [<c0115188>] pte_alloc_one+0x11/0x12
Mar 14 09:39:19 mm-home1 [<c015094f>] __pte_alloc+0x2b/0xb6
Mar 14 09:39:19 mm-home1 [<c01533e9>] __handle_mm_fault+0x1ec/0x302
Mar 14 09:39:19 mm-home1 [<c0156339>] do_brk+0x1c7/0x295
Mar 14 09:39:19 mm-home1 [<c0115738>] do_page_fault+0x1b7/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:19 mm-home1 Code: 24 18 8d 1c c2 8d b3 80 00 00 00 9c 5d fa 
8b 83 80 00 00 00 3b 46 04 0f 8e 23 01 00 00 85 c0 74 28 8b 46 10 8d 48 
e4 89 4c 24 1c <8b> 48 04 8b 10 89 4a 04 89 11 c7 40 04 00 02 20 00 c7 
00 00 01
Mar 14 09:39:19 mm-home1 <6>note: kicker[16457] exited with preempt_count 1
Mar 14 09:39:19 mm-home1 Unable to handle kernel paging request at 
virtual address 00100104
Mar 14 09:39:19 mm-home1 printing eip:
Mar 14 09:39:19 mm-home1 c01461a9
Mar 14 09:39:19 mm-home1 *pde = 00000000
Mar 14 09:39:19 mm-home1 Oops: 0002 [#8]
Mar 14 09:39:19 mm-home1 PREEMPT SMP
Mar 14 09:39:19 mm-home1 Modules linked in: lp vmnet vmmon snd_seq_midi 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event 
snd_seq eth1394 nls_utf8 rfcomm bnep l2cap snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus 
snd_page_alloc snd_util_mem snd_hwdep dv1394 video1394 raw1394 ohci1394 
ieee1394 w83627hf hwmon_vid i2c_isa eeprom i2c_dev i2c_i801 3c59x loop 
nvidia ntfs rtc dm_mod hci_usb bluetooth tsdev
Mar 14 09:39:19 mm-home1 CPU:    0
Mar 14 09:39:19 mm-home1 EIP:    0060:[<c01461a9>]    Tainted: PF   B VLI
Mar 14 09:39:19 mm-home1 EFLAGS: 00010082   (2.6.15-gentoo-r1)
Mar 14 09:39:19 mm-home1 EIP is at free_hot_cold_page+0xe6/0x161
Mar 14 09:39:19 mm-home1 eax: 00100100   ebx: c1f90810   ecx: c04bab10 
  edx: c1f9082c
Mar 14 09:39:19 mm-home1 esi: c04baa80   edi: e2706000   ebp: c04bab00 
  esp: e2707c48
Mar 14 09:39:19 mm-home1 ds: 007b   es: 007b   ss: 0068
Mar 14 09:39:19 mm-home1 Process kicker (pid: 16457, threadinfo=e2706000 
task=c0e50a70)
Mar 14 09:39:19 mm-home1 Stack: 00000034 00000001 01cb3f60 000000b7 
00000282 c04baa80 00000001 e2707c84
Mar 14 09:39:19 mm-home1 c04baa80 00000008 c01469dc 00000002 c04baa80 
c014c689 e2707c84 00000002
Mar 14 09:39:19 mm-home1 00000000 c1ec59e0 c1f90810 650af065 c1f25b18 
fffffffe 00000000 f7a5e080
Mar 14 09:39:19 mm-home1 Call Trace:
Mar 14 09:39:19 mm-home1 [<c01469dc>] __pagevec_free+0x16/0x1e
Mar 14 09:39:19 mm-home1 [<c014c689>] release_pages+0x161/0x176
Mar 14 09:39:19 mm-home1 [<c01512b9>] unmap_page_range+0xb4/0x13a
Mar 14 09:39:19 mm-home1 [<c0159d90>] free_pages_and_swap_cache+0x5d/0x83
Mar 14 09:39:19 mm-home1 [<c0151553>] unmap_vmas+0x214/0x24c
Mar 14 09:39:19 mm-home1 [<c015649a>] exit_mmap+0x93/0x13e
Mar 14 09:39:19 mm-home1 [<c011b564>] mmput+0x38/0x9b
Mar 14 09:39:19 mm-home1 [<c01205e2>] do_exit+0xfc/0x41d
Mar 14 09:39:19 mm-home1 [<c010414a>] do_trap+0x0/0x11d
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0115912>] do_page_fault+0x391/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:19 mm-home1 [<c014629f>] buffered_rmqueue+0x6a/0x275
Mar 14 09:39:19 mm-home1 [<c0132eb2>] autoremove_wake_function+0x0/0x57
Mar 14 09:39:19 mm-home1 [<c014661e>] get_page_from_freelist+0xa7/0xbf
Mar 14 09:39:19 mm-home1 [<c014668c>] __alloc_pages+0x56/0x300
Mar 14 09:39:19 mm-home1 [<c0154869>] vma_adjust+0x1ff/0x38a
Mar 14 09:39:19 mm-home1 [<c0115188>] pte_alloc_one+0x11/0x12
Mar 14 09:39:19 mm-home1 [<c015094f>] __pte_alloc+0x2b/0xb6
Mar 14 09:39:19 mm-home1 [<c01533e9>] __handle_mm_fault+0x1ec/0x302
Mar 14 09:39:19 mm-home1 [<c0156339>] do_brk+0x1c7/0x295
Mar 14 09:39:19 mm-home1 [<c0115738>] do_page_fault+0x1b7/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:19 mm-home1 Code: 8d 14 76 c1 e0 07 03 44 24 14 8d 34 d0 8d 
ae 80 00 00 00 9c 8f 44 24 10 fa 8b 86 90 00 00 00 8d 53 1c 8d 8e 90 00 
00 00 89 43 1c <89> 50 04 89 4a 04 89 96 90 00 00 00 8b 86 80 00 00 00 
83 c0 01
Mar 14 09:39:19 mm-home1 <1>Fixing recursive fault but reboot is needed!
Mar 14 09:39:19 mm-home1 scheduling while atomic: kicker/0x00000003/16457
Mar 14 09:39:19 mm-home1 [<c0439c45>] schedule+0xa21/0xd33
Mar 14 09:39:19 mm-home1 [<c0122e73>] __do_softirq+0x6b/0xd8
Mar 14 09:39:19 mm-home1 [<c012088e>] do_exit+0x3a8/0x41d
Mar 14 09:39:19 mm-home1 [<c011007b>] __acpi_map_table+0xb/0xd6
Mar 14 09:39:19 mm-home1 [<c010414a>] do_trap+0x0/0x11d
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0115912>] do_page_fault+0x391/0x557
Mar 14 09:39:19 mm-home1 [<c03f0030>] tcp_send_dupack+0x93/0xfc
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:19 mm-home1 [<c01461a9>] free_hot_cold_page+0xe6/0x161
Mar 14 09:39:19 mm-home1 [<c01469dc>] __pagevec_free+0x16/0x1e
Mar 14 09:39:19 mm-home1 [<c014c689>] release_pages+0x161/0x176
Mar 14 09:39:19 mm-home1 [<c01512b9>] unmap_page_range+0xb4/0x13a
Mar 14 09:39:19 mm-home1 [<c0159d90>] free_pages_and_swap_cache+0x5d/0x83
Mar 14 09:39:19 mm-home1 [<c0151553>] unmap_vmas+0x214/0x24c
Mar 14 09:39:19 mm-home1 [<c015649a>] exit_mmap+0x93/0x13e
Mar 14 09:39:19 mm-home1 [<c011b564>] mmput+0x38/0x9b
Mar 14 09:39:19 mm-home1 [<c01205e2>] do_exit+0xfc/0x41d
Mar 14 09:39:19 mm-home1 [<c010414a>] do_trap+0x0/0x11d
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0115912>] do_page_fault+0x391/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:19 mm-home1 [<c014629f>] buffered_rmqueue+0x6a/0x275
Mar 14 09:39:19 mm-home1 [<c0132eb2>] autoremove_wake_function+0x0/0x57
Mar 14 09:39:19 mm-home1 [<c014661e>] get_page_from_freelist+0xa7/0xbf
Mar 14 09:39:19 mm-home1 [<c014668c>] __alloc_pages+0x56/0x300
Mar 14 09:39:19 mm-home1 [<c0154869>] vma_adjust+0x1ff/0x38a
Mar 14 09:39:19 mm-home1 [<c0115188>] pte_alloc_one+0x11/0x12
Mar 14 09:39:19 mm-home1 [<c015094f>] __pte_alloc+0x2b/0xb6
Mar 14 09:39:19 mm-home1 [<c01533e9>] __handle_mm_fault+0x1ec/0x302
Mar 14 09:39:19 mm-home1 [<c0156339>] do_brk+0x1c7/0x295
Mar 14 09:39:19 mm-home1 [<c0115738>] do_page_fault+0x1b7/0x557
Mar 14 09:39:19 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:19 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:30 mm-home1 Unable to handle kernel paging request at 
virtual address 00100104
Mar 14 09:39:30 mm-home1 printing eip:
Mar 14 09:39:30 mm-home1 c01461a9
Mar 14 09:39:30 mm-home1 *pde = 00000000
Mar 14 09:39:30 mm-home1 Oops: 0002 [#9]
Mar 14 09:39:30 mm-home1 PREEMPT SMP
Mar 14 09:39:30 mm-home1 Modules linked in: lp vmnet vmmon snd_seq_midi 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event 
snd_seq eth1394 nls_utf8 rfcomm bnep l2cap snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus 
snd_page_alloc snd_util_mem snd_hwdep dv1394 video1394 raw1394 ohci1394 
ieee1394 w83627hf hwmon_vid i2c_isa eeprom i2c_dev i2c_i801 3c59x loop 
nvidia ntfs rtc dm_mod hci_usb bluetooth tsdev
Mar 14 09:39:30 mm-home1 CPU:    0
Mar 14 09:39:30 mm-home1 EIP:    0060:[<c01461a9>]    Tainted: PF   B VLI
Mar 14 09:39:30 mm-home1 EFLAGS: 00010082   (2.6.15-gentoo-r1)
Mar 14 09:39:30 mm-home1 EIP is at free_hot_cold_page+0xe6/0x161
Mar 14 09:39:30 mm-home1 eax: 00100100   ebx: c1ec17ec   ecx: c04bab10 
  edx: c1ec1808
Mar 14 09:39:30 mm-home1 esi: c04baa80   edi: e2382000   ebp: c04bab00 
  esp: e2383e4c
Mar 14 09:39:30 mm-home1 ds: 007b   es: 007b   ss: 0068
Mar 14 09:39:30 mm-home1 Process vncviewer (pid: 16529, 
threadinfo=e2382000 task=f7a57a70)
Mar 14 09:39:30 mm-home1 Stack: 00000034 00000001 00000007 714b8067 
00000282 c04baa80 00000004 e2383e88
Mar 14 09:39:30 mm-home1 c04baa80 00000008 c01469dc 00000005 c04baa80 
c014c689 e2383e88 00000005
Mar 14 09:39:30 mm-home1 00000000 c1f159d8 c1f3a77c c1f15b64 c1fed534 
c1ec17ec 00000000 eedb3b80
Mar 14 09:39:30 mm-home1 Call Trace:
Mar 14 09:39:30 mm-home1 [<c01469dc>] __pagevec_free+0x16/0x1e
Mar 14 09:39:30 mm-home1 [<c014c689>] release_pages+0x161/0x176
Mar 14 09:39:30 mm-home1 [<c01512b9>] unmap_page_range+0xb4/0x13a
Mar 14 09:39:30 mm-home1 [<c0159d90>] free_pages_and_swap_cache+0x5d/0x83
Mar 14 09:39:30 mm-home1 [<c0151553>] unmap_vmas+0x214/0x24c
Mar 14 09:39:30 mm-home1 [<c015649a>] exit_mmap+0x93/0x13e
Mar 14 09:39:30 mm-home1 [<c011b564>] mmput+0x38/0x9b
Mar 14 09:39:30 mm-home1 [<c01205e2>] do_exit+0xfc/0x41d
Mar 14 09:39:30 mm-home1 [<c012096e>] do_group_exit+0x3c/0xa6
Mar 14 09:39:30 mm-home1 [<c0102e8f>] sysenter_past_esp+0x54/0x75
Mar 14 09:39:30 mm-home1 Code: 8d 14 76 c1 e0 07 03 44 24 14 8d 34 d0 8d 
ae 80 00 00 00 9c 8f 44 24 10 fa 8b 86 90 00 00 00 8d 53 1c 8d 8e 90 00 
00 00 89 43 1c <89> 50 04 89 4a 04 89 96 90 00 00 00 8b 86 80 00 00 00 
83 c0 01
Mar 14 09:39:30 mm-home1 <1>Fixing recursive fault but reboot is needed!
Mar 14 09:39:30 mm-home1 scheduling while atomic: vncviewer/0x00000002/16529
Mar 14 09:39:30 mm-home1 [<c0439c45>] schedule+0xa21/0xd33
Mar 14 09:39:30 mm-home1 [<c0102e8f>] sysenter_past_esp+0x54/0x75
Mar 14 09:39:30 mm-home1 [<c01461bd>] free_hot_cold_page+0xfa/0x161
Mar 14 09:39:30 mm-home1 [<c012088e>] do_exit+0x3a8/0x41d
Mar 14 09:39:30 mm-home1 [<c011e04a>] printk+0x17/0x1b
Mar 14 09:39:30 mm-home1 [<c010414a>] do_trap+0x0/0x11d
Mar 14 09:39:30 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:30 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:30 mm-home1 [<c0115912>] do_page_fault+0x391/0x557
Mar 14 09:39:30 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:30 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:30 mm-home1 [<c029007b>] udf_get_pblock_virt15+0x143/0x159
Mar 14 09:39:30 mm-home1 [<c01461a9>] free_hot_cold_page+0xe6/0x161
Mar 14 09:39:30 mm-home1 [<c01469dc>] __pagevec_free+0x16/0x1e
Mar 14 09:39:30 mm-home1 [<c014c689>] release_pages+0x161/0x176
Mar 14 09:39:30 mm-home1 [<c01512b9>] unmap_page_range+0xb4/0x13a
Mar 14 09:39:30 mm-home1 [<c0159d90>] free_pages_and_swap_cache+0x5d/0x83
Mar 14 09:39:30 mm-home1 [<c0151553>] unmap_vmas+0x214/0x24c
Mar 14 09:39:30 mm-home1 [<c015649a>] exit_mmap+0x93/0x13e
Mar 14 09:39:30 mm-home1 [<c011b564>] mmput+0x38/0x9b
Mar 14 09:39:30 mm-home1 [<c01205e2>] do_exit+0xfc/0x41d
Mar 14 09:39:30 mm-home1 [<c012096e>] do_group_exit+0x3c/0xa6
Mar 14 09:39:30 mm-home1 [<c0102e8f>] sysenter_past_esp+0x54/0x75
Mar 14 09:39:30 mm-home1 Unable to handle kernel paging request at 
virtual address 00100104
Mar 14 09:39:30 mm-home1 printing eip:
Mar 14 09:39:30 mm-home1 c014629f
Mar 14 09:39:30 mm-home1 *pde = 00000000
Mar 14 09:39:30 mm-home1 Oops: 0000 [#10]
Mar 14 09:39:30 mm-home1 PREEMPT SMP
Mar 14 09:39:30 mm-home1 Modules linked in: lp vmnet vmmon snd_seq_midi 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event 
snd_seq eth1394 nls_utf8 rfcomm bnep l2cap snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus 
snd_page_alloc snd_util_mem snd_hwdep dv1394 video1394 raw1394 ohci1394 
ieee1394 w83627hf hwmon_vid i2c_isa eeprom i2c_dev i2c_i801 3c59x loop 
nvidia ntfs rtc dm_mod hci_usb bluetooth tsdev
Mar 14 09:39:30 mm-home1 CPU:    0
Mar 14 09:39:30 mm-home1 EIP:    0060:[<c014629f>]    Tainted: PF   B VLI
Mar 14 09:39:30 mm-home1 EFLAGS: 00010002   (2.6.15-gentoo-r1)
Mar 14 09:39:30 mm-home1 EIP is at buffered_rmqueue+0x6a/0x275
Mar 14 09:39:30 mm-home1 eax: 00100100   ebx: c04baa80   ecx: 001000e4 
  edx: c04baa80
Mar 14 09:39:30 mm-home1 esi: c04bab00   edi: e2914000   ebp: 00000246 
  esp: e2915e6c
Mar 14 09:39:30 mm-home1 ds: 007b   es: 007b   ss: 0068
Mar 14 09:39:30 mm-home1 Process artsd (pid: 26339, threadinfo=e2914000 
task=f70dea70)
Mar 14 09:39:30 mm-home1 Stack: 00000000 01cb3f60 000000b7 01cabf60 
f7a4bb00 b7816000 00000000 001000e4
Mar 14 09:39:30 mm-home1 c04bb128 00000044 00000000 00000003 c014661e 
c04baa80 00000000 000280d2
Mar 14 09:39:30 mm-home1 00000003 00000044 c04bb128 f70dea70 000280d2 
c04baa80 c014668c 000280d2
Mar 14 09:39:30 mm-home1 Call Trace:
Mar 14 09:39:30 mm-home1 [<c014661e>] get_page_from_freelist+0xa7/0xbf
Mar 14 09:39:30 mm-home1 [<c014668c>] __alloc_pages+0x56/0x300
Mar 14 09:39:30 mm-home1 [<c0154869>] vma_adjust+0x1ff/0x38a
Mar 14 09:39:30 mm-home1 [<c0117838>] try_to_wake_up+0x332/0x410
Mar 14 09:39:30 mm-home1 [<c0152d4a>] do_anonymous_page+0x50/0x19f
Mar 14 09:39:30 mm-home1 [<c0153307>] __handle_mm_fault+0x10a/0x302
Mar 14 09:39:30 mm-home1 [<c0156339>] do_brk+0x1c7/0x295
Mar 14 09:39:30 mm-home1 [<c0115738>] do_page_fault+0x1b7/0x557
Mar 14 09:39:30 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:30 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:30 mm-home1 Code: 24 18 8d 1c c2 8d b3 80 00 00 00 9c 5d fa 
8b 83 80 00 00 00 3b 46 04 0f 8e 23 01 00 00 85 c0 74 28 8b 46 10 8d 48 
e4 89 4c 24 1c <8b> 48 04 8b 10 89 4a 04 89 11 c7 40 04 00 02 20 00 c7 
00 00 01
Mar 14 09:39:30 mm-home1 <6>note: artsd[26339] exited with preempt_count 1
Mar 14 09:39:44 mm-home1 Bad page state at prep_new_page (in process 
'X', page c2069230)
Mar 14 09:39:44 mm-home1 flags:0xc0000010 mapping:00000000 mapcount:-1 
count:1
Mar 14 09:39:44 mm-home1 Backtrace:
Mar 14 09:39:44 mm-home1 [<c01458e8>] bad_page+0x84/0xbc
Mar 14 09:39:44 mm-home1 [<c0145d4d>] prep_new_page+0x27/0x80
Mar 14 09:39:44 mm-home1 [<c0146354>] buffered_rmqueue+0x11f/0x275
Mar 14 09:39:44 mm-home1 [<c014661e>] get_page_from_freelist+0xa7/0xbf
Mar 14 09:39:44 mm-home1 [<c014668c>] __alloc_pages+0x56/0x300
Mar 14 09:39:44 mm-home1 [<c0152d4a>] do_anonymous_page+0x50/0x19f
Mar 14 09:39:44 mm-home1 [<c0153307>] __handle_mm_fault+0x10a/0x302
Mar 14 09:39:44 mm-home1 [<c0115738>] do_page_fault+0x1b7/0x557
Mar 14 09:39:44 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:44 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:44 mm-home1 Trying to fix it up, but a reboot is needed
Mar 14 09:39:44 mm-home1 Unable to handle kernel paging request at 
virtual address 00100104
Mar 14 09:39:44 mm-home1 printing eip:
Mar 14 09:39:44 mm-home1 c01461a9
Mar 14 09:39:44 mm-home1 *pde = 00000000
Mar 14 09:39:44 mm-home1 Oops: 0002 [#11]
Mar 14 09:39:44 mm-home1 PREEMPT SMP
Mar 14 09:39:44 mm-home1 Modules linked in: lp vmnet vmmon snd_seq_midi 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event 
snd_seq eth1394 nls_utf8 rfcomm bnep l2cap snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus 
snd_page_alloc snd_util_mem snd_hwdep dv1394 video1394 raw1394 ohci1394 
ieee1394 w83627hf hwmon_vid i2c_isa eeprom i2c_dev i2c_i801 3c59x loop 
nvidia ntfs rtc dm_mod hci_usb bluetooth tsdev
Mar 14 09:39:44 mm-home1 CPU:    0
Mar 14 09:39:44 mm-home1 EIP:    0060:[<c01461a9>]    Tainted: PF   B VLI
Mar 14 09:39:44 mm-home1 EFLAGS: 00013082   (2.6.15-gentoo-r1)
Mar 14 09:39:44 mm-home1 EIP is at free_hot_cold_page+0xe6/0x161
Mar 14 09:39:44 mm-home1 eax: 00100100   ebx: c21d3510   ecx: c04bab10 
  edx: c21d352c
Mar 14 09:39:44 mm-home1 esi: c04baa80   edi: f54ac000   ebp: c04bab00 
  esp: f54ade94
Mar 14 09:39:44 mm-home1 ds: 007b   es: 007b   ss: 0068
Mar 14 09:39:44 mm-home1 Process X (pid: 9988, threadinfo=f54ac000 
task=f7b28a70)
Mar 14 09:39:44 mm-home1 Stack: 00000034 00000001 c09ff06f c09ff06f 
00003282 c04baa80 00000000 f54aded0
Mar 14 09:39:44 mm-home1 c04baa80 00000001 c01469dc 00000001 c04baa80 
c014c689 f54aded0 00000001
Mar 14 09:39:44 mm-home1 00000000 c21d3510 c0150671 0000000c ffffffff 
b6c00000 c0150806 c220e900
Mar 14 09:39:44 mm-home1 Call Trace:
Mar 14 09:39:44 mm-home1 [<c01469dc>] __pagevec_free+0x16/0x1e
Mar 14 09:39:44 mm-home1 [<c014c689>] release_pages+0x161/0x176
Mar 14 09:39:44 mm-home1 [<c0150671>] free_pte_range+0x62/0xf2
Mar 14 09:39:44 mm-home1 [<c0150806>] free_pgd_range+0x105/0x195
Mar 14 09:39:44 mm-home1 [<c0159d90>] free_pages_and_swap_cache+0x5d/0x83
Mar 14 09:39:44 mm-home1 [<c0155da7>] unmap_region+0x13b/0x152
Mar 14 09:39:44 mm-home1 [<c01560a2>] do_munmap+0x10f/0x179
Mar 14 09:39:44 mm-home1 [<c0156151>] sys_munmap+0x45/0x66
Mar 14 09:39:44 mm-home1 [<c0102e8f>] sysenter_past_esp+0x54/0x75
Mar 14 09:39:44 mm-home1 Code: 8d 14 76 c1 e0 07 03 44 24 14 8d 34 d0 8d 
ae 80 00 00 00 9c 8f 44 24 10 fa 8b 86 90 00 00 00 8d 53 1c 8d 8e 90 00 
00 00 89 43 1c <89> 50 04 89 4a 04 89 96 90 00 00 00 8b 86 80 00 00 00 
83 c0 01
Mar 14 09:39:44 mm-home1 <6>note: X[9988] exited with preempt_count 2
Mar 14 09:39:44 mm-home1 scheduling while atomic: X/0x00000002/9988
Mar 14 09:39:44 mm-home1 [<c0439c45>] schedule+0xa21/0xd33
Mar 14 09:39:44 mm-home1 [<c011e429>] release_console_sem+0xb8/0xba
Mar 14 09:39:44 mm-home1 [<c011e1e8>] vprintk+0x19a/0x2b2
Mar 14 09:39:44 mm-home1 [<c043ab6f>] rwsem_down_read_failed+0x88/0x17b
Mar 14 09:39:44 mm-home1 [<c0121938>] .text.lock.exit+0x27/0x87
Mar 14 09:39:44 mm-home1 [<c01205e2>] do_exit+0xfc/0x41d
Mar 14 09:39:44 mm-home1 [<c010414a>] do_trap+0x0/0x11d
Mar 14 09:39:44 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:44 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:44 mm-home1 [<c0115912>] do_page_fault+0x391/0x557
Mar 14 09:39:44 mm-home1 [<c012711e>] update_wall_time+0x10/0x3b
Mar 14 09:39:44 mm-home1 [<c0115581>] do_page_fault+0x0/0x557
Mar 14 09:39:44 mm-home1 [<c0103a0f>] error_code+0x4f/0x54
Mar 14 09:39:44 mm-home1 [<c01461a9>] free_hot_cold_page+0xe6/0x161
Mar 14 09:39:44 mm-home1 [<c01469dc>] __pagevec_free+0x16/0x1e
Mar 14 09:39:44 mm-home1 [<c014c689>] release_pages+0x161/0x176
Mar 14 09:39:44 mm-home1 [<c0150671>] free_pte_range+0x62/0xf2
Mar 14 09:39:44 mm-home1 [<c0150806>] free_pgd_range+0x105/0x195
Mar 14 09:39:44 mm-home1 [<c0159d90>] free_pages_and_swap_cache+0x5d/0x83
Mar 14 09:39:44 mm-home1 [<c0155da7>] unmap_region+0x13b/0x152
Mar 14 09:39:44 mm-home1 [<c01560a2>] do_munmap+0x10f/0x179
Mar 14 09:39:44 mm-home1 [<c0156151>] sys_munmap+0x45/0x66
Mar 14 09:39:44 mm-home1 [<c0102e8f>] sysenter_past_esp+0x54/0x75
---------------- end ----------------
