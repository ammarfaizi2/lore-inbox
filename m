Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbSKABvx>; Thu, 31 Oct 2002 20:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262212AbSKABvw>; Thu, 31 Oct 2002 20:51:52 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:9719 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S265538AbSKABvq>; Thu, 31 Oct 2002 20:51:46 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC8B6@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Davide Libenzi'" <davidel@xmailserver.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: RE: Unifying epoll,aio,futexes etc. (What I really want from epol
	l)
Date: Thu, 31 Oct 2002 17:56:49 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> everything easier. I don't really see futex creation/destroy 
> as an high
> frequency event that might be suitable for optimization. 
> Usually you have
> your own set of resources to be "protected" and in 95% of 
> cases you know
> those resources from the beginning.

If with inititialization you mean taking the slow path ...

... then that depends. If you have futexes with an small contention rate,
you will be initializing and destroying futexes over and over again all the
time [eg: futex is unlocked, somebody acquires it [no init], then somebody
acquires it [init], then two releases in a row, then same thing, over and
over]. I have seen that behaviour, and that is specially true when you go up
to a lot of threads.

In fact, this is one of the main killers for the priority based futex
implementation I am trying to figure out ... I allocate a _big_ array the
first time I take the slow path for a futex - and that is ugly when you go
up to many futexes that have a low contention rate. I need to devise some
kind of smart caching or some way to take care of that case.

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]



