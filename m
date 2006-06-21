Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWFUU4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWFUU4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWFUU4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:56:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:16845 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030275AbWFUU4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:56:34 -0400
Date: Wed, 21 Jun 2006 16:56:08 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit resources start end value fix
Message-ID: <20060621205608.GC14739@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060621172903.GC9423@in.ibm.com> <20060621132227.ec401f93.akpm@osdl.org> <20060621204120.GA14739@in.ibm.com> <20060621204414.GA30766@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621204414.GA30766@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 01:44:15PM -0700, Greg KH wrote:
> On Wed, Jun 21, 2006 at 04:41:21PM -0400, Vivek Goyal wrote:
> > On Wed, Jun 21, 2006 at 01:22:27PM -0700, Andrew Morton wrote:
> > > On Wed, 21 Jun 2006 13:29:03 -0400
> > > Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > > 
> > > > Hi Greg,
> > > > 
> > > > While changing 64bit kconfig options to CONFIG_RESOURCES_64BIT, I forgot
> > > > to update the values of start and end fields in ioport_resource and
> > > > iomem_resource.
> > > > 
> > > > Following patch applies on top of your reworked 64 bit patches and
> > > > is based on Andrew Morton's patch. Please apply.
> > > > 
> > > > http://marc.theaimsgroup.com/?l=linux-mm-commits&m=115087406130723&w=2
> > > > 
> > > > Thanks
> > > > Vivek
> > > > 
> > > > 
> > > > 
> > > > o Update start and end fields for 32bit and 64bit resources.
> > > > 
> > > > Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> > > > ---
> > > > 
> > > >  linux-2.6.17-1M-vivek/kernel/resource.c |    6 +++---
> > > >  1 files changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff -puN kernel/resource.c~64bit-resources-start-end-value-fix kernel/resource.c
> > > > --- linux-2.6.17-1M/kernel/resource.c~64bit-resources-start-end-value-fix	2006-06-21 12:43:43.000000000 -0400
> > > > +++ linux-2.6.17-1M-vivek/kernel/resource.c	2006-06-21 12:44:59.000000000 -0400
> > > > @@ -23,7 +23,7 @@
> > > >  
> > > >  struct resource ioport_resource = {
> > > >  	.name	= "PCI IO",
> > > > -	.start	= 0x0000,
> > > > +	.start	= 0,
> > > >  	.end	= IO_SPACE_LIMIT,
> > > >  	.flags	= IORESOURCE_IO,
> > > >  };
> > > > @@ -32,8 +32,8 @@ EXPORT_SYMBOL(ioport_resource);
> > > >  
> > > >  struct resource iomem_resource = {
> > > >  	.name	= "PCI mem",
> > > > -	.start	= 0UL,
> > > > -	.end	= ~0UL,
> > > > +	.start	= 0,
> > > > +	.end	= -1,
> > > >  	.flags	= IORESOURCE_MEM,
> > > >  };
> > > >  
> > > 
> > > Confused.  This patch won't apply.  It will apply with `patch -R', and if
> > > you do that you'll break iomem_reosurce.end by setting it to
> > > 0x00000000ffffffff.
> > > 
> > > I don't think any additional changes are needed here.
> > 
> > Andrew, you don't have to apply this patch. It is supposed to be picked
> > by Greg.
> > 
> > There seems to be some confusion. Just few days back Greg consolidated
> > and re-organized all the 64bit resources patches and posted on LKML for
> > review.
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=115015916118671&w=2
> > 
> > There were few review comments regarding kconfig options.
> > I reworked the patch and CONFING_RESOURCES_32BIT was changed to
> > CONFIG_RESOURCES_64BIT.
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=115072559700302&w=2
> > 
> > Now Greg's tree and your tree are not exact replica when it comes to 
> > 64bit resource patches. Hence this patch is supposed to be picked by 
> > Greg to make sure things are not broken in his tree.
> 
> It still breaks things as Andrew pointed out.  .end should not be set to
> -1.

I think Andrew mentioned that it breaks things if applied on -mm with -R.
Because it will set .end to ~0UL instead of -1

Is .end = -1 wrong? Won't it effectively be .end = 0xffffffffffffffff for 
64 bit resources?

Thanks
Vivek
