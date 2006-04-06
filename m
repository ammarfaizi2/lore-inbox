Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWDFExE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWDFExE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 00:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWDFExE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 00:53:04 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:30926 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750851AbWDFExD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 00:53:03 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: Respin: [PATCH] mm: limit lowmem_reserve
Date: Thu, 6 Apr 2006 14:52:42 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200604021401.13331.kernel@kolivas.org> <20060405204009.3235b021.akpm@osdl.org> <200604061436.16907.kernel@kolivas.org>
In-Reply-To: <200604061436.16907.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604061452.43020.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 April 2006 14:36, Con Kolivas wrote:
> On Thursday 06 April 2006 13:40, Andrew Morton wrote:
> > Con Kolivas <kernel@kolivas.org> wrote:
> > > On Thursday 06 April 2006 12:55, Con Kolivas wrote:
> > > > On Thursday 06 April 2006 12:43, Andrew Morton wrote:
> > > > > Con Kolivas <kernel@kolivas.org> wrote:
> > > > > > It is possible with a low enough lowmem_reserve ratio to make
> > > > > >  zone_watermark_ok fail repeatedly if the lower_zone is small
> > > > > > enough.
> > > > >
> > > > > Is that actually a problem?
> > > >
> > > > Every single call to get_page_from_freelist will call on zone
> > > > reclaim. It seems a problem to me if every call to __alloc_pages will
> > > > do that?
> > >
> > > every call to __alloc_pages of that zone I mean
> >
> > One would need to check with the NUMA guys.  zone_reclaim() has a
> > (lame-looking) timer in there to prevent it from doing too much work.
> >
> > That, or I'm missing something.  This problem wasn't particularly well
> > described, sorry.
>
> Ah ok. This all came about because I'm trying to honour the lowmem_reserve
> better in swap_prefetch at Nick's request. It's hard to honour a watermark
> that on some configurations is never reached.

Forget that. If the numa people don't care about it I shouldn't touch it. I 
thought I was doing something helpful at the source but got no response from 
Nick or the the other numa_ids out there so they obviously don't care. I'll 
tackle it differently in swap prefetch.

Cheers,
Con
