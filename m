Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbTGEVzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 17:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266518AbTGEVzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 17:55:00 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:20943 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S266517AbTGEVys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 17:54:48 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: 2.5.74-mm1
Date: Sun, 6 Jul 2003 00:10:25 +0200
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <200307052309.12680.phillips@arcor.de> <20030705214413.GA28824@mail.jlokier.co.uk>
In-Reply-To: <20030705214413.GA28824@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307060010.26002.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 July 2003 23:44, Jamie Lokier wrote:
> Daniel Phillips wrote:
> > Unfortunately, negative priority requires root privilege, at least
> > on Debian.
> >
> > That's dumb.  By default, the root privilege requirement should kick
> > in at something like -5 or -10, so ordinary users can set priorities
> > higher than the default, as well as lower.  For the millions of
> > desktop users out there, sound ought to work by default, not be
> > broken by default.
>
> The security problem, on a multi-user box, is that negative priority
> apps can easily take all of the CPU and effectively lock up the box.

I don't see that: the solution is to set the niceness any essential process 
more negative than is possible for a normal user, which is just what we have 
now.  The stupid thing is the making the most negative possible and the 
default niceness the same.  What are you going to do if you have one 
application you want to take priority, re-nice the other 50?

An alternate solution is to allow the user to specify the default niceness.  
For all I know, there is such a way.  If not, there ought to be, and it 
should be higher than the superuser cutoff by default.  Then the sound app 
will come along and grab the highest priority it can, and it will actually 
succeed in obtaining a higher priority than garden variety processes, which 
is not what happens now.

> Something I've often thought would fix this is to allow normal users
> to set negative priority which is limited to using X% of the CPU -
> i.e. those tasks would have their priority raised if they spent more
> than a small proportion of their time using the CPU.

That's essentially SCHED_RR.  As I mentioned above, it's not clear to me why 
SCHED_RR requires superuser privilege, since the amount of CPU you can burn 
that way is bounded.  Well, the total of all SCHED_RR processes would need to 
be bounded as well, which is straightforward.

Regards,

Daniel

