Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263477AbTJBULJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 16:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTJBULI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 16:11:08 -0400
Received: from bcsii.com ([67.114.178.171]:7829 "EHLO mail.bcsii.com")
	by vger.kernel.org with ESMTP id S263477AbTJBUK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 16:10:59 -0400
Message-ID: <3F7C8742.5090907@bcsii.net>
Date: Thu, 02 Oct 2003 13:14:58 -0700
From: Andriy Rysin <arysin@bcsii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20030929
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext3 crash with 2.4.22: Assertion failure in journal_forget_R10d91946()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having crashes on ext3 with 2.4.22 kernel. System was up for 8 
days. I am not sure I can reproduce it real quick but we've seen it 
occasionly on 2.4.20 for about several months and after we updated to 
2.4.22 it's here again.

please CC me if you answer or need more information.

Andriy

the log looks like this:

Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
ext3_free_blocks: Freeing blocks not in datazone - bloc
k = 2907885836, count = 1
Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
ext3_free_blocks: Freeing blocks not in datazone - bloc
k = 1660415916, count = 1
Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
ext3_free_blocks: Freeing blocks not in datazone - bloc
k = 1438298218, count = 1
Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
ext3_free_blocks: Freeing blocks not in datazone - bloc
k = 4209573569, count = 1
Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
ext3_free_blocks: Freeing blocks not in datazone - bloc
k = 2918065562, count = 1
......
Sep 29 21:05:18 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
ext3_free_blocks: bit already cleared for block 5970190
......
Oct  2 00:43:53 dunne-demo kernel: hda: dma_timer_expiry: dma status == 0x20
Oct  2 00:43:53 dunne-demo kernel: hda: timeout waiting for DMA
Oct  2 00:43:53 dunne-demo kernel: hda: timeout waiting for DMA
Oct  2 00:43:53 dunne-demo kernel: hda: (__ide_dma_test_irq) called 
while not waiting
Oct  2 00:43:53 dunne-demo kernel: hda: status timeout: status=0xd0 { Busy }
Oct  2 00:43:53 dunne-demo kernel:
Oct  2 00:43:53 dunne-demo kernel: hda: drive not ready for command
Oct  2 00:43:53 dunne-demo kernel: ide0: reset: success
Oct  2 00:44:34 dunne-demo logger: DMA is off, switching back on
......
Oct  2 12:40:11 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
ext3_free_blocks: Freeing blocks not in datazone - bloc
k = 743239489, count = 1
Oct  2 12:40:11 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
ext3_free_blocks: Freeing blocks not in datazone - bloc
k = 1661028389, count = 1
......
Oct  2 12:40:47 dunne-demo kernel: Assertion failure in 
journal_forget_R10d91946() at transaction.c:1259: "!jh->b_committed_
data"
Oct  2 12:40:47 dunne-demo kernel: ------------[ cut here ]------------
Oct  2 12:40:47 dunne-demo kernel: kernel BUG at transaction.c:1259!
Oct  2 12:40:47 dunne-demo kernel: invalid operand: 0000
Oct  2 12:40:47 dunne-demo kernel: it87 i2c-proc i2c-isa snd-pcm-oss 
snd-mixer-oss vfat fat floppy snd-emu10k1 snd-util-mem
snd-hwdep snd-intel8x0 snd-pcm snd-timer snd-ac97-codec snd-mpu401-ua
Oct  2 12:40:47 dunne-demo kernel: CPU:    0
Oct  2 12:40:47 dunne-demo kernel: EIP:    0060:[<e08177fd>]    Tainted: P
Oct  2 12:40:47 dunne-demo kernel: EFLAGS: 00010286
Oct  2 12:40:47 dunne-demo kernel:
Oct  2 12:40:47 dunne-demo kernel: EIP is at journal_forget_R10d91946 
[jbd] 0x1cd (2.4.22-20.1.2024.2.36.nptl)
Oct  2 12:40:47 dunne-demo kernel: eax: 00000062   ebx: c4ebd80c   ecx: 
00000001   edx: 00000001
Oct  2 12:40:47 dunne-demo kernel: esi: cfdaf264   edi: dffe7c50   ebp: 
dffe7bdc   esp: c1e51cc4
Oct  2 12:40:47 dunne-demo kernel: ds: 0068   es: 0068   ss: 0068
Oct  2 12:40:47 dunne-demo kernel: Process rm (pid: 31074, 
stackpage=c1e51000)
Oct  2 12:40:47 dunne-demo kernel: Stack: e081e520 e081decd e081dd30 
000004eb e081dee6 d669c434 01000000 c0ace834
Oct  2 12:40:47 dunne-demo kernel:        dea31864 dea31864 e0827a57 
dea31864 c4ebd80c cc4a191c c1e50000 dea31864
Oct  2 12:40:47 dunne-demo kernel:        c0107ad8 cd268000 01000000 
01000000 cc4a1e70 c1e50000 e0829f49 dea31864
Oct  2 12:40:47 dunne-demo kernel: Call Trace:   [<e081e520>] 
.rodata.str1.32 [jbd] 0x40 (0xc1e51cc4)
Oct  2 12:40:47 dunne-demo kernel: [<e081decd>] .rodata.str1.1 [jbd] 
0x1ad (0xc1e51cc8)
Oct  2 12:40:47 dunne-demo kernel: [<e081dd30>] .rodata.str1.1 [jbd] 
0x10 (0xc1e51ccc)
Oct  2 12:40:47 dunne-demo kernel: [<e081dee6>] .rodata.str1.1 [jbd] 
0x1c6 (0xc1e51cd4)
Oct  2 12:40:47 dunne-demo kernel: [<e0827a57>] ext3_forget [ext3] 0x67 
(0xc1e51cec)
Oct  2 12:40:47 dunne-demo kernel: [<c0107ad8>] __switch_to [kernel] 
0x148 (0xc1e51d04)
Oct  2 12:40:47 dunne-demo kernel: [<e0829f49>] ext3_clear_blocks [ext3] 
0x119 (0xc1e51d1c)
Oct  2 12:40:47 dunne-demo kernel: [<c01198b8>] schedule [kernel] 0x118 
(0xc1e51d44)
Oct  2 12:40:47 dunne-demo kernel: [<e082a0a7>] ext3_free_data [ext3] 
0xa7 (0xc1e51d64)
Oct  2 12:40:47 dunne-demo kernel: [<c011ad19>] context_switch [kernel] 
0x79 (0xc1e51d90)
Oct  2 12:40:47 dunne-demo kernel: [<e082a425>] ext3_free_branches 
[ext3] 0x275 (0xc1e51dbc)
Oct  2 12:40:47 dunne-demo kernel: [<c014795a>] bread [kernel] 0x8a 
(0xc1e51df8)
Oct  2 12:40:47 dunne-demo kernel: [<e082a273>] ext3_free_branches 
[ext3] 0xc3 (0xc1e51e0c)
Oct  2 12:40:47 dunne-demo kernel: [<c014795a>] bread [kernel] 0x8a 
(0xc1e51e48)
Oct  2 12:40:47 dunne-demo kernel: [<e082a273>] ext3_free_branches 
[ext3] 0xc3 (0xc1e51e5c)
Oct  2 12:40:47 dunne-demo kernel: [<e0827bdc>] start_transaction [ext3] 
0x8c (0xc1e51e94)
Oct  2 12:40:47 dunne-demo kernel: [<e082a7d8>] ext3_truncate [ext3] 
0x398 (0xc1e51eac)
Oct  2 12:40:47 dunne-demo kernel: [<e081623a>] start_this_handle [jbd] 
0x9a (0xc1e51ec8)
Oct  2 12:40:47 dunne-demo kernel: [<e0816425>] journal_start_R1b781ba1 
[jbd] 0xa5 (0xc1e51ef4)
Oct  2 12:40:47 dunne-demo kernel: [<e0827bdc>] start_transaction [ext3] 
0x8c (0xc1e51f18)
Oct  2 12:40:47 dunne-demo kernel: [<e0827d7f>] ext3_delete_inode [ext3] 
0x10f (0xc1e51f30)
Oct  2 12:40:47 dunne-demo kernel: [<e082d93d>] ext3_unlink [ext3] 0x10d 
(0xc1e51f38)
Oct  2 12:40:47 dunne-demo kernel: [<e0827c70>] ext3_delete_inode [ext3] 
0x0 (0xc1e51f44)
Oct  2 12:40:47 dunne-demo kernel: [<c015c6d6>] iput [kernel] 0x116 
(0xc1e51f4c)
Oct  2 12:40:47 dunne-demo kernel: [<c01529d1>] vfs_unlink [kernel] 0xf1 
(0xc1e51f68)
Oct  2 12:40:47 dunne-demo kernel: [<c0152c17>] sys_unlink [kernel] 
0x117 (0xc1e51f84)
Oct  2 12:40:47 dunne-demo kernel: [<c0109a0f>] system_call [kernel] 
0x33 (0xc1e51fc0)
Oct  2 12:40:47 dunne-demo kernel:
Oct  2 12:40:47 dunne-demo kernel:
Oct  2 12:40:47 dunne-demo kernel: Code: 0f 0b eb 04 30 dd 81 e0 e9 51 
ff ff ff c7 44 24 10 fc de 81


