Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261348AbTCGFFX>; Fri, 7 Mar 2003 00:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbTCGFFX>; Fri, 7 Mar 2003 00:05:23 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:36228
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261348AbTCGFFW>; Fri, 7 Mar 2003 00:05:22 -0500
Date: Fri, 7 Mar 2003 00:13:51 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Oops: 2.5.64 check_obj_poison for 'size-64'
Message-ID: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just popped up on my screen, seems to have been triggered by sar/cron 
(i'll probably have to reboot the box soon)

slab error in check_poison_obj(): cache `size-64': object was modified after freeing
Call Trace:
 [<c0142226>] check_poison_obj+0x66/0x70
 [<c0143b92>] kmalloc+0xd2/0x180
 [<c0166078>] pipe_new+0x28/0xd0
 [<c0166153>] get_pipe_inode+0x23/0xb0
 [<c0166212>] do_pipe+0x32/0x1e0
 [<c0111ed3>] sys_pipe+0x13/0x60
 [<c010ad9b>] syscall_call+0x7/0xb

Unable to handle kernel paging request at virtual address 2020202b
 printing eip:
c010cbd7
*pde = 5a5a5a5a
Oops: 0002
CPU:    0
EIP:    0060:[<c010cbd7>]    Not tainted
EFLAGS: 00010283
EIP is at show_interrupts+0x237/0x270
eax: 20202020   ebx: e4f798a4   ecx: 00000000   edx: 0000000b
esi: c02ba31b   edi: 00000020   ebp: 00000000   esp: e424df00
ds: 007b   es: 007b   ss: 0068
Process sadc (pid: 1250, threadinfo=e424c000 task=e43780e0)
Stack: 00000390 c03b40a0 000000e0 00000001 e4f799bc 00000001 e4f799bc c0178e68 
       e4f799bc 00000001 e424df38 00000000 e424df48 00000001 00000000 00000000 
       e41d1870 e457ae84 e4649ef0 e4649ee4 00000000 40014000 e3830b54 00000400 
Call Trace:
 [<c0178e68>] seq_read+0x108/0x2c0
 [<c01590d8>] vfs_read+0xa8/0x160
 [<c01593ca>] sys_read+0x2a/0x40
 [<c010ad9b>] syscall_call+0x7/0xb

Code: c6 04 02 0a ff 43 0c a1 60 6a 3b c0 50 68 21 a3 2b c0 53 e8 

(gdb) list *show_interrupts+0x237
0xc010cbd7 is in show_interrupts (include/linux/seq_file.h:40).
35	int seq_escape(struct seq_file *, const char *, const char *);
36	
37	static inline int seq_putc(struct seq_file *m, char c)
38	{
39		if (m->count < m->size) {
40			m->buf[m->count++] = c;
41			return 0;
42		}
43		return -1;
 
-- 
function.linuxpower.ca
