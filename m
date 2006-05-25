Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWEYJAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWEYJAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 05:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWEYJAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 05:00:04 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:7914 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965090AbWEYJAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 05:00:03 -0400
Message-ID: <348547594.25107@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 25 May 2006 16:59:57 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/33] readahead: initial method
Message-ID: <20060525085957.GC4996@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469546.16482@ustc.edu.cn> <447541E6.4090702@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447541E6.4090702@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 03:34:30PM +1000, Nick Piggin wrote:
> BTW. while your patchset might be nicely broken down, I think your
> naming and descriptions are letting it down a little bit.

:) Maybe more practices will help.

> Wu Fengguang wrote:
> 
> >Aggressive readahead policy for read on start-of-file.
> >
> >Instead of selecting a conservative readahead size,
> >it tries to do large readahead in the first place.
> >
> >However we have to watch on two cases:
> >	- do not ruin the hit rate for file-head-checkers
> >	- do not lead to thrashing for memory tight systems
> >
> >
> 
> How does it handle
>             -  don't needlessly readahead too much if the file is in cache

It is prevented by the calling scheme.

The adaptive readahead logic will only be called on
        - read a non-cached page
                So readahead will be started/stopped on demand.
        - read a PG_readahead marked page
                Since the PG_readahead mark will only be set on fresh
                new pages in __do_page_cache_readahead(), readahead
                will automatically cease on cache hit.

> 
> Would the current readahead mechanism benefit from more aggressive 
> start-of-file
> readahead?

It will have the same benefits(and drawbacks).

[QUOTE FROM ANOTHER MAIL]
> can we try to incrementally improve the current logic as well as work
> towards merging your readahead rewrite?

The current readahead is left untouched on purpose.

If I understand it right, its simplicity is a great virtue.  And it is
hard to improve it without loosing this virtue, or avoid disturbing
old users.

Then the new framework provides a ideal testbed for fancy new things.
We can do experimental things without calling for complaints(before it
is stabilized after one year). And then we might port some proved
features to the current logic.

Wu
