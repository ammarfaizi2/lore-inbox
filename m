Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313932AbSDKPap>; Thu, 11 Apr 2002 11:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313942AbSDKPao>; Thu, 11 Apr 2002 11:30:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:16771 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313932AbSDKPan>; Thu, 11 Apr 2002 11:30:43 -0400
Date: Thu, 11 Apr 2002 11:31:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Abraham vd Merwe <abraham@2d3d.co.za>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: CHECKSUM_HW not behaving as expected
In-Reply-To: <20020411170458.A2786@crystal.2d3d.co.za>
Message-ID: <Pine.LNX.3.95.1020411111450.14550A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002, Abraham vd Merwe wrote:

> Hi!
> 
> In Rubini's "Linux Device Drivers 2nd edition" he states in his networking
> chapter that skb->ip_summed = CHECKSUM_HW means that the hardware already
> performed a checksum and that the upper layers therefore don't need to do it
> (He also states that CHECKSUM_NONE (default) means that it still needs to be
> verified).
> 
> I'm currently writing a network driver for 2.4.17 and the chip automatically
> performs checksums and you can tell it to exclude the CRC from the packet or
> not before making it available for the host. Now, if I configure it to
> exclude the CRC and use skb->ip_summed = CHECKSUM_HW I get:
> 

CRC not!
The IP checksum is not the CRC. Some new network boards "know" about
the IP checksum and can compute it. The CRC is a hardware-computed CRC
that is appended to every Ethernet packet. The CRC must be received
intact or the packet is rejected (dropped). If it's possible to 'tell'
your board to exclude the CRC, this is not what you want.

If you already know this, then the possible problem is that the
packet length is wrong. The IP checksum is a 16-bit integer of
16-bit integers. This means that the packet length must be an even
number. Your driver may be returning the wrong length. Also, when
you transmit, if the hardware is going to do the checksum, what
does it expect at the checksum offset in the IP packet? Hardware
checksums usually don't 'skip' some offset so the checksum value
should probably be 0 when it goes to your hardware.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

