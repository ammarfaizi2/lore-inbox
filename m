Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287939AbSBIOll>; Sat, 9 Feb 2002 09:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288685AbSBIOlc>; Sat, 9 Feb 2002 09:41:32 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:34742 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S287939AbSBIOlS>;
	Sat, 9 Feb 2002 09:41:18 -0500
To: Telford002@aol.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [HDLC] Purpose of this Driver?
In-Reply-To: <143.90e492f.29927e68@aol.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 09 Feb 2002 01:20:05 +0100
In-Reply-To: <143.90e492f.29927e68@aol.com>
Message-ID: <m3pu3fwloq.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Telford002@aol.com writes:

> I would recommend a generalized WAN interface that is capable of
> being configured for SDLC Loop (primary & secondary), all variants
> of bisync and transparent modes.  I have clients that do all of these,
> including a very bizarre 13 bit bisync.  And practically every
> variation is used either to carry IP or to communicate with
> a proprietary legacy protocol application.

There is no problem with that. However, things in Linux get implemented
usually because users require them. For now, users want PPP, Frame
Relay, Cisco HDLC.

> > Plus there are different CRCs or no CRC (FCS) at all.
> > In fact, we're using "idle flags" version only (?).
> 
> Why?  It would be trivial to add Mark Idle support.

Of course. But nobody just wanted it.

> Is there a functional specification somewhere that outlines
> the goals of the project?  I have only just started to follow
> this discussion because I included a synchronous HDLC
> flag framing and bit inserting-deleting character driver
> as well as synchronous TTY terminals in the SAB8253X
> ASLX driver that I am in the process of releasing.

No, there is no specification. You can get the idea by browsing hdlc*.c
and include/linux/hdlc.h file (using a modern kernel + my hdlc patch).

> If FR and PPP are to be supported, are LAP, LAPB, LAPD
> to be supported?  How about X.25 Packet Layer, CCITT
> 1976, 1980, 1984, 1988 and BX.25 variants.  How about
> PADs and V.120?
> 
> Obviously, it could take man decades to implement all
> this stuff completely.  But the presence of hooks for
> other people to add such support in later would be great.

The kernel source is open, anyone can add the support.
No special hooks seem necessary. For now, it can do FR, PPP (via
syncppp.c), Cisco, and X.25 is done using Linux X.25 + LAPB stack.

> I would recommend that a generic WAN interface be able
> to interface to the Linux network layer and the TTY
> driver and include some sort of getmsg/putmsg-like
> application interface.

It seems unrelated. Of course the HDLC code interfaces with the network
code. I'd stay away from tty as sync serial devices are rarely used for
TTY-alike communications, and no tty drivers exist for most of such cards.
Obviously, particular driver can support tty mode if needed, or new
"protocol" can be implemented which does exactly that.
-- 
Krzysztof Halasa
Network Administrator
