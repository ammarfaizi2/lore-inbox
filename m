Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311828AbSCNWMo>; Thu, 14 Mar 2002 17:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311832AbSCNWMY>; Thu, 14 Mar 2002 17:12:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10112 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311827AbSCNWLm>; Thu, 14 Mar 2002 17:11:42 -0500
Date: Thu, 14 Mar 2002 17:11:51 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <a6r6a4$8hg$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.3.95.1020314165931.715A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Mar 2002, H. Peter Anvin wrote:

> Followup to:  <Pine.LNX.3.95.1020314164142.382B-100000@chaos.analogic.com>
> By author:    "Richard B. Johnson" <root@chaos.analogic.com>
> In newsgroup: linux.dev.kernel
> > 
> > Well no, IO doesn't "time-out". The PC/AT/ISA bus is asychronous, it's
> > not clocked. If there's no hardware activity as a result of the write
> > to nowhere, it's just a no-op. The CPU isn't slowed down at all. It's
> > just some bits that got flung out on the bus with no feed-back at all.
> > 
> 
> An OUT on the x86 architecture is synchronous... the CPU will not
> proceed until the OUT is present on the bus.  This is a requirement of
> the SMM architecture, actually.
> 
> 	-hpa

Yeh?  Then "how do it know?". It doesn't. I/O instructions are ordered,
however, that's all. There is no bus-interface state machine that exists
except on the addressed device. The CPU driven interface device just
makes sure that the data is valid before the address and I/O-read or
I/O-write are valid after this. The address is decoded by the device
and is used to enable the device. It either puts its data onto the
bus in the case of a read, or gets data off the bus, in the case of
a write. The interface timing is specified and is handled by hardware.
In the meantime the CPU has not waited because there is nothing to
wait for. On a READ, if the device cannot put its data on the bus
fast enough, it puts its finger io IO-chan-ready. This forces the
CPU (through its bus-interface) to wait.

Writes to nowhere are just that, writes to nowhere.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

