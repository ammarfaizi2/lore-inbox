Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291104AbSAaPYo>; Thu, 31 Jan 2002 10:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291105AbSAaPYe>; Thu, 31 Jan 2002 10:24:34 -0500
Received: from chaos.analogic.com ([204.178.40.224]:61574 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S291104AbSAaPY0>; Thu, 31 Jan 2002 10:24:26 -0500
Date: Thu, 31 Jan 2002 10:26:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Terje Eggestad <terje.eggestad@scali.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP/IP Speed
In-Reply-To: <1012485627.21288.100.camel@pc-16.office.scali.no>
Message-ID: <Pine.LNX.3.95.1020131091155.26514A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 2002, Terje Eggestad wrote:

> Hmmm, 
> 
> I tend to use the rdtsc register to do these kind of measurements, 
> but I get ~110 uS round trip with or without TCP_NDELAY
>

AMD-SC520 ( 'i486 ) don't have such an instruction. Therefore benchmarks,
which have to run 'everywhere' need to be generic.

> I get ~100uS wehen pinging with raw ethernet frames.

> 
> PS: Intel 82557 Ethernet Pro 100 NIC's
> 

Ping doesn't count. ICMP is handled in the kernel a few procedures
removed from actual frame acquisition. It looks like the kernel
takes the data I'm waiting for, hides it away for awhile, scheduling
other tasks, then finally decides to wake me up, having been sleeping
in read() for a whole millisecond. This is entirely unacceptable.

Since this 1000 data-buffers-per-second limitation is independent of
CPU speed and/or RAM speed, it seems to be imposed artificially by
the network implementation. It may have something to do with additions
to stop DOS or whatever. I need to turn it OFF.

I have done setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &x sizeof(x));
                      ... SOL_TCP, TCP_NODELAY...
with int x = 1;, everywhere a socket is created. It seems like a
no-op.

My sun uses SunOS 5.5.1, with GNU 'C' runtime libraries, gcc 2.7.2, and
it doesn't display this problem. The speed is lower because it has only
a 10-base network connection, but the Tx/Rx time is running around
250 to 300 microseconds, not the awful 1 millisecond.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


