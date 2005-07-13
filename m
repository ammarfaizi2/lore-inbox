Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVGMXS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVGMXS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVGMXPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 19:15:35 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:3564 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261934AbVGMXOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 19:14:51 -0400
Message-ID: <42D5A066.20501@ribosome.natur.cuni.cz>
Date: Thu, 14 Jul 2005 01:14:46 +0200
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Oops: 2.6.13-rc2 at vma_prio_tree_remove
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  has anybody seen this? I have 2.6.13-rc2 kernel on intel P4 box.

Unable to handle kernel paging request at virtual address 00040034
 printing eip:
c014937e
*pde = 00000000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in: radeon drm parport_pc lp parport snd_rtctimer snd_seq_virmidi snd_seq_midi snd_rawmidi snd_intel8x0 snd_ac97_codec snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd uhci_hcd ohci_hcd ehci_hcd intel_agp agpgart
CPU:    0
EIP:    0060:[<c014937e>]    Not tainted VLI
EFLAGS: 00010206   (2.6.13-rc2) 
EIP is at vma_prio_tree_remove+0x47/0x100
eax: dc7561fc   ebx: dc7561fc   ecx: f6b3df74   edx: f6b3df88
esi: 00040000   edi: eb1b4f70   ebp: e7b1defc   esp: e7b1deec
ds: 007b   es: 007b   ss: 0068
Process make (pid: 11893, threadinfo=e7b1c000 task=f6643b10)
Stack: f6b3df88 dc7561fc dc7561fc eb1b4f70 e7b1df08 c014dcc2 f6b3df74 e7b1df1c 
       c014dd11 f1d74db4 dc7561fc dab68dd0 e7b1df48 c014fc6d 00000000 ffffffff 
       e7b1df38 00000000 c05a6618 00000049 dab68dd0 dab68e0c f6643b10 e7b1df58 
Call Trace:
 [<c0103e0c>] show_stack+0x7a/0x90
 [<c0103f91>] show_registers+0x156/0x1ce
 [<c0104196>] die+0xf4/0x17e
 [<c0117655>] do_page_fault+0x434/0x613
 [<c0103a6b>] error_code+0x4f/0x54
 [<c014dcc2>] __remove_shared_vm_struct+0x39/0x53
 [<c014dd11>] remove_vm_struct+0x35/0x95
 [<c014fc6d>] exit_mmap+0x125/0x156
 [<c011d15d>] mmput+0x35/0xa0
 [<c0121005>] exit_mm+0x88/0x109
 [<c01219d2>] do_exit+0xcd/0x42e
 [<c0121da2>] do_group_exit+0x3a/0xbe
 [<c0121e35>] sys_exit_group+0xf/0x11
 [<c0102f67>] sysenter_past_esp+0x54/0x75
Code: 48 30 85 c9 0f 85 8e 00 00 00 8d 40 28 8b 53 28 8b 48 04 89 4a 04 89 11 89 40 04 89 43 28 8b 5d f4 8b 75 f8 8b 7d fc 89 ec 5d c3 <39> 46 34 0f 85 a3 00 00 00 8b 53 30 85 d2 74 2f 8d 4e 28 8b 56 
 <1>Fixing recursive fault but reboot is needed!
scheduling while atomic: make/0x00000001/11893
 [<c0103e39>] dump_stack+0x17/0x19
 [<c03d98db>] schedule+0x58d/0x653
 [<c0121cb3>] do_exit+0x3ae/0x42e
 [<c0104220>] do_trap+0x0/0xb8
 [<c0117655>] do_page_fault+0x434/0x613
 [<c0103a6b>] error_code+0x4f/0x54
 [<c014dcc2>] __remove_shared_vm_struct+0x39/0x53
 [<c014dd11>] remove_vm_struct+0x35/0x95
 [<c014fc6d>] exit_mmap+0x125/0x156
 [<c011d15d>] mmput+0x35/0xa0
 [<c0121005>] exit_mm+0x88/0x109
 [<c01219d2>] do_exit+0xcd/0x42e
 [<c0121da2>] do_group_exit+0x3a/0xbe
 [<c0121e35>] sys_exit_group+0xf/0x11
 [<c0102f67>] sysenter_past_esp+0x54/0x75


It happened to me just when compiling 2.6.13-rc3 kernel:

...
  LD [M]  drivers/char/drm/radeon.o
  LD [M]  drivers/char/drm/mga.o
  CC [M]  drivers/input/misc/uinput.o
Ooops!


Please cc: me in replies. Thanks.
