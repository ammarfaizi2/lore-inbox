Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268195AbUHFRkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268195AbUHFRkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268218AbUHFRaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:30:09 -0400
Received: from h-66-166-159-6.sttnwaho.covad.net ([66.166.159.6]:46282 "EHLO
	pooka.dleonard.net") by vger.kernel.org with ESMTP id S268221AbUHFR04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:26:56 -0400
Date: Fri, 6 Aug 2004 10:26:46 -0700 (PDT)
From: dleonard@dleonard.net
To: Jens Axboe <axboe@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
In-Reply-To: <20040806143258.GB23263@suse.de>
Message-ID: <Pine.LNX.4.44.0408061020220.8255-100000@pooka.dleonard.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Jens Axboe wrote:

> On Fri, Aug 06 2004, Alan Cox wrote:
> > On Gwe, 2004-08-06 at 07:23, Jens Axboe wrote:
> > > Perhaps if you acknowledge that it wont be perfect, then it's becomes
> > > more acceptable imo. So you can issue some commands that do write to the
> > > drive even as a regular user, but none that permanently alter the state
> > > of the drive or its media (to the best of our knowledge). Other commands
> > > you let through.
> >
> > The code you included is roughly the kind of filtering I mean except
> > that unknown commands must not get through without CAP_SYS_RAWIO.
> > Anything that is doubtful doesn't get through. As to the location you do
> > it there are at least two ways to handle that. One is that you stick the
> > CAP_SYS_RAWIO of the requester in a flag in the request block the other
> > is that you do it at the top layer. Some BSD socket implementations take
> > the former approach and it works very well as the driver can make a
> > final decision but is told the rights attached to the command.
> >
> > So once its
> >
> > 	switch()
> > 	{
> > 		case READ6:
> > 		case READ10:
> > 				...
> > 			/* Always */
> > 			break;
> > 		case WRITE6:
> > 		case WRITE10:
> > 			...
> > 			/* if write */
> > 		default:
> > 			if(capable(CAP_SYS_RAWIO))
> > 			/* Only administrators get to do arbitary things */
> >
> > I agree with it.
>
> That's the case I don't agree with, and why I didn't like the idea
> originally. That suddenly requires a patching of the kernel because of
> new commands in new devices. Like when dvd readers became common, you
> can't just require people to update their kernel because a few new
> commands are needed to drive them from user space.

This is no different from having to build a new kernel whenever you happen to install a new revision of a videocard, nic, scsi controller, or random other device new enough that its pci_id isn't in pci_ids.h.  New features and new devices frequently require new kernels.

Allowing specific commands while disallowing unknown commands to standard users is a far better scenario than any other proposals I've heard so far.

--
Douglas Leonard
dleonard@dleonard.net

