Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSKBTgn>; Sat, 2 Nov 2002 14:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbSKBTgl>; Sat, 2 Nov 2002 14:36:41 -0500
Received: from user141.3eti.com ([65.220.88.141]:23313 "EHLO mail.aeptec.local")
	by vger.kernel.org with ESMTP id <S261206AbSKBTgY>;
	Sat, 2 Nov 2002 14:36:24 -0500
Message-ID: <EF5625F9F795C94BA28B150706A215480DF84F@MAIL>
From: "Donepudi, Suneeta" <sdonepudi@3eti.com>
To: "'Dave Jones '" <davej@codemonkey.org.uk>,
       "'Matt D. Robinson '" <yakker@aparity.com>
Cc: "Donepudi, Suneeta" <sdonepudi@3eti.com>,
       "''linux-kernel@vger.kernel.org' '" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel Panic during memcpy_toio to PCI card
Date: Sat, 2 Nov 2002 14:46:17 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Dave,

I am not sure if the problem is with memcpy_toio() itself because
I found that the kernel crash occurred even when I replaced the
memcpy_xxio() calls with readl() and writel(). The panic occured
during the memory transfer. We tried looking at the PCI bus
using an analyzer but found nothing wrong.

Thanks,
Suneeta 

-----Original Message-----
From: Dave Jones
To: Matt D. Robinson
Cc: Donepudi, Suneeta; 'linux-kernel@vger.kernel.org'
Sent: 11/1/02 6:29 PM
Subject: Re: Kernel Panic during memcpy_toio to PCI card

On Fri, Nov 01, 2002 at 03:28:10PM -0800, Matt D. Robinson wrote:

 >It still caused the crash in the same manner and at the same location.
 >Could someone help me with pointers to where I should start looking ?
 >Disabling interrupts around the memcpy_toio() did not make any
 >difference. Is this a hardware problem with the PCI card ? We are
using
 >a Xilinx core with out FPGA build into it.

memcpy_toio() in 2.4 is still using memcpy() which could use prefetch()
if you compile for certain processors.  Prefetching io space could do
all sorts of nasties.

2.5 changed this define (in include/asm-i386/io.h) to use __memcpy
instead, which doesn't use prefetching.

		Dave

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
