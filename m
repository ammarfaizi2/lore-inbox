Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268758AbUI2SIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268758AbUI2SIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUI2SIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:08:42 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:23709 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S268758AbUI2SIV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:08:21 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2: isofs oops
Date: Wed, 29 Sep 2004 20:08:16 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409292008.17149.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just got a segmentation fault from mount and dmesg shows this oops:


ISO 9660 Extensions: RRIP_1991A
Unable to handle kernel paging request at virtual address edc80ef4
 printing eip:
c01470eb
*pde = 005f2067
Oops: 0000 [#1]
SMP DEBUG_PAGEALLOC
Modules linked in: sg snd_pcm_oss snd_pcm snd_timer snd_page_alloc i2c_dev lp parport_pc mga snd_mixer_oss par
port snd uhci_hcd ohci_hcd md w83627hf eeprom lm75 i2c_sensor i2c_isa i2c_viapro i2c_core sata_via sd_mod
CPU:    0
EIP:    0060:[<c01470eb>]    Not tainted VLI
EFLAGS: 00010002   (2.6.9-rc2-tc1) 
EIP is at cache_free_debugcheck+0x1fb/0x290
eax: edc80ef4   ebx: 80052c00   ecx: edc80000   edx: c193f640
esi: edc7b258   edi: edc80000   ebp: ebd89d08   esp: ebd89cf8
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 16261, threadinfo=ebd88000 task=f5459a90)
Stack: 2dc80000 c194df78 c193f640 edc80ef8 ebd89d2c c0147d5f c193f640 edc80ef8 
       c01ec1a2 00000282 00000000 00000000 edc80ef8 ebd89d6c c01ec1a2 edc80ef8 
       00000027 0000000e 0000000a 0000001c 00000002 edc80ef8 00000000 00000000 
Call Trace:
 [<c01083a5>] show_stack+0x75/0x90
 [<c0108505>] show_registers+0x125/0x190
 [<c01086e4>] die+0xe4/0x170
 [<c011b294>] do_page_fault+0x2e4/0x5b4
 [<c0107f7d>] error_code+0x2d/0x40
 [<c0147d5f>] kfree+0x4f/0x90
 [<c01ec1a2>] parse_rock_ridge_inode_internal+0x1b2/0x630
 [<c01ec7b4>] parse_rock_ridge_inode+0x14/0x50
 [<c01eb318>] isofs_read_inode+0x288/0x400
 [<c01eb537>] isofs_iget+0x57/0x70
 [<c01ea6dc>] isofs_fill_super+0x3cc/0x670
 [<c01629f3>] get_sb_bdev+0x103/0x140
 [<c01eb56d>] isofs_get_sb+0x1d/0x30
 [<c0162bc4>] do_kern_mount+0x44/0xc0
 [<c0177a38>] do_new_mount+0x78/0xb0
 [<c01780cf>] do_mount+0x13f/0x190
 [<c01784ba>] sys_mount+0x9a/0x100
 [<c0106ed9>] sysenter_past_esp+0x52/0x79
Code: c0 e9 00 ff ff ff 8b 4d 08 57 51 e8 10 e4 ff ff 8b 55 10 89 10 58 8b 45 08 5a 8b 58 54 e9 c7 fe ff ff 57
 52 e8 87 e3 ff ff 5a 59 <81> 38 a5 c2 0f 17 74 6d 8b 45 08 68 a0 31 42 c0 50 68 f1 5b 40 
 

Please ignore the kernel extension -tc1, its just for making several 
configurations easier and doesn't mean any additional patches.

Thanks,
	Bernd

-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
