Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131380AbRBWRsz>; Fri, 23 Feb 2001 12:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131447AbRBWRsp>; Fri, 23 Feb 2001 12:48:45 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14354 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131380AbRBWRsf>; Fri, 23 Feb 2001 12:48:35 -0500
Date: Fri, 23 Feb 2001 09:48:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x 
In-Reply-To: <200102230534.WAA460104@ibg.colorado.edu>
Message-ID: <Pine.LNX.4.10.10102230938360.20762-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Feb 2001, Jeff Lessem wrote:
>
> In your message of: Thu, 22 Feb 2001 20:37:15 PST, you write:
> >Hmm.. You shouldn't be loading any i82365 module at all. You should load
> >the "yenta_socket" module. 
> 
> I had gone back to my old ways of useing the external PCMCIA stuff.
> Here are the relevant lspci --vvxx listings using the yenta driver
> builtin to the kernel.  The main difference I notice between the
> working and broken setup is that the memory locations of the CardBus
> controller are different.

That should be harmless - they are both unique, and it's just due to
different PCI region allocation for the new PCI code (and when
soft-booting from an older setup it will remember and honor the old
address).

The much more likely cause is the "magic registers" for the Texas
Instruments PCI1225, namely

		works		broken

	81:	b0		90
	a8:	11		10

Although it worries me a bit that your second controller also seems to
have differences in the BridgeCtl thing (16bInt).

Can you try if a broken setup is fixed by doing a

	setpci -s 00.04.0 81.b=b0
	setpci -s 00.04.0 a8.b=11
	setpci -s 00.04.1 81.b=b0
	setpci -s 00.04.1 81.b=11

or similar?

Also, how much memory does this machine have? That "13ff0000" does worry
me a bit..

		Linus

