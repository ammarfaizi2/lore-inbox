Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbTJPDNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 23:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTJPDNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 23:13:37 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:24961
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262647AbTJPDNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 23:13:34 -0400
Date: Wed, 15 Oct 2003 23:13:14 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] constant_test_bit doesn't like my gcc
Message-ID: <Pine.LNX.4.53.0310152244330.2328@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810560-708114547-1066273994=:2328"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463810560-708114547-1066273994=:2328
Content-Type: TEXT/PLAIN; charset=US-ASCII

cpu_has_foo and friends don't work at all with my gcc 3.2.2-5 and i'm 
branching off into all sorts of tests (which is another story...). i also 
took the liberty of removing the const volatile...

Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man 
--infodir=/usr/share/info --enable-shared --enable-threads=posix 
--disable-checking --with-system-zlib --enable-__cxa_atexit 
--host=i386-redhat-linux
Thread model: posix
gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)

0x08048328 <main+0>:    push   %ebp
0x08048329 <main+1>:    mov    %esp,%ebp
0x0804832b <main+3>:    sub    $0x8,%esp
0x0804832e <main+6>:    mov    0xfffffffc(%ebp),%eax
0x08048331 <main+9>:    and    $0xfffffff0,%esp
0x08048334 <main+12>:   shr    $0x3,%eax
0x08048337 <main+15>:   sub    $0x8,%esp
0x0804833a <main+18>:   and    $0x1,%eax
0x0804833d <main+21>:   push   %eax
0x0804833e <main+22>:   push   $0x8048400
0x08048343 <main+27>:   movl   $0xff,0xfffffffc(%ebp)
0x0804834a <main+34>:   call   0x8048268 <printf>
0x0804834f <main+39>:   xor    %eax,%eax
0x08048351 <main+41>:   leave

Index: linux-2.6.0-test7-mm1/include/asm-i386/bitops.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test7-mm1/include/asm-i386/bitops.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bitops.h
--- linux-2.6.0-test7-mm1/include/asm-i386/bitops.h	15 Oct 2003 09:02:10 -0000	1.1.1.1
+++ linux-2.6.0-test7-mm1/include/asm-i386/bitops.h	16 Oct 2003 03:04:34 -0000
@@ -239,12 +239,12 @@ static __inline__ int test_and_change_bi
 static int test_bit(int nr, const volatile void * addr);
 #endif
 
-static __inline__ int constant_test_bit(int nr, const volatile unsigned long * addr)
+static __inline__ int constant_test_bit(int nr, const unsigned long * addr)
 {
-	return ((1UL << (nr & 31)) & (((const volatile unsigned int *) addr)[nr >> 5])) != 0;
+	return ((1UL << (nr & 31)) & (((const unsigned long *) addr)[nr >> 5])) != 0;
 }
 
-static __inline__ int variable_test_bit(int nr, const volatile unsigned long * addr)
+static __inline__ int variable_test_bit(int nr, const unsigned long * addr)
 {
 	int oldbit;
 
---1463810560-708114547-1066273994=:2328
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="foo.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0310152313140.2328@montezuma.fsmlabs.com>
Content-Description: 
Content-Disposition: attachment; filename="foo.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQoNCnN0YXRpYyBpbnQgX19pbmxpbmVfXyBj
b25zdGFudF90ZXN0X2JpdChpbnQgbnIsIGNvbnN0IHZvbGF0aWxlIHVuc2ln
bmVkIGxvbmcgKiBhZGRyKQ0Kew0KCXJldHVybiAoKDFVTCA8PCAobnIgJiAz
MSkpICYgKCgoY29uc3Qgdm9sYXRpbGUgdW5zaWduZWQgaW50ICopIGFkZHIp
W25yID4+IDVdKSkgIT0gMDsNCn0NCg0KaW50IG1haW4oKQ0Kew0KCXVuc2ln
bmVkIGxvbmcgZm9vWzJdOw0KCSpmb28gPSAweGZmOw0KCWZvb1sxXSA9IDB4
ZmY7DQoNCglwcmludGYoIiVkICVkXG4iLCBjb25zdGFudF90ZXN0X2JpdCgz
LCBmb28pLCBjb25zdGFudF90ZXN0X2JpdCgzMywgZm9vKSk7DQoJcmV0dXJu
IDA7DQp9DQo=

---1463810560-708114547-1066273994=:2328--
