Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVAGM4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVAGM4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVAGM4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:56:23 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:11410 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261397AbVAGM4J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:56:09 -0500
Message-Id: <200501071256.j07Cu24a017948@localhost.localdomain>
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Wed, 05 Jan 2005 10:21:11 EST."
             <1104938472.8589.8.camel@krustophenia.net> 
Date: Fri, 07 Jan 2005 07:56:02 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.197.185.179] at Fri, 7 Jan 2005 06:56:04 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just read the thread of messages about this, and I am just
dumbfounded. Jack O'Quin has very politely explained the whole thing,
and it appears that almost nobody actually paid attention to what 
he was saying.

1) capabilities: it has been explained by several people that
capabilities do not work, and in the past there has been an utter lack
of interest on the part of the kernel crowd to fix them, sometimes
even going as far as "it can't be fixed".

2) this is *not* only about scheduling. Realtime tasks need
mlockall() and/or mlock as well. even the man page for mlock
recognizes this, yet almost all the discussion here has focused on
scheduling. 

3) christoph claims that using uid/gid to define priviledge scope
is a bad idea. but that is the *desired* method. uid/gid corresponds exactly
to what the users of these systems want. they don't want priviledge
accorded to specific applications - its the *users* not the
applications that have the right to get RT scheduling, lock down
memory and so on. these applications will run without RT priviledges,
just not very well (in general, so badly that they are unusable for
their intended purpose).

4) christoph's claims about OS X are nothing but ridiculous. whatever
the internals of Darwin may or may not be (and they certainly include
some of the best ideas about media-friendly kernels from the last 20
years, unlike our favorite OS), professional people are using OS X
(like they used OS 9 and OS 8 before) to get serious, paid work done
in a way that they cannot on Linux. and if attitudes like christoph's
prevail, in a way that they will never get to do on Linux without
going through steps that they will consider absurd. Alan jokes (i
presume) "oh, thats easy, make everyone root", but thats not what OS X
does. OS X says "we know that running realtime applications matters
for a broad class of our likely users, and so anyone can do it, not
just root". And note: "realtime applications" does not mean just
"rt-scheduled", as noted above.

5) setuid wrappers don't work for this, because even though you can
change the scheduling class of another process, you cannot "grant" it
the ability to use mlock. at least not without capabilities, so back
to (1) above ...

So, what do we have here? The two most successful media-friendly OS's
(BeOS and OS X) demonstrate clearly the way things need to be from the
user experience perspective, a development community within the Linux
world evolves a solution using the very nice new security modules in
2.6, and then people who don't appear to understand anything about
what is required or what the use cases are say "i don't like and
because nobody pays me i don't have to tell you why".

I've spent probably burnt through to $250,000 supporting myself and my
family over the last 5 years while I develop pro-level audio software
for Linux. I don't expect to see any of that back. So when Christoph
chimes in with the "I'm not paid, I don't have to tell you why I don't
like it, I just don't" ... that really, really, really irritates me in
a way that few other comments do.

We (Jack, Lee and now myself) have tried to explain what the problem
with the kernel is, how LSM makes a solution possible, acknowledged
issues and attempted to address them, and finally have offered up a
working patch that makes life easier for a bunch of people who don't
want to run webservers or compile kernels all day. If you're going to
publically argue that what the "realtime" LSM does should not be part
of the kernel, at least do us the favor of showing us enough respect
to provide technical or policy based reasons for why its such a bad
solution. 

--p
