Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273470AbRIYUDn>; Tue, 25 Sep 2001 16:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273465AbRIYUDe>; Tue, 25 Sep 2001 16:03:34 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:29447 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273464AbRIYUDT>; Tue, 25 Sep 2001 16:03:19 -0400
Date: Tue, 25 Sep 2001 15:40:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: andrea@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <20010925.125758.94556009.davem@redhat.com>
Message-ID: <Pine.LNX.4.21.0109251539150.2193-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Sep 2001, David S. Miller wrote:

>    From: Marcelo Tosatti <marcelo@conectiva.com.br>
>    Date: Tue, 25 Sep 2001 14:49:40 -0300 (BRT)
>    
>    Do you really need to do this ? 
>    
>                    if (unlikely(!spin_trylock(&pagecache_lock))) {
>                            /* we hold the page lock so the page cannot go away from under us */
>                            spin_unlock(&pagemap_lru_lock);
>    
>                            spin_lock(&pagecache_lock);
>                            spin_lock(&pagemap_lru_lock);
>                    }
>    
>    Have you actually seen bad hold times of pagecache_lock by
>    shrink_caches() ? 
> 
> Marcelo, this is needed because of the spin lock ordering rules.
> The pagecache_lock must be obtained before the pagemap_lru_lock
> or else deadlock is possible.  The spin_trylock is an optimization.

Not, it is not.

We can simply lock the pagecachelock and the pagemap_lru_lock at the
beginning of the cleaning function. page_launder() use to do that.

Thats why I asked Andrea if there was long hold times by shrink_caches().

