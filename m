Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136919AbREJU2a>; Thu, 10 May 2001 16:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136918AbREJU2L>; Thu, 10 May 2001 16:28:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27913 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S136888AbREJU2G>; Thu, 10 May 2001 16:28:06 -0400
Date: Thu, 10 May 2001 15:49:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Mark Hemment <markhe@veritas.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] allocation looping + kswapd CPU cycles
In-Reply-To: <20010510211913.R16590@redhat.com>
Message-ID: <Pine.LNX.4.21.0105101545140.19732-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 May 2001, Stephen C. Tweedie wrote:

> Hi,
> 
> On Thu, May 10, 2001 at 03:22:57PM -0300, Marcelo Tosatti wrote:
> 
> > Initially I thought about __GFP_FAIL to be used by writeout routines which
> > want to cluster pages until they can allocate memory without causing any
> > pressure to the system. Something like this: 
> > 
> > while ((page = alloc_page(GFP_FAIL))
> > 	add_page_to_cluster(page);
> > write_cluster(); 
> 
> Isn't that an orthogonal decision?  You can use __GFP_FAIL with or
> without __GFP_WAIT or __GFP_IO, whichever is appropriate.

Correct. 

Back to the main discussion --- I guess we could make __GFP_FAIL (with
__GFP_WAIT set :)) allocations actually fail if "try_to_free_pages()" does
not make any progress (ie returns zero). But maybe thats a bit too
extreme.

What do you think? 

