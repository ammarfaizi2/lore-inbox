Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281142AbRKTPtY>; Tue, 20 Nov 2001 10:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281139AbRKTPtI>; Tue, 20 Nov 2001 10:49:08 -0500
Received: from [61.171.119.66] ([61.171.119.66]:2308 "EHLO marvin.zhlinux.com")
	by vger.kernel.org with ESMTP id <S281140AbRKTPss>;
	Tue, 20 Nov 2001 10:48:48 -0500
Date: Tue, 20 Nov 2001 23:49:28 +0800
From: Wenzhuo Zhang <wenzhuo@zhmail.com>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.4.13-ac5 default_idle
Message-ID: <20011120234928.B714@zhmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I noticed frequent crashings of my old Pentium desktop, after I kept it
running 24x7 as a gateway/filewall. Tonight, I caught sight of a oops
and hand-copied it down.

ksymoops 2.3.4 on i686 2.4.13-ac5.  Options used
		  ^^ Since I cannot compile ksymoops in the slackware-8.0
  box, I copied the kernel/modules to another box, and ran ksymoops there.
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.13-ac5/ (default)
     -m /boot/System.map-2.4.13-ac5 (specified)

CPU: 0
EIP: 0010:[<c0105173>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000246
eax: 00000000 ebx: c0210000 ecx: c11e2260 edx: c11e2260
esi: c0105150 edi: ffffe000 ebp: 0008e000 esp: c0211fdc
ds: 0018 es: 0018 ss:0018
Process swapper (pid: 0, stackpage=c0211000)
Stack: c01051d7 00003000 000a0600 c0105000 c0105027 c02127f3 00000000 c0246060
       c0100197
Call Trace: [<c01051d7>] [<c0105000>] [<c0105027>]
Code: c3 fb c3 89 f6 fb ba 00 e0 ff ff 21 e2 b8 ff ff ff ff 87 42

>>EIP; c0105173 <default_idle+23/28>   <=====
Trace; c01051d7 <cpu_idle+3f/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/28>
Code;  c0105173 <default_idle+23/28>
00000000 <_EIP>:
Code;  c0105173 <default_idle+23/28>   <=====
   0:   c3                        ret       <=====
Code;  c0105174 <default_idle+24/28>
   1:   fb                        sti    
Code;  c0105175 <default_idle+25/28>
   2:   c3                        ret    
Code;  c0105176 <default_idle+26/28>
   3:   89 f6                     mov    %esi,%esi
Code;  c0105178 <poll_idle+0/20>
   5:   fb                        sti    
Code;  c0105179 <poll_idle+1/20>
   6:   ba 00 e0 ff ff            mov    $0xffffe000,%edx
Code;  c010517e <poll_idle+6/20>
   b:   21 e2                     and    %esp,%edx
Code;  c0105180 <poll_idle+8/20>
   d:   b8 ff ff ff ff            mov    $0xffffffff,%eax
Code;  c0105185 <poll_idle+d/20>
  12:   87 42 00                  xchg   %eax,0x0(%edx)

  <0> Kernel panic: Attempted to kill the idle task!


Thanks,

-- 
Wenzhuo
  GnuPG Key ID 0xBA586A68
  Key fingerprint = 89C7 C6DE D956 F978 3F12  A8AF 5847 F840 BA58 6A68
