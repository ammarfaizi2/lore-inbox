Return-Path: <linux-kernel-owner+w=401wt.eu-S965113AbWLVMRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWLVMRk (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 07:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWLVMRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 07:17:40 -0500
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:52253 "EHLO
	post-25.mail.nl.demon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965113AbWLVMRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 07:17:39 -0500
X-Greylist: delayed 1066 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 07:17:39 EST
Message-ID: <458BC8AE.2030507@edsons.demon.nl>
Date: Fri, 22 Dec 2006 12:59:42 +0100
From: Rudy Zijlstra <rudy@edsons.demon.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7.12) Gecko/20050923
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nfs@lists.sourceforge.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel BUG
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a system where whenever i trigger a ongoing consistent NFS load i 
get the following kernel BUG:

----------
kernel BUG at mm/truncate.c:311!
invalid opcode: 0000 [#1]
SMP
Modules linked in: cx88_alsa cx88_dvb cx88_vp3054_i2c or51132 
video_buf_dvb isl6421 zl10353
cx24123 cx22702 cx88_blackbird cx8802 cx2341x cx8800 cx88xx ir_common 
i2c_algo_bit tveeprom
compat_ioctl32 btcx_risc i2c_piix4 b2c2_flexcop_pci b2c2_flexcop mt352 
mt312 bcm3510 stv0297
 nxt200x lgdt330x budget_av dvb_pll saa7146_vv video_buf videodev 
v4l1_compat v4l2_common tu
a6100 budget_core saa7146 ttpci_eeprom tda10021 tda1004x stv0299 
dvb_core pcnet32
CPU:    1
EIP:    0060:[<c01489f0>]    Not tainted VLI
EFLAGS: 00010002   (2.6.19.1 #1)
EIP is at invalidate_complete_page2+0x45/0x84
eax: 8000082d   ebx: c1171e00   ecx: 00000000   edx: 00000000
esi: d2299db4   edi: 000b6096   ebp: 00000000   esp: d3f53db4
ds: 007b   es: 007b   ss: 0068
Process mythbackend (pid: 3584, ti=d3f52000 task=d5400550 task.ti=d3f52000)
Stack: c1171e00 000000d0 c1171e00 00000000 c0148b97 d2299db4 c1171e00 
000b6095
       0000000e 00000001 ffffffff 00000000 00000000 00000000 0000000e 
00000000
       c1171e00 c1171e20 c11a1e40 c11a1e60 c1245c00 c1245c20 c12694c0 
c12694e0
Call Trace:
 [<c0148b97>] invalidate_inode_pages2_range+0x168/0x264
 [<c0148cb2>] invalidate_inode_pages2+0x1f/0x25
 [<c01fa9ab>] nfs_revalidate_mapping+0x98/0x143
 [<c01632c4>] pipe_write+0x44d/0x459
 [<c01f9206>] nfs_file_read+0x91/0xf0
 [<c015d386>] do_sync_read+0xdd/0x11a
 [<c012daca>] autoremove_wake_function+0x0/0x4b
 [<c0398b12>] sock_ioctl+0x1b1/0x1d1
 [<c015d463>] vfs_read+0xa0/0x16b
 [<c015d7fe>] sys_read+0x4b/0x71
 [<c0102bc3>] syscall_call+0x7/0xb
 =======================
Code: c7 44 24 04 d0 00 00 00 89 1c 24 e8 1b b7 ff ff 31 d2 85 c0 74 4d 
8d 46 10 e8 4e fe 2b
 00 8b 03 a8 10 75 34 8b 03 f6 c4 08 74 08 <0f> 0b 37 01 07 b0 43 c0 89 
1c 24 e8 b0 86 ff ff
 f0 81 46 10 00
EIP: [<c01489f0>] invalidate_complete_page2+0x45/0x84 SS:ESP 0068:d3f53db4

---------

Captured using serial console.

Anybody an idea?

Its on a dual processor Netfinity 5000. Two PIII 500 processors, 512MB 
memory.

Cheers,

Rudy
