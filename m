Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTKAPBP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 10:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTKAPBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 10:01:14 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:46030 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263824AbTKAPBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 10:01:07 -0500
Date: Sat, 01 Nov 2003 07:00:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: tom@carrott.org
Subject: [Bug 1467] New: oops on network block device module	unload
Message-ID: <90360000.1067698859@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1467

           Summary: oops on network block device module unload
    Kernel Version: 2.6.0-test9
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: tom@carrott.org


Distribution: Debian unstable
Hardware Environment: intel pentium 3
Software Environment: 
Problem Description: 

Nov  2 00:53:42 tv kernel: nbd: registered device at major 43
Nov  2 00:53:46 tv kernel:  printing eip:
Nov  2 00:53:46 tv kernel: c01c2bf1
Nov  2 00:53:46 tv kernel: Oops: 0000 [#1]
Nov  2 00:53:46 tv kernel: CPU:    0
Nov  2 00:53:46 tv kernel: EIP:    0060:[kobject_del+9/88]    Not tainted
Nov  2 00:53:46 tv kernel: EFLAGS: 00010282
Nov  2 00:53:46 tv kernel: EIP is at kobject_del+0x9/0x58
Nov  2 00:53:46 tv kernel: eax: c2804c48   ebx: c2804c48   ecx: c7f71f78   edx: c7f71f88
Nov  2 00:53:46 tv kernel: esi: c40c4ef8   edi: cab87d1c   ebp: c5c85eec   esp: c5c85ee8
Nov  2 00:53:46 tv kernel: ds: 007b   es: 007b   ss: 0068
Nov  2 00:53:46 tv kernel: Process modprobe (pid: 411, threadinfo=c5c84000 task=c262d960)
Nov  2 00:53:46 tv kernel: Stack: c2804c48 c5c85efc c01c2c4d c2804c48 c2804bf8 c5c85f0c c021e564 c2804c48
Nov  2 00:53:46 tv kernel:        c2804bf8 c5c85f20 c02224b9 c2804bf8 c40c4ef8 c40c4ef8 c5c85f30 c02235f9
Nov  2 00:53:46 tv kernel:        c40c4ef8 00000000 c5c85f50 c019ef3f c40c4ef8 c40c4ef8 00000000 c40c4ef8
Nov  2 00:53:46 tv kernel: Call Trace:
Nov  2 00:53:46 tv kernel:  [kobject_unregister+13/28] kobject_unregister+0xd/0x1c
Nov  2 00:53:46 tv kernel:  [elv_unregister_queue+20/40] elv_unregister_queue+0x14/0x28
Nov  2 00:53:46 tv kernel:  [blk_unregister_queue+21/52] blk_unregister_queue+0x15/0x34
Nov  2 00:53:46 tv kernel:  [unlink_gendisk+13/40] unlink_gendisk+0xd/0x28
Nov  2 00:53:46 tv kernel:  [del_gendisk+67/172] del_gendisk+0x43/0xac
Nov  2 00:53:46 tv kernel:  [_end+175703324/1069580512] nbd_cleanup+0x2c/0x70 [nbd]
Nov  2 00:53:46 tv kernel:  [sys_delete_module+379/412] sys_delete_module+0x17b/0x19c
Nov  2 00:53:46 tv kernel:  [sys_munmap+68/100] sys_munmap+0x44/0x64
Nov  2 00:53:46 tv kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov  2 00:53:46 tv kernel:
Nov  2 00:53:46 tv kernel: Code: 83 7b 28 00 75 1e 83 7b 24 00 74 12 8d 76 00 8b 40 24 83 78


tv:/var/log# ksymoops /tmp/oops
ksymoops 2.4.9 on i686 2.6.0-test9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test9/ (default)
     -m /boot/System.map-2.6.0-test9 (default)
 
Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.
 
Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Nov  2 00:53:46 tv kernel: c01c2bf1
Nov  2 00:53:46 tv kernel: Oops: 0000 [#1]
Nov  2 00:53:46 tv kernel: CPU:    0
Nov  2 00:53:46 tv kernel: EIP:    0060:[kobject_del+9/88]    Not tainted
Nov  2 00:53:46 tv kernel: EFLAGS: 00010282
Nov  2 00:53:46 tv kernel: eax: c2804c48   ebx: c2804c48   ecx: c7f71f78   edx: c7f71f88
Nov  2 00:53:46 tv kernel: esi: c40c4ef8   edi: cab87d1c   ebp: c5c85eec   esp: c5c85ee8
Nov  2 00:53:46 tv kernel: ds: 007b   es: 007b   ss: 0068
Nov  2 00:53:46 tv kernel: Stack: c2804c48 c5c85efc c01c2c4d c2804c48 c2804bf8 c5c85f0c c021e564 c2804c48
Nov  2 00:53:46 tv kernel:        c2804bf8 c5c85f20 c02224b9 c2804bf8 c40c4ef8 c40c4ef8 c5c85f30 c02235f9
Nov  2 00:53:46 tv kernel:        c40c4ef8 00000000 c5c85f50 c019ef3f c40c4ef8 c40c4ef8 00000000 c40c4ef8
Nov  2 00:53:46 tv kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available
 
 
>> eax; c2804c48 <_end+240ed28/3fc080e0>
>> ebx; c2804c48 <_end+240ed28/3fc080e0>
>> ecx; c7f71f78 <_end+7b7c058/3fc080e0>
>> edx; c7f71f88 <_end+7b7c068/3fc080e0>
>> esi; c40c4ef8 <_end+3ccefd8/3fc080e0>
>> edi; cab87d1c <_end+a791dfc/3fc080e0>
>> ebp; c5c85eec <_end+588ffcc/3fc080e0>
>> esp; c5c85ee8 <_end+588ffc8/3fc080e0>
 
Nov  2 00:53:46 tv kernel: Code: 83 7b 28 00 75 1e 83 7b 24 00 74 12 8d 76 00 8b 40 24 83 78
Using defaults from ksymoops -t elf32-i386 -a i386
 
 
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   83 7b 28 00               cmpl   $0x0,0x28(%ebx)
Code;  00000004 Before first symbol
   4:   75 1e                     jne    24 <_EIP+0x24>
Code;  00000006 Before first symbol
   6:   83 7b 24 00               cmpl   $0x0,0x24(%ebx)
Code;  0000000a Before first symbol
   a:   74 12                     je     1e <_EIP+0x1e>
Code;  0000000c Before first symbol
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  0000000f Before first symbol
   f:   8b 40 24                  mov    0x24(%eax),%eax
Code;  00000012 Before first symbol
  12:   83 78 00 00               cmpl   $0x0,0x0(%eax)
 
 
2 warnings and 1 error issued.  Results may not be reliable.



Steps to reproduce:
tv:/home/tparker# modprobe nbd
tv:/home/tparker# modprobe -r nbd

