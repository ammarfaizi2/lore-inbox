Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317697AbSHHRer>; Thu, 8 Aug 2002 13:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317696AbSHHReA>; Thu, 8 Aug 2002 13:34:00 -0400
Received: from [63.204.6.12] ([63.204.6.12]:62647 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S317697AbSHHRcz>;
	Thu, 8 Aug 2002 13:32:55 -0400
Date: Thu, 8 Aug 2002 13:36:35 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation
In-Reply-To: <20020808170611.GA21821@kroah.com>
Message-ID: <Pine.LNX.4.33.0208081326480.26999-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Greg KH wrote:

> On Tue, Aug 06, 2002 at 05:16:30PM -0400, Scott Murray wrote:
> > I've been using this for several weeks now, and it allows me to hot
> > insert new devices quite well.  However, my goal for my CompactPCI work
> > is to get it into the mainline kernel so people can add drivers for
> > other boards and chassis on top of it.  If this resource reservation
> > scheme is too distasteful, or there is indeed a "cleaner" way, I'd
> > really like comments or suggestions before I push on much further.
>
> Hm, now that it looks like this is going to be necessary for cPCI
> hotplug drivers, could you make up a 2.5 version of it?

I'm not working against 2.5 at the moment, but I'll try and cook up a
patch before I go on vacation this coming Monday.

> The code should only be compiled in if CONFIG_HOTPLUG_PCI_CPCI is
> enabled, and hopefully with the splitup of the PCI code in the 2.5 tree,
> you should be able to contain it to one file, much like this patch has.

Are you interested in this reservation code as a seperate patch for 2.4,
or should I just send you all of my cPCI stuff to look at in one go?  I
was going to cut it up into 3-4 patches before sending it to
pcihpd-discuss sometime later today, but I can do whatever you want.

> One small comment:
>
> > @@ -2031,6 +2031,10 @@
> >  	struct pci_dev *dev;
> >
> >  	pcibios_init();
> > +
> > +#ifdef CONFIG_HOTPLUG_PCI
> > +	pci_hp_reserve_resources();
> > +#endif
>
> Move this #ifdef to a header file file, so it doesn't show up in the .c
> file.

Done.  I'd considered doing that right off, but it didn't seem to match
the style of the rest of the PCI code, for example the proc and pm stuff.
If you want, I can work on a patch to clean those up as well.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

