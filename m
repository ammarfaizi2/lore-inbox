Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132605AbRDHUqa>; Sun, 8 Apr 2001 16:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbRDHUqU>; Sun, 8 Apr 2001 16:46:20 -0400
Received: from albireo.ucw.cz ([62.168.0.14]:263 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S132605AbRDHUqD>;
	Sun, 8 Apr 2001 16:46:03 -0400
Date: Sun, 8 Apr 2001 22:45:40 +0200
From: Martin Mares <mj@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Gunther Mayer <Gunther.Mayer@t-online.de>, linux-kernel@vger.kernel.org,
        reinelt@eunet.at, twaugh@redhat.com
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
Message-ID: <20010408224540.C2623@albireo.ucw.cz>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de> <3ACF6223.41F138CF@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACF6223.41F138CF@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Apr 07, 2001 at 02:53:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff!

> Is Martin still alive?  He hasn't been active in PCI development well
> over six months, maybe a year now.  Ivan (alpha hacker) appeared on the
> scene to fix serious PCI bridge bugs, DaveM has added some PCI DMA
> stuff, and I've added a couple driver-related things.  I haven't seen
> code from Martin in a long long time, and only a comment or two in
> recent memory.

I'm buried alive in mail, graph theory and several other projects,
so I'm now happy I'm able to at least keep track of kernel development
and answer some bug reports, but I hope it will get better soon.
If it won't, I'll probably have to pass the maintainer's sceptre
to someone less busy, but I'd rather like to avoid it as I still like
the PCI world very much though it's got somewhat messy these days.
 
> > --- linux-2.4.3-orig/include/linux/pci.h        Wed Apr  4 19:46:49 2001
> > +++ linux/include/linux/pci.h   Sat Apr  7 20:01:51 2001
> > @@ -454,6 +454,9 @@
> >         void (*remove)(struct pci_dev *dev);    /* Device removed (NULL if not a hot-plug capable driver) */
> >         void (*suspend)(struct pci_dev *dev);   /* Device suspended */
> >         void (*resume)(struct pci_dev *dev);    /* Device woken up */
> > +       int multifunction_quirks;               /* Quirks for PCI serial+parport cards,
> > +                                                   here multiple drivers are allowed to register
> > +                                                   for the same pci id match */
> >  };

This is incredibly ugly. IMHO the right solution is to add a driver for
each such multi-function device which will split the device to two virtual
devices as Linus has suggested, or maybe better to add a generic driver
doing such splitting for multiple similar multi-function cards.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
bug, n: A son of a glitch.
