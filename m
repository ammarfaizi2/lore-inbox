Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262247AbSJJJ46>; Thu, 10 Oct 2002 05:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbSJJJ46>; Thu, 10 Oct 2002 05:56:58 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:36870 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262247AbSJJJ45>; Thu, 10 Oct 2002 05:56:57 -0400
Message-Id: <200210100957.g9A9vop02409@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Date: Thu, 10 Oct 2002 12:51:17 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <1034104637.29468.1483.camel@phantasy> <20021009170517.GA5608@mark.mielke.cc> <3DA4852B.7CC89C09@denise.shiny.it>
In-Reply-To: <3DA4852B.7CC89C09@denise.shiny.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 October 2002 17:36, Giuliano Pochini wrote:
> > > Does it drop pages unconditionally ?  What happens if I do a
> > > streaming_cat largedatabase > /dev/null while other processes
> > > are working on it ?  It's not a good thing to remove the whole
> > > cached data other apps are working on.
> >
> > Anybody could make the cache thrash. I don't see this as an
> > argument against O_STREAMING (whether explicitly activated, or
> > dynamically activated).
>
> In fact it isn't. But I don't undestand why we unconditionally
> discard a page after it has been read. Yes, I told the kernel I will
> not need it anymore, but someone else could need it. I'm not a kernel
> hacker and I don't know if this is possible: when a page is read from
> disk by a O_STR file flag it "kill me first when needed, otherwise
> leave me in memory", and if a page is already cache, just use it and
> change nothing. This will preserve data used by other processes, and
> the data I've just read if there is room. Free memory is wasted

There is almost never room. Linux fills all memory with cache
pretty soon unless you have several gigs of RAM. This is good.
The question is, what to cache and what to drop.

Come on, do you really want to find all your caches washed out
after dinner if you left your box playing MP3s? Or after you
watched MPEG?
--
vda
