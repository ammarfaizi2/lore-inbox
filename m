Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287947AbSABUWE>; Wed, 2 Jan 2002 15:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287945AbSABUVp>; Wed, 2 Jan 2002 15:21:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S287944AbSABUVm>; Wed, 2 Jan 2002 15:21:42 -0500
Date: Wed, 2 Jan 2002 15:21:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: Michal Moskal <malekith@pld.org.pl>, linux-kernel@vger.kernel.org
Subject: Re: strange TCP stack behiviour with write()es in pieces
In-Reply-To: <Pine.LNX.4.33.0201021140130.22556-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.3.95.1020102150256.498A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, dean gaudet wrote:

> On Wed, 2 Jan 2002, Michal Moskal wrote:
> 
> > 	void send_packet(int cmd, void *data, int len)
> > 	{
> > 		struct header h = { cmd, len };
> >
> > 		write(fd, &h, sizeof(h));
> > 		write(fd, data, len);
> > 	}
> 
> you should look into writev(2).
[SNIPPED...]

First, this isn't "TCP stack behavior...". It's an apparent attempt
to write raw (network?) packets using some kernel primitives. I presume
that you have obtained the fd from either socket() or by opening some
device. Whatever. If you are generating a "packet", you need to
make the packet in a buffer and send the packet. You can't presume
that something will concatenate to separate writes into some
kind of "packet". If the hardware is Ethernet, even the hardware
will fight you because it puts a destination-hardware-address, 
source-hardware-address, packet-length, data (your packet), then
32-bit CRC into the outgoing packet. FYI, that 'data' is where
the TCP/IP data-gram exists.

That said, if you are trying to make some kind of "zero-copy" thing,
you need to leave space in the initial allocation for the header and
other overhead. That way, you do one write to the device.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


