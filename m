Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287645AbSBGMkR>; Thu, 7 Feb 2002 07:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287710AbSBGMkH>; Thu, 7 Feb 2002 07:40:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50842 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287645AbSBGMj5>;
	Thu, 7 Feb 2002 07:39:57 -0500
Date: Thu, 07 Feb 2002 04:37:44 -0800 (PST)
Message-Id: <20020207.043744.93473658.davem@redhat.com>
To: riel@conectiva.com.br
Cc: akpm@zip.com.au, bcrl@redhat.com, hugh@veritas.com,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0202071033130.17850-100000@imladris.surriel.com>
In-Reply-To: <3C6227B7.37BFA2EC@zip.com.au>
	<Pine.LNX.4.33L.0202071033130.17850-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Thu, 7 Feb 2002 10:34:20 -0200 (BRST)

   Actually, at this point we _know_ page->list.{prev,next} are
   NULL.
   
   We can use this to add the pages to a special list, from where
   __alloc_pages() and kswapd can move them to the free list, in
   process context.

I don't think there should be any special logic on how to free a page
outside of the page allocator itself.  Certainly this kind of stuff
doesn't belong in the networking.

Pages can be freed from arbitrary contexts, and the page allocator
should be the part the knows how to deal with it.

Maybe I don't understand and you're really suggesting something else.
