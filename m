Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbSBGHIh>; Thu, 7 Feb 2002 02:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285093AbSBGHI2>; Thu, 7 Feb 2002 02:08:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13843 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S284987AbSBGHIO>;
	Thu, 7 Feb 2002 02:08:14 -0500
Message-ID: <3C6227B7.37BFA2EC@zip.com.au>
Date: Wed, 06 Feb 2002 23:07:35 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: bcrl@redhat.com, hugh@veritas.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <3C621C74.8A005EB6@zip.com.au>,
		<3C6214F0.A66C89CF@zip.com.au>
		<20020206.215539.33252283.davem@redhat.com>
		<3C621C74.8A005EB6@zip.com.au> <20020206.224940.122062252.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Andrew Morton <akpm@zip.com.au>
>    Date: Wed, 06 Feb 2002 22:19:32 -0800
> 
>    It's only a problem if this is the final put_page().  In the
>    case of sendfile(), process-context code can be taught to take
>    a temporary reference on the page, and only release it after the network
>    stack is known to have finished with the page. sendfile is synchronous, yes?
> 
> Userspace can return long before the SKBs are free'd up.  That SKB
> free doesn't happen until the ACKs come back from the receiver.

I feel that presence on the lru list should contribute to
page->count.  It seems a bit weird and kludgy that this
is not so.

If we were to do this then would this not fix networking's
problem?  The skb free wouldn't release the page - it would
be left on the LRU with ->count == 1 and kswapd would reap it.

(Says me, hoping that Hugh will code it :))

-
