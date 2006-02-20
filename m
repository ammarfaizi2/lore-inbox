Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWBTOxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWBTOxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWBTOxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:53:04 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:37067 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030252AbWBTOxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:53:01 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 20 Feb 2006 15:51:29 +0100
To: schilling@fokus.fraunhofer.de, dhazelton@enter.net
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F9D771.nail4AL36GWSG@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <200602161742.26419.dhazelton@enter.net>
 <43F5B686.nail2VCA2A2OF@burner>
 <200602171502.20268.dhazelton@enter.net>
In-Reply-To: <200602171502.20268.dhazelton@enter.net>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Hazelton" <dhazelton@enter.net> wrote:

> > cdrtools and libscg are a serious project and are maintained in a way that
> > tries to _plan_ all interfaces in a way that allows to upgrade interfaces
> > for at least 10 years without a need for incompatible changes.
>
> Noted. However even if I do create said patch, I'm more than 90% certain you 
> won't even take a look at it.

If your code will have similar relevence than the code from Matthias, you are 
obviously true.


> Why do you use the autoconf system in such a nonstandard way? It's scripts are 
> portable to all POSIX compliant systems. From what I have seen they would 
> remove most of the problems you have and would allow for the code to be 
> ported to other operating systems even faster.

I do use autoconf in the only senseful way.

And if you did have a look at the schily makefile system you would know that
it provides protability to more plaforms than you get from using an GNU
autoconf the way the GNU people tell you.

If you like best portability, you need to use my version of autoconf inside the
schily makefile system and you need to use my smake instead of GNU make.

So my conclusion is that you did not understand portability. All my software is 
using layered portability and if you did take a closer look at the few FSF people 
who know what they are talking about, you would find that e.g. Paul Eggert 
recently started to silently imitate my portability methods.....


> (Yes, I'm aware of the DOS/Windows case - but I did say all POSIX compliant 
> systems, didn't I? Most packages provide prebuilt stuff for compiling for 
> DOS/Windows anyway.)

???? There are many problems with portability.

One problem is that GNU make is not working in a useful way on many patforms
that are listed to be working. GNU make is unmaintained since many years and
a serious bug I reported in 1999 still has not been fixed.

So for portability, I was forced to make my smake more portable than any other
open source make program. The automake features (don't confuse this with the
ill designed and wrongly named "automake" program from the FSF) of smake
allow to compile my software on nearly any unknown platform.


> > I like to have things orthogonal, but it seems that most people in LKML
> > do not understand implicit constraints from requiring orthogobality.
>
> This is why I'm asking why you don't include such workarounds. As far as I can 
> see all you do in your code is complain about things with somewhat pointless 
> warnings and do minimal work to get around the flaws you complain about.

Well what I did first was to try to have a discussion with the Linux people in 
order to avoid the problems introduced by Linux.

When it turned out that the related people are not interested, all I could do
was to print warnings.


> > Sorry, the way to access SCSI generic via /dev/hd* is deprecated. If
> > ide-scsi ir removed, then a clean and orthogonal way of accessing SCSI in a
> > generic way is removed from Linux. If Linux does nto care about
> > orthogonality of interfaces, this is a problem of the people who are
> > responbile for the related interfaces.
>
> Says you. Since the SCSI system via /dev/hd* was just added in, IIRC, the 2.5 
> series kernel - at the same time ide-scsi was deprecated access via SG_IO 
> on /dev/hd* is the new method and not deprecated.

Any system that is worse than another one is deprecated.

If people on LKML believe it is OK not to abide promises and if they don't have 
the vision that /dev/hd* only serves some limited applications but not the need
of generic applications like libscg, this is a LKML problem.


> I do agree that it would be _easier_ if Linux had tied the ATA/ATAPI transport 
> layer into the SCSI bus code for generic SCSI access, but in Linux there is a 
> clear distinction that exists because the IDE/ATA/ATAPI drivers can exist on 
> the system entirely without the SCSI system even being built.

The SCSI glue layer on Solaris is less than 50 kB. I did mention more than once 
that a uniquely layered system could save a lot of code by avoiding to 
implement things more than once.

> The reason for this, at least to me, is to allow people building Linux kernels 
> for embedded devices to turn off everything that isn't needed.

Well, on such a system, a /dev/hd driver is not needed for the CD-ROM.
A SCSI disk driver would be sufficient.


> > My patch did enable sg.c to return more error/status information back to
> > the user (e.g. the SCSI status byte) _and_ it defined a way to return DMA
> > residual counts to the user. If Linux still does not even have the DMA
> > residual count internally available, this is a proof that nobody with
> > sufficient SCSI know how is willing to work on the Linux SCSI layer.
>
> I can see how the residual DMA count information might be impossible to get at 
> - the Linux memory allocator has been changed quite a bit over the course of 
> the past nine years.

Most other OS provide this information.

Is Linux really that underdeveloped for not being able to provide DMA residual 
counts?


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
