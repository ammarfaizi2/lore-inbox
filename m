Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265001AbSKAM5I>; Fri, 1 Nov 2002 07:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbSKAM5I>; Fri, 1 Nov 2002 07:57:08 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:12679 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265001AbSKAM5G>; Fri, 1 Nov 2002 07:57:06 -0500
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lk@tantalophile.demon.co.uk, davidel@xmailserver.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       Linus Torvalds <torvalds@transmeta.com>, akpm@digeo.com
In-Reply-To: <20021101090034.42e207e5.rusty@rustcorp.com.au>
References: <20021031005259.GA25651@bjl1.asuk.net>
	<Pine.LNX.4.44.0210301924190.1452-100000@blue1.dev.mcafeelabs.com>
	<20021031154112.GB27801@bjl1.asuk.net>
	<1036082758.8575.81.camel@irongate.swansea.linux.org.uk> 
	<20021101090034.42e207e5.rusty@rustcorp.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 13:23:24 +0000
Message-Id: <1036157004.12551.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 22:00, Rusty Russell wrote:
>  try:
> 	for each futex in set {
> 		if (grab in userspace) {
> 			close fds;
> 			return with futex;
> 		}
> 		close old fd for futex if any
> 		call FUTEX_FD to get fd notification of futex;
> 	}
> 
> 	select on fds
> 	set = fds which are ready
> 	goto try
> 
> You could, of course, loop through the fast path once before making any
> syscalls.  Another optimization is to have FUTEX_FD reuse an existing fd
> rather than requiring the close.
> 
> Not sure I get the point about livelock though: deadlock is possible if
> apps seek multiple locks at once without care, of course.

Think about 1000 futexes where one task wants to grab them all and other
tasks want any one of them - done wrongly at that point busy traffic
will starve the 1000 futex waiter. 


