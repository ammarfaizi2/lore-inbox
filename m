Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVKDX0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVKDX0H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVKDX0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:26:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4049 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750988AbVKDX0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:26:05 -0500
Date: Fri, 4 Nov 2005 15:26:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] uml: fix hardcoded ZONE_* constants in zone setup
Message-Id: <20051104152621.7b28faed.akpm@osdl.org>
In-Reply-To: <200511050021.48331.blaisorblade@yahoo.it>
References: <20051101170633.GB6448@ccure.user-mode-linux.org>
	<20051101203721.26156.11021.stgit@zion.home.lan>
	<20051104144632.55b92ea4.akpm@osdl.org>
	<200511050021.48331.blaisorblade@yahoo.it>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> On Friday 04 November 2005 23:46, Andrew Morton wrote:
> > "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > >
> > > Remove usage of hardcoded constants in paging_init().
> 
> > An earlier patch from Jeff (below) already changed this code.
> 
> Andrew, yes indeed: quoting from my changelog (yep, I should have made it 
> clearer):
> > > By chance I spotted a bug in zones_setup involving a change to ZONE_*
> > > constants, due to the ZONE_DMA32 patch from Andi Kleen (which is in -mm).
> > > So, possibly, instead of zones_size[2] you will find zones_size[3] in the
> > > code, but that change is wrong and this patch is still correct.
> I'm talking exactly of this Jeff's change, and I did exactly what you did...

It all comes back to me now ;)

> Thanks anyway for spending some time caring about this, it's nice to see 
> attention on UML (sorry, no kidding and no complaining).
> 
> > Jeff's change looks rather wrong:
> The original reason was done for -mm and ZONE_DMA32.
> 
> > #define MAX_NR_ZONES            3       /* Sync this with ZONES_SHIFT */
> > 	zones_size[3] = highmem >> PAGE_SHIFT;
> >
> > which overindexes the local array.
> 
> > The above change is unmentioned in Jeff's changelog and I'll just drop that
> > part.  Please confirm.
> Yep, ACK.

OK, using ZONE_HIGHMEM there will insulate UML from Andi's changes.

> > There are other parts of this patch whci are unchangelogged.  Please
> > double-check the whole thing.
> 
> I will re-check again later, but the unchangelogged changes seem to be just 
> long -> long long conversions.

OK, thanks.
