Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280538AbRKFUlO>; Tue, 6 Nov 2001 15:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280537AbRKFUlE>; Tue, 6 Nov 2001 15:41:04 -0500
Received: from [209.149.111.162] ([209.149.111.162]:5139 "EHLO
	ROCKY.campusfcu.org") by vger.kernel.org with ESMTP
	id <S280570AbRKFUky>; Tue, 6 Nov 2001 15:40:54 -0500
Message-ID: <0FD28E544E09BB46847FCEBEEDFBA9AB0DA770@ROCKY.campusfcu.org>
From: Burton Windle <bwindle@campuscu.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-ac8: oops in update_one_process
Date: Tue, 6 Nov 2001 15:40:26 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an oops that I've had so far (3 seperate times) with 2.4.13-ac8. ac6
was rock-solid on this machine (PP200, 32mb ram, ext3, no modules, 3c590).

ksymoops 2.4.3 on i686 2.4.13-ac8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.13-ac8/ (default)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
Unable to handle kernel paging request at virtual address 080ae0fc
 c0118e8b
 *pde = 00cb6067
 Oops: 0002
 CPU:    0
 EIP:    0010:[<c0118e8b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010046
 eax: 00000000   ebx: 51eb851f   ecx: 0002131e   edx: 00000000
 esi: 080ae000   edi: 00000001   ebp: c0c7dc44   esp: c0c7dbb8
 ds: 0018   es: 0018   ss: 0018
 Process bb-combo.sh (pid: 5980, stackpage=c0c7c000)
 Stack: 080ae000 00000000 00000001 c0118f5d 080ae000 00000001 00000000
00000000
        00002e8e c0c7dc44 00000000 c011927f 00000001 c010a6dd c0c7dc44
c0275448
               20000001 c0107caf 00000000 00000000 c0c7dc44 00000000
c02c0900 00000000
               Call Trace: [<c0118f5d>] [<c011927f>] [<c010a6dd>]
[<c0107caf>] [<c0107e16>]
               Code: 01 bc 30 fc 00 00 00 01 94 30 00 01 00 00 89 f8 03 86
e8 00

>>EIP; c0118e8a <update_one_process+1a/d4>   <=====
Trace; c0118f5c <update_process_times+18/88>
Trace; c011927e <do_timer+22/6c>
Trace; c010a6dc <timer_interrupt+d0/18c>
Trace; c0107cae <handle_IRQ_event+2e/58>
Trace; c0107e16 <do_IRQ+6a/a8>
Code;  c0118e8a <update_one_process+1a/d4>
00000000 <_EIP>:
Code;  c0118e8a <update_one_process+1a/d4>   <=====
   0:   01 bc 30 fc 00 00 00      add    %edi,0xfc(%eax,%esi,1)   <=====
Code;  c0118e90 <update_one_process+20/d4>
   7:   01 94 30 00 01 00 00      add    %edx,0x100(%eax,%esi,1)
Code;  c0118e98 <update_one_process+28/d4>
   e:   89 f8                     mov    %edi,%eax
Code;  c0118e9a <update_one_process+2a/d4>
  10:   03 86 e8 00 00 00         add    0xe8(%esi),%eax

                <0>Kernel panic: Aiee, killing interrupt handler!



Signed,

Burton Windle
