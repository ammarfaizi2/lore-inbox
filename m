Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSGAHf4>; Mon, 1 Jul 2002 03:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSGAHfz>; Mon, 1 Jul 2002 03:35:55 -0400
Received: from dns.uni-trier.de ([136.199.8.101]:150 "EHLO rzmail.uni-trier.de")
	by vger.kernel.org with ESMTP id <S315439AbSGAHfy>;
	Mon, 1 Jul 2002 03:35:54 -0400
Date: Mon, 1 Jul 2002 09:38:12 +0200 (CEST)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: whitney@math.berkeley.edu
cc: Stanislav Brabec <utx@penguin.cz>, LKML <linux-kernel@vger.kernel.org>,
       <sb@utx.vol.cz>, Daniel Nofftz <nofftz@castor.Uni-Trier.DE>
Subject: Re: another way to activate AMD disconnect on VIA KT266 (aka cooling
 bits)
In-Reply-To: <200206272052.g5RKqOe01878@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Message-ID: <Pine.LNX.4.40.0207010916410.26953-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there ....
sorry that i answer so late on this topic :)

On Thu, 27 Jun 2002, Wayne Whitney wrote:

> In mailing-lists.linux-kernel, you wrote:
>
> > enable:
> > setpci -v -H1 -s 0:0.0 70=86
> > setpci -v -H1 -s 0:0.0 95=1e
> >
> > disable:
> > setpci -v -H1 -s 0:0.0 70=82
> > setpci -v -H1 -s 0:0.0 95=1c
> >
> > The result is 15 degrees temperature decrease on low system load!
> > I don't know exactly, what I am doing (and chipset docs are not
> > available), explanation is welcome, (un)success stories for other
> > motherboards too.

interesting ... on my computer this does not work, but i have acpi system
enabled and use my own kernel patch. (which enables "disconnect enable on
STPGNT detect")

>
> Well, from a WPCREDIT file I found floating around the net
> (11063099.pcr):
>
> [70:2]=PCI Master Read Buffering  0=disable  1=enable
> [92:7]=Disc when STPGNT# Detect   0=disable  1=enable
> [95:1]=HALT Command Detect        0=disable  1=enable

ok ... that is the same information and source of information i have
...

> My understanding is that the Athlon CPU only turns on power savings
> when the chipset does a "bus disconnect".  [92:7] enables bus
> disconnect when the CPU issues STPGNT; [95:1] enables it when the
> chipset issues HALT.  Both the APM and ACPI idle loops at least do a

this is new for me ... in my documentation on the kt266a there stands only
"reserved"for the 95:1 ... interesting to know ...

> HALT, so with [95:1] set you will see power savings when the machine
> is idle.  As for an idle loop that does STPGNT, apparently only the
> ACPI C2 idle loop does that, so you will see power savings from
> setting just [92:7] only when your system supports the ACPI C2 state
> and you compile ACPI into the kernel.

the acpi c2 should be supported by many of the newer athlon boards ... but
some don't support it ... maybe cause they think it is not secure cause of
the athlon cpu bugs in this issue (athlon xp should not be affected by
this)

>
> As for [70:2], my understanding is that without it, PCI audio cards
> sometimes don't work when bus disconnect is enabled, they generate
> only noise.  This must be a more general interaction between bus
> disconnect and the PCI bus, but which is mostly just showing up with
> PCI audio cards.  Reportedly, setting [70:2] usually fixes PCI audio
> card noise.
>

yes .. .this is the same i heared ... but it does not work for everyone
...

> As for me, I'm using an ASUS A7V333 with the Via KT333 chipset, which
> has the same device id and register layout as the KT266 chipset.
> Unfortunately this board doesn't support the ACPI C2 state in its BIOS
> ACPI tables, so I use disconnect on HALT to enable power savings.  The
> only side effect I have noticed is that the on-board PCI audio chip
> acquires a quiet, high-pitched tone, presumably do to electrical noise
> from the CPU.  I don't need to use PCI Master Read Buffering, I guess
> because the PCI audio chip is on board.  I haven't tried a PCI audio
> card.
>
> I'd be very happy if anyone could tell me how to do any of these: get
> rid of the high-pitched noise with disconnect on HALT; have an idle

sorry ... no idea ...

> loop that uses STPGNT when my board doesn't support ACPI C2; hack the

hmmm ... there is a kernel patch out there, which replaces the apm idle
loop with an idle loop which issues STPGNT ... but this patch is only for
kt133 ... (-> lvcool kernel patch) ... maybe you could take this patch,
and use the altered idle loop for your system ...


daniel

# Daniel Nofftz .......................... #
# Sysadmin CIP-Pool Informatik ........... #
# University of Trier(Germany), Room V 103 #

The resonable man adapts himself to the world. The unreasonable
man persists in trying to adapt the world to himself. It follows
that all progress depends on the unresaonable man.
                                        George Bernard Shaw

