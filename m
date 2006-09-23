Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWIXASJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWIXASJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 20:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWIXASJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 20:18:09 -0400
Received: from 1wt.eu ([62.212.114.60]:13587 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751288AbWIXASH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 20:18:07 -0400
Date: Sun, 24 Sep 2006 01:53:15 +0200
From: Willy Tarreau <w@1wt.eu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060923235315.GB24214@1wt.eu>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com> <20060923045610.GM541@1wt.eu> <20060923232150.GK5566@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923232150.GK5566@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 01:21:50AM +0200, Adrian Bunk wrote:
> On Sat, Sep 23, 2006 at 06:56:10AM +0200, Willy Tarreau wrote:
> > Hi Greg, Hi Adrian,
> > 
> > On Fri, Sep 22, 2006 at 04:09:28PM -0700, Greg KH wrote:
> > 
> > > If you want to accept new drivers and backports like this, I think you
> > > will find it very hard to determine what to say yes or no to in the
> > > future.  It's the main problem that everyone who has tried to maintain a
> > > stable tree has run into, that is why we set up the -stable rules to be
> > > what they are for that very reason.
> > 
> > When I started the 2.4-hotfix tree nearly two years ago, I wanted to
> > avoid merging drivers changes as much as possible. And particularly,
> > I avoided to add support for new hardware. The reason is very simple.
> > I want to be able to guarantee that if 2.4.X works, then any 2.4.X.Y
> > does too so that they can blindly upgrade.
> 
> Bugfixes causing regressions are much more likely than new hardware 
> support adding regressions.
> 
> > And if, for any reason,
> > people suspect that 2.4.X.Y might have brought a bug, then reverting
> > to 2.4.X.Z(Z<Y) should at most bring back older bugs but not remove
> > previous support for any hardware.
> 
> Either you want to use the newly supported hardware or you don't want to 
> use it.
> 
> In any case, I don't see your point.

The problem is when some hardware suddenly become detected and assigned
in the middle of a stable release. Do not forget that people need stable
releases to be able to blindly update and get their security vulnerabilities
fixed. Sometimes, unlocking 2 SATA ports on the mobo by adding a PCI ID or
adding the PCI ID of some new ethernet cards that were not supported may
lead to such fun things (eth0 becoming eth2, sda becoming sdc, etc...).
This causes real trouble to admins, particularly those doing remote
updates. At least, I think that if you manage to inform people clearly
enough, and to separate security fixes and such fixes in distinct releases,
it might work in most situations. But this is a dangerous game anyway.

> > The problem with new hardware
> > support is that it can break sensible setups :
> > 
> >   - adding a new network card support will cause existing cards to be
> >     renumberred (it happened to me on several production systems when
> >     switching from 2.2 to 2.4)
> > 
> >   - adding support for a new IDE controller can cause hda to become
> >     hdc, or worse, hda to become sda (problems encountered when adding
> >     libata support)
> 
> I don't consider merging any patches that could cause the sda problem.
> 
> People not using the onboard IDE controller but a different controller, 
> but OTOH having the driver for their onboard controller enabled in their 
> kernel really sounds like a strange case.

No, this one is common, it's the reverse which is uncommon. Think about it.
You buy a mobo, you discover that the onboard SATA is not supported, you add
a new controller but do not disable the old one in case you have time to
perform more tests.

Anyway, the case above was even not that. It was simply that if the shiny
new sata_piix driver detected the sata controller, it would then steal the
resources first, preventing ata_piix from registering.

Cheers,
Willy

