Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273147AbRIYT6D>; Tue, 25 Sep 2001 15:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273450AbRIYT5x>; Tue, 25 Sep 2001 15:57:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3219 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S273147AbRIYT5q>;
	Tue, 25 Sep 2001 15:57:46 -0400
Date: Tue, 25 Sep 2001 12:57:58 -0700 (PDT)
Message-Id: <20010925.125758.94556009.davem@redhat.com>
To: marcelo@conectiva.com.br
Cc: andrea@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0109251446210.1495-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0109251446210.1495-100000@freak.distro.conectiva>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Marcelo Tosatti <marcelo@conectiva.com.br>
   Date: Tue, 25 Sep 2001 14:49:40 -0300 (BRT)
   
   Do you really need to do this ? 
   
                   if (unlikely(!spin_trylock(&pagecache_lock))) {
                           /* we hold the page lock so the page cannot go away from under us */
                           spin_unlock(&pagemap_lru_lock);
   
                           spin_lock(&pagecache_lock);
                           spin_lock(&pagemap_lru_lock);
                   }
   
   Have you actually seen bad hold times of pagecache_lock by
   shrink_caches() ? 

Marcelo, this is needed because of the spin lock ordering rules.
The pagecache_lock must be obtained before the pagemap_lru_lock
or else deadlock is possible.  The spin_trylock is an optimization.

Franks a lot,
David S. Miller
davem@redhat.com
