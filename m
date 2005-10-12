Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVJLVzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVJLVzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVJLVzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:55:54 -0400
Received: from xenotime.net ([66.160.160.81]:53722 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932460AbVJLVzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:55:53 -0400
Date: Wed, 12 Oct 2005 14:55:50 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       venki <venkatesh.pallipadi@intel.com>, bob.picco@hp.com,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH 1/3] hpet: allow fixed_mem32 ACPI resource type
In-Reply-To: <200510121408.32163.bjorn.helgaas@hp.com>
Message-ID: <Pine.LNX.4.58.0510121441010.6823@shark.he.net>
References: <20051012115814.1d367a94.randy_d_dunlap@linux.intel.com>
 <200510121408.32163.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry, replying from different email address; I've waited > 1 hour
for your email to arrive at linux.intel.com ... :(
Maybe it was a bad choice.)


On Wed, 12 Oct 2005, Bjorn Helgaas wrote:

> On Wednesday 12 October 2005 12:58 pm, Randy Dunlap wrote:
> > Allow the ACPI HPET description table to use a resource type
> > of FIXED_MEM32 for the HPET reource.  Use the fixed resoure
> > size of 1 KB for the HPET resource as per the HPET spec.
>
> I have a patch in my tree to convert HPET from an ACPI
> driver to a PNP driver, using PNPACPI.  That should take
> care of issues like this.

Thanks, that's good news.

> But my patch is waiting on some PNP work by Adam to allow
> PNPACPI devices to have more than 2 IRQs.
>
> In the meantime, I think your patch is fine.
>
> > +#define HPET_RANGE_SIZE		1024	/* from HPET spec */
>
> Out of curiosity, why do you need this?  ACPI_RSTYPE_FIXED_MEM32
> contains a length field, and my patch uses it.  Did you run
> into some firmware that supplies incorrect information about the
> size of the HPET MMIO area?

a.  The HPET spec says that the HPET block size is 1 KB
in section 3.2.1.

b.  Table 3 (HPET description table) requires an HPET base
address (offset 40), but seems not to require a length.
However, the description text again states a fixed block size
of 1 KB.

c.  Yes, I've seen descriptor.length field value of 0.
Whether it's incorrect is a discussion for an specster IMO.
At least it's debatable (by someone).

d.  Yes, I would prefer to use (valid) length from the descriptor.
Maybe default to 1 KB if desc.length is 0 (?).


> Another minor HPET nit I fixed is that it currently doesn't
> use request_mem_region().  I did it in PNP terms, so it's
> waiting on Adam's work, but maybe it'd be worth an interim
> patch until that's ready.

OK, maybe you can get Bob Picco or me to add that to our
todo lists.

Thanks,
-- 
~Randy
