Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVKRQiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVKRQiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVKRQiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:38:54 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:37265 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964789AbVKRQiy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:38:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OspC2IOlG36xtFm+ka5GL4NN3KBajMis2KCoOHGATm3ac5gHAmIacI3UsJRmhA+8TvKfE1pH0ZdYkzq53R0nHu7z7K5ow5QjDmT59feuprwfjitj0XE4j0wHzfgf0RFRqrBsDmcWsFfsCIbpyp98UK+e8sCChIsjzBaNlHO1EUc=
Message-ID: <58cb370e0511180838x621d35c9w57df4551016cd52f@mail.gmail.com>
Date: Fri, 18 Nov 2005 17:38:50 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 09/10] blk: add FUA support to IDE
Cc: Tejun Heo <htejun@gmail.com>, axboe@suse.de, jgarzik@pobox.com,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
In-Reply-To: <1132333365.25914.53.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117153509.B89B4777@htj.dyndns.org>
	 <20051117153509.5A77ED53@htj.dyndns.org>
	 <58cb370e0511171239i16e0aaffr237ef7af68ece946@mail.gmail.com>
	 <437DF271.6050702@gmail.com>
	 <58cb370e0511180817p48602e3ap6d3ef49b842e8a00@mail.gmail.com>
	 <1132333365.25914.53.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2005-11-18 at 17:17 +0100, Bartlomiej Zolnierkiewicz wrote:
> > Probably it should work fine given that drive->mult_count is on.
> >
> > The only controller using drive->vdma in the current tree is cs5520
> > so you should confirm this with Mark Lord & Alan Cox.
>
> The CS5520 VDMA performs PIO commands with controller driven DMA to PIO
> of the data blocks. Thus it can do any PIO command with one data in or
> out phase as if it were DMA.

Therefore doing ATA_CMD_WRITE_MULTI_FUA_EXT w/ VDMA
should be just fine as is WIN_WRITE_EXT w/ VDMA currently?

> > Long-term we should see if it is possible to remove dynamic IDE
> > drive configuration and always just use the best possible settings.
>
> Hotplug rather prevents that. For the lifetime of a drive connection
> most of the settings ought to be settable once. Speeds are the obvious
> exception.

I'm talking only about lifetime of a drive connection here
so I think that we fully agree on this one.

Thanks,
Bartlomiej
