Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290825AbSBGX2f>; Thu, 7 Feb 2002 18:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290957AbSBGX2Z>; Thu, 7 Feb 2002 18:28:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15621 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290825AbSBGX2J>;
	Thu, 7 Feb 2002 18:28:09 -0500
Message-ID: <3C630D5D.CD66795@zip.com.au>
Date: Thu, 07 Feb 2002 15:27:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, bcrl@redhat.com,
        Hugh Dickins <hugh@lrel.veritas.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <Pine.LNX.4.33L.0202071120160.17850-100000@imladris.surriel.com> <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain>, <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain> <20020207215854.P1743@athlon.random> <3C62ED05.F4683103@zip.com.au>, <3C62ED05.F4683103@zip.com.au> <20020207231837.S1743@athlon.random> <3C630045.24E74301@zip.com.au>,
		<3C630045.24E74301@zip.com.au> <20020208000942.V1743@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> > Or I'm missing something.  Did something change?
> 
> as said in the previous email that becomes a buffercache mapped in
> userspace, with refcount > 1 (unfreeable from the vm side), so the
> __free_page from irq will do nothing (it will only decrease the refcount
> of 1 unit, and then the page will be released by the vm). If the
> refcount was 1 instead, then it means the page wasn't in the lru in the
> first place and so the check won't trigger either.

Ah.

If the second try_to_release_page() against the truncated page
(in shrink_cache()) succeeds, the page is removed from the LRU.

OK, I agree the weird case won't trigger the bug.   So I think we
agree that we need to run with Hugh's BUG check and do nothing else.


-
