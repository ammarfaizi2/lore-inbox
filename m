Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281453AbRKTWyu>; Tue, 20 Nov 2001 17:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281457AbRKTWyk>; Tue, 20 Nov 2001 17:54:40 -0500
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:4600 "EHLO
	gintaras.vetrunge.lt.eu.org") by vger.kernel.org with ESMTP
	id <S281453AbRKTWyZ>; Tue, 20 Nov 2001 17:54:25 -0500
Date: Wed, 21 Nov 2001 00:54:19 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <greg@kroah.com>
Subject: visor.o oopses in 2.4.14
Message-ID: <20011121005419.A11766@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Syncing my Palm m500 with coldsync 2.2.0 always results in an oops.  This
happened on 2.4.12 and 2.4.14 (both with preemptive kernel patch from Robert
Love plus whatever patches Debian includes in its kernel-source-2.4.x
packages).  There's also NVidia binary-only module loaded that taints the
kernel.  If you think any of these factors (kpreempt/strange modules) are
relevant here, I can try hotsyncing with plain 2.4.14 (or maybe the current
2.4.15pre would be better?).  However I've seen other reports about similair
oopses going back to late October, so I think it shouldn't be kpreempt/NVidia
specific.


ksymoops 2.4.3 on i686 2.4.14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14/ (default)
     -m /boot/System.map-2.4.14 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

  (I've diffed the last .modules in /var/log/ksymoops/ (which was created
  about 1 second before the oops, according to syslog) with
  /proc/modules -- they were identical except for visor.o use count)

Unable to handle kernel paging request at virtual address 0004004c
c01d1770
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01d1770>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00040038   ebx: c94b8494   ecx: c1e4c000   edx: 00040038
esi: c1e4c7a0   edi: c94b8400   ebp: c94b84f0   esp: c5029ec4
ds: 0018   es: 0018   ss: 0018
Process coldsync (pid: 4631, stackpage=c5029000)
Stack: d5a292bf 00040038 c94b8494 c94b8400 cb706540 00000000 d5a23334 c94b8494
       cb706540 cfd86000 cdfd1680 c1405320 c0173950 cfd86000 cb706540 c5028000
       cdfd1680 c1405320 c3be52e0 00000001 cbfea780 0806600d 00000000 c5028000
Call Trace: [<d5a292bf>] [<d5a23334>] [<c0173950>] [<c01110d8>] [<c0173fdd>]
   [<c0132c74>] [<c0131a9c>] [<c0131b07>] [<c0106d2b>]
Code: 8b 42 14 85 c0 74 19 8b 80 bc 00 00 00 8b 40 18 52 8b 40 10

>>EIP; c01d1770 <usb_unlink_urb+8/30>   <=====
Trace; d5a292be <[visor]visor_close+13a/168>
Trace; d5a23334 <[usbserial]serial_close+a0/b0>
Trace; c0173950 <release_dev+240/520>
Trace; c01110d8 <do_page_fault+0/4a8>
Trace; c0173fdc <tty_release+24/5c>
Trace; c0132c74 <fput+4c/f0>
Trace; c0131a9c <filp_close+a0/ac>
Trace; c0131b06 <sys_close+5e/90>
Trace; c0106d2a <system_call+32/38>
Code;  c01d1770 <usb_unlink_urb+8/30>
00000000 <_EIP>:
Code;  c01d1770 <usb_unlink_urb+8/30>   <=====
   0:   8b 42 14                  mov    0x14(%edx),%eax   <=====
Code;  c01d1772 <usb_unlink_urb+a/30>
   3:   85 c0                     test   %eax,%eax
Code;  c01d1774 <usb_unlink_urb+c/30>
   5:   74 19                     je     20 <_EIP+0x20> c01d1790 <usb_unlink_urb+28/30>
Code;  c01d1776 <usb_unlink_urb+e/30>
   7:   8b 80 bc 00 00 00         mov    0xbc(%eax),%eax
Code;  c01d177c <usb_unlink_urb+14/30>
   d:   8b 40 18                  mov    0x18(%eax),%eax
Code;  c01d1780 <usb_unlink_urb+18/30>
  10:   52                        push   %edx
Code;  c01d1780 <usb_unlink_urb+18/30>
  11:   8b 40 10                  mov    0x10(%eax),%eax


1 warning issued.  Results may not be reliable.


Another oops is very similair, so I'm only providing the differences:

--- oopsII-01.decoded   Tue Nov 20 21:55:43 2001
+++ oopsII-02.decoded   Tue Nov 20 21:55:49 2001
@@ -19,14 +19,14 @@
 CPU:    0
 EIP:    0010:[<c01d1770>]    Tainted: PF
 Using defaults from ksymoops -t elf32-i386 -a i386
-EFLAGS: 00010202
-eax: 00040038   ebx: c94b8494   ecx: c1e4c000   edx: 00040038
-esi: c1e4c7a0   edi: c94b8400   ebp: c94b84f0   esp: c5029ec4
+EFLAGS: 00013202
+eax: 00040038   ebx: c94b8894   ecx: c1e4c000   edx: 00040038
+esi: c1e4c7c0   edi: c94b8800   ebp: c94b88f0   esp: c66bdec4
 ds: 0018   es: 0018   ss: 0018
-Process coldsync (pid: 4631, stackpage=c5029000)
-Stack: d5a292bf 00040038 c94b8494 c94b8400 cb706540 00000000 d5a23334 c94b8494
-       cb706540 cfd86000 cdfd1680 c1405320 c0173950 cfd86000 cb706540 c5028000
-       cdfd1680 c1405320 c3be52e0 00000001 cbfea780 0806600d 00000000 c5028000
+Process coldsync (pid: 4697, stackpage=c66bd000)
+Stack: d5a292bf 00040038 c94b8894 c94b8800 cb969820 00000000 d5a23334 c94b8894
+       cb969820 cfd86000 cdfd1680 c1405320 c0173950 cfd86000 cb969820 c66bc000
+       cdfd1680 c1405320 c3be52e0 00000001 c431f3c0 0806600d 00000000 c66bc000
 Call Trace: [<d5a292bf>] [<d5a23334>] [<c0173950>] [<c01110d8>] [<c0173fdd>]
    [<c0132c74>] [<c0131a9c>] [<c0131b07>] [<c0106d2b>]
 Code: 8b 42 14 85 c0 74 19 8b 80 bc 00 00 00 8b 40 18 52 8b 40 10


Marius Gedminas
-- 
As easy as 3.14159265358979323846264338327950288419716
