Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTJFQPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbTJFQPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:15:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:63618 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262386AbTJFQPI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:15:08 -0400
Date: Mon, 6 Oct 2003 12:17:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: John Bradford <john@grabjohn.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       Dave Jones <davej@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: FDC motor left on
In-Reply-To: <Pine.GSO.3.96.1031006174121.18687C-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.53.0310061157090.9590@chaos>
References: <Pine.GSO.3.96.1031006174121.18687C-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Maciej W. Rozycki wrote:

> On Mon, 6 Oct 2003, Richard B. Johnson wrote:
>
> > > This is not a problem to deal with in the kernel - what if there is
> > > hardware other than a floppy controller at that address?
> >
> > In the ix86 architecture (and it is in arch-specific code), there
> > cannot be anything at this address except a floppy or nothing.
> > In both cases, you are covered.
>
>  Huh?  The floppies use ordinary I/O ports at the ISA bus, not the range
> reserved for motherboard devices as, until quite recently, FDCs used to
> exist solely as add-on cards (I still have one).  Any other ISA device is
> free to use the port range if it's unused by anything else (e.g. no FDC
> there).  Ditto for IRQ6 -- older cards used to have an option to use this
> line, only newer ones often do not have it anymore, for unknown reason
> (i.e. the cost is probably one).

No. The range of addresses for floppy disk controllers is
"reserved" for floppy disk controllers. That's the rule for
IBM/PC/AT/Intel compatible devices. This is specified in
the literature like that written by Phoenix, IBM, etc.
(Phoenix Technical Reference Series, System BIOS for
IBM PC/XT/AT and Compatible Computers.  ISBN 0-201-51806-6

We have rules. That's what "Compatible" means. If you break
the compatibility by putting something else at that address,
you take your chances.

When the Super I/O chips are programmed, the floppy device,
(usually logical device 0) is (must) be put at the base
address reserved for floppy disks in compatible machines.
It's the rule. If you are using the same chip in some non-
compatible machine (like a power-PC), they have rules where
the floppy must be addressed, too. These addresses are
different for different architectures and, some machines
don't have I/O ports, they are memory mapped. In those
cases, the floppy is put at some memory-mapped address.

For the architecture in the linux i386 subdirectory, which
is what I was talking about, there will either be a FDC
controller output register at 0x372, with the bits previously
taught, or there will be nothing. It's that simple. If
you make it more complicated, then you don't understand
what compatibility means.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


