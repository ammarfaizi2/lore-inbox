Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311788AbSCNVEr>; Thu, 14 Mar 2002 16:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311789AbSCNVE0>; Thu, 14 Mar 2002 16:04:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311788AbSCNVEO>; Thu, 14 Mar 2002 16:04:14 -0500
Date: Thu, 14 Mar 2002 16:03:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: John Heil <kerndev@sc-software.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <Pine.LNX.4.33.0203141234170.1286-100000@scsoftware.sc-software.com>
Message-ID: <Pine.LNX.3.95.1020314155816.136A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, John Heil wrote:

> On Thu, 14 Mar 2002, Linus Torvalds wrote:
> 
> > Date: Thu, 14 Mar 2002 19:23:20 +0000 (UTC)
> > From: Linus Torvalds <torvalds@transmeta.com>
> > To: linux-kernel@vger.kernel.org
> > Subject: Re: IO delay, port 0x80, and BIOS POST codes
> >
> > In article <E16lZg3-0001Ug-00@the-village.bc.nu>,
> > Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
> > >> Unfortunately we can't read this information because Linux uses
> > >> port 80 as "dummy" port for delay operations. (outb_p and friends,
> > >> actually there seem to be a more hard-coded references to port
> > >> 0x80 in the code).
> > >
> > >The dummy port needs to exist. By using 0x80 we have probably the only
> > >port we can safely use in this way. We know it fouls old style POST
> > >boards on odd occasions.
> >
> > In fact, port 0x80 is safe exactly _because_ it is used for BIOS POST
> > codes, which pretty much guarantees that it will never be used for
> > anything else. That tends to not be as true of any other ports.
> >
> > Also, it should be noted that to get the 1us delay, the port should be
> > behind the ISA bridge in a legacy world (in a modern all-PCI system it
> > doesn't really matter, because the ports that need more delays are
> > faster too, so this works out ok).  That's why I personally would be
> > nervous about using some of the well-specified (but irrelevant) ports
> > that are on the PCI side of a super-IO controller.
> >
> > I suspect the _real_ solution is to stop using "inb_p/outb_p" and make
> > the delay explicit, although it may be that some drivers depend on the
> > fact that not only is the "outb $0x80" a delay, it also tends to act as
> > a posting barrier.
> >
> > 			Linus
> 
> No, the better/correct port is 0xED which removes the conflict.
> 
> We've used 0xED w/o problem doing an embedded linux implementation
> at kernel 2.4.1, where SMM issues were involved. (It was recommended
> to me by an x-Phoenix BIOS developer, because of its safety as well as
> conflict resolution,
> 
> Johnh
> 

Well I can see why he's an EX-Phoenix BIOS developer. A port at 0xed
does not exist on any standard or known non-standard Intel/PC/AT 
compatible.

Remember DOS debug?

C:\>debug

-i ed
FF
-o ed aa
-i ed
FF
-o ed 55
-i ed
FF
-q


This is not a DOS emulation. This is a real-mode boot where any ports
will be visible. If you used it with success, it means that you didn't
need the I/O delay of writing to a real port. Instead you got the
few hundred nanoseconds of delay you get by writing to nowhere.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

