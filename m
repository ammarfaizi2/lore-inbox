Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317103AbSEXHQO>; Fri, 24 May 2002 03:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317104AbSEXHQN>; Fri, 24 May 2002 03:16:13 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:8628 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317103AbSEXHQM>; Fri, 24 May 2002 03:16:12 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] XBUG(comment) BUG enhancement 
In-Reply-To: Your message of "Fri, 24 May 2002 02:49:06 -0400."
             <20020524024906.A1547@redhat.com> 
Date: Fri, 24 May 2002 17:19:51 +1000
Message-Id: <E17B9Me-00019p-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020524024906.A1547@redhat.com> you write:
> On Fri, May 24, 2002 at 03:24:30PM +1000, Rusty Russell wrote:
> >   __asm__ __volatile__(	"ud2\n"		\
> > -			"\t.word %c0\n"	\
> > +			"\t.long %c0\n"	\
> >  			"\t.long %c1\n"	\
> > -			 : : "i" (__LINE__), "i" (__FILE__))
> > +			 : : "i" (__stringify(__LINE__)), "i" (__FILE__))
> 
> This part I can't agree with: changing the line number to a string 
> results in excess pollution of the data segment with useless strings 
> that are frequently duplicates.  Why not leave it as a number?

To unify the trap handler to handle both cases.  If you really think
this is unacceptable bloat, please measure the difference, then use
line number zero or something for XBUG and place the comment string at
in a third .long.

But I was lazy, and this was tested...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
