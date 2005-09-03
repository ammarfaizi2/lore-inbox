Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbVICEZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbVICEZs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 00:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbVICEZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 00:25:47 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:23228 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1161126AbVICEZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 00:25:47 -0400
Message-ID: <431925C4.60509@nortel.com>
Date: Fri, 02 Sep 2005 22:25:40 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: looking for help tracing oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Sep 2005 04:25:42.0346 (UTC) FILETIME=[8BB832A0:01C5B03F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm debugging a problem.  Unfortunately, I have a module loaded that 
taints the kernel.

Now that that's out of the way, if anyone is still willing to help, the 
oops is below, along with the disassembly of filp_close().  One thing I 
don't understand--the function makes calls to other functions including 
printk(), but I don't see those calls listed in the disassembly.

I'm seeing the problem with both 2.6.9 and 2.6.10.  The kernels have 
been modified as well, and I'm trying to track down where the problem is 
coming from--the kernel mods or the non-GPL module.

Any ideas?

Chris


Unable to handle kernel paging request at virtual address f88ad52c
  printing eip:
*pde = 02373067
*pte = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c0150374>]    Tainted: P      VLI
EFLAGS: 00010286   (2.6.10)
EIP is at filp_close+0x64/0xa0
eax: f88ad500   ebx: f7554dc0   ecx: f77bd6c0   edx: f7554dc0
esi: 00000000   edi: f78c1c80   ebp: 00000001   esp: f70b1f48
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 1593, threadinfo=f70b0000 task=f78cf570)
Stack: f77bd6c0 f78c1c80 00000001 00000008 f78c1c80 c0115be2 f7554dc0 
f78c1c80
        f70b0000 f7a9b4ec f78cf570 00000000 c011693f f78cf570 f70b1f90 
f751bf3c
        f7a7c21c 00000001 b7eaf003 f7a7c21c f7a9b4c0 f7a9b4ec f70b0000 
00000000
Call Trace:
  [<c0115be2>] put_files_struct+0x62/0xd0
  [<c011693f>] do_exit+0x19f/0x3a0
  [<c0116bb7>] do_group_exit+0x37/0x80
  [<c010252d>] sysenter_past_esp+0x52/0x75




(gdb) disassemble filp_close
Dump of assembler code for function filp_close:
0x00001a60 <filp_close+0>:      sub    $0x14,%esp
0x00001a63 <filp_close+3>:      mov    %ebx,0x8(%esp,1)
0x00001a67 <filp_close+7>:      mov    0x18(%esp,1),%ebx
0x00001a6b <filp_close+11>:     mov    %edi,0x10(%esp,1)
0x00001a6f <filp_close+15>:     mov    0x1c(%esp,1),%edi
0x00001a73 <filp_close+19>:     mov    %esi,0xc(%esp,1)
0x00001a77 <filp_close+23>:     mov    0x20(%ebx),%esi
0x00001a7a <filp_close+26>:     test   %esi,%esi
0x00001a7c <filp_close+28>:     je     0x1a85 <filp_close+37>
0x00001a7e <filp_close+30>:     movl   $0x0,0x20(%ebx)
0x00001a85 <filp_close+37>:     mov    0x14(%ebx),%eax
0x00001a88 <filp_close+40>:     test   %eax,%eax
0x00001a8a <filp_close+42>:     je     0x1ad8 <filp_close+120>
0x00001a8c <filp_close+44>:     mov    0x10(%ebx),%eax
0x00001a8f <filp_close+47>:     test   %eax,%eax
0x00001a91 <filp_close+49>:     jne    0x1ac4 <filp_close+100>
0x00001a93 <filp_close+51>:     mov    %edi,0x4(%esp,1)
0x00001a97 <filp_close+55>:     mov    %ebx,(%esp,1)
0x00001a9a <filp_close+58>:     call   0x1a9b <filp_close+59>
0x00001a9f <filp_close+63>:     mov    %edi,0x4(%esp,1)
0x00001aa3 <filp_close+67>:     mov    %ebx,(%esp,1)
0x00001aa6 <filp_close+70>:     call   0x1aa7 <filp_close+71>
0x00001aab <filp_close+75>:     mov    %ebx,%eax
0x00001aad <filp_close+77>:     call   0x1aae <filp_close+78>
0x00001ab2 <filp_close+82>:     mov    0x8(%esp,1),%ebx
0x00001ab6 <filp_close+86>:     mov    %esi,%eax
0x00001ab8 <filp_close+88>:     mov    0xc(%esp,1),%esi
0x00001abc <filp_close+92>:     mov    0x10(%esp,1),%edi
0x00001ac0 <filp_close+96>:     add    $0x14,%esp
0x00001ac3 <filp_close+99>:     ret
0x00001ac4 <filp_close+100>:    mov    0x2c(%eax),%edx
0x00001ac7 <filp_close+103>:    test   %edx,%edx
0x00001ac9 <filp_close+105>:    je     0x1a93 <filp_close+51>
0x00001acb <filp_close+107>:    mov    %ebx,(%esp,1)
0x00001ace <filp_close+110>:    call   *0x2c(%eax)
0x00001ad1 <filp_close+113>:    test   %esi,%esi
0x00001ad3 <filp_close+115>:    cmove  %eax,%esi
0x00001ad6 <filp_close+118>:    jmp    0x1a93 <filp_close+51>
0x00001ad8 <filp_close+120>:    movl   $0x28,(%esp,1)
0x00001adf <filp_close+127>:    call   0x1ae0 <filp_close+128>
0x00001ae4 <filp_close+132>:    mov    0x8(%esp,1),%ebx
0x00001ae8 <filp_close+136>:    mov    %esi,%eax
0x00001aea <filp_close+138>:    mov    0xc(%esp,1),%esi
0x00001aee <filp_close+142>:    mov    0x10(%esp,1),%edi
0x00001af2 <filp_close+146>:    add    $0x14,%esp
0x00001af5 <filp_close+149>:    ret
0x00001af6 <filp_close+150>:    lea    0x0(%esi),%esi
0x00001af9 <filp_close+153>:    lea    0x0(%edi,1),%edi
End of assembler dump.

