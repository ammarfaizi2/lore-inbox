Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272686AbTG3DEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 23:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272712AbTG3DEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 23:04:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:42249 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S272686AbTG3DEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 23:04:43 -0400
Date: Tue, 29 Jul 2003 22:56:00 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@osdl.org>
cc: "S. Anderson" <sa@xmission.com>, pavel@xal.co.uk,
       linux-kernel@vger.kernel.org, adaplas@pol.net
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
In-Reply-To: <20030728223229.528ddad1.akpm@osdl.org>
Message-ID: <Pine.LNX.3.96.1030729225445.27753D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Andrew Morton wrote:

> "S. Anderson" <sa@xmission.com> wrote:
> >
> > when that driver is 
> >  "i810fb, i810_audio or intel-agp" (and i810fb, i810_audio or intel-agp
> >  is allready loaded) the id_table is at an address that cant be handled, 
> >  thus cauing the oops. I am having trouble figuring out why 
> >  pci_drv->id_table isnt valid in this case.
> 
> Does this fix?  I'm not sure whether that "{ }" in there will generate
> another table entry...
> 
> 
> diff -puN drivers/char/agp/intel-agp.c~intel-agp-oops-fix drivers/char/agp/intel-agp.c
> --- 25/drivers/char/agp/intel-agp.c~intel-agp-oops-fix	2003-07-28 22:30:30.000000000 -0700
> +++ 25-akpm/drivers/char/agp/intel-agp.c	2003-07-28 22:30:53.000000000 -0700
> @@ -1426,7 +1426,7 @@ static struct pci_device_id agp_intel_pc
>  	.subvendor	= PCI_ANY_ID,
>  	.subdevice	= PCI_ANY_ID,
>  	},
> -	{ }
> +	{ 0, },
>  };
>  
>  MODULE_DEVICE_TABLE(pci, agp_intel_pci_table);
> 
> _

Sure about that last comma? Any compiler version issues?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

