Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVANAwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVANAwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVANAtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:49:18 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:10604 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261727AbVANAsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:48:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=c4qQe9LVykxd934Ke/PzeoejQORkkXVpZFcHkhRbUk5goVpVt9pqRNXM4BdkDnI8qaWNWGveY8r4bGWggPEYeDEsQO2xR4tgG0YT52fyco4S+E2+UVgXXCfUnV1uYUGKmI3+KCGqQGXoMVDDwTaT1ePJK+Q5WNVnDIdis7sjzuU=
Message-ID: <8746466a0501131648640e0575@mail.gmail.com>
Date: Thu, 13 Jan 2005 17:48:16 -0700
From: Dave <dave.jiang@gmail.com>
Reply-To: Dave <dave.jiang@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] Convert resource to u64 from unsigned long
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       smaurer@teja.com, linux@arm.linux.org.uk, dsaxena@plexity.net,
       drew.moseley@intel.com, mporter@kernel.crashing.org
In-Reply-To: <Pine.LNX.4.58.0501131641390.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <8746466a050113152636f49d18@mail.gmail.com>
	 <20050113162309.2a125eb1.akpm@osdl.org>
	 <Pine.LNX.4.58.0501131641390.2310@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005 16:43:58 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> 
> On Thu, 13 Jan 2005, Andrew Morton wrote:
> >
> > Also, the patches introduce tons of ifdefs such as:
> >
> > +#if BITS_PER_LONG == 64
> >       return (void __iomem *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> > +#else
> > +     return (void __iomem *)(u32)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> > +#endif
> 
> Ouch. Who does that, anyway? It's wrong to do that. It's not a pointer,
> not even an __iomem one. You'd need to do an ioremap() on it to turn it
> into a pointer.
> 
>                 Linus
> 

It's in the PCI option ROM code and at first it thew me just a bit
too. Apparently the resource.start is a kmalloc'd buffer and not
really an actual bus address. Is that a gross abuse of the way struct
resource is intended to be used?

-- 
-= Dave =-

Software Engineer - Advanced Development Engineering Team 
Storage Component Division - Intel Corp. 
mailto://dave.jiang @ intel
http://sourceforge.net/projects/xscaleiop/
----
The views expressed in this email are
mine alone and do not necessarily 
reflect the views of my employer
(Intel Corp.).
