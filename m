Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVBMGHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVBMGHY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 01:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVBMGHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 01:07:24 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53920 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261251AbVBMGHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 01:07:16 -0500
Subject: Oops with oprofile + RT preempt 2.6.11-rc2-RT-V0.7.37-01
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 13 Feb 2005 01:07:15 -0500
Message-Id: <1108274835.3739.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any known incompatibilities with oprofile and the RT preempt patch?

Lee

Oops: 0000 [#1]
PREEMPT 
Modules linked in: realtime commoncap af_packet via_rhine mii crc32 ehci_hcd usbhid uhci_hcd usbcore via_
agp agpgart evdev snd_rtctimer snd_emu10k1_synth snd_emu10k1 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_emux_synth snd_seq_virmidi s
nd_seq_midi_emul snd_seq_midi snd_rawmidi snd_seq_oss snd_seq_midi_event snd_seq snd_timer snd_seq_device snd_hwdep snd_util_mem snd snd_page_
alloc
CPU:    0
EIP:    0060:[oprofilefs_str_to_user+21/64]    Not tainted VLI
EFLAGS: 00010246   (2.6.11-rc2-RT-V0.7.37-01) 
EIP is at oprofilefs_str_to_user+0x15/0x40
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: 00000000
esi: d593b6a0   edi: 00000000   ebp: cb966f6c   esp: cb966f68
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process cat (pid: 3290, threadinfo=cb966000 task=d083ce10)
Stack: cb966fa8 cb966f90 c01529ec 00000000 0804d038 00001000 cb966fa8 d593b6a0 
       fffffff7 0804d038 cb966fbc c0152cc1 d593b6a0 0804d038 00001000 cb966fa8 
       00000000 00000000 00000000 00000003 00001000 cb966000 c01026a4 00000003 
Call Trace:
  [show_stack+133/160] show_stack+0x85/0xa0 (32)
  [show_registers+299/400] show_registers+0x12b/0x190 (40)
  [die+219/384] die+0xdb/0x180 (52)
  [do_page_fault+824/1629] do_page_fault+0x338/0x65d (212)
  [error_code+43/48] error_code+0x2b/0x30 (64)
  [vfs_read+188/320] vfs_read+0xbc/0x140 (36)
  [sys_read+65/112] sys_read+0x41/0x70 (44)
  [syscall_call+7/11] syscall_call+0x7/0xb (-4028)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [die+56/384] .... die+0x38/0x180
.....[do_page_fault+824/1629] ..   ( <= do_page_fault+0x338/0x65d)
.. [print_traces+19/80] .... print_traces+0x13/0x50
.....[show_stack+133/160] ..   ( <= show_stack+0x85/0xa0)

Code: 89 43 44 89 53 48 89 d8 8b 5d fc 89 ec 5d c3 8d b4 26 00 00 00 00 55 89 e5 57 e8 ab 49 ee ff 8b 55 
08 31 c0 b9 ff ff ff ff 89 d7 <f2> ae f7 d1 49 51 52 8b 45 14 8b 7d 10 50 57 8b 4d 0c 51 e8 73 
  <1>BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c02284a5
*pde = 00000000

