Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266710AbRGFOmR>; Fri, 6 Jul 2001 10:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266711AbRGFOmH>; Fri, 6 Jul 2001 10:42:07 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266710AbRGFOmD>; Fri, 6 Jul 2001 10:42:03 -0400
Date: Fri, 6 Jul 2001 10:41:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: are ioctl calls supposed to take this long?
In-Reply-To: <3B45BE6C.5DBE4F35@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1010706103248.519B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Chris Friesen wrote:

> 
> I am using the following snippet of code to find out some information about the
> MII PHY interface of my ethernet device (which uses the tulip driver).  When I
> did some timing measurements with gettimeofday() I found that the ioctl call
> takes a bit over a millisecond to complete.  This seems to me to be an awfully
> long time for what should be (as far as I can see) a very simple operation.
> 
> Is this the normal amount of time that this should take, and if so then why in
> the world does it take so long?  If not, then does anyone have any idea why it's
> taking so long?
> 
> Thanks,
> 

It's not ioctl() overhead, it's what has to be done in the driver to
get the information you request.

(1)	Stop the chip
(2)	Read the media interface using an awful SERIAL protocol in which
	you manipulate 3 bits using multiple instructions, to send
	or receive a single BIT (not BYTE) of data. You do the 8 times
	per byte.
(3)	Restart the chip.

You are lucky it doesn't take an hour. This garbage 1 bit interface,
in which hardware designers assumed that software was free, is an
example of the junk software engineers have to put up with.

This is, obviously, not designed to be accessed very often, just
any time somebody disconnects/reconnects the network wire. Don't
ioctl-it in a loop. You will lose most of the network packets.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


