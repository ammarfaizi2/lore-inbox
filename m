Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272141AbTHBIjd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 04:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272246AbTHBIjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 04:39:32 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:9734 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S272141AbTHBIja convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 04:39:30 -0400
Date: Sat, 2 Aug 2003 01:29:45 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Marcelo Penna Guerra <eu@marcelopenna.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Merge the changes from siimage 2.4.22-pre9 to 2.6.0-test2
In-Reply-To: <Pine.SOL.4.30.0307311710440.8394-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.10.10308020127410.19607-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a future proposal to deal with SATAPI devices.
It has to do with the features register having a bit set to define
direction of IO for the PHY.

Expect a proposal to be public in 2-6 months, my best guess.

Obviously I am talking about things that do not exist today again, sorry.

-a


On Thu, 31 Jul 2003, Bartlomiej Zolnierkiewicz wrote:

> 
> On Thu, 31 Jul 2003, Marcelo Penna Guerra wrote:
> 
> > Hi,
> 
> Hi,
> 
> > I don't know if anyone is working on this, but I merged the changes from
> > siimage 1.06 present in 2.4.x to 2.6.0-test2. I'm really not very familiar
> > with the IDE code, so it's probably a good idea if someone could take a look
> > at it. All I can tell is it's working with the SiI3112A present in my
> > motherboard and it's a lot more stable than before.
> 
> Thanks, I'll take a look.
> 
> What do you mean by "a lot more stable than before"?
> 
> > I also added the suggestion from Andre to make the driver not care about cable
> > detection and found a possible bug in the 2.4.x code.
> 
> Can you separate your changes from forward-port?
> 
> > In 2.4.22-pre9:
> >
> > if (!is_sata(hwif))
> >        hwif->atapi_dma = 1;
> >
> > and DMA is not enabled by default.
> 
> This means that if this is a SATA controller DMA shouldn't be
> enabled on ATAPI devices.  There are probably some reasons to do this.
> 
> > I think it should be:
> >
> > if (is_sata(hwif))
> >        hwif->atapi_dma = 1;
> >
> > With this DMA is enabled by default on my board and works great.
> 
> Are you aware of side effect?
> [ Disabling DMA on ATAPI devices on SiI680. ]
> 
> Please consult this change with Alan :-).
> 
> > Marcelo Penna Guerra
> 
> Regards,
> --
> Bartlomiej
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

