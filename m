Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVAGOSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVAGOSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVAGOSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:18:41 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:32654 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261420AbVAGOQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:16:53 -0500
Message-Id: <200501071416.j07EGoa4018080@localhost.localdomain>
To: Christoph Hellwig <hch@infradead.org>
cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 07 Jan 2005 13:04:07 GMT."
             <20050107130407.GA8119@infradead.org> 
Date: Fri, 07 Jan 2005 09:16:50 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.197.185.179] at Fri, 7 Jan 2005 08:16:52 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, Jan 07, 2005 at 07:56:02AM -0500, Paul Davis wrote:
>> 2) this is *not* only about scheduling. Realtime tasks need
>> mlockall() and/or mlock as well. even the man page for mlock
>> recognizes this, yet almost all the discussion here has focused on
>> scheduling. 
>
>RLIMIT_MEMLOCK is your friend.

rlimit_memlock limits the *amount* of memory that mlock() can be used
on, not whether mlock can be used. at least, thats my understanding of
the POSIX design for this. the man page and the source code for mlock
support make that reasonably clear.

moreover, AFAIK all the issues that existed for granting capabilities
exist for rlimit-based priviledges. if they are not granted to all
users/processes, how are they granted, and can they controlled by a
non-root process? last time i looked, the hard limit used by rlimits is
system-wide. you want to copy that idea from OSX or not?

>it doesn't really matter what you want, but how we can implement
>something that fits in the kernel design.

"realtime" LSM does fit into the kernel, quite demonstrably so. it
doesn't, it appears, fit into *your* idea of kernel design.

>> 4) christoph's claims about OS X are nothing but ridiculous. whatever
>> the internals of Darwin may or may not be (and they certainly include
>> some of the best ideas about media-friendly kernels from the last 20
>> years, unlike our favorite OS), professional people are using OS X
>
>professional people are also using Windows or Solaris.  That doesn't
>mean we have to copy every bad idea from them.

I didn't say "copy every idea from them". The point of "realtime" LSM
is precisely *not* to copy every idea from them - instead of every
user being able to run RT apps, only specifically root-administered
uids and/or gids can.

>And we have told you that this solution is not okay.  You can spend

You, Christoph, have told us that. There is no "we" here. You provided
no rationale other than "uid/gid based privildge control is the wrong
method". 

>more time whining which won't do anything or you could help brainstorming
>how to implement a workable solution.

We (Jack, Torben and others on LAD) did brainstorm. We were told on
lkml that LSM was the right way to do this kind of things these days,
because capabilities were broken. But you don't like LSM, so now,
totally post-facto you're telling us that this is not a "workable
solution."

Newsflash: its a totally workable and working solution, and its one
that distributions will adopt whether you get paid or i suck up and
ask you nicely offline. The question was whether we could make
distributions' and users' lives a little easier by not requiring them
to download additional stuff first. Apparently, your unexplained
convictions about the right and wrong way to grant priviledges,
(something that no OS has ever really gotten its head around except
VMS (maybe)), is more important.

Fine, we'll continue to tell people to use "realtime" LSM for audio
work. The people this really affects probably won't use vanilla
kernels anyway. 

--p


