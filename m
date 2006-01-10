Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWAJC2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWAJC2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 21:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWAJC2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 21:28:25 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:36834 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932269AbWAJC2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 21:28:25 -0500
Date: Mon, 9 Jan 2006 18:28:06 -0800
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.15 - retry
Message-ID: <20060110022806.GA32206@suse.de>
References: <20060109203711.GA25023@kroah.com> <Pine.LNX.4.64.0601091557480.5588@g5.osdl.org> <20060109164410.3304a0f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109164410.3304a0f6.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 04:44:10PM -0800, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > On Mon, 9 Jan 2006, Greg KH wrote:
> > >
> > > Here are some PCI patches against your latest git tree.  They have all
> > > been in the -mm tree for a while with no problems.  I've pulled out all
> > > of the offending patches that people objected to, or ones that crashed
> > > older machines from the last series I sent you.
> > 
> > Before I pull this, I'd like to get some confirmation that some of the 
> > other problems that seem to be PCI-related in the -mm tree are also 
> > understood, or at least known to be part of the stuff that you're _not_ 
> > sending me..
> 
> It's really hard to keep track of all this, so it's likely that some things
> will still sneak through.
> 
> - Reuben Farrelly's oops in make_class_name().  Could be libata, or scsi
>   or driver core.

Haven't heard of this one before, but it shouldn't be a pci issue.

> - A few problems with ehci.  For example Grant Coady went oops loading
>   the module.  Probably USB, maybe solved now, but there are
>   interactions...

People are still working on this one, but it shouldn't be a pci issue.

> - gregkh-pci-x86-pci-domain-support-the-meat.patch is a problem, but
>   wasn't in this tree.
> 
> > [ There's at least a pci_call_probe() NULL ptr dereference report by 
> >   Martin Bligh, I think Andrew has a few others he's tracked.. ]

Yes, that's the x86-* patches in my tree, from Jeff, and I'm not going
to be sending them to you until all of the breakage is fixed up (he
created them for machines that aren't public yet, so I don't think
there's a rush for them to get in anytime soon...)

> Yes, Martin is reporting failures on a few machines.  Hopefully he's
> working out whether gregkh-pci-x86-pci-domain-support-the-meat.patch was
> the culprit here.  If so, I'd say we're good to go.  If that's _not_ the
> source then we just don't know where the failure is coming from.

It sure looks like it's the reason why, as we are suddenly failing with
a NULL pointer problem after we change an integer field into a pointer :)

Linus, it should all be safe for you to pull this tree, as I took
everything that people objected to out of my last attempt :)

thanks,

greg k-h
