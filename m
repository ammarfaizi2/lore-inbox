Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbWBTSBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbWBTSBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWBTSBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:01:46 -0500
Received: from smtp.enter.net ([216.193.128.24]:18451 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932241AbWBTSBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:01:45 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 20 Feb 2006 13:02:04 -0500
User-Agent: KMail/1.8.1
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <200602171502.20268.dhazelton@enter.net> <43F9D771.nail4AL36GWSG@burner>
In-Reply-To: <43F9D771.nail4AL36GWSG@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201302.05347.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 09:51, Joerg Schilling wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
> > > cdrtools and libscg are a serious project and are maintained in a way
> > > that tries to _plan_ all interfaces in a way that allows to upgrade
> > > interfaces for at least 10 years without a need for incompatible
> > > changes.
> >
> > Noted. However even if I do create said patch, I'm more than 90% certain
> > you won't even take a look at it.
>
> If your code will have similar relevence than the code from Matthias, you
> are obviously true.
>
> > Why do you use the autoconf system in such a nonstandard way? It's
> > scripts are portable to all POSIX compliant systems. From what I have
> > seen they would remove most of the problems you have and would allow for
> > the code to be ported to other operating systems even faster.
>
> I do use autoconf in the only senseful way.
>
> And if you did have a look at the schily makefile system you would know
> that it provides protability to more plaforms than you get from using an
> GNU autoconf the way the GNU people tell you.
>
> If you like best portability, you need to use my version of autoconf inside
> the schily makefile system and you need to use my smake instead of GNU
> make.
>
> So my conclusion is that you did not understand portability. All my
> software is using layered portability and if you did take a closer look at
> the few FSF people who know what they are talking about, you would find
> that e.g. Paul Eggert recently started to silently imitate my portability
> methods.....

I have taken a second look and it does appear that you are correct. But I 
still have some doubts (none that I can quantify) - would it not make sense 
to also use automake?

> > (Yes, I'm aware of the DOS/Windows case - but I did say all POSIX
> > compliant systems, didn't I? Most packages provide prebuilt stuff for
> > compiling for DOS/Windows anyway.)
>
> ???? There are many problems with portability.
>
> One problem is that GNU make is not working in a useful way on many
> patforms that are listed to be working. GNU make is unmaintained since many
> years and a serious bug I reported in 1999 still has not been fixed.

Apparently true - the version of gmake I use is four years old. Too bad almost 
everything on my system relies on the quirks and features of gmake...

<snip>
> > > I like to have things orthogonal, but it seems that most people in LKML
> > > do not understand implicit constraints from requiring orthogobality.
> >
> > This is why I'm asking why you don't include such workarounds. As far as
> > I can see all you do in your code is complain about things with somewhat
> > pointless warnings and do minimal work to get around the flaws you
> > complain about.
>
> Well what I did first was to try to have a discussion with the Linux people
> in order to avoid the problems introduced by Linux.
>
> When it turned out that the related people are not interested, all I could
> do was to print warnings.

Dodged the question there, didn't you? My question here goes unanswered. 
Rather than putting workarounds in your code for the bugs you complain about 
you've just put warnings in the code. Seems that that breaks orthagonality in 
favor of complaining.

> > > Sorry, the way to access SCSI generic via /dev/hd* is deprecated. If
> > > ide-scsi ir removed, then a clean and orthogonal way of accessing SCSI
> > > in a generic way is removed from Linux. If Linux does nto care about
> > > orthogonality of interfaces, this is a problem of the people who are
> > > responbile for the related interfaces.
> >
> > Says you. Since the SCSI system via /dev/hd* was just added in, IIRC, the
> > 2.5 series kernel - at the same time ide-scsi was deprecated access via
> > SG_IO on /dev/hd* is the new method and not deprecated.
>
> Any system that is worse than another one is deprecated.

It seems we have different definitions of deprecated. The definition you are 
using is incompatable with the definition of the word as used in software 
development. In software development the word means "Old and in the process 
of being removed from use".

<snip>

> > I do agree that it would be _easier_ if Linux had tied the ATA/ATAPI
> > transport layer into the SCSI bus code for generic SCSI access, but in
> > Linux there is a clear distinction that exists because the IDE/ATA/ATAPI
> > drivers can exist on the system entirely without the SCSI system even
> > being built.
>
> The SCSI glue layer on Solaris is less than 50 kB. I did mention more than
> once that a uniquely layered system could save a lot of code by avoiding to
> implement things more than once.

Does that glue code comprise the proposed SATL system? Recently I've come 
across those whitepapers and opened a discussion about it on LKML.

> > The reason for this, at least to me, is to allow people building Linux
> > kernels for embedded devices to turn off everything that isn't needed.
>
> Well, on such a system, a /dev/hd driver is not needed for the CD-ROM.
> A SCSI disk driver would be sufficient.

and? The ATA/IDE drivers are more compact that requiring the _entire_ SCSI 
transport code and the specific SCSI driver for a device.

> > > My patch did enable sg.c to return more error/status information back
> > > to the user (e.g. the SCSI status byte) _and_ it defined a way to
> > > return DMA residual counts to the user. If Linux still does not even
> > > have the DMA residual count internally available, this is a proof that
> > > nobody with sufficient SCSI know how is willing to work on the Linux
> > > SCSI layer.
> >
> > I can see how the residual DMA count information might be impossible to
> > get at - the Linux memory allocator has been changed quite a bit over the
> > course of the past nine years.
>
> Most other OS provide this information.
>
> Is Linux really that underdeveloped for not being able to provide DMA
> residual counts?

No idea. All I said was that with the changes to how the memory allocator 
works I can see where it might be impossible to get such information. I don't 
think it is, though. What I think is that the developers of the allocator and 
the DMA systems just forgot to include such a capability.

DRH
