Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267317AbSKPRuf>; Sat, 16 Nov 2002 12:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267318AbSKPRuf>; Sat, 16 Nov 2002 12:50:35 -0500
Received: from crack.them.org ([65.125.64.184]:48774 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267317AbSKPRue>;
	Sat, 16 Nov 2002 12:50:34 -0500
Date: Sat, 16 Nov 2002 12:58:51 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: David Mosberger-Tang <David.Mosberger@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lan based kgdb
Message-ID: <20021116175851.GA32641@nevyn.them.org>
Mail-Followup-To: David Mosberger-Tang <David.Mosberger@acm.org>,
	linux-kernel@vger.kernel.org
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com> <20021115222430.GA1877@tahoe.alcove-fr> <ar4h11$g7n$1@penguin.transmeta.com> <ugadkaase6.fsf@panda.mostang.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ugadkaase6.fsf@panda.mostang.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 11:24:49PM -0800, David Mosberger-Tang wrote:
> >>>>> On Sat, 16 Nov 2002 05:30:05 +0100, torvalds@transmeta.com (Linus Torvalds) said:
> 
>   Linus> Yes, if you're comparing to a full TCP implementation, plain
>   Linus> USB serial lines may be simpler (ignoring for the moment the
>   Linus> fact that there isn't even a standard USB serial line
>   Linus> protocol, and they may be going the same way as the hardware
>   Linus> serial lines - the way of the dodo).
> 
>   Linus> But it should be possible to do a really simple
>   Linus> UDP-packets-only thing for kgdb.  Sure, it may lose packets.
>   Linus> Tough.  Don't debug over a WAN, and try to keep a clean
>   Linus> direct network connection if you are worried about it.  But
>   Linus> we want kernel printk's to be synchronous anyway, without
>   Linus> timeouts etc.
> 
>   Linus> And I suspect you're better off losing packets (very rarely
>   Linus> over any normal local network) if that means that your
>   Linus> debugger needs only minimal support. You can always re-type.
> 
> I did this a couple of years ago for my research OS (Scout) and it
> worked great.  It did UDP over Ethernet and was about 300 lines of
> code.  Rather than using the normal UDP stack, the kernel gdb I/O ran
> directly on top of the network driver to reduce the risk of getting
> hit by a breakpoint that is in the way of the gdb I/O.  The code is
> almost too trivial to mention, but for anyone interested, it can still
> be found at:
> 
> 	http://www.cs.arizona.edu/scout/software.html
> 
> The relevant files are scout/sys/ai/kgdb_net.c and
> scout/router/tulip/tulip.c (the latter contains the Ethernet driver
> portion).

And I'm 95% sure that someone here (MontaVista) has done the same thing
for Linux... ARM if my memory serves me correctly.  You'll also notice
that UDP debugging support is now in FSF GDB 5.3 snapshots.  Sure, it's
a little lossy, but it works in the useful cases.

I'm not quite sure what happened to the kernel side... but it sounds
like this could be a nice candidate for the network dumping stack, too.

> PS: IIRC, the kgdb protocol has a simple checksumming protocol so it
>     can deal with packet losses (perhaps not very gracefully, but on a
>     LAN it's not going to be a problem anyhow).

Yes.  The protocol also has explicit ACKs and has the basis for
retransmission; it's not extensive but it's enough to get by over even
a lossy serial cable.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
