Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315216AbSEQA2r>; Thu, 16 May 2002 20:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315227AbSEQA2q>; Thu, 16 May 2002 20:28:46 -0400
Received: from [202.135.142.194] ([202.135.142.194]:10507 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315216AbSEQA2o>; Thu, 16 May 2002 20:28:44 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix BUG macro 
In-Reply-To: Your message of "Thu, 16 May 2002 12:21:44 +0100."
             <Pine.LNX.4.21.0205161154410.1036-100000@localhost.localdomain> 
Date: Fri, 17 May 2002 10:31:41 +1000
Message-Id: <E178Ven-0007jA-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.21.0205161154410.1036-100000@localhost.localdomain> you 
write:
> On Thu, 16 May 2002, Rusty Russell wrote:
> 
> > Replaces filename with object name.  Sure, it's not as canonical, but
> > it means that ccache works across different directories (at the
> > moment, ccache gets almost no caceh hits when you compile in a
> > different dir).
> 
> __STRINGIZE(KBUILD_BASENAME) sounds good, except in inline
> function from header file; perhaps that's why you're adding
> __FUNCTION__, which will waste a lot of space.

Um, show me where sizeof(KBUILD_BASENAME) + sizeof(__FUNCTION__) >
sizeof(__FILENAME__).

>  Suggest you
> should test __INCLUDE_LEVEL__: use __STRINGIZE(KBUILD_BASENAME)
> at __INCLUDE_LEVEL__ 0, __FUNCTION__ at included levels?

That'd be cute.  Of course best would be using KBUILD_BASENAME (which
means BUG() in a header works correclty) and make BUG() take a string
arg.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
