Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136877AbREJSWl>; Thu, 10 May 2001 14:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136873AbREJSWb>; Thu, 10 May 2001 14:22:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4114 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S136877AbREJSWT>; Thu, 10 May 2001 14:22:19 -0400
Date: Thu, 10 May 2001 13:43:46 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mark Hemment <markhe@veritas.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] allocation looping + kswapd CPU cycles 
In-Reply-To: <Pine.LNX.4.21.0105100935040.31900-100000@alloc>
Message-ID: <Pine.LNX.4.21.0105101341130.19732-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 May 2001, Mark Hemment wrote:

> 
> On Wed, 9 May 2001, Marcelo Tosatti wrote:
> > On Wed, 9 May 2001, Mark Hemment wrote:
> > >   Could introduce another allocation flag (__GFP_FAIL?) which is or'ed
> > > with a __GFP_WAIT to limit the looping?
> > 
> > __GFP_FAIL is in the -ac tree already and it is being used by the bounce
> > buffer allocation code. 
> 
> Thanks for the pointer.
> 
>   For non-zero order allocations, the test against __GFP_FAIL is a little
> too soon; it would be better after we've tried to reclaim pages from the
> inactive-clean list.  Any nasty side effects to this?

No. __GFP_FAIL can to try to reclaim pages from inactive clean.

We just want to avoid __GFP_FAIL allocations from going to
try_to_free_pages().

>   Plus, the code still prevents PF_MEMALLOC processes from using the
> inactive-clean list for non-zero order allocations.  As the trend seems to
> be to make zero and non-zero allocations 'equivalent', shouldn't this
> restriction to lifted?

I don't see any problem about making non-zero allocations be able to
directly reclaim pages.


