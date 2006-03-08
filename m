Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWCHB1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWCHB1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbWCHB1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:27:36 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:52169 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751999AbWCHB1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:27:35 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm: yield during swap prefetching
Date: Wed, 8 Mar 2006 12:28:05 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, ck@vds.kolivas.org
References: <200603081013.44678.kernel@kolivas.org> <200603081212.03223.kernel@kolivas.org> <20060307172337.1d97cd80.akpm@osdl.org>
In-Reply-To: <20060307172337.1d97cd80.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081228.05820.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2006 12:23 pm, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > > but, but.  If prefetching is prefetching stuff which that game will
> > > soon use then it'll be an aggregate improvement.  If prefetch is
> > > prefetching stuff which that game _won't_ use then prefetch is busted. 
> > > Using yield() to artificially cripple kprefetchd is a rather sad
> > > workaround isn't it?
> >
> > It's not the stuff that it prefetches that's the problem; it's the disk
> > access.
>
> But the prefetch code tries to avoid prefetching when the disk is otherwise
> busy (or it should - we discussed that a bit a while ago).

Anything that does disk access delays prefetch fine. Things that only do heavy 
cpu do not delay prefetch. Anything reading from disk will be noticeable 
during 3d gaming.

> Sorry, I'm not trying to be awkward here - I think that nobbling prefetch
> when there's a lot of CPU activity is just the wrong thing to do and it'll
> harm other workloads.

I can't distinguish between when cpu activity is important (game) and when it 
is not (compile), and assuming worst case scenario and not doing any swap 
prefetching is my intent. I could add cpu accounting to prefetch_suitable() 
instead, but that gets rather messy and yielding achieves the same endpoint.

Cheers,
Con
