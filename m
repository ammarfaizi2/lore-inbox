Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSEaRqj>; Fri, 31 May 2002 13:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316531AbSEaRqi>; Fri, 31 May 2002 13:46:38 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:54146 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S316477AbSEaRqh>; Fri, 31 May 2002 13:46:37 -0400
Date: Fri, 31 May 2002 19:46:34 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: do_mmap
In-Reply-To: <ad8bvv$3tr$1@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.05.10205311941360.10681-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--snip/snip

> >> is it possible to have 0 as a valid address? - if not, this should
> >> be the return on errors.
> >
> >SuS explicitly says that 0 is not a valid mmap return address.
> 
> But if so, SuS is _very_ _very_ wrong.
> 
> The fact is, if you use something like vm86 mode, you absolutely _need_
> to be able to explicitly mmap at address 0. 
> 
> So it is correct (and in fact there is no other sane way to do it) to
> say
> 
> 	addr = mmap(NULL, 1024*1024,
> 		PROT_READ | PROT_WRITE ,
> 		MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED,
> 		-1, 0);
> 
> and if SuS says that mmap must not return NULL for this case, then SuS
> is so full of sh*t that it's not worth worrying about.
> 
> In short, under Linux 0 _is_, and will always be (at least on x86) a
> perfectly valid return address from mmap() and friends. It's only going
> to be returned when you explicitly ask for it with MAP_FIXED, but it
> absolutely is a valid return.

ok. so 0 or (NULL) is not an option, and also unnneccessary once someone
know how the error retun is used. - wouldn't it be much more cleaner
to convert this _ugly_ unsigned long vals into void * wherever these vals
are carrying an address? (well at least for do_mmap*) and use ERR_PTR
for returning, and IS_ERR for checking for an error?

btw, is err should (according to alans explaination be):

	return (unsigned long)ptr > (unsigned long)-1024UL;

	tm

-- 
in some way i do, and in some way i don't.

