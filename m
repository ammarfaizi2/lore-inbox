Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbSBGGUl>; Thu, 7 Feb 2002 01:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284970AbSBGGUV>; Thu, 7 Feb 2002 01:20:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51474 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S284305AbSBGGUK>;
	Thu, 7 Feb 2002 01:20:10 -0500
Message-ID: <3C621C74.8A005EB6@zip.com.au>
Date: Wed, 06 Feb 2002 22:19:32 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: bcrl@redhat.com, hugh@veritas.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <3C6214F0.A66C89CF@zip.com.au>,
		<Pine.LNX.4.21.0202061844450.1856-100000@localhost.localdomain>
		<20020207000930.A17125@redhat.com>
		<3C6214F0.A66C89CF@zip.com.au> <20020206.215539.33252283.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Andrew Morton <akpm@zip.com.au>
>    Date: Wed, 06 Feb 2002 21:47:28 -0800
> 
>    Are you sure that the pages are being released from interrupt context?
> 
> BH context... that's where SKB frees happen.
> 
> hmmm...

It's only a problem if this is the final put_page().  In the
case of sendfile(), process-context code can be taught to take
a temporary reference on the page, and only release it after the network
stack is known to have finished with the page. sendfile is synchronous, yes?

And in the case of all other skb frees, the underlying page
won't be on the LRU.  I hope.

-
