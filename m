Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273509AbRIYUZn>; Tue, 25 Sep 2001 16:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273506AbRIYUZf>; Tue, 25 Sep 2001 16:25:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25355 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273509AbRIYUZ2>; Tue, 25 Sep 2001 16:25:28 -0400
Date: Tue, 25 Sep 2001 16:02:29 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: andrea@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <20010925.131528.78383994.davem@redhat.com>
Message-ID: <Pine.LNX.4.21.0109251601360.2193-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Sep 2001, David S. Miller wrote:

>    From: Marcelo Tosatti <marcelo@conectiva.com.br>
>    Date: Tue, 25 Sep 2001 15:40:23 -0300 (BRT)
>    
>    We can simply lock the pagecachelock and the pagemap_lru_lock at the
>    beginning of the cleaning function. page_launder() use to do that.
>    
>    Thats why I asked Andrea if there was long hold times by shrink_caches().
>    
> Ok, I see.
> 
> I do think it's silly to hold the pagecache_lock during pure scanning
> activities of shrink_caches().

It may well be, but I would like to see some lockmeter results which show
that _shrink_cache()_ itself is a problem. :)

> It is known that pagecache_lock is the biggest scalability issue on
> large SMP systems, and thus the page cache locking patches Ingo and
> myself did.

Btw, is that one going into 2.5 for sure? (the per-address-space lock). 

