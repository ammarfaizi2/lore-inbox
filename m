Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbSL1Wlh>; Sat, 28 Dec 2002 17:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbSL1Wlh>; Sat, 28 Dec 2002 17:41:37 -0500
Received: from [209.195.52.121] ([209.195.52.121]:21634 "HELO
	warden2b.diginsite.com") by vger.kernel.org with SMTP
	id <S266330AbSL1Wle>; Sat, 28 Dec 2002 17:41:34 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Tomas Szepe <szepe@pinerecords.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Samuel Flory <sflory@rackable.com>, Janet Morgan <janetmor@us.ibm.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 28 Dec 2002 14:37:38 -0800 (PST)
Subject: Re: [PATCH] aic7xxx bouncing over 4G
In-Reply-To: <705128112.1041102818@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.44.0212281433000.14400-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, I'll resend this report (previously sent to linux-kernel as it
didn't seem to be exclusingly a scsi bug)

I attempted to start running 2.5 at .50 and have not yet been able to get
it to work with my adaptec card (including .53).

with .53 I get a message
aic7xxx PCI Device 0:10:0 failed memory mapped test useing PIO
followed by the standard 'I found a card' message, but it never finishes
initializing the card and doesn't go any further through the boot.

with .50 .51 and .52 I don't get the memory map error, but I do get a
large number of error messages as it is trying to initilize things
(unfortunantly they scrolll off the screen quickly so I haven't been able
to copy them down)

David Lang

On Sat, 28 Dec 2002, Justin T. Gibbs wrote:

> Date: Sat, 28 Dec 2002 12:13:38 -0700
> From: Justin T. Gibbs <gibbs@scsiguy.com>
> To: Rik van Riel <riel@conectiva.com.br>, Tomas Szepe <szepe@pinerecords.com>
> Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
>      Samuel Flory <sflory@rackable.com>, Janet Morgan <janetmor@us.ibm.com>,
>      linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
>      Alan Cox <alan@lxorguk.ukuu.org.uk>
> Subject: Re: [PATCH] aic7xxx bouncing over 4G
>
> > On Sat, 28 Dec 2002, Tomas Szepe wrote:
> >
> >> Marcelo, you've been overlooking these updates for a bit too long now
> >> for your "let's throw them at -ac" to sound fair.  IMHO of course.  Also
> >> remember those are both production drivers tested thoroughly in FreeBSD,
> >
> > Are we talking about the old or the new aic7xxx driver ?
> >
> > If it's the new driver, it's breaking on WAY too many
> > machines and I have no idea why it got ever merged...
> >
> > I have yet to see a machine where the new aic7xxx driver
> > works. I'm sure they exist, but it doesn't work on any
> > of the machines I have access to.
>
> Thanks for all of your detailed bug reports.  Wait!  I haven't
> gotten any from you.  That certainly makes it easy for me to
> ignore these problems. 8-)
>
> The main reason why the new driver "breaks" where the old one
> doesn't is that the new driver does not perform an extra register
> read to work-around chipsets that screw up memory mapped I/O.  There
> are four solutions to this problem:
>
> 1) Insist that people buy sane hardware.
>
> 2) Perform the extra read.
>
> 3) Use programmed I/O by default and provide an option for enabling
>    mememory mapped I/O.  Adaptec's Windows drivers have worked this way
>    forever just because so many chipsets are broken.
>
> 4) Devise tests in the driver for catching the broken behavior and
>    disabling memory mapped I/O on the fly.  The latest Linux and FreeBSD
>    drivers do this and the number of systems that "suddenly work" is
>    pretty amazing.
>
> We don't live in a world where most people can tell if they are buying
> sane hardware or not, so option 1 is out for the general user.  Option two
> is too costly.  It is cheaper (cpu and bus cycle wise) to use PIO than to
> perform the extra read on every outgoing write.  This is why the "new"
> aic7xxx driver has never done this.  Option 3 makes sense if option 4 isn't
> practical, but recent experience has shown that the current tests in the
> aic7xxx and aic79xx drivers catch all of the known broken systems.
>
> Unfortunately, the versions of the aic7xxx driver that are in the main
> trees (both nearly a year out of date) don't have this test and, like the
> "old" driver, they default to memory mapped I/O.  One of the reasons I've
> been pushing so hard for this new driver to go into the tree is that 90%
> of the complaints about the new driver would go away if it were updated
> to a sane revision.
>
> --
> Justin
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
