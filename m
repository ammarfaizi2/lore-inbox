Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSEQIEF>; Fri, 17 May 2002 04:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315459AbSEQIEE>; Fri, 17 May 2002 04:04:04 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:12339 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S315458AbSEQIEC>; Fri, 17 May 2002 04:04:02 -0400
Date: Fri, 17 May 2002 08:56:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Hugh Dickins <hugh@lrel.veritas.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix BUG macro 
In-Reply-To: <E178Ven-0007jA-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.21.0205170839240.1369-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, Rusty Russell wrote:
> 
> Um, show me where sizeof(KBUILD_BASENAME) + sizeof(__FUNCTION__) >
> sizeof(__FILENAME__).

If you're talking about kbuild2.5 where all the __FILENAME__s
become absolute (for good reason) instead of the leafnames they
usually were (header files excepted): not many instances, but
that's not the point.  The point is that all the instances of
__FILENAME__ within one compilation unit (across compilation
units? rumours that that will become so) get combined into a
single string, so little overhead to many BUG()s in one file.
But you are now creating lots of __FUNCTION__ strings which
cannot be combined to the nearly same extent (though, yeah,
all those "__free_pages_ok"s will get combined into one).

Your BUG() may have made space savings relative to kbuild2.5,
I don't know, but that's because kbuild2.5 has inadvertently
added a bloat there, and I thought we were looking for ways
to recover from that (I'd earlier proposed KBUILD_BASENAME,
but didn't understand stringification), to get back to
Andrew's lean mean clean implementation (before which we
needed CONFIG_DEBUG_BUGVERBOSE=n to cut out the overhead).

Hugh

