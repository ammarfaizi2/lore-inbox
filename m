Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286962AbSBGJsg>; Thu, 7 Feb 2002 04:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286968AbSBGJs1>; Thu, 7 Feb 2002 04:48:27 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:26967 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S286962AbSBGJsP>; Thu, 7 Feb 2002 04:48:15 -0500
Date: Thu, 7 Feb 2002 04:48:14 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: "David S. Miller" <davem@redhat.com>, hugh@veritas.com,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
Message-ID: <20020207044814.A18023@redhat.com>
In-Reply-To: <3C6214F0.A66C89CF@zip.com.au>, <Pine.LNX.4.21.0202061844450.1856-100000@localhost.localdomain> <20020207000930.A17125@redhat.com> <3C6214F0.A66C89CF@zip.com.au> <20020206.215539.33252283.davem@redhat.com> <3C621C74.8A005EB6@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C621C74.8A005EB6@zip.com.au>; from akpm@zip.com.au on Wed, Feb 06, 2002 at 10:19:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 10:19:32PM -0800, Andrew Morton wrote:
> It's only a problem if this is the final put_page().  In the
> case of sendfile(), process-context code can be taught to take
> a temporary reference on the page, and only release it after the network
> stack is known to have finished with the page. sendfile is synchronous, yes?
> 
> And in the case of all other skb frees, the underlying page
> won't be on the LRU.  I hope.

sendfile isn't synchronous, nor is aio, which also relies on freeing pages 
acquired from user mappings in irq/bh/whatever context.  Restricting where 
pages may be freed really ties our hands on what is possible for zero copy 
io. (ie O_DIRECT, aio, sendfile, TUX all get hosed by this).

		-ben (who is really on vacation)
-- 
begin 644 fish.com
866]U(&AA=F4@=&]O(&UU8V@@=&EM92X*
`
end
