Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317575AbSFMKNo>; Thu, 13 Jun 2002 06:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317574AbSFMKNn>; Thu, 13 Jun 2002 06:13:43 -0400
Received: from mail.webmaster.com ([216.152.64.131]:8878 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317573AbSFMKNk> convert rfc822-to-8bit; Thu, 13 Jun 2002 06:13:40 -0400
From: David Schwartz <davids@webmaster.com>
To: <kernel@tekno-soft.it>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Thu, 13 Jun 2002 03:13:36 -0700
In-Reply-To: <5.1.1.6.0.20020613104128.02c119a0@mail.tekno-soft.it>
Subject: Re: Developing multi-threading applications
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020613101337.AAA26116@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jun 2002 11:08:27 +0200, Roberto Fichera wrote:
>You are right! But "computational intensive" is not totaly right as I say ;-
>),

	It's really not fair to change the premises in the middle of an argument.

>because most of thread are waiting for I/O,

	Still wrong. You don't tie up threads waiting for I/O. You can wait without 
having a thread doing the waiting.

>after I/O are performed the
>computational intensive tasks, finished its work all the result are sent
>to thread-father,

	Okay, so you need a new abstraction -- separate the waiting from the 
working. Create as many threads to do the work as you have processors to do 
the work on. As for the waiting, minimize threads waiting, they're pure 
overhead. If it's sockets, use 'poll' so one thread can do lots of waiting.

>the father collect all the child's result and perform some
>computational work and send its result to its father and so on with many
>thread-father controlling other child. So I think the main problem/overhead
>is thread creation and the thread's numbers.

	So get rid of the problem! Don't create so many threads, create only as many 
threads as can do useful work and reuse them rather than destroying and 
recreating them. Solve the actual problem/overhead since it's totally 
artificial and due to your model rather than your problem!

	DS


