Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSJZFw3>; Sat, 26 Oct 2002 01:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261862AbSJZFw3>; Sat, 26 Oct 2002 01:52:29 -0400
Received: from portofix.ida.liu.se ([130.236.177.25]:34246 "EHLO
	portofix.ida.liu.se") by vger.kernel.org with ESMTP
	id <S261861AbSJZFw2>; Sat, 26 Oct 2002 01:52:28 -0400
Date: Sat, 26 Oct 2002 07:58:36 +0200 (MEST)
From: Adrian Pop <adrpo@ida.liu.se>
To: Adam Kropelin <akropel1@rochester.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: The pain with the Net Drivers (ne*, xirc2ps_c, etc)
In-Reply-To: <20021026044500.GA11483@www.kroptech.com>
Message-ID: <Pine.GSO.4.44.0210260712300.11632-100000@mir20.ida.liu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Oct 2002, Adam Kropelin wrote:

> Show a little effort.


Here it comes some little effort :)
Doesn't matter the kernel version,
if is bigger than 2.2 (better to say: the version
when the timeouts handlers were introduced in
the network drivers)
Doesn't matter the computer even.

Error:
 NETDEV WATCHDOG: eth0: transmit timed out
 eth0: transmit timed out
And after this the card resets, and it
takes quite a while for that.

My workaround for NE2000 cards: in 8390.h replaced
  #define TX_TIMEOUT (20*HZ/100)
  with
  #define TX_TIMEOUT (100*HZ/100)

I used the NE2000 cards in 2 computers:
 Computer 1: K6 4xx Mhz (i don't remeber more because i don't have it
anymore)
 Computer 2: Cyrix 486DX2 66Mhz
 Network cards: NE2000 ISA

Both gived the errors under medium load with
the original timeout: TX_TIMEOUT (20*HZ/100).
They reported no error and worked perfectly after
changing TX_TIMEOUT to (100*HZ/100)

Now the story repeats itself with Dell Latitude
laptop and with the pcmcia credit card Xircom
that uses xirc2ps_cs driver. If i download
with more than 20Kbps for 2 minutes the network
goes down and i have to "pcmcia restart" to make it
work again.
In xirc2ps_cs.c the TX_TIMEOUT is (400*HZ/1000).
I just finally downloaded the kernel and i'll see
what improvements i have if i make the timeout
bigger.

The error happens with older
NE2K-PCI cards too, and
it really doesn't matter
the computer (Dual Pentium - 233Mhz or Athlon - 1Ghz).

The most annoying thing is when you try to
install linux from the net. It just takes
forever because of the timeouts/card resets.
Or it just stalles.

I don't know what it should be done concering these
problems. To give TX_TIMEOUT as a boot parameter
would be ok, or at least in the bootnet.img and pcmciadd.img
to make the timeout bigger for these drivers.

Regards,
/Adi, who still has some patience left.

