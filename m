Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317527AbSFRSAm>; Tue, 18 Jun 2002 14:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317526AbSFRSAl>; Tue, 18 Jun 2002 14:00:41 -0400
Received: from mail.webmaster.com ([216.152.64.131]:12430 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317524AbSFRSAk> convert rfc822-to-8bit; Tue, 18 Jun 2002 14:00:40 -0400
From: David Schwartz <davids@webmaster.com>
To: <rml@tech9.net>, Chris Friesen <cfriesen@nortelnetworks.com>
CC: <mgix@mgix.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Tue, 18 Jun 2002 11:00:39 -0700
In-Reply-To: <1024420400.3090.202.camel@sinai>
Subject: Re: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020618180040.AAA21856@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Exactly.  The reason the behavior is odd is not because the sched_yield
>task is getting any CPU, David.  I realize sched_yield is not equivalent
>to blocking.

	Good.

>The reason this behavior is suspect is because the task is receiving a
>similar amount of CPU to tasks that are _not_ yielding but in fact doing
>useful work for the entire duration of their timeslice.

	This is the same error repeated again. Since you realize that an endless 
loop on sched_yield is *not* equivalent to blocking, why do you then say "in 
fact doing useful work"? By what form of ESP is the kernel supposed to 
determine that the sched_yield task is not 'doing useful work' and the other 
task is?

	The kernel doesn't know the loop is endless. For all it knows, as soon as 
another process gets a drop of CPU, the yielding process may be able to 
succeed. And because the yielding process is being nice (by yielding), it 
should get better and better treatment over processes that are burning CPU 
rather than yielding.

>A task that continually uses its timeslice vs one that yields should
>easily receive a greater amount of CPU, but this is not the case.

	Why should the mean task get preferential treatment over the nice task when 
both are always ready-to-run?

	DS


