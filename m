Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267619AbTAHSiN>; Wed, 8 Jan 2003 13:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbTAHSiN>; Wed, 8 Jan 2003 13:38:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63617 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267619AbTAHSiM>; Wed, 8 Jan 2003 13:38:12 -0500
Date: Wed, 8 Jan 2003 13:49:26 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ray Lee <ray-lk@madrabbit.org>
cc: fretre3618@hotmail.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tenth post about PCI code, need help
In-Reply-To: <1042049372.850.921.camel@orca.madrabbit.org>
Message-ID: <Pine.LNX.3.95.1030108132812.28791A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2003, Ray Lee wrote:

> > 1. which device is at port address 0xCFB? (please note, NOT 0xCF8)
> 
> 0xcfb ('bee') is the fourth byte of the 32 bit register that sits/starts
> at 0xcf8 ('eight'). Note the difference in the code between the outb and
> outl calls.
> 
> To answer your other questions, I think you'd have better luck reading
> the spec for the x86 pc-style PCI bridge chip, rather than the (generic)
> PCI v2.0 spec itself. The spec for the actual chip is always the final
> authority for what's going on. (Unless, of course, it's wrong...)
> 
> Ray
> 

The problem is that he's discovered something that's not supposed
to be in the code. Only 32-bit accesses are supposed to be made to
the PCI controller ports. He has discovered that somebody has made
some 8-bit accesses that will not become configuration 'transactions'
because they are not 32 bits. According to the spec, such accesses
become direct I/O to some underlying device. So, if some underlying
device shares the same I/O address space as the PCI device, that
machine is broken.

FYI, the mechanism by which ix86 hardware determines if the PCI
port access is a configuration read or configuration write is
the 32-bit access. Any other access cannot be interpreted by
the hardware as a configuration transaction. (Page 321., 
"Into to configuration Mechanisms", PCI System Architecture,
ISBN 0-201-30974-2)


It is possible that somebody had a bad board and found that writing
some junk to this port 'fixed' something. If this is so, then the
code needs some comments. Otherwise, the non-32bit accesses should
be removed.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


