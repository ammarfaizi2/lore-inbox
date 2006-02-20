Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWBTBxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWBTBxI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 20:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWBTBxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 20:53:08 -0500
Received: from smtp.enter.net ([216.193.128.24]:38929 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932523AbWBTBxG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 20:53:06 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Sun, 19 Feb 2006 20:53:24 -0500
User-Agent: KMail/1.8.1
Cc: Bill Davidsen <davidsen@tmr.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, mj@ucw.cz,
       nix@esperi.org.uk, linux-kernel@vger.kernel.org, chris@gnome-de.org,
       axboe@suse.de
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <200602182010.02468.dhazelton@enter.net> <20060219092059.GA21626@merlin.emma.line.org>
In-Reply-To: <20060219092059.GA21626@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602192053.25767.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 February 2006 04:20, Matthias Andree wrote:
> On Sat, 18 Feb 2006, D. Hazelton wrote:
> > At this point I seem to have stumbled across a document that has what
> > Joerg might be looking for Linux to introduce. It's available at t10.org
> > and is a translation layer specification for OS's to use if they want to
> > access ATA devices like SCSI ones.
>
> Is that something other than CAM? If so, please mention the exact
> document name.


The documents title is: "Information Technology - SCSI / ATA translation (SAT)

The revision I'm looking at is R08 - the most current I could find. I'll have 
to dig, but it doesn't appear to just be a rewrite of CAM from the quick once 
over I gave it.

> > Seems to me this wouldn't be a good or bad thing to add to the kernel.
> > The
>
> Well, such an integration must avoid:
>
> - breaking existing conformant applications, where conformant here would
>   apply to existing interface documentation such as the SCSI General
>   Programming HOWTO from torque.net.
>
>   This means that int fd = open("/dev/foo", O_RDWR, 0);
>                   int e = ioctl(fd, SG_IO, &cmd_block);
>   needs to remain functional.
>
> - duplicating code which would cause immediate bit-rot...

Yes, true. After all Linus has said that there is to be no more breaking of 
userspace interfaces. In this case I think what the layer would do is allow 
the people that want to to use /dev/sg* to access all SCSI and ATA devices on 
a given system.

It's purpose, from the blurb on t10.org, is to provide a SCSI interface to ATA 
disks for people that want to access them that way.

> > problem is that introducing the layer and thereby unifying the SCSI and
> > ATA busses into one namespace is a big task.
>
> ...so it could really only be an interface layer on top of existing
> interfaces to avoid that. (Any other opinions?)
>

Right. Which is one reason why I did say that I thought it might be a good 
idea, but didn't think that anyone would bother. I also don't think it's 
really necessary. SG_IO happens to work great and the amount of work 
involved...

Anyway, to me it seems like it'd just be resurrecting a deprecated module and 
expanding it so it has a wider scope. Only real difference would be that it 
wouldn't take devices from their driver, just provide a second interface to 
it - which also means that all the ATA drivers would need to have hooks that 
it could call into. (Or am I over thinking it here?)

> And then that interface would only be sensible if it actually improves
> the situation, for instance, if applications gain source-level
> compatibility with NetBSD or FreeBSD.

Well, FreeBSD implements CAM, so if someone implemented CAM that'd provide 
source-level compatability. In this case what it would do is hard to say - 
the only thing I can think it _might_ do is quiet a couple of people down a 
bit.

> I think libata's integration of parallel ATA is already going a way that
> leads to unifiying all the layers. For disks, the sd driver is used with
> libata. I'd be surprised if it wouldn't work for CD/DVD drives, too, at
> least in the long run.

Ah, yes. I was under the impression that libata only handled PATA and SATA - 
is it going to be expanded to encompass the entire ATA bus?

> Part of the problem is Jörg's expecting a solution the day before
> yesterday.

Well, from some comments he made in private mails he seems to think he was 
promised (by Linus, no less) that the DMA problems in ide-scsi were going to 
be fixed. Instead the module was deprecated and SG_IO was introduced - this 
seems to be one of the things he's been angry about.

DRH
