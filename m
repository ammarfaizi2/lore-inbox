Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHUbK>; Thu, 8 Feb 2001 15:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130998AbRBHUax>; Thu, 8 Feb 2001 15:30:53 -0500
Received: from smtp-rt-5.wanadoo.fr ([193.252.19.159]:54474 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129031AbRBHUao>; Thu, 8 Feb 2001 15:30:44 -0500
Message-ID: <3A8301D6.26EED9C@wanadoo.fr>
Date: Thu, 08 Feb 2001 21:30:14 +0100
From: Jean-luc Coulon <jean-luc.coulon@wanadoo.fr>
Organization: personal system
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.19pre8 i586)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.1-ac6 (and all older than 2.2.x)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I experienced a Oops with all versions  of the kernel newer than 2.2.x :

Here is the Oops processed by ksymoops. In this case, it was with
2.4.1-ac6.
This oops seems related to ax25 (hamradio) use. I can have access to
magic keys
(but the reboot one, but I _never_ managed to have this one to work,
maybe a
configuration problem with my French keyboard ?).
After trying a remount, I got :
SysReq : Emergency Remount R/O
Remounting device 03:02... Scheduling in interrupt
Kernel BUG at sched.c:714!
incalid operand: 0000 ... etc. etc.

ksymoops 2.3.7 on i586 2.4.1-ac6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-ac6/ (default)
     -m /boot/System.map-2.4.1-ac6 (specified)

Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring
ksyms_base entry
Unable to handle kernel paging request at virtual address fffffffc
c0112c38
*pde = 00001063
Oops: 0000
CPU: 0
EIP: 0010 : [<c0112c38>]
Using defaults from ksymoops -t elf32-i386 -a i386
eax: c5c3aec4 eb: 00000000 ecx: 00000001 edx: c5c3aec8
esi: c3dc8680 edi: fffffff8 ebp: c5219f54 esp: c5219f38
ds: 0018 es: 0018 ss:0018
Process make (pid: 1565, stackpage=c5219000)
stack: c5c3aec4 c3dc8680 c02336fc c5c3aec8 00000282 00000001 00000001
c5219fbc
       c018c72f c3dc8680 c4d66140 c018c03f c3dc8680 00000000 c018cba2
c4d66140
       00000000 c02336fc c018e6d3 c4d66140 00000001 c02335c8 0000000d
c0118470
Call Trace: [<c018c72f>] [<c018c03f>] [<c018cba2>] [<c018e6d3>]
[<c0118470>] [<c010a132>] [<c0108e00>]
Code : 8b 4f 04 8b 1b 8b 01 85 45 fc 74 4c 9c 5e fa c7 01 00 00 00

>>EIP; c0112c38 <__wake_up+28/98>   <=====
Trace; c018c72f <sock_def_write_space+33/78>
Trace; c018c03f <sock_wfree+17/30>
Trace; c018cba2 <__kfree_skb+7e/f4>
Trace; c018e6d3 <net_tx_action+4f/a8>
Trace; c0118470 <do_softirq+40/64>
Trace; c010a132 <do_IRQ+a2/b0>
Trace; c0108e00 <ret_from_intr+0/20>
Code;  c0112c38 <__wake_up+28/98>
00000000 <_EIP>:
Code;  c0112c38 <__wake_up+28/98>   <=====
   0:   8b 4f 04                  mov    0x4(%edi),%ecx   <=====
Code;  c0112c3b <__wake_up+2b/98>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0112c3d <__wake_up+2d/98>
   5:   8b 01                     mov    (%ecx),%eax
Code;  c0112c3f <__wake_up+2f/98>
   7:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0112c42 <__wake_up+32/98>
   a:   74 4c                     je     58 <_EIP+0x58> c0112c90
<__wake_up+80/98>
Code;  c0112c44 <__wake_up+34/98>
   c:   9c                        pushf
Code;  c0112c45 <__wake_up+35/98>
   d:   5e                        pop    %esi
Code;  c0112c46 <__wake_up+36/98>
   e:   fa                        cli
Code;  c0112c47 <__wake_up+37/98>
   f:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Kernel panic: Aiee, killing the interrupt handler!

1 warning issued.  Results may not be reliable.

------

Best regards

  Jean-Luc


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
