Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265150AbSJWSc1>; Wed, 23 Oct 2002 14:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265151AbSJWSc1>; Wed, 23 Oct 2002 14:32:27 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:40601 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265150AbSJWSc0>; Wed, 23 Oct 2002 14:32:26 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 23 Oct 2002 11:47:33 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Benjamin LaHaise <bcrl@redhat.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <20021023133900.B27433@redhat.com>
Message-ID: <Pine.LNX.4.44.0210231144500.1581-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Benjamin LaHaise wrote:

> On Wed, Oct 23, 2002 at 09:49:54AM -0700, Dan Kegel wrote:
> > Furthermore, epoll is nice because it delivers one-shot readiness change
> > notification (I used to think that was a drawback, but coding
> > nonblocking OpenSSL apps has convinced me otherwise).
> > I may be confused, but I suspect the async poll being proposed by
> > Ben only delivers absolute readiness, not changes in readiness.
> >
> > I think epoll is worth having, even if Ben's AIO already handled
> > networking properly.
>
> That depends on how it compares to async read/write, which hasn't
> been looked into yet.  The way the pipe code worked involved walking
> the page tables, which is still quite expensive for small data sizes.
> With the new code, the CPU's tlb will be used, which will make a big
> difference, especially for the case where only a single address space
> is in use on the system.

Ben, does it work at all currently read/write requests on sockets ? I
would like to test AIO on networking using my test http server, and I was
thinking about using poll() for async accept and AIO for read/write. The
poll() should be pretty fast because there's only one fd in the set and
the remaining code will use AIO for read/write. Might this work currently ?



- Davide


