Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317596AbSFRUMg>; Tue, 18 Jun 2002 16:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317595AbSFRUMf>; Tue, 18 Jun 2002 16:12:35 -0400
Received: from dsl092-042-129.lax1.dsl.speakeasy.net ([66.92.42.129]:54534
	"EHLO mgix.com") by vger.kernel.org with ESMTP id <S317594AbSFRUMe>;
	Tue, 18 Jun 2002 16:12:34 -0400
From: <mgix@mgix.com>
To: "David Schwartz" <davids@webmaster.com>, <rml@tech9.net>
Cc: <root@chaos.analogic.com>, <Chris.Friesen@vax.home.local>,
       <cfriesen@nortelnetworks.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Question about sched_yield()
Date: Tue, 18 Jun 2002 13:12:35 -0700
Message-ID: <AMEKICHCJFIFEDIBLGOBEEEKCBAA.mgix@mgix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020618195344.AAA831@shell.webmaster.com@whenever>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Let's do a little thought experiment with 2
naive scheduling algorithms and see what happens:

Algorithm 1: the FIFO (favours those that haven't had it yet over those who already had it)
	- All ready to run processes are in a FIFO queue.
	- The top of the queue is the yielder
	- It's given a slice of CPU time to run on
	- It gives it back right away.
	- It's sent to back to the queue.
	- The next in line is a task that does real work.
	- It gets a time slice and fully uses it.
	- etc ...

Algorithm 1 will have the expected behaviour: yielders
won't consume anything, workers get it all.

Algorithm 2: the Monte-Carlo scheduler (favours no one, schedules blindly)
	- All ready to run processes are are kept in a black bag
	- The scheduler randomly grabs one out of the bag
	- It's given a slice of CPU time to run on
	- If it's a yielder, it gives the CPU right back
	- If it's an actual worker, it makes full use of the slice.
	- etc ...

Lo and behold, Algorithm 2 exhibits the same behaviour as well:
yielders get nothing since they give it all away, and workers
get it all.

Now, if I understand you well enough David, you'd like an
algorithm where the less you want the CPU, the more you get
it. I'd love if you could actually give us an outlook of
your ideal scheduler so I can try my thought experiment on it,
because from what I've understood so far, your hypothetical
scheduler would allocate all of the CPU to the yielders.

Also, since it seems to worry you: no I'm not using sched_yield
to implement pseudo-blocking behaviour.

	- Mgix

