Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271109AbRHYTzB>; Sat, 25 Aug 2001 15:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271073AbRHYTyt>; Sat, 25 Aug 2001 15:54:49 -0400
Received: from jakorasia.nic.fi ([212.38.224.80]:19654 "EHLO jakorasia.nic.fi")
	by vger.kernel.org with ESMTP id <S271054AbRHYTyo>;
	Sat, 25 Aug 2001 15:54:44 -0400
Message-ID: <3B87E3D2.C01F301F@pp.nic.fi>
Date: Sat, 25 Aug 2001 17:43:46 +0000
From: Fredrik Jansson <fredrikj@pp.nic.fi>
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops in ide-scsi emulation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following oops while trying to burn a CD-RW, using 
kernel 2.4.9
cdrecord 1.9
HP CD-writer plus, 7200i (an IDE unit)
An intel celeron A 300MHz

The ide-interface as reported by lspci:
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)

CD-burning worked fine under kernel 2.2.14, but has not worked with
kernel 2.4.x. This time the computer crashed after it had burned approx.
4 MB.

I copied the oops from the screen by hand, but I have checked it
carefully, so I believe it is correct.
If I need to tell you anything more, please ask.


ksymoops 0.7c on i686 2.4.9.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9/ (default)
     -m /usr/src/linux/System.map (default)

Warning (compare_maps): snd symbol pm_register not found in
/lib/modules/2.4.9/misc/snd.o.  Ignoring /lib/modules/2.4.9/misc/snd.o
entry
Warning (compare_maps): snd symbol pm_send not found in
/lib/modules/2.4.9/misc/snd.o.  Ignoring /lib/modules/2.4.9/misc/snd.o
entry
Warning (compare_maps): snd symbol pm_unregister not found in
/lib/modules/2.4.9/misc/snd.o.  Ignoring /lib/modules/2.4.9/misc/snd.o
entry
Unable to handle kernel paging request at virtual address ac958592
c01af320
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c01af320>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax:  ac9583b1  abx: c026b6c0  ecx: 0000005a  edx: c02ca72c
esi:  d5ee5ea0  edi: 00000006  ebp: cb0b0000  esp: ceaabee0
ds: 0018  es:0018  ss: 0018
Stack: c026b6c0 c02ca704 0000000b 00000000 00000000 d5ee5ea0 c1668ce0
c02ca704
       c019adc7 00000000 d7ffe160 c02ca704 00000000 d7ffe160 c01af4f8
000000d0
       c019ba10 c02ca704 c022b9e2 000000d0 d7ffe160 00000000 c02ac740
c019b884
 Call Trace: [<c019adc7>] [<c01af4f8>] [<c019ba10>] [<c019b884>]
[<c011a90c>]
 [<c011a989>] [<c010ab16>] [c011742e>] [<c0117369>] [<c011715d>]
[<c0107ec4>]
 [<c0106be0>]
 Code: c7 80 78 01 00 00 00 00 07 00 83 7c 24 10 00 0f 84 6b 01 00

>>EIP; c01af320 <idescsi_end_request+74/24c>   <=====
Trace; c019adc7 <ide_error+137/190>
Trace; c01af4f8 <idescsi_pc_intr+0/24c>
Trace; c019ba10 <ide_timer_expiry+18c/1dc>
Trace; c019b884 <ide_timer_expiry+0/1dc>
Trace; c011a90c <timer_bh+21c/258>
Trace; c011a989 <do_timer+41/74>
Trace; c010ab16 <timer_interrupt+76/124>
Trace; c0106be0 <ret_from_intr+0/7>
Code;  c01af320 <idescsi_end_request+74/24c>
00000000 <_EIP>:
Code;  c01af320 <idescsi_end_request+74/24c>   <=====
   0:   c7 80 78 01 00 00 00      movl   $0x70000,0x178(%eax)   <=====
Code;  c01af327 <idescsi_end_request+7b/24c>
   7:   00 07 00 
Code;  c01af32a <idescsi_end_request+7e/24c>
   a:   83 7c 24 10 00            cmpl   $0x0,0x10(%esp,1)
Code;  c01af32f <idescsi_end_request+83/24c>
   f:   0f 84 6b 01 00 00         je     180 <_EIP+0x180> c01af4a0
<idescsi_end_request+1f4/24c>

 Kernel panic: Aiee, killing interrupt handler!

3 warnings issued.  Results may not be reliable.


Fredrik Jansson


