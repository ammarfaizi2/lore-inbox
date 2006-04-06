Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWDFEgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWDFEgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 00:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWDFEgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 00:36:36 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:17057 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932148AbWDFEgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 00:36:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Respin: [PATCH] mm: limit lowmem_reserve
Date: Thu, 6 Apr 2006 14:36:16 +1000
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <200604021401.13331.kernel@kolivas.org> <200604061258.40487.kernel@kolivas.org> <20060405204009.3235b021.akpm@osdl.org>
In-Reply-To: <20060405204009.3235b021.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604061436.16907.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 April 2006 13:40, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > On Thursday 06 April 2006 12:55, Con Kolivas wrote:
> > > On Thursday 06 April 2006 12:43, Andrew Morton wrote:
> > > > Con Kolivas <kernel@kolivas.org> wrote:
> > > > > It is possible with a low enough lowmem_reserve ratio to make
> > > > >  zone_watermark_ok fail repeatedly if the lower_zone is small
> > > > > enough.
> > > >
> > > > Is that actually a problem?
> > >
> > > Every single call to get_page_from_freelist will call on zone reclaim.
> > > It seems a problem to me if every call to __alloc_pages will do that?
> >
> > every call to __alloc_pages of that zone I mean
>
> One would need to check with the NUMA guys.  zone_reclaim() has a
> (lame-looking) timer in there to prevent it from doing too much work.
>
> That, or I'm missing something.  This problem wasn't particularly well
> described, sorry.

Ah ok. This all came about because I'm trying to honour the lowmem_reserve 
better in swap_prefetch at Nick's request. It's hard to honour a watermark 
that on some configurations is never reached.

Cheers,
Con
