Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUGZLGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUGZLGG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 07:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbUGZLF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 07:05:58 -0400
Received: from debug.office.uw.ru ([212.119.104.166]:34242 "EHLO
	debug.office.uw.ru") by vger.kernel.org with ESMTP id S265181AbUGZLFp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 07:05:45 -0400
Message-ID: <4104E587.1050606@office.uw.ru>
Date: Mon, 26 Jul 2004 15:05:43 +0400
From: Ilyak Kasnacheev <ilyak@office.uw.ru>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel panic (reiserfs), some hangs - bad hardware?.
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have following problems:

1) (looks like )Applications such as oggenc or flac, who mmap() output files and write into mapped memory area, produce corrupted files on my system. ~1 error on 10-100M, resulting file just some bytes different from what program wrote.
Second attempts always removes error (while may cause new one with same proportion)
More errors on intensive IO/bad interface cable, less errors on no other IO/good cable. Tried 2.6.7 vanilla kernel.
Am i crazy?
2) With bad interface cable, my system used to just hang. With better?/40pin cable, it do this very rare.
Memtest86 and burncpu do not produce errors, and windows works fine on same box. Both 2.4.x and 2.6.7 kernels.
3) Main. I have got a reiserfs partition with some errors (due to 2)), and kernel panics on it when i do 'find /'.
with these errors:
==
double fault, gdt at c03d2000 [255 bytes]
double fault, tss at c030e80
eip = c0115116
esp = cd0e98b0768
eax = 00000a96 ebx = cf2a547c ecx = 0f0001e3 edx = 0f000000
esi = 00000000 edi = c0115030
 *OR*
EFLAGS: 0010007 (2.6.7)
EIP is at scheduler_tick+0x108/0x400
eax: 00000000 ebx: 00000001 ecx: 0000023d edx: 00000000
esi: ca0a9750 edi: c0343520 ebp: ca0a7d4c esp: ca0a7d30
ds: 007b es: 007b ss: 0068
Process (pid: -1048345824, threadinfo = ca0a6000, task=ca0a9750)
Stack: c188a23c 00145ad7 00000000 3d108500 00000000 00000001 00000000
       ca0a7dd4 c0121606 00000000 00000001 00000001 00000000 ca0a6000
       ca0a7dd4 c0121834 00000000 ca0a6000 c010a2ce ca0a7dd4 c02d51c4
       20000001 00000000 c010632a

Trace:
c0121606	update_process_times+0x46/0x60
c0121834	do_timer+0x34/0xf0
c010a2ce	timer_interrupt+0x4e/0x120
c010632a	handle_IRQ_event+0x3a/0x70
c01066c1	do_IRQ+0x91/0x130
c0124a48	common_interrupt+0x18/0x20
c01ba80a	_mmx_memcpy+0x8a/0x170
d08c8630	reiserfs_readdir+0x4c0/0x560		[reiserfs]
c0127052	in_group_p+0x42/0x80
d08e5fa9	__reiserfs_permission+0x169/0x260	[reiserfs]

Code: 0f ba 68 08 03 83 c4 10 56 5e 5f c9 c3 b8 00 e0 ff ff 21 e0

Panic: Fatal exception in interrupt
==
Both 2.4.x and 2.6.7. Running fsck.reiserfs --rebuild-trees cured problem,
but should it behave like this anyway?
I have this kernel and this filesystem image, and will assist if someone will go fix this.
All numbers here was transferred by screen-paper-screen, so are not guaranted to be correct.
4) I have sacred cow files on my XFS system (again thanx to 2)).
They exist, but can not be stat()ed and deleted.
like this:
==
(1)/usr/share/locale/gr% LANG=C ls
ls: ESSAGES: No such file or directory
ls: : No such file or directory
ls: : No such file or directory
ls: : No such file or directory
ls: : No such file or directory
ls: : No such file or directory
ls: : No such file or directory
ls: džI"Ps?A`0V+A`pS+A`3U^?: No such file or directory
ls: : No such file or directory
ls: : No such file or directory
ls: : No such file or directory
ls: : No such file or directory
ls: : No such file or directory
ls: : No such file or directory
ls: : No such file or directory
ls: : No such file or directory
ls: A"pT--I^PdžI"?a*RE^PZ+: Invalid argument
ls: : No such file or directory
ls: : No such file or directory
ls: : No such file or directory
==
fsck.xfs looks pretty like void main() {};, what should i do?

P.S. Athlon 1333, Via KT266 (Elitegroup motherboard), Seagate Barracuda (don't actually remember model, ST2x0036A?).
Kernel 2.6.7.
Checked with memtest86 (3 passes), cpuburn (25 mins), SeaTools (controller, simple, and full tests) - all OK.

P.P.S. Please CC responces to me.


