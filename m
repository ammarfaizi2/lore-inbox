Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTFXLvi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 07:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTFXLvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 07:51:37 -0400
Received: from [213.171.53.133] ([213.171.53.133]:54276 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id S261989AbTFXLvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 07:51:36 -0400
Date: Tue, 24 Jun 2003 15:07:29 +0400
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.5.71 svgatextmode
Message-Id: <20030624150729.056b14c7.deepfire@ibe.miee.ru>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a call to svgatextmode causes this in both 2.5.71,72, on 4 different boxes:

--ksymoops 2.4.8 on i686 2.5.71.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.71/ (default)
     -m /boot/System.map-2.5.71 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000010
c0252f85
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0252f85>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013206
eax: 00000000   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: 00000250   edi: 00000010   ebp: 00000025   esp: cf581eb0
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 00000064 00000025 c133c005 00000320 00000064 00000000 cf581f80
       cfff16e0 cf581f14 c0157800 c128d000 00000000 cfce6000 cf6b0bc0 00000001
       c025b7ea 00000001 c128d000 cffcf600 c0249865 cfce6000 cf6b0bc0 cf581f14
Call Trace: [<c0157800>]  [<c025b7ea>]  [<c0249865>]  [<c0249660>]  [<c01536ce>]  [<c015873d>]  [<c014a66a>]  [<c024a739>]  [<c015b8b5>]  [<c01090cf>]
Code: 89 70 10 66 85 ff 74 0a 8b 04 9d e0 8e 49 c0 89 78 68 89 1c


>>EIP; c0252f85 <vt_ioctl+1be5/1dd0>   <=====

>>esp; cf581eb0 <_end+f0d7e6c/3fb53fbc>

Trace; c0157800 <do_lookup+30/c0>
Trace; c025b7ea <con_open+1a/90>
Trace; c0249865 <tty_open+205/360>
Trace; c0249660 <tty_open+0/360>
Trace; c01536ce <chrdev_open+be/170>
Trace; c015873d <open_namei+9d/3e0>
Trace; c014a66a <dentry_open+12a/1c0>
Trace; c024a739 <tty_ioctl+3b9/4d0>
Trace; c015b8b5 <sys_ioctl+c5/250>
Trace; c01090cf <syscall_call+7/b>

Code;  c0252f85 <vt_ioctl+1be5/1dd0>
00000000 <_EIP>:
Code;  c0252f85 <vt_ioctl+1be5/1dd0>   <=====
   0:   89 70 10                  mov    %esi,0x10(%eax)   <=====
Code;  c0252f88 <vt_ioctl+1be8/1dd0>
   3:   66 85 ff                  test   %di,%di
Code;  c0252f8b <vt_ioctl+1beb/1dd0>
   6:   74 0a                     je     12 <_EIP+0x12>
Code;  c0252f8d <vt_ioctl+1bed/1dd0>
   8:   8b 04 9d e0 8e 49 c0      mov    0xc0498ee0(,%ebx,4),%eax
Code;  c0252f94 <vt_ioctl+1bf4/1dd0>
   f:   89 78 68                  mov    %edi,0x68(%eax)
Code;  c0252f97 <vt_ioctl+1bf7/1dd0>
  12:   89 1c 00                  mov    %ebx,(%eax,%eax,1)


1 error issued.  Results may not be reliable.

regards, Samium Gromoff
