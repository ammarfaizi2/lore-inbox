Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273488AbRIYUPn>; Tue, 25 Sep 2001 16:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273495AbRIYUPd>; Tue, 25 Sep 2001 16:15:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18067 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S273488AbRIYUPO>;
	Tue, 25 Sep 2001 16:15:14 -0400
Date: Tue, 25 Sep 2001 13:15:28 -0700 (PDT)
Message-Id: <20010925.131528.78383994.davem@redhat.com>
To: marcelo@conectiva.com.br
Cc: andrea@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0109251539150.2193-100000@freak.distro.conectiva>
In-Reply-To: <20010925.125758.94556009.davem@redhat.com>
	<Pine.LNX.4.21.0109251539150.2193-100000@freak.distro.conectiva>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Marcelo Tosatti <marcelo@conectiva.com.br>
   Date: Tue, 25 Sep 2001 15:40:23 -0300 (BRT)
   
   We can simply lock the pagecachelock and the pagemap_lru_lock at the
   beginning of the cleaning function. page_launder() use to do that.
   
   Thats why I asked Andrea if there was long hold times by shrink_caches().
   
Ok, I see.

I do think it's silly to hold the pagecache_lock during pure scanning
activities of shrink_caches().

It is known that pagecache_lock is the biggest scalability issue on
large SMP systems, and thus the page cache locking patches Ingo and
myself did.

Franks a lot,
David S. Miller
davem@redhat.com
