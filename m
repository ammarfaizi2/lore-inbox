Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWHKTNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWHKTNO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWHKTNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:13:14 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:57250 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932190AbWHKTNO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:13:14 -0400
Date: Fri, 11 Aug 2006 22:13:11 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for review] [69/145] x86_64: Disable DAC on VIA PCI bridges
Message-ID: <20060811191311.GI4745@rhun.haifa.ibm.com>
References: <20060810935.775038000@suse.de> <20060810193625.3605D13C0B@wotan.suse.de> <20060810205554.GE4745@rhun.haifa.ibm.com> <200608110851.53038.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608110851.53038.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 08:51:53AM +0200, Andi Kleen wrote:

> I've haven't decided yet. I put it out for review for now at least.
> 
> I got various reports of the VIA bridges having trouble with DAC over the
> years, but usually when I asked for confirmation the reporters disappeared.
> I finally did the patch now because with cheap 2GB DIMMs VIA systems
> with 4GB (which gives some memory over 4GB) are becomming more common.
> 
> But again the last reporters disappeared this time.
> 
> I will probably not sent it off before final confirmation again.

Ok. I'll give it and the rest of the patches a spin on my systems with
and without Calgary on Sunday.

> > >  int dma_supported(struct device *dev, u64 mask)
> > >  {
> > >  	if (dma_ops->dma_supported)
> > >  		return dma_ops->dma_supported(dev, mask);
> > 
> > I just checked, no ops has a dma_supported method... should we remove
> > it?
> 
> The if()? Possible.

the .dma_supported member of dma_ops. If no one is using it, I don't
see a point in keeping it there - we can always reintroduce it when an
IOMMU implementation that needs it comes along.

> > > +	    if (!strncmp(p, "nodac", 5))
> > > +		    allow_dac = -1;
> > 
> > Why <0? we usually set 1 for enabled and 0 for disabled.
> 
> For hardware workarounds it is usually best to have three values:
> 
> - Force disabled
> - Default based on black/white list 
>   The black/white list is not active when != 0
> - Force enabled
> 
> I tend to use -1/0/1 for this. 

I understand, makes sense. Thanks.

Cheers,
Muli
