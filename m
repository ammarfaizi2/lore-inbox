Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWJ0RJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWJ0RJq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 13:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWJ0RJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 13:09:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:52701 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751145AbWJ0RJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 13:09:45 -0400
Date: Fri, 27 Oct 2006 10:07:48 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC: 2.6.19 patch] let PCI_MULTITHREAD_PROBE depend on BROKEN
Message-ID: <20061027170748.GA9020@kroah.com>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de> <20061027012058.GH5591@parisc-linux.org> <20061026182838.ac2c7e20.akpm@osdl.org> <20061026191131.003f141d@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026191131.003f141d@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 07:11:31PM -0700, Stephen Hemminger wrote:
> On Thu, 26 Oct 2006 18:28:38 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Thu, 26 Oct 2006 19:20:58 -0600
> > Matthew Wilcox <matthew@wil.cx> wrote:
> > 
> > > On Fri, Oct 27, 2006 at 03:02:52AM +0200, Adrian Bunk wrote:
> > > > PCI_MULTITHREAD_PROBE is an interesting feature, but in it's current 
> > > > state it seems to be more of a trap for users who accidentally
> > > > enable it.
> > > > 
> > > > This patch lets PCI_MULTITHREAD_PROBE depend on BROKEN for 2.6.19.
> > > > 
> > > > The intention is to get this patch reversed in -mm as soon as it's in 
> > > > Linus' tree, and reverse it for 2.6.20 or 2.6.21 after the fallout of 
> > > > in-kernel problems PCI_MULTITHREAD_PROBE causes got fixed.
> > > 
> > > People who enable features clearly marked as EXPERIMENTAL deserve what
> > > they get, IMO.
> > 
> > It's not the impact on "people" which is of concern - it's the impact on
> > kernel developers - specifically those who spend time looking at bug
> > reports :(
> 
> Either it is broken and should be removed, or is barely working and
> should be fixed. If Greg wants to take bug reports then it can stay.

I want to keep taking bug reports.

I've found only 1 real bug from all of this.  The pci MSI initialization
issue.  It's on my queue of things to fix.  Andrew has also sent me
another "interesting" patch about making sure devices are found by the
time we hit another init level which I'll see about adding too.

But that MSI bug was a real bug, which is good to have found.  It's also
found other real bugs in other subsystems that could easily be hit by
other users.

So no, this should not be marked BROKEN.

It's a very experimental feature, as the help text says.  If you can
think of any harsher language to put in that text, please let me know.

And yes, there also has been a proposed change to the driver core to fix
up how the multi-thread stuff works that looks very good, but it's down
in my queue that I'm trying to catch up on right now.

So consider this a NAK for this change.

thanks,

greg k-h
