Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVI0MJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVI0MJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVI0MJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:09:04 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:3596 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750703AbVI0MJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:09:02 -0400
Date: Tue, 27 Sep 2005 08:08:40 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Al Boldi <a1426z@gawab.com>
Cc: Matthew Helsley <matthltc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Resource limits
Message-ID: <20050927120840.GA5947@hmsreliant.homelinux.net>
References: <200509251712.42302.a1426z@gawab.com> <200509262326.10305.a1426z@gawab.com> <20050927010522.GB4522@localhost.localdomain> <200509270808.21821.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509270808.21821.a1426z@gawab.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 08:08:21AM +0300, Al Boldi wrote:
> Neil Horman wrote:
> > On Mon, Sep 26, 2005 at 11:26:10PM +0300, Al Boldi wrote:
> > > Neil Horman wrote:
> > > > On Mon, Sep 26, 2005 at 08:32:14PM +0300, Al Boldi wrote:
> > > > > Neil Horman wrote:
> > > > > > On Mon, Sep 26, 2005 at 05:18:17PM +0300, Al Boldi wrote:
> > > > > > > Rik van Riel wrote:
> > > > > > > > On Sun, 25 Sep 2005, Al Boldi wrote:
> > > > > > > > > Too many process forks and your system may crash.
> > > > > > > > > This can be capped with threads-max, but may lead you into a
> > > > > > > > > lock-out.
> > > > > > > > >
> > > > > > > > > What is needed is a soft, hard, and a special emergency
> > > > > > > > > limit that would allow you to use the resource for a limited
> > > > > > > > > time to circumvent a lock-out.
> > > > > > > >
> > > > > > > > How would you reclaim the resource after that limited time is
> > > > > > > > over ?  Kill processes?
> > > > > > >
> > > > > > > That's one way,  but really, the issue needs some deep thought.
> > > > > > > Leaving Linux exposed to a lock-out is rather frightening.
> > > > > >
> > > > > > What exactly is it that you're worried about here?
> > > > >
> > > > > Think about a DoS attack.
> > > >
> > > > Be more specific.  Are you talking about a fork bomb, a ICMP flood,
> > > > what?
> > >
> > > How would you deal with a situation where the system hit the threads-max
> > > ceiling?
> >
> > Nominally I would log the inability to successfully create a new
> > process/thread, attempt to free some of my applications resources, and try
> > again.
> 
> Consider this dilemma:
> Runaway proc/s hit the limit.
> Try to kill some and you are denied due to the resource limit.
> Use some previously running app like top, hope it hasn't been killed by some 
> OOM situation, try killing some procs and another one takes it's place 
> because of the runaway situation.
> Raise the limit, and it gets filled by the runaways.
> You are pretty much stuck.
> 
Not really, this is the sort of thing ulimit is meant for.  To keep processes
from any one user from running away.  It lets you limit the damage it can do,
until such time as you can control it and fix the runaway application.

> You may get around the problem by a user-space solution, but this will always 
> run the risks associated with user-space.
> 
Ulimit isn't a user-space solution, its a user-_based_ restriction mechanism for
resources.  It allows you to prevent user X (or group X, IIRC) from creating
more than A MB of files, or B processes, or allocating C KB of memory, etc.  man
3 ulimit.


> > > The issue here is a general lack of proper kernel support for resource
> > > limits.  The fork problem is just an example.
> >
> > Thats not really true.  As Mr. Helsley pointed out, CKRM is available
> 
> Matthew Helsley wrote:
> > 	Have you looked at Class-Based Kernel Resource Managment (CKRM)
> > (http://ckrm.sf.net) to see if it fits your needs? My initial thought is
> > that the CKRM numtasks controller may help limit forks in the way you
> > describe.
> 
> Thanks for the link!  CKRM is great!
> 
> Is there a CKRM-lite version?  This would make it easier to be included into 
> the mainline, something that would concentrate on the pressing issues, like 
> lock-out prevention, and leave all the management features as an option.
> 
> Thanks!
> 
> --
> Al

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
