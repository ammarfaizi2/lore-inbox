Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWELPSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWELPSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWELPSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:18:15 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:35789 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932128AbWELPSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:18:15 -0400
Date: Fri, 12 May 2006 17:18:11 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bill Davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: www.softpanorama.org: sparc_vs_x86 fun
In-Reply-To: <4460A9A0.5090404@tmr.com>
Message-ID: <Pine.LNX.4.61.0605100920330.27657@yvahk01.tjqt.qr>
References: <200605041224.41827.vda@ilport.com.ua>
 <Pine.LNX.4.61.0605041322070.24957@yvahk01.tjqt.qr> <4460A9A0.5090404@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> while on SPARC, it takes 6 instructions (of course, being RISC makes it
>> execute differently than x64)
>> 
>> sethi %g1, $some_upper_bits
>> or %g1, $next_bitgroup
>> (shift-left)
>> or %g1, $next_bitgroup
>> (shift-left)
>> or %g1, $last_bitgroup
>> 
>> BTW, T1 is cool, but that the 1U version only has space for 1 disk is
>> pretty limiting :/
>
> I have to believe that you can load 64 bit constant data from memory and
> don't have to do all this dancing with immediate loads. Therefore this
> must be faster or they wouldn't do it this way. Or is this a point that
> some unoptimized compiler could generate this code?

gcc 4.1.0 -m64. (Debian unstable)
I also tried
gcc version 4.0.0 20041019 (Red Hat 4.0.0-0.8sparc) <Aurora SPARC> -m64

generating (`objdump -DS test.o`)

0000000000000000 <main>:
#include <stdio.h>
int main(void) {
   0:   9d e3 bf 40     save  %sp, -192, %sp
    return printf("%lld\n", 0x12345678abcdefULL);
   4:   03 00 00 00     sethi  %hi(0), %g1
   8:   90 10 60 00     mov  %g1, %o0   ! 0 <main>
   c:   03 00 04 8d     sethi  %hi(0x123400), %g1
  10:   82 10 60 56     or  %g1, 0x56, %g1      ! 123456 <main+0x123456>
  14:   85 28 70 20     sllx  %g1, 0x20, %g2
  18:   03 1e 2a f3     sethi  %hi(0x78abcc00), %g1
  1c:   82 10 61 ef     or  %g1, 0x1ef, %g1     ! 78abcdef <main+0x78abcdef>
  20:   92 00 80 01     add  %g2, %g1, %o1
  24:   40 00 00 00     call  24 <main+0x24>




Jan Engelhardt
-- 
