Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbSKPHRx>; Sat, 16 Nov 2002 02:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbSKPHRx>; Sat, 16 Nov 2002 02:17:53 -0500
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:24020
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id <S267241AbSKPHRw>; Sat, 16 Nov 2002 02:17:52 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: lan based kgdb
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com> <20021115222430.GA1877@tahoe.alcove-fr> <ar4h11$g7n$1@penguin.transmeta.com>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 15 Nov 2002 23:24:49 -0800
In-Reply-To: <ar4h11$g7n$1@penguin.transmeta.com>
Message-ID: <ugadkaase6.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 16 Nov 2002 05:30:05 +0100, torvalds@transmeta.com (Linus Torvalds) said:

  Linus> Yes, if you're comparing to a full TCP implementation, plain
  Linus> USB serial lines may be simpler (ignoring for the moment the
  Linus> fact that there isn't even a standard USB serial line
  Linus> protocol, and they may be going the same way as the hardware
  Linus> serial lines - the way of the dodo).

  Linus> But it should be possible to do a really simple
  Linus> UDP-packets-only thing for kgdb.  Sure, it may lose packets.
  Linus> Tough.  Don't debug over a WAN, and try to keep a clean
  Linus> direct network connection if you are worried about it.  But
  Linus> we want kernel printk's to be synchronous anyway, without
  Linus> timeouts etc.

  Linus> And I suspect you're better off losing packets (very rarely
  Linus> over any normal local network) if that means that your
  Linus> debugger needs only minimal support. You can always re-type.

I did this a couple of years ago for my research OS (Scout) and it
worked great.  It did UDP over Ethernet and was about 300 lines of
code.  Rather than using the normal UDP stack, the kernel gdb I/O ran
directly on top of the network driver to reduce the risk of getting
hit by a breakpoint that is in the way of the gdb I/O.  The code is
almost too trivial to mention, but for anyone interested, it can still
be found at:

	http://www.cs.arizona.edu/scout/software.html

The relevant files are scout/sys/ai/kgdb_net.c and
scout/router/tulip/tulip.c (the latter contains the Ethernet driver
portion).

	--david

PS: IIRC, the kgdb protocol has a simple checksumming protocol so it
    can deal with packet losses (perhaps not very gracefully, but on a
    LAN it's not going to be a problem anyhow).
