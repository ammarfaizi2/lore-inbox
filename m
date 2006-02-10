Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWBJFsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWBJFsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWBJFsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:48:30 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:17819 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751126AbWBJFsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:48:30 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
Date: Fri, 10 Feb 2006 16:48:01 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org, ck@vds.kolivas.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
References: <200602101355.41421.kernel@kolivas.org> <200602101637.57821.kernel@kolivas.org> <43EC281B.2030000@yahoo.com.au>
In-Reply-To: <43EC281B.2030000@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101648.01923.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 16:43, Nick Piggin wrote:
> Con Kolivas wrote:
> > On Friday 10 February 2006 16:32, Nick Piggin wrote:
> >>Con Kolivas wrote:
> >>>Just so it's clear I understand, is this what you (both) had in mind?
> >>>Inline so it's not built for !CONFIG_SWAP_PREFETCH
> >>
> >>Close...
> >>
> >>>+inline void lru_cache_add_tail(struct page *page)
> >>
> >>Is this inline going to do what you intend?
> >
> > I don't care if it's actually inlined, but the subtleties of compilers is
> > way beyond me. All it positively achieves is silencing the unused
> > function warning so I had hoped it meant that function was not built. I
> > tend to be wrong though...
>
> I don't think it can because it is not used in the same file.
> You'd have to put it into the header file.

Yes that was the stream of "unimplemented" errors we started seeing on new 
gccs that couldn't inline and said so. The build process is mystical and 
somewhat random in order but I guessed if it encounters this first it should 
be able to inline it. However as I said I don't really need it inlined.

> Not sure why it silences the unused function warning.

It probably just fools it... Will probably warn on newer gccs soon.

> You didn't 
> replace a 'static' with the inline? I don't think there is any
> other way the compiler can know the function isn't used externally.

Well I could always just put it in a header file under CONFIG_SWAP_PREFETCH.. 
I was trying to do the swap.c thing that akpm suggested though.

Cheers,
Con
