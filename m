Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSEMGqd>; Mon, 13 May 2002 02:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315857AbSEMGqc>; Mon, 13 May 2002 02:46:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45210 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315856AbSEMGqb>;
	Mon, 13 May 2002 02:46:31 -0400
Date: Mon, 13 May 2002 12:03:23 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: torvalds@transmeta.com
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Segfault hidden in list.h
Message-ID: <20020513120323.A1265@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <Pine.LNX.4.44.0205121805220.15392-100000@home.transmeta.com> Linus Torvalds wrote:

> On Sun, 12 May 2002, David S. Miller wrote:
>> However, if the list manipulation had some memory barriers
>> added to it...

> That would just make _those_ much slower, with some very doubtful end
> results.

I agree. In most cases, list.h macros will be used under lock and
putting barriers there will penalize the common case.


> Show me numbers, and show me readable source, and show me a proof that the
> memory ordering actually works, and I may consider lockless algorithms
> worthwhile. As it is, they are damn fragile and require more care that I
> personally care to expect out of 99.9% of all programmers.
> And I'm sure as hell not going to put any lockless stuff in functions
> meant for "normal human consumption". If we create list macros like that,
> they had better be called "lockless_list_add_be_damn_careful_about_it()"
> rather than "list_add()".

It isn't really necessary to to put memeory barriers in list macros
for use with RCU. In many data structures, list traversal is done in
only one direction and therefore memory barriers can be put after
list_add() or such macros. If indeed traversal is more complicated
than that, it might not be a good idea to do lockfree traversal in
the first place.

As for readable lockless algorithms, sure they exist. See
http://prdownloads.sourceforge.net/lse/rt_rcu-2.5.3-1.patch.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
