Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130515AbQKKPg2>; Sat, 11 Nov 2000 10:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130891AbQKKPgT>; Sat, 11 Nov 2000 10:36:19 -0500
Received: from 3dyn245.com21.casema.net ([212.64.94.245]:14611 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S130515AbQKKPgH>;
	Sat, 11 Nov 2000 10:36:07 -0500
Date: Sat, 11 Nov 2000 16:27:50 +0100
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11pre2-ac1 and previous problem
Message-ID: <20001111162750.A1031@spaans.ds9a.nl>
In-Reply-To: <Pine.LNX.4.30.0011101806140.29502-100000@tfuj.ahoj.pl> <3A0C91DC.97693969@uow.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A0C91DC.97693969@uow.edu.au>; from andrewm@uow.edu.au on Sat, Nov 11, 2000 at 11:25:00AM +1100
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2000 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 11, 2000 at 11:25:00AM +1100, Andrew Morton wrote:

> > NMI Watchdog detected LOCKUP on CPU3, registers:

> Oh no.  Another one.  Could you please try this attached
> patch (against test11-pre2) and see if the diagnostics
> come out?

And yet another one... I applied your patch, and ran my oopses through
ksymoops, results attached.

Kernel: 2.4.0-test11-pre2 + reiserfs-3.6.18
2 * P-II 350, 256 MB RAM, no special hardware, AFAIK.

Of course, more details are available.

Regards,
-- 
Jasper Spaans  <jasper@spaans.ds9a.nl>

--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ksymoops-output

ksymoops 2.3.4 on i686 2.4.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11/ (default)
     -m /boot/System.map-2.4.0-test11-pre2 (specified)

Nov 11 13:37:08 spaans kernel: NMI Watchdog detected LOCKUP on CPU1, registers:
Nov 11 13:37:08 spaans kernel: CPU:    1
Nov 11 13:37:08 spaans kernel: EIP:    0010:[tvecs+21104/42928]
Nov 11 13:37:08 spaans kernel: EFLAGS: 00000086
Nov 11 13:37:08 spaans kernel: eax: 00000000   ebx: ce780000   ecx: 00000000   edx: ffffffff
Nov 11 13:37:08 spaans kernel: esi: 00000002   edi: 00000000   ebp: cd0f1eb0   esp: cd0f1ea8
Nov 11 13:37:08 spaans kernel: ds: 0018   es: 0018   ss: 0018
Nov 11 13:37:08 spaans kernel: Process mysqld (pid: 5799, stackpage=cd0f1000)
Nov 11 13:37:08 spaans kernel: Stack: ce780000 00000021 00000000 c01152ea ce780000 00000021 00000086 c01153c6 
Nov 11 13:37:08 spaans kernel:        00000021 cd0f1f04 ce780000 00040001 00000000 cd0f0000 00000021 c011589a 
Nov 11 13:37:08 spaans kernel:        00000021 cd0f1f04 ce780000 cd0f0000 c1458000 cd0f0000 ce780000 00000021 
Nov 11 13:37:08 spaans kernel: Call Trace: [do_ioctl+334/820] [do_ioctl+554/820] [apm+358/644] [will_become_orphaned_pgrp+14/124] [do_fork+211/2788] [do_fork+1188/2788] [do_fork+1274/2788] 
Nov 11 13:37:08 spaans kernel: Code: 80 3d 00 44 2e c0 00 f3 90 7e f5 e9 67 59 ee ff 80 3b 00 f3 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   80 3d 00 44 2e c0 00      cmpb   $0x0,0xc02e4400
Code;  00000007 Before first symbol
   7:   f3 90                     repz nop 
Code;  00000009 Before first symbol
   9:   7e f5                     jle    0 <_EIP>
Code;  0000000b Before first symbol
   b:   e9 67 59 ee ff            jmp    ffee5977 <_EIP+0xffee5977> ffee5977 <END_OF_CODE+2ec39fd0/????>
Code;  00000010 Before first symbol
  10:   80 3b 00                  cmpb   $0x0,(%ebx)
Code;  00000013 Before first symbol
  13:   f3 00 00                  repz add %al,(%eax)

Nov 11 13:37:08 spaans kernel: NMI Watchdog detected LOCKUP on CPU0, registers:
Nov 11 13:37:08 spaans kernel: CPU:    0
Nov 11 13:37:08 spaans kernel: EIP:    0010:[__down+339/588]
Nov 11 13:37:08 spaans kernel: EFLAGS: 00000097
Nov 11 13:37:08 spaans kernel: eax: c02e4420   ebx: ca6c0000   ecx: 00000000   edx: ffffffff
Nov 11 13:37:08 spaans kernel: esi: c02e4420   edi: ca6c1fa8   ebp: ca6c1fa8   esp: ca6c1f90
Nov 11 13:37:08 spaans kernel: ds: 0018   es: 0018   ss: 0018
Nov 11 13:37:08 spaans kernel: Process mysqld (pid: 5801, stackpage=ca6c1000)
Nov 11 13:37:08 spaans kernel: Stack: c0234797 ca6c0000 40083890 bf5ffc00 fffffff2 00000008 ca6c1fbc c0119ad4 
Nov 11 13:37:08 spaans kernel:        000016a9 00000000 bf5ff8e8 bf5ff8b4 c010b203 000016a9 00000000 bf5ff8e8 
Nov 11 13:37:08 spaans kernel:        40083890 bf5ffc00 bf5ff8b4 0000009c 0000002b 0000002b 0000009c 401a03e4 
Nov 11 13:37:08 spaans kernel: Call Trace: [tvecs+21059/42928] [proc_sel+68/140] [restore_sigcontext+63/328] 
Nov 11 13:37:08 spaans kernel: Code: 83 38 01 78 fb f0 ff 08 0f 88 ef ff ff ff c3 90 90 90 90 90 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   83 38 01                  cmpl   $0x1,(%eax)
Code;  00000003 Before first symbol
   3:   78 fb                     js     0 <_EIP>
Code;  00000005 Before first symbol
   5:   f0 ff 08                  lock decl (%eax)
Code;  00000008 Before first symbol
   8:   0f 88 ef ff ff ff         js     fffffffd <_EIP+0xfffffffd> fffffffd <END_OF_CODE+2ed54656/????>
Code;  0000000e Before first symbol
   e:   c3                        ret    
Code;  0000000f Before first symbol
   f:   90                        nop    
Code;  00000010 Before first symbol
  10:   90                        nop    
Code;  00000011 Before first symbol
  11:   90                        nop    
Code;  00000012 Before first symbol
  12:   90                        nop    
Code;  00000013 Before first symbol
  13:   90                        nop    


--Clx92ZfkiYIKRjnr--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
