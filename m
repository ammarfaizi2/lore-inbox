Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVIDPe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVIDPe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 11:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVIDPe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 11:34:57 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:3724 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750932AbVIDPe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 11:34:56 -0400
Date: Sun, 4 Sep 2005 17:32:41 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Giampaolo Tomassoni <g.tomassoni@libero.it>
Cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Re: R: [Linux-ATM-General] [ATMSAR] Request for review - update #1
Message-ID: <20050904153241.GA7779@electric-eye.fr.zoreil.com>
References: <20050904120047.GA6556@electric-eye.fr.zoreil.com> <NBBBIHMOBLOHKCGIMJMDCEICEKAA.g.tomassoni@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NBBBIHMOBLOHKCGIMJMDCEICEKAA.g.tomassoni@libero.it>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giampaolo Tomassoni <g.tomassoni@libero.it> :
[...]
> Well, the idea is that more pci devices may appear, as adsl-enabled
> embedded systems will begin to appear in the market.
> 
> Also, I believe that adsl will carry much more services then just AAL5 for
> internet connection in the future.

I'd be happily surprized to see more documented ADSL PCI/USB device in the
near future. :o(

> Even if the ATMSAR actually lacks of AAL1 and AAL2/3 capabilities, adding
> them in a single, specialized module is much easier than swimming in a
> usb+atm middle layer.
> 
> Finally, the fact that ATMSAR is device-unspecific makes it easier to
> maintain, I guess.

Ok. Your suggestion may have more impact if there is a patch to convert
the sole existing in-kernel driver to use this module.

[...]
> > The codingstyle is broken. Please read again Documentation/CodingStyle,
> 
> That's a matter of taste: even Linus burned the GNU coding style book...

An uniform codingstyle is useful when people need to review code. Something
is wrong when a reviewer must uncipher a piece of code. You will find areas
in the kernel whose trends differ but a codingstyle from Mars is usually a
hint. So it is not _only_ a matter of taste.

> However, if it is needed by the linux community, I shurely will fix it
> whenever the ATMSAR idea will get passed: I'm just gathering feedbacks
> like the previous one you expressed.

You may have more feedback/review then. I only gave a cursory look at the
code.

[...]
> > remove the redundant typedef
> 
> Oh, you mean the "typedef enum _HECSTS ..." ?

Rather the "typedef struct atmsar_dev atmsar_dev_t;" (yes, I know the "It
saves typing" argument). Maybe something could be done at the same time
regarding the need for the forward declarations.

[...]
> > and the silly comments ("Reserve 
> > header space",
> > Encode packet into cells", ...).
> 
> I would prefer to explain better what the ATMSAR is doing there. So, I'll
> get your as a "clarify silly comments". Ok?

s/what/why/

And no, documenting a call to skb_reserve is silly.

[...]
> > - &page[strlen(page)] in atmProcRead sucks.
> 
> Why? It is preceded by an strcpy(page,...). A constant would be worse if
> someone changes the prefix string...

The value returned by sprintf and friends contains the needed offset, i.e.
buf += sprintf(buf, ...);.

[...]
> > - "return" is not a function.
> 
> Not even for() or while(). But doesn't they look cute this way?

No.

for (), while (), return rc;

[...]
> > - consider 'goto' to handle the errors instead of deep nesting
> 
> I prefer not using goto when not required to. Nesting is far more readable
> to my opinion.

OTOH, it makes ugly code to have it fit in a 80 columns console.

[...]
> Anyway, which are the functions you are objecting?

atmSend. Probably others.

If you can make the code look like existing in-kernel code (not fs/cifs
please) say network or ata driver code and you do not need goto, it's fine
too.

[...]
> > - +const atmsar_aalops_t opsAALR = {
> >   +       ATM_AAL0,
> >   +       "raw",
> >   -> use .foo = baz instead.
> 
> atmasr_aalops_t is not an exported structure (you'll find just an opaque
> definition in include/linux/atmsar.h), so it is not meant to be statically
> declared by device drivers. But I guess that the problem is readability,
> right?

struct foo zoy {
	.bar	= barbar,
	.baz	= bazbaz,
	.quuz	= ...
};

[...]
> May I ask if this is just your own contribution or if you are in charge of
> something in the linux and/or linux-atm projects?

/me scratches head

http://ww.google.com/search?hl=en&q=romieu+linux+cabal

--
Ueimor
