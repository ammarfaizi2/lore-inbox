Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbUCPIDG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbUCPIBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:01:52 -0500
Received: from mail.cyclades.com ([64.186.161.6]:19691 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263507AbUCPIA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:00:58 -0500
Date: Tue, 16 Mar 2004 04:25:04 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, <marcelo.tosatti@cyclades.com>,
       <j-nomura@ce.jp.nec.com>, <linux-kernel@vger.kernel.org>,
       <torvalds@osdl.org>
Subject: Re: [2.4] heavy-load under swap space shortage
In-Reply-To: <405628AC.4030609@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0403160414080.1667-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Mar 2004, Nick Piggin wrote:

> 
> 
> Andrea Arcangeli wrote:
> 
> >On Tue, Mar 16, 2004 at 01:37:04AM +1100, Nick Piggin wrote:
> >
> >>This case I think is well worth the unfairness it causes, because it
> >>means your zone's pages can be freed quickly and without freeing pages
> >>from other zones.
> >>
> >
> >freeing pages from other zones is perfectly fine, the classzone design
> >gets it right, you have to free memory from the other zones too or you
> >have no way to work on a 1G machine. you call the thing "unfair" when it
> >has nothing to do with fariness, your unfariness is the slowdown I
> >pointed out, it's all about being able to maintain a more reliable cache
> >information from the point of view of the pagecache users (the pagecache
> >users cares at the _classzone_, they can't care about the zones
> >themself), it has nothing to do with fairness.
> >
> >
> 
> What I meant by unfairness is that low zone scanning in response
> to low zone pressure will not put any pressure on higher zones.
> Thus pages in higher zones have an advantage.
> 
> We do scan lowmem in response to highmem pressure.

Hi Nick, 

I'm having a good time reading this discussion, so let me jump in.

Sure, the "unfairness" between lowmem and highmem exists. Quoting what 
you said, "pages in higher zones have an advantage". 

That is natural, after all the necessity for lowmem pages is much higher
than the need for highmem pages. And this necessity for the lowmem
precious increases as far as the lowmem/highmem ratio grows.

As Andrew has demonstrated, the problems previously caused by such
"unfairness" are non existant with per-zone LRU lists.

So, yes, we have unfairness between lowmem and highmem, and yes, that is
the way it should be.

I felt you had a problem with such a thing, however I dont see one.

Am I missing something?

Regards

