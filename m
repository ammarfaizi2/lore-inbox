Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316531AbSEaR5T>; Fri, 31 May 2002 13:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSEaR5S>; Fri, 31 May 2002 13:57:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52495 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316531AbSEaR5R>; Fri, 31 May 2002 13:57:17 -0400
Date: Fri, 31 May 2002 10:56:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: do_mmap
In-Reply-To: <Pine.GSO.4.05.10205311941360.10681-100000@mausmaki.cosy.sbg.ac.at>
Message-ID: <Pine.LNX.4.33.0205311051080.3816-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 31 May 2002, Thomas 'Dent' Mirlacher wrote:
> 
> ok. so 0 or (NULL) is not an option, and also unnneccessary once someone
> know how the error retun is used. - wouldn't it be much more cleaner
> to convert this _ugly_ unsigned long vals into void * wherever these vals
> are carrying an address? (well at least for do_mmap*) and use ERR_PTR
> for returning, and IS_ERR for checking for an error?

Using ERR_PTR/PTR_ERR/IS_ERR is probably the correct thing to do, but 
that codebase predates the "error pointer" macros by about 9 years ;)

> btw, is err should (according to alans explaination be):
> 
> 	return (unsigned long)ptr > (unsigned long)-1024UL;

The 1000 vs 1024 thing is just another "random number". I don't know what
the right number is myself, it may be worth trying to pick one that is
uniformly easy to test against, for example. Many architectures are better
at some constants than others.

		Linus

