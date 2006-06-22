Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWFVW43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWFVW43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbWFVW43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:56:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39094 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030438AbWFVW42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:56:28 -0400
Date: Thu, 22 Jun 2006 15:59:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: jeff@garzik.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 build fix
Message-Id: <20060622155943.27c98d61.akpm@osdl.org>
In-Reply-To: <20060622223919.GB50270@muc.de>
References: <20060622205928.GA23801@havoc.gtf.org>
	<20060622142430.3219f352.akpm@osdl.org>
	<20060622223919.GB50270@muc.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Thu, Jun 22, 2006 at 02:24:30PM -0700, Andrew Morton wrote:
> > Jeff Garzik <jeff@garzik.org> wrote:
> > >
> > > As of last night, I still needed the Kconfig patch below to
> > > successfully build allmodconfig on x86-64.  I believe Andrew has the
> > > patch with a proper description and attribution, so I would prefer
> > > that he send it...
> > 
> > It was transferred from the -mm-only stuff and into the x86_64 tree, so
> > Andi owns it now.
> > 
> > I'll steal it back and will send it to Linus.
> 
> It's in my pile to eventually send, but so far nobody was able to explain
> to me why it is suddenly needed at all, so  I wasn't feeling
> very comfortable with it.
> 

urgh, we worked all this out several weeks ago.  Forget.

Looking at the patch, I guess the problem is the

config AGP
	default y if GART_IOMMU

which doesn't dtrt if you already have AGP=m.


The patch does this, instead:

config GART_IOMMU
	select AGP

which gives us AGP=y if GART_IOMMU=y.


I don't think Jeff has sent us an example .config, but I hit this a few
times too, before we fixed it.  I think this was all triggered by a Kconfig
change in the AGP tree, so you wouldn't have seen it, but -mm did.
