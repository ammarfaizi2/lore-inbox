Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275161AbRIZMhi>; Wed, 26 Sep 2001 08:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275162AbRIZMh3>; Wed, 26 Sep 2001 08:37:29 -0400
Received: from chaos.analogic.com ([204.178.40.224]:64385 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S275161AbRIZMhV>; Wed, 26 Sep 2001 08:37:21 -0400
Date: Wed, 26 Sep 2001 08:37:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ben Greear <greearb@candelatech.com>
cc: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: Ethernet Error Correction
In-Reply-To: <3BB0F4C8.124B6576@candelatech.com>
Message-ID: <Pine.LNX.3.95.1010926082644.15440A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Ben Greear wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Tue, 25 Sep 2001, Karel Kulhavy wrote:
> > 
> > > What about implementing an Ethernet error correction in Linux kernel?
> > >
> > 
> > Ethernet uses hardware error detection. Only good packets get through.
> > Therefore there is nothing that a driver in the kernel could do to
> > recover an otherwise errored packet because the packet doesn't exist.
> > 
> 
> That's probably the default of most chipsets, but I wonder if you could
> tell it to send the busted packets up the stack anyway.  Then, the driver
> could make the decision in software whether or not to correct/foward, or
> discard the packet...  I assume that in order to detect a CRC error,
> the NIC already has the packet in it's buffers somewhere...
> 

The easiest thing is to not use an Ethernet SNIC. Instead use some
other serializer/deserializer for the IR link. Then you make a
serial driver with whatever error correction you want. You use PPP
with this serial driver.

FYI, you will probably find that fogged-in IR is not recoverable.
It has been my experience that you don't get "single-bit" errors,
instead, you get bursts of garbage as the PLL data-recovery circuit
goes out-of-lock.

When using a TAXI chip and Hewlett-Packard transceivers on a
fiber IR link, I don't use any error detection/correction at all.
TCP/IP has a checksum. The normal retry/retransmit mechanism works
fine.

Slowly pulling the fiber connector out of the socket, thus increasing
the attenuation (just like fog), produces no errors until a threshold
is reached. Then, all I get is errors --just junk, as the PLL loses
lock.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


