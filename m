Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267837AbTBEHTm>; Wed, 5 Feb 2003 02:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267838AbTBEHTm>; Wed, 5 Feb 2003 02:19:42 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:15627 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267837AbTBEHTl>; Wed, 5 Feb 2003 02:19:41 -0500
Message-Id: <200302050717.h157HTs16569@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Herman Oosthuysen <Herman@WirelessNetworksInc.com>,
       John Bradford <john@grabjohn.com>
Subject: Re: gcc 2.95 vs 3.21 performance
Date: Wed, 5 Feb 2003 09:15:48 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Dave Jones <davej@codemonkey.org.uk>, wookie@osdl.org,
       root@chaos.analogic.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
References: <200302042011.h14KBuG6002791@darkstar.example.net> <3E40264C.5050302@WirelessNetworksInc.com>
In-Reply-To: <3E40264C.5050302@WirelessNetworksInc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 February 2003 22:45, Herman Oosthuysen wrote:
> Hi there,
>
>  From my experience, the speed issue is caused by misalligned memory
> accesses, causing inefficient SDRAM to Cache movement of data and
> instructions.
>
> I don't think that you necessarily need a modification to the
> compiler. What you can do is carefully place the ALLIGN switch in a
> few critical places in the kernel code, to ensure that the code and
> data will be properly alligned for whatever processor it is compiled
> for, be that a Pentium, an ARM, a MIPS or whatever.
>
> It would be nice if GCC can be suitably improved to do this correcly
> for all architectures, but a little bit of human help can do wonders,
> without having to fork the GCC project.

			NO.

GCC already went this way, i.e. it aligns functions and loops by
ridiculous (IMHO) amounts like 16 bytes. That's 7,5 bytes per alignment
on average. Now count lk functions and loops and mourn for lost icache.
Or just disassemble any .o module and read the damn code.

This is the primary reason why people report larger kernels for GCC 3.x

I am damn sure that if you compile with less sadistic alignment
you will get smaller *and* faster kernel.
--
vda
