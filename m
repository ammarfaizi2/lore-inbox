Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317372AbSFCLJt>; Mon, 3 Jun 2002 07:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317370AbSFCLIj>; Mon, 3 Jun 2002 07:08:39 -0400
Received: from holomorphy.com ([66.224.33.161]:28544 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317372AbSFCLIg>;
	Mon, 3 Jun 2002 07:08:36 -0400
Date: Mon, 3 Jun 2002 04:07:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: remove mixture of non-atomic operations with page->flags which requires atomic operations to access
Message-ID: <20020603110742.GC912@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, hugh@veritas.com,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
In-Reply-To: <20020603102809.GA912@holomorphy.com> <20020603.022739.102772773.davem@redhat.com> <20020603110055.GB912@holomorphy.com> <20020603.030048.15263428.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: William Lee Irwin III <wli@holomorphy.com>
>    Date: Mon, 3 Jun 2002 04:00:55 -0700
> 
>     	if (PageWriteback(page))
>     		BUG();
>    -	ClearPageDirty(page);
>    -	page->flags &= ~(1<<PG_referenced);
>    +
>    +	page->flags &= ~((1UL << PG_referenced) | (1UL << PG_dirty));
> 
> Umm, nevermind.  Look at ClearPageDirty, it does
> "other stuff" so you can't remove it wholesale.
> In the end, the code is as it should be right now.

Ugh, even if it isn't I don't care to deal with it, rusty, chuck this one.


Cheers,
Bill
