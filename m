Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263908AbRFNSa1>; Thu, 14 Jun 2001 14:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263894AbRFNSaS>; Thu, 14 Jun 2001 14:30:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64525 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263887AbRFNSaL>; Thu, 14 Jun 2001 14:30:11 -0400
Subject: Re: threading question
To: kmacy@netapp.com (Kip Macy)
Date: Thu, 14 Jun 2001 19:28:32 +0100 (BST)
Cc: ognen@gene.pbi.nrc.ca, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10106121200330.20809-100000@orbit-fe.eng.netapp.com> from "Kip Macy" at Jun 12, 2001 12:06:40 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Abr6-00057R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> just processes that share the same address space. Their performance is
> measurably worse than it is on most commercial Unixes and FreeBSD.

Actually their performance is massively superior. But that is because we were
not stupid enough to burden the kernel with all of the posix pthread crap.
Pthreads is an ugly compromise API that can be badly implemented in both
userland and kernel space. Unfortunately its also a standard.

So you have two choices
1.	Pthread performance is poorer due to library glue
2.	Every single signal delivery is 20% slower threaded or otherwise due
	to all the crap that it adds 
	And it does damage to other calls too.

In the big picture #1 is definitely preferable. 

There are really only two reasons for threaded programming. 

- Poor programmer skills/language expression of event handling

- OS implementation flaws (and yes the posix/sus unix api has some of these)

Co-routines or better language choices are much more efficient ways to express
the event handling problem.

fork() is often a better approach than pthreads at least for the design of an
SMP threaded application because unless you explicitly think about what you
share you will never get the cache affinity you need for good performance.

And if you don't care about cache affinity then you shouldnt care about
pthread_create overhead because quite frankly pthread_create overhead is easily
mitigated (thread cache) and in most real world applications considerably less
of an performance hit

Alan

