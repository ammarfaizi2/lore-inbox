Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314621AbSDTNdM>; Sat, 20 Apr 2002 09:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314623AbSDTNdM>; Sat, 20 Apr 2002 09:33:12 -0400
Received: from dsl-213-023-062-225.arcor-ip.net ([213.23.62.225]:60169 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S314621AbSDTNdL>;
	Sat, 20 Apr 2002 09:33:11 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 usb(?) oops
Date: Sat, 20 Apr 2002 15:33:50 +0200
X-Mailer: KMail [version 1.4]
X-PGP-KeyID: 0x561D4FD2
X-PGP-Key: http://www.lionking.org/~kiza/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204201533.50375.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This oops occurs everytime I use kpilot to hotsync my Handpsring Visor.

The tainted flag originates from lm_sensors 2.5.5:
Warning: loading /lib/modules/2.4.18/misc/sensors.o will taint the kernel: no 
license
Warning: loading /lib/modules/2.4.18/misc/via686a.o will taint the kernel: no 
license

This is the oops from my system (VIA):

ksymoops 2.3.7 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 008d01d9
c01e6608
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01e6608>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013206
eax: 008d01c5   ebx: c2be0494   ecx: c7ece000   edx: 008d01c5
esi: c7ece200   edi: c2be0400   ebp: c2be04f0   esp: c263fed0
ds: 0018   es: 0018   ss: 0018
Process kpilotDaemon (pid: 30693, stackpage=c263f000)
Stack: d892a2ed 008d01c5 c2be0494 c2be0400 d06dc840 00000000 d8924350 c2be0494 
       d06dc840 d725a000 c9fc6c80 c16063c0 c018c460 d725a000 d06dc840 d06dc840 
       c9fc6c80 c16063c0 c0c8d740 00000001 d06dc840 bffff0e8 00000000 00000000 
Call Trace: [<d892a2ed>] [<d8924350>] [<c018c460>] [<c0190a01>] [<c018ca9a>] 
   [<c01311ec>] [<c01301ac>] [<c0130203>] [<c0106c4f>] 
Code: 8b 42 14 85 c0 74 21 8b 80 bc 00 00 00 85 c0 74 17 8b 40 18 

>>EIP; c01e6608 <usb_unlink_urb+8/40>   <=====
Trace; d892a2ed <[visor]visor_close+13d/170>
Trace; d8924350 <[usbserial]serial_close+a0/b0>
Trace; c018c460 <release_dev+240/500>
Trace; c0190a01 <n_tty_ioctl+101/4b0>
Trace; c018ca9a <tty_release+a/10>
Trace; c01311ec <fput+4c/e0>
Trace; c01301ac <filp_close+5c/70>
Trace; c0130203 <sys_close+43/60>
Trace; c0106c4f <system_call+33/38>
Code;  c01e6608 <usb_unlink_urb+8/40>
00000000 <_EIP>:
Code;  c01e6608 <usb_unlink_urb+8/40>   <=====
   0:   8b 42 14                  mov    0x14(%edx),%eax   <=====
Code;  c01e660b <usb_unlink_urb+b/40>
   3:   85 c0                     test   %eax,%eax
Code;  c01e660d <usb_unlink_urb+d/40>
   5:   74 21                     je     28 <_EIP+0x28> c01e6630 
<usb_unlink_urb+30/40>
Code;  c01e660f <usb_unlink_urb+f/40>
   7:   8b 80 bc 00 00 00         mov    0xbc(%eax),%eax
Code;  c01e6615 <usb_unlink_urb+15/40>
   d:   85 c0                     test   %eax,%eax
Code;  c01e6617 <usb_unlink_urb+17/40>
   f:   74 17                     je     28 <_EIP+0x28> c01e6630 
<usb_unlink_urb+30/40>
Code;  c01e6619 <usb_unlink_urb+19/40>
  11:   8b 40 18                  mov    0x18(%eax),%eax


1 warning issued.  Results may not be reliable.

------

This is the same thing happening on another hardware (Intel BX based board):

ksymoops 2.3.7 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says 
c02772d0, System.map says c014ef50.  Ignoring ksyms_base entry
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
ac97_codec: AC97  codec, id: 0x5452:0x4103 (TriTech TR28023)
Unable to handle kernel paging request at virtual address 000f034f
c025c210
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c025c210>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 000f033b   ebx: d1ba1894   ecx: d1ebf000   edx: 000f033b
esi: d1ebfdc0   edi: d1ba1800   ebp: d1ba18f0   esp: cfe07ed0
ds: 0018   es: 0018   ss: 0018
Process kpilotDaemon (pid: 542, stackpage=cfe07000)
Stack: c026bb6f 000f033b d1ba1894 d1ba1800 d0823620 00000000 c026a1a4 d1ba1894 
       d0823620 cfc5a000 cfc20a40 c1606360 c01c9080 cfc5a000 d0823620 d0823620 
       cfc20a40 c1606360 d57d8aa0 00000001 d0823620 bfffe9e8 00000000 00000000 
Call Trace: [<c026bb6f>] [<c026a1a4>] [<c01c9080>] [<c01cd501>] [<c01c968e>] 
   [<c01303c4>] [<c012f43c>] [<c012f487>] [<c0106b1b>] 
Code: 8b 42 14 85 c0 74 1b 8b 80 bc 00 00 00 85 c0 74 11 8b 40 18 

>>EIP; c025c210 <usb_unlink_urb+8/30>   <=====
Trace; c026bb6f <visor_close+13b/15c>
Trace; c026a1a4 <serial_close+a0/b0>
Trace; c01c9080 <release_dev+240/4fc>
Trace; c01cd501 <n_tty_ioctl+101/4b0>
Trace; c01c968e <tty_release+a/10>
Trace; c01303c4 <fput+4c/d0>
Trace; c012f43c <filp_close+5c/64>
Trace; c012f487 <sys_close+43/54>
Trace; c0106b1b <system_call+33/38>
Code;  c025c210 <usb_unlink_urb+8/30>
00000000 <_EIP>:
Code;  c025c210 <usb_unlink_urb+8/30>   <=====
   0:   8b 42 14                  mov    0x14(%edx),%eax   <=====
Code;  c025c213 <usb_unlink_urb+b/30>
   3:   85 c0                     test   %eax,%eax
Code;  c025c215 <usb_unlink_urb+d/30>
   5:   74 1b                     je     22 <_EIP+0x22> c025c232 
<usb_unlink_urb+2a/30>
Code;  c025c217 <usb_unlink_urb+f/30>
   7:   8b 80 bc 00 00 00         mov    0xbc(%eax),%eax
Code;  c025c21d <usb_unlink_urb+15/30>
   d:   85 c0                     test   %eax,%eax
Code;  c025c21f <usb_unlink_urb+17/30>
   f:   74 11                     je     22 <_EIP+0x22> c025c232 
<usb_unlink_urb+2a/30>
Code;  c025c221 <usb_unlink_urb+19/30>
  11:   8b 40 18                  mov    0x18(%eax),%eax


2 warnings issued.  Results may not be reliable.



-- 
Oliver Feiler  <kiza@(gmx.net|lionking.org|claws-and-paws.com|spot.dtip.de)> /
http://www.lionking.org/~kiza/      (http://spot.dtip.de/~kiza/)            /
___________________________________________________________________________/
