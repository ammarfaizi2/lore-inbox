Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129287AbQJ0Wfh>; Fri, 27 Oct 2000 18:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129229AbQJ0Wf1>; Fri, 27 Oct 2000 18:35:27 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:53001 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129197AbQJ0WfS>; Fri, 27 Oct 2000 18:35:18 -0400
Message-ID: <39FA0305.3FB3AD27@Hell.WH8.TU-Dresden.De>
Date: Sat, 28 Oct 2000 00:34:45 +0200
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] Another ext2 OOPS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just got another oops with test10pre6. Decoded output follows.
Hopefully this helps to hunt a bug down.

-Udo


Unable to handle kernel NULL pointer dereference at virtual address 00000010
c0130512
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0130512>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: c13871cc   ecx: c38788c0   edx: c13871f8
esi: c13871cc   edi: 00000001   ebp: cd9fad5c   esp: c9bc1ec8
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 275, stackpage=c9bc1000)
Stack: 00000000 c13871cc 00000001 cd9fad5c 00000019 c02a0000 cdae7480
cadc9680
       c9bc0000 00000019 00000000 ca742000 c02d7180 00000246 c01225d1
00000000
       c13871cc 00000001 cd9fad5c 080e2902 c13871f4 01234567 c9bc0000
c13871f8

Call Trace: [<c01225d1>] [<c01505ff>] [<c014fee0>] [<c0122f2e>] [<c0123213>]
[<c0123150>] [<c012ddfe>]
       [<c010a9d7>]
Code: 8b 48 10 89 4c 24 40 c7 44 24 34 00 00 00 00 8b 5b 18 f6 c3

>>EIP; c0130512 <block_read_full_page+12/270>   <=====
Trace; c01225d1 <___wait_on_page+d1/e0>
Trace; c01505ff <ext2_readpage+f/20>
Trace; c014fee0 <ext2_get_block+0/510>
Trace; c0122f2e <do_generic_file_read+2fe/520>
Trace; c0123213 <generic_file_read+63/80>
Trace; c0123150 <file_read_actor+0/60>
Trace; c012ddfe <sys_read+8e/d0>
Trace; c010a9d7 <system_call+33/38>
Code;  c0130512 <block_read_full_page+12/270>
00000000 <_EIP>:
Code;  c0130512 <block_read_full_page+12/270>   <=====
   0:   8b 48 10                  movl   0x10(%eax),%ecx   <=====
Code;  c0130515 <block_read_full_page+15/270>
   3:   89 4c 24 40               movl   %ecx,0x40(%esp,1)
Code;  c0130519 <block_read_full_page+19/270>
   7:   c7 44 24 34 00 00 00      movl   $0x0,0x34(%esp,1)
Code;  c0130520 <block_read_full_page+20/270>
   e:   00
Code;  c0130521 <block_read_full_page+21/270>
   f:   8b 5b 18                  movl   0x18(%ebx),%ebx
Code;  c0130524 <block_read_full_page+24/270>
  12:   f6 c3 00                  testb  $0x0,%bl
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
