Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314123AbSESDfX>; Sat, 18 May 2002 23:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314128AbSESDfW>; Sat, 18 May 2002 23:35:22 -0400
Received: from slip-202-135-75-36.ca.au.prserv.net ([202.135.75.36]:1931 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314123AbSESDfV>; Sat, 18 May 2002 23:35:21 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: Your message of "Sun, 19 May 2002 13:31:55 +1000."
Date: Sun, 19 May 2002 13:38:05 +1000
Message-Id: <E179HWb-0000jY-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Um, what about delivering a SIGSEGV?  So, copy_to/from_user always
> returns 0, but a signal is delivered.  Then the only places which need
> to be clever are the mount option copying, and the signal delivery
> code for SIGSEGV (which uses copy_to_user).

Sorry, this doesn't work here either: this would return the wrong
value from read.

Of course, everyone who does more than one copy_to_user should be
checking that return value, and not doing:

	if (copy_to_user(uptr....) 
	   || copy_to_user(uptr+10,....) 
		return -EFAULT

So that such gc schemes actually work,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
