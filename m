Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266546AbSKGNcp>; Thu, 7 Nov 2002 08:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266549AbSKGNcp>; Thu, 7 Nov 2002 08:32:45 -0500
Received: from zeus.kernel.org ([204.152.189.113]:30668 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S266546AbSKGNco> convert rfc822-to-8bit;
	Thu, 7 Nov 2002 08:32:44 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Fernando Fraga e Silva <fernando.fraga@poli.usp.br>
Organization: Universidade de =?iso-8859-1?q?S=E3o?= Paulo
To: linux-kernel@vger.kernel.org
Subject: Parallel port misbehavior using kernel 2.4.19 and pcchips M810
Date: Fri, 8 Nov 2002 10:38:21 -0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211081038.21291.fernando.fraga@poli.usp.br>
X-OriginalArrivalTime: 07 Nov 2002 13:38:53.0939 (UTC) FILETIME=[038F1C30:01C28663]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys
I'm working for 4 days on a parallel port misbehavior problem without having 
any sucess. I have to control a device with SPP mode using a pcchips M810, a 
Duron processor and a kernel 2.4.19.
So I made the following simple code :
--
#include <asm/io.h> //i've tried <sys/io.h>  too
int main ()
{
ioperm( 0x378, 3, 1);
outb (0x01, 0x378 );
ioperm (0x378, 3, 0);
return 0;
}
--
And copiled with "gcc -O2 test.c -o test; ./test".  running it as superuser 
the result should be a "1" logic on pin "2" of parallel port.
Ok it is correct except for this motherboard, it works on Soyo+K6 , 
Gigabyte+Athlon, i810+Celeron, etc. But it doesn't for M810+Duron.
I verified the BIOS setup, changed the kernel source for 2.2.20, changed the 
motherboard for M812, recompiled and recompiled the kernel, changed the 
distro from Debian/Woody to Debian/Testing. None of this worked.

So I tried to install Win95 and make it using a assembler code ... It worked.

The next thing i've done was start making a kernel module.... it worked for 
Gigabyte+Athlon, i810+Celeron, Soyo+K6 and a old PC-Chips board with K6 
processor....but nothing happened for the M810+Duron board though.

So I thought it should be a problem with outb call, so I made a module using 
assembler instead outb call, it was compiled with success and was installed. 
The requested i/o region was reserved with success but didn't work with 
M810+Duron. Though It worked with Gigabyte+Athlon and Soyo+K6 again.
So i get the old code (as i listed above)  and after testing it with success 
again in the Soyo+K6 board i compiled it and linked the program statically. i 
brought the executable to the M810+Duron and it didn't work again... though 
it always runs without any errors the signals are not present on the parallel 
port. 

I tried to access the parallel port through /dev/ports using lseek to get the 
0x378 address position... and the result was the same... nothing for 
M810+Duron

I don't know any more to do, and I'm wondered if anyone here can help me. I 
can't believe it will not work on this motherboard if the parallel works 
perfectly. If anyone have any information about this parallel port on this 
motherboard, any code or any related knowlegment and like to share It would 
be a lot appreciated.

Thanks.

Fernando.

