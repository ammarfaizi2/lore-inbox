Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbRADJJF>; Thu, 4 Jan 2001 04:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131201AbRADJIz>; Thu, 4 Jan 2001 04:08:55 -0500
Received: from smtp.mountain.net ([198.77.1.35]:34321 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S129867AbRADJIq>;
	Thu, 4 Jan 2001 04:08:46 -0500
Message-ID: <3A543D8E.9489F715@mountain.net>
Date: Thu, 04 Jan 2001 04:08:30 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test13-pre4 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [OOPS] testing/prerelease of 01/03 on startup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

kernel is 2.4.0-prerelease with testing/prerelease patch of Jan. 3, i486.
Oops is repeatable.

I caught this one on serial console just as init begins:

$ ksymoops -K -L -O -v /boot/vmlinux-2.4.0-prerelease -m
/boot/System.map-2.4.0-prerelease tleete.prerelease.oops
ksymoops 2.3.5 on i486 2.4.0-test13-pre4.  Options used
     -v /boot/vmlinux-2.4.0-prerelease (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.0-prerelease (specified)

Unable to handle kernel paging request at virtual address 08048004
c011240a
*pde = 01151067
Oops: 0003
CPU:    0
EIP:    0010:[<c011240a>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 08048000   ebx: c1169120   ecx: c11690ac   edx: c1169090
esi: c1169090   edi: c1169154   ebp: 00000000   esp: c11dbf28
ds: 0018   es: 0018   ss: 0018
Process init (pid: 1, stackpage=c11db000)
Stack: c3758000 c116a534 c116aa44 c02210c0 c1167550 c11da000 c11690c4
c1169154
       c11690ac c11da000 c116755c c1169090 c0112c52 00000011 c3758000
c11da000
       bffffa18 bffff998 c11dbfbc 00000000 c11dbf94 fffffff4 00000000
00000000
Call Trace: [<c0112c52>] [<c0107804>] [<c0108e63>] [<c0100023>]
Code: 89 78 04 89 43 34 8b 44 24 18 89 47 04 89 7e 34 85 ed 75 22

>>EIP; c011240a <copy_mm+27a/2d0>   <=====
Trace; c0112c52 <do_fork+472/6c0>
Trace; c0107804 <sys_fork+14/20>
Trace; c0108e63 <system_call+33/40>
Trace; c0100023 <startup_32+23/139>
Code;  c011240a <copy_mm+27a/2d0>
00000000 <_EIP>:
Code;  c011240a <copy_mm+27a/2d0>   <=====
   0:   89 78 04                  mov    %edi,0x4(%eax)   <=====
Code;  c011240d <copy_mm+27d/2d0>
   3:   89 43 34                  mov    %eax,0x34(%ebx)
Code;  c0112410 <copy_mm+280/2d0>
   6:   8b 44 24 18               mov    0x18(%esp,1),%eax
Code;  c0112414 <copy_mm+284/2d0>
   a:   89 47 04                  mov    %eax,0x4(%edi)
Code;  c0112417 <copy_mm+287/2d0>
   d:   89 7e 34                  mov    %edi,0x34(%esi)
Code;  c011241a <copy_mm+28a/2d0>
  10:   85 ed                     test   %ebp,%ebp
Code;  c011241c <copy_mm+28c/2d0>
  12:   75 22                     jne    36 <_EIP+0x36> c0112440
<copy_mm+2b0/2d0>

Kernel panic: Attempted to kill init!
$

Everything is looged on the serial console machine, so if you need more,
it's here.

Hope this helps,
Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
