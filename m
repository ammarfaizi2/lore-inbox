Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbSJITbC>; Wed, 9 Oct 2002 15:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSJITbB>; Wed, 9 Oct 2002 15:31:01 -0400
Received: from vsmtp1.tin.it ([212.216.176.221]:42963 "EHLO smtp1.cp.tin.it")
	by vger.kernel.org with ESMTP id <S261572AbSJITbB>;
	Wed, 9 Oct 2002 15:31:01 -0400
Message-ID: <3DA4852B.7CC89C09@denise.shiny.it>
Date: Wed, 09 Oct 2002 21:36:11 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.19 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
References: <1034104637.29468.1483.camel@phantasy> <XFMail.20021009103325.pochini@shiny.it> <20021009170517.GA5608@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Does it drop pages unconditionally ?  What happens if I do a
> > streaming_cat largedatabase > /dev/null while other processes
> > are working on it ?  It's not a good thing to remove the whole
> > cached data other apps are working on.
> 
> Anybody could make the cache thrash. I don't see this as an argument against
> O_STREAMING (whether explicitly activated, or dynamically activated).

In fact it isn't. But I don't undestand why we unconditionally discard a
page after it has been read. Yes, I told the kernel I will not need it
anymore, but someone else could need it. I'm not a kernel hacker and I
don't know if this is possible: when a page is read from disk by a O_STR
file flag it "kill me first when needed, otherwise leave me in memory",
and if a page is already cache, just use it and change nothing. This
will preserve data used by other processes, and the data I've just
read if there is room. Free memory is wasted momory. Don't drop caches
if nobody need memory.


Bye.
