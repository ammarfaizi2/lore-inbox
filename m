Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318193AbSHIJa4>; Fri, 9 Aug 2002 05:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318205AbSHIJa4>; Fri, 9 Aug 2002 05:30:56 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:58548 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318193AbSHIJaz>; Fri, 9 Aug 2002 05:30:55 -0400
Message-Id: <200208090934.g799YVZe116824@d12relay01.de.ibm.com>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: klibc development release
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Mail-Copies-To: arndb@de.ibm.com
Date: Fri, 09 Aug 2002 13:33:53 +0200
References: <aivdi8$r2i$1@cesium.transmeta.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> I would particularly appreciate portability comments, since I'm flying
> blind on non-i386 machines (anyone want to send me hardware?),
> although any bug reports would be appreciated.

I just tried compiling for 64 bit s390x, this is what I found so far:

- in include/stdint.h, the definitions for *int_fast*_t conflict with
  the 64 bit ones

- mmap.c does not compile because _syscall6 is defined only for i386,
  alpha, cris, mips(64) and parisc but not for the other ten architectures.

- syscalls/time.o does not compile because __NR_time is not defined for
  alpha, ia64 and s390x

- making klibc cross compilable with 'make CROSS_COMPILE=prefix-' would be 
  a nice and trivial addition

- compile time warnings: see below

more later when I actually manage to run something

	Arnd <><

testvsnp.c: In function `main':
testvsnp.c:14: warning: int format, different type arg (arg 3)
testvsnp.c:17: warning: int format, different type arg (arg 3)
testvsnp.c:20: warning: int format, different type arg (arg 3)
testvsnp.c:23: warning: int format, different type arg (arg 3)
testvsnp.c:31: warning: int format, different type arg (arg 3)
testvsnp.c:36: warning: int format, different type arg (arg 3)
testvsnp.c:39: warning: int format, different type arg (arg 3)
testvsnp.c:42: warning: int format, different type arg (arg 3)
testvsnp.c:45: warning: int format, different type arg (arg 3)
testvsnp.c:48: warning: int format, different type arg (arg 3)
testvsnp.c:51: warning: int format, different type arg (arg 3)
testvsnp.c:54: warning: int format, different type arg (arg 3)
testvsnp.c:57: warning: int format, different type arg (arg 3)
testvsnp.c:60: warning: int format, different type arg (arg 3)
testvsnp.c:63: warning: int format, different type arg (arg 3)
testvsnp.c:66: warning: int format, different type arg (arg 3)
testvsnp.c:69: warning: int format, different type arg (arg 3)
testvsnp.c:72: warning: int format, different type arg (arg 3)
testvsnp.c:75: warning: int format, different type arg (arg 3)
testvsnp.c:79: warning: int format, different type arg (arg 3)
testvsnp.c:83: warning: int format, different type arg (arg 3)
testvsnp.c:87: warning: int format, different type arg (arg 3)
testvsnp.c:90: warning: int format, different type arg (arg 3)
testvsnp.c:93: warning: int format, different type arg (arg 3)
testvsnp.c:96: warning: int format, different type arg (arg 3)
testvsnp.c:99: warning: int format, different type arg (arg 3)
testvsnp.c:102: warning: int format, different type arg (arg 3)
testvsnp.c:105: warning: int format, different type arg (arg 3)
testvsnp.c:108: warning: int format, different type arg (arg 3)
testvsnp.c:111: warning: int format, different type arg (arg 3)
vfprintf.c: In function `vfprintf':
vfprintf.c:26: warning: cast from pointer to integer of different size
fputs.c: In function `fputs':
fputs.c:15: warning: cast from pointer to integer of different size
calloc.c: In function `calloc':
calloc.c:16: warning: type mismatch in implicit declaration for built-in function `memset'
vfprintf.c: In function `vfprintf':
vfprintf.c:26: warning: cast from pointer to integer of different size
fputs.c: In function `fputs':
fputs.c:15: warning: cast from pointer to integer of different size
calloc.c: In function `calloc':
