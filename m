Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUGGTSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUGGTSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 15:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUGGTSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 15:18:39 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:15373 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S265264AbUGGTSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 15:18:36 -0400
Date: Wed, 7 Jul 2004 21:18:38 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: psmouse.c forced kernel BUG at fs/devfs/base.c:2100!
Message-ID: <20040707191838.GA30334@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 It BUGed without any visible reason after my trackball lost
synchronization. Relevelant dmesg part:

#v
psmouse.c: bad data from KBC - bad parity
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
psmouse.c: bad data from KBC - timeout
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
devfs_d_iput(0): de: cfe174ec dentry: ceb860e4 de->dentry: c62252a0
Forcing Oops
------------[ cut here ]------------
kernel BUG at fs/devfs/base.c:2100!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: binfmt_misc lp parport_pc parport uhci_hcd usbcore snd_via82xx snd_ac97_codec snd_mpu401_uart snd_bt87x ipt_MARK ipt_REJECT sch_sfq sch_tbf sch_prio 8139too crc32 e1000 ir_kbd_gpio ir_common tuner tvaudio bttv video_buf btcx_risc via686a i2c_sensor i2c_isa floppy
CPU:    0
EIP:    0060:[<c01b59cb>]    Not tainted
EFLAGS: 00010246   (2.6.7) 
EIP is at devfs_d_iput+0x5b/0xa0
eax: 0000000d   ebx: cfe174ec   ecx: 00000000   edx: cfe3fedc
esi: ceb860e4   edi: c3904ee0   ebp: cfe3f000   esp: cfe3fed8
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 49, threadinfo=cfe3f000 task=cfe685d0)
Stack: c03a5c8a c0393a23 cfe17539 cfe174ec ceb860e4 c62252a0 ceb860e4 c3904ee0 
       0000001b c0166113 cfe3f000 00000080 cfe3f000 00000000 cffeea88 c0166596 
       c013d971 0781fa38 00000000 cfe3f000 0000a8e2 00000b61 00000000 000000d0 
Call Trace:
 [<c0166113>] prune_dcache+0x1c3/0x1f0
 [<c0166596>] shrink_dcache_memory+0x16/0x20
 [<c013d971>] shrink_slab+0x141/0x180
 [<c013ed53>] balance_pgdat+0x193/0x220
 [<c013ee98>] kswapd+0xb8/0xd0
 [<c0115340>] autoremove_wake_function+0x0/0x50
 [<c0103e62>] ret_from_fork+0x6/0x14
 [<c0115340>] autoremove_wake_function+0x0/0x50
 [<c013ede0>] kswapd+0x0/0xd0
 [<c010229d>] kernel_thread_helper+0x5/0x18

Code: 0f 0b 34 08 98 5c 3a c0 8d b6 00 00 00 00 8d bc 27 00 00 00 

#v-

.config attached, contact me out of list if more info needed.

-- 
Tomasz Torcz                Only gods can safely risk perfection,     
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia

