Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135699AbREJUBp>; Thu, 10 May 2001 16:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135773AbREJUBf>; Thu, 10 May 2001 16:01:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35589 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135699AbREJUBW>; Thu, 10 May 2001 16:01:22 -0400
Date: Thu, 10 May 2001 15:22:57 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Mark Hemment <markhe@veritas.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] allocation looping + kswapd CPU cycles
In-Reply-To: <20010510205204.O16590@redhat.com>
Message-ID: <Pine.LNX.4.21.0105101517050.19732-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 May 2001, Stephen C. Tweedie wrote:

> Hi,
> 
> On Thu, May 10, 2001 at 01:43:46PM -0300, Marcelo Tosatti wrote:
> 
> > No. __GFP_FAIL can to try to reclaim pages from inactive clean.
> > 
> > We just want to avoid __GFP_FAIL allocations from going to
> > try_to_free_pages().
> 
> Why?  __GFP_FAIL is only useful as an indication that the caller has
> some magic mechanism for coping with failure.  

Hum, not _only_. 

Initially I thought about __GFP_FAIL to be used by writeout routines which
want to cluster pages until they can allocate memory without causing any
pressure to the system. Something like this: 


while ((page = alloc_page(GFP_FAIL))
	add_page_to_cluster(page);

write_cluster(); 

See?

> There's no other information passed, so a brief call to
> try_to_free_pages is quite appropriate.

This obviously depends on what we decide __GFP_FAIL will be used for.



