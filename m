Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318538AbSHVIsW>; Thu, 22 Aug 2002 04:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318539AbSHVIsW>; Thu, 22 Aug 2002 04:48:22 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:45063
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318538AbSHVIsV>; Thu, 22 Aug 2002 04:48:21 -0400
Date: Thu, 22 Aug 2002 01:51:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
cc: Gonzalo Servat <gonzalo@unixpac.com.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ServerWorks OSB4 in impossible state
In-Reply-To: <1030005316.9869.52.camel@biker.pdb.fsc.net>
Message-ID: <Pine.LNX.4.10.10208220143440.11626-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem is we need a special DMA engine for this broken puppy.

I am trying to remember the rule for forming the dma-table, and it is not
nice.  The 4 byte issues is a direct result of building the SG which is
not compatable to the hardware.

508 + 4 is okay but 510 + 2 is not.

Now I have to remember why :-/

IIRC, we have to have 4 byte boundaries on the list.

This is where I need some extra help and doing something like the trm290
but for all of OSB4 because parsing out the broken engine bases on asic
revisions is darn near impossible.

Big Problem -- Big Hammer.

Tough if it tanks some of the performance, but it is better than the
deadlocks we are getting now.

Yeah I expect to take heat for this one from ServerWorks and it may cost
me later, but nobody else has got the guts to press the issue for the
correct solution.

Then again if we solve this correctly I have "ends justify means"
argument.

Cheers,

On 22 Aug 2002, Martin Wilck wrote:

> Am Don, 2002-08-22 um 09.52 schrieb Gonzalo Servat:
> 
> > Do you have any suggestions on how I can work around this problem? It's
> > been driving me nuts all day! (I bet it's driven people nuts for
> > weeks...). Do you think your patch (as posted on
> > http://linux-kernel.skylab.org/20020609/msg00935.html) may help my
> > situation? If so, what kernel does it apply to? I looked up
> > serverworks.c in a 2.4.19-rc3 tree to see if the patch would apply
> > cleanly but it won't because line 547 is different to yours.
> 
> It should be fairly easy to adapt the patch, all you need is modify 
> the line
> 			if(inb(dma_base+0x02)&1)
> 
> in svwks_dmaproc() to the more complex condition test in the patch.
> 
> Alan, I understood you to wanted apply this patch - what happened to it,
> do you want me to resubmit it?
> 
> Martin
> 
> -- 
> Martin Wilck                Phone: +49 5251 8 15113
> Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
> Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
> D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

