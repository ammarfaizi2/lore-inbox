Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbTB1GcC>; Fri, 28 Feb 2003 01:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTB1GcC>; Fri, 28 Feb 2003 01:32:02 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:59365 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267542AbTB1GcA>; Fri, 28 Feb 2003 01:32:00 -0500
Date: Fri, 28 Feb 2003 12:17:25 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software Suspend Functionality in 2.5
Message-ID: <20030228121725.B2241@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1046238339.1699.65.camel@laptop-linux.cunninghams> <20030227181220.A3082@in.ibm.com> <1046369790.2190.9.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1046369790.2190.9.camel@laptop-linux.cunninghams>; from ncunningham@clear.net.nz on Fri, Feb 28, 2003 at 07:16:31AM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 07:16:31AM +1300, Nigel Cunningham wrote:
> Hi.
> 
> I've looked at LKCD and seen that they have a provision for compressing
> the pages which are written. Ideally, I'd like to see us sharing code
> because I reckon there's a fair bit in common between the two projects.
> For the moment, though, I haven't seriously considered implementing
> compression. I've just been concentrating on getting things as stable as
> possible under 2.4 (given that there's no driver model there), and
> beginning to seek to port the changes to 2.5. Perhaps compression could
> be added later, but I am worrying about the basics (getting the pages
> saved in any form!) first.

The thought was that with compression you can copy more pages 
into the same free memory space; meaning that you need to 
free up far less pages. If you are lucky enough, you might 
get to resume from very close to the state you suspended and 
hence avoid the initial sluggishness on resume.

But yes, you've rightly guessed that my question did stem from 
what we are doing on LKCD. People have asked me if we could 
reuse swsusp logic, and even I'd thought about that way back 
when swsusp started for 2.5. I remember talking to Pavel about 
it last year at OLS - hoping it could save some work for 
us :) 

The problem was that we have to deal with far more stringent 
conditions in a crash dump situation, and the very things that 
seemed like interesting ideas or neat twists in swsusp (like 
the trick of freeing-up enough pages to be able to an atomic 
suspend-to-ram, or maybe even the refridgerator concept), 
just couldn't work or apply in that situation. 

Aside of the fact that we can't swapout at that point of 
time, we do want a near-exact snapshot of memory. And we are 
ambitious enough to want to be able to snapshot full memory 
or as close as possible to that, if so required.

Since we've had to work on a solution that can be used 
for accurate non-disruptive dumps as well as crash dumps
(the latter using kexec), I was wondering whether it 
was worth exploring possibilities of commonality with 
swsusp down the line ... I know its not probably not 
something very immediate, but just an indication on 
whether we should keep applicability for swsusp (probably 
reuse and share ideas/code back and forth between the 
two efforts) in mind as we move forward. Because we 
have to support a more restrictive situation when it 
comes to dumping, it just may be usable by swsusp too 
if we can get it right.

Regards
Suparna

> 
> On Fri, 2003-02-28 at 01:42, Suparna Bhattacharya wrote:
> > Nigel,
> > 
> > When I noticed some of your discussions on swsusp mailing
> > list earlier, a question that crossed my mind was whether
> > you'd thought about the possibility of compression of data 
> > at the time of copy. 
> > 
> > Would that have been another way to helped achieve the 
> > objective you have in mind ? Do any issues come to mind ?
> > 
> > Regards
> > Suparna
> > 
> 
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

