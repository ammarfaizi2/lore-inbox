Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265104AbSJWRcv>; Wed, 23 Oct 2002 13:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265105AbSJWRcv>; Wed, 23 Oct 2002 13:32:51 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:41464 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S265104AbSJWRcu>; Wed, 23 Oct 2002 13:32:50 -0400
Date: Wed, 23 Oct 2002 13:39:00 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Dan Kegel <dank@kegel.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       "Charles 'Buck' Krasic" <krasic@acm.org>,
       Mark Mielke <mark@mark.mielke.cc>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
Message-ID: <20021023133900.B27433@redhat.com>
References: <Pine.LNX.4.44.0210221231330.1563-100000@blue1.dev.mcafeelabs.com> <3DB6D332.9000709@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB6D332.9000709@kegel.com>; from dank@kegel.com on Wed, Oct 23, 2002 at 09:49:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 09:49:54AM -0700, Dan Kegel wrote:
> Furthermore, epoll is nice because it delivers one-shot readiness change
> notification (I used to think that was a drawback, but coding
> nonblocking OpenSSL apps has convinced me otherwise).
> I may be confused, but I suspect the async poll being proposed by
> Ben only delivers absolute readiness, not changes in readiness.
> 
> I think epoll is worth having, even if Ben's AIO already handled
> networking properly.

That depends on how it compares to async read/write, which hasn't 
been looked into yet.  The way the pipe code worked involved walking 
the page tables, which is still quite expensive for small data sizes.  
With the new code, the CPU's tlb will be used, which will make a big 
difference, especially for the case where only a single address space 
is in use on the system.

		-ben
-- 
"Do you seek knowledge in time travel?"
