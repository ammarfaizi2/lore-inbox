Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUHFWsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUHFWsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 18:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268318AbUHFWsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 18:48:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29666 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266196AbUHFWr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 18:47:57 -0400
Date: Sat, 7 Aug 2004 00:47:46 +0200
From: Jens Axboe <axboe@suse.de>
To: dleonard@dleonard.net
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Message-ID: <20040806224743.GA19131@suse.de>
References: <20040806143258.GB23263@suse.de> <Pine.LNX.4.44.0408061020220.8255-100000@pooka.dleonard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408061020220.8255-100000@pooka.dleonard.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2004, dleonard@dleonard.net wrote:
> On Fri, 6 Aug 2004, Jens Axboe wrote:
> 
> > On Fri, Aug 06 2004, Alan Cox wrote:
> > > On Gwe, 2004-08-06 at 07:23, Jens Axboe wrote:
> > > > Perhaps if you acknowledge that it wont be perfect, then it's becomes
> > > > more acceptable imo. So you can issue some commands that do write to the
> > > > drive even as a regular user, but none that permanently alter the state
> > > > of the drive or its media (to the best of our knowledge). Other commands
> > > > you let through.
> > >
> > > The code you included is roughly the kind of filtering I mean except
> > > that unknown commands must not get through without CAP_SYS_RAWIO.
> > > Anything that is doubtful doesn't get through. As to the location you do
> > > it there are at least two ways to handle that. One is that you stick the
> > > CAP_SYS_RAWIO of the requester in a flag in the request block the other
> > > is that you do it at the top layer. Some BSD socket implementations take
> > > the former approach and it works very well as the driver can make a
> > > final decision but is told the rights attached to the command.
> > >
> > > So once its
> > >
> > > 	switch()
> > > 	{
> > > 		case READ6:
> > > 		case READ10:
> > > 				...
> > > 			/* Always */
> > > 			break;
> > > 		case WRITE6:
> > > 		case WRITE10:
> > > 			...
> > > 			/* if write */
> > > 		default:
> > > 			if(capable(CAP_SYS_RAWIO))
> > > 			/* Only administrators get to do arbitary things */
> > >
> > > I agree with it.
> >
> > That's the case I don't agree with, and why I didn't like the idea
> > originally. That suddenly requires a patching of the kernel because of
> > new commands in new devices. Like when dvd readers became common, you
> > can't just require people to update their kernel because a few new
> > commands are needed to drive them from user space.
> 
> This is no different from having to build a new kernel whenever you
> happen to install a new revision of a videocard, nic, scsi controller,
> or random other device new enough that its pci_id isn't in pci_ids.h.
> New features and new devices frequently require new kernels.

It's completely different, that you say so shows you don't understand
the issue at all. New devices work just fine even if the kernel doesn't
understand the pci id, as long as you can drive it from user space. If
you want a direct comparison, it would be comparable to disallow anyone
to use a pci id you did not know about at kernel compile time. So if you
get a new video card later on, it would not work properly until you got
a new kernel with that id included.

But thanks for high lighting why filtering is bad for new devices.

-- 
Jens Axboe

