Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVJCQQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVJCQQq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVJCQQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:16:46 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:30592 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932344AbVJCQQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:16:45 -0400
Subject: Re: [PATCH 07/07] i386: numa emulation on pc
From: Dave Hansen <haveblue@us.ibm.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Magnus Damm <magnus@valinux.co.jp>,
       Isaku Yamahata <yamahata@valinux.co.jp>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <aec7e5c30510030259j2698f982ue7169768730f3d53@mail.gmail.com>
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
	 <20050930073308.10631.24247.sendpatchset@cherry.local>
	 <1128106512.8123.26.camel@localhost>
	 <aec7e5c30510030259j2698f982ue7169768730f3d53@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 09:16:32 -0700
Message-Id: <1128356192.10290.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-03 at 18:59 +0900, Magnus Damm wrote:
> > > +#ifdef CONFIG_NUMA_EMU
> > > +     bootmap_size = init_bootmem(max(min_low_pfn, node_start_pfn[0]),
> > > +                                 min(max_low_pfn, node_end_pfn[0]));
> > > +#else
> > >       bootmap_size = init_bootmem(min_low_pfn, max_low_pfn);
> > > +#endif
> >
> > This shouldn't be necessary.  Again, take a look at my discontig
> > separation patches and see if what I did works for you here.
> 
> Do you mean "discontig-consolidate0.patch"? Maybe I'm misunderstanding.

This one, I believe:

http://sr71.net/patches/2.6.14/2.6.14-rc2-git8-mhp1/broken-out/B2.1-i386-discontig-consolidation.patch

> > > +#ifdef CONFIG_NUMA_EMU
> > ...
> > > +#endif
> >
> > Ewwwwww :)  No real need to put new function in a big #ifdef like that.
> > Can you just create a new file for NUMA emulation?
> 
> Hehe, what is this, a beauty contest? =) I agree, but I guess the
> reason for this code to be here is that a similar arrangement is done
> by x86_64...

If that's really the case, can they _actually_ share code?  Maybe we can
do this NUMA emulation thing in non-arch code.  Just guessing...

> I will create a new file. Is arch/i386/mm/numa_emu.c good?

> But first, you have written lots and lots of patches, and I am
> confused. Could you please tell me on which patches I should base my
> code to make things as easy as possible?

This is the staging ground for my memory hotplug work.  But, it contains
all of my work on other stuff, too.  If you build on top of this, it
would be great:

http://sr71.net/patches/2.6.14/2.6.14-rc2-git8-mhp1/

-- Dave

