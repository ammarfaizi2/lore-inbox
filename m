Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVIDSoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVIDSoM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 14:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbVIDSoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 14:44:12 -0400
Received: from smtp2.libero.it ([193.70.192.52]:53891 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S1750979AbVIDSoL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 14:44:11 -0400
From: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
To: "Francois Romieu" <romieu@fr.zoreil.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-atm-general@lists.sourceforge.net>
Subject: R: R: [Linux-ATM-General] [ATMSAR] Request for review - update #1
Date: Sun, 4 Sep 2005 20:44:01 +0200
Message-ID: <NBBBIHMOBLOHKCGIMJMDIEIIEKAA.g.tomassoni@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20050904153241.GA7779@electric-eye.fr.zoreil.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Messaggio originale-----
> Da: Francois Romieu [mailto:romieu@fr.zoreil.com]
> Inviato: domenica 4 settembre 2005 17.33
> A: Giampaolo Tomassoni
> Cc: linux-kernel@vger.kernel.org;
> linux-atm-general@lists.sourceforge.net
> Oggetto: Re: R: [Linux-ATM-General] [ATMSAR] Request for review - update #1
> 
> ...omissis...
> 
> I'd be happily surprized to see more documented ADSL PCI/USB device in the
> near future. :o(

OT Question. What about an open adsl device? The linux community had been bumped out by the adsl market for at least a couple of years, and nobody knows (or tells) why...

That could be a definitive answer. Is there anybody interested in this?


> 
> ...omissis...
> 
> > Finally, the fact that ATMSAR is device-unspecific makes it easier to
> > maintain, I guess.
> 
> Ok. Your suggestion may have more impact if there is a patch to convert
> the sole existing in-kernel driver to use this module.

Mmmh. I can try to do this, but I would prefer to hear Sands about this.


>
> ...omissis
>
> An uniform codingstyle is useful when people need to review code. 
> Something is wrong when a reviewer must uncipher a piece of code.
> You will find areas in the kernel whose trends differ but a codingstyle
> from Mars is usually a hint. So it is not _only_ a matter of taste.

Ok, ok. I'll (try to) behave...


> 
> ...omissis...
> 
> You may have more feedback/review then. I only gave a cursory look at the
> code.

Right, that's what I'm looking for.


> 
> ...omissis...
> 
> Rather the "typedef struct atmsar_dev atmsar_dev_t;" (yes, I know the "It
> saves typing" argument). Maybe something could be done at the same time
> regarding the need for the forward declarations.

Well, fine. I'll "struct _whatever *". But atmsar_dev_t no, that nonono: it mimics the atm_dev_t typedef... It's all around the idea a developer needs to use atmsar_dev_t instead of atm_dev_t...


>
> ...omissis...
>
> s/what/why/
> 
> And no, documenting a call to skb_reserve is silly.

...


> 
> ...omissis...
> 
> The value returned by sprintf and friends contains the needed offset, i.e.
> buf += sprintf(buf, ...);.

I used an strcpy() to put the constant string in the buffer. However, I'm changing it this way:

        if(skip-- == 0) {
                count = strlen(strcpy(page, "dnrate:\t"));
                if(dev->rx_speed != ATMSAR_SPEED_UNSPEC)
                        count += sprintf(
                                &page[count],
                                "%ld kbps\n",
                                dev->rx_speed
                        );
                else
                        count += strlen(strcpy(&page[count], "unknown\n"));
                return(count);
        }


> [...]
> > > - "return" is not a function.
> > 
> > Not even for() or while(). But doesn't they look cute this way?
> 
> No.
> 
> for (), while (), return rc;

...


> [...]
> > > - consider 'goto' to handle the errors instead of deep nesting
> > 
> > I prefer not using goto when not required to. Nesting is far 
> more readable
> > to my opinion.
> 
> OTOH, it makes ugly code to have it fit in a 80 columns console.
> 
> [...]
> > Anyway, which are the functions you are objecting?
> 
> atmSend. Probably others.
> 
> If you can make the code look like existing in-kernel code (not fs/cifs
> please) say network or ata driver code and you do not need goto, it's fine
> too.

Mmmmh. I'll check it out.


> > > - +const atmsar_aalops_t opsAALR = {
> > >   +       ATM_AAL0,
> > >   +       "raw",
> > >   -> use .foo = baz instead.
> > 
> > atmasr_aalops_t is not an exported structure (you'll find just an opaque
> > definition in include/linux/atmsar.h), so it is not meant to be 
> statically
> > declared by device drivers. But I guess that the problem is readability,
> > right?
> 
> struct foo zoy {
> 	.bar	= barbar,
> 	.baz	= bazbaz,
> 	.quuz	= ...
> };

...


> [...]
> > May I ask if this is just your own contribution or if you are 
> in charge of
> > something in the linux and/or linux-atm projects?
> 
> /me scratches head
> 
> http://ww.google.com/search?hl=en&q=romieu+linux+cabal

That was to give the right wedge to your hints. If you were just around this list, your hints had a different value than if you were a committer. Am I wrong?

Thanks,

-----------------------------------
Giampaolo Tomassoni - IT Consultant
Piazza VIII Aprile 1948, 4
I-53044 Chiusi (SI) - Italy
Ph: +39-0578-21100

