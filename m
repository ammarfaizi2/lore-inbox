Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVI0FLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVI0FLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 01:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVI0FLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 01:11:04 -0400
Received: from dial169-154.awalnet.net ([213.184.169.154]:14084 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S964810AbVI0FLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 01:11:03 -0400
From: Al Boldi <a1426z@gawab.com>
To: Neil Horman <nhorman@tuxdriver.com>, Matthew Helsley <matthltc@us.ibm.com>
Subject: Re: Resource limits
Date: Tue, 27 Sep 2005 08:08:21 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200509251712.42302.a1426z@gawab.com> <200509262326.10305.a1426z@gawab.com> <20050927010522.GB4522@localhost.localdomain>
In-Reply-To: <20050927010522.GB4522@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509270808.21821.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
> On Mon, Sep 26, 2005 at 11:26:10PM +0300, Al Boldi wrote:
> > Neil Horman wrote:
> > > On Mon, Sep 26, 2005 at 08:32:14PM +0300, Al Boldi wrote:
> > > > Neil Horman wrote:
> > > > > On Mon, Sep 26, 2005 at 05:18:17PM +0300, Al Boldi wrote:
> > > > > > Rik van Riel wrote:
> > > > > > > On Sun, 25 Sep 2005, Al Boldi wrote:
> > > > > > > > Too many process forks and your system may crash.
> > > > > > > > This can be capped with threads-max, but may lead you into a
> > > > > > > > lock-out.
> > > > > > > >
> > > > > > > > What is needed is a soft, hard, and a special emergency
> > > > > > > > limit that would allow you to use the resource for a limited
> > > > > > > > time to circumvent a lock-out.
> > > > > > >
> > > > > > > How would you reclaim the resource after that limited time is
> > > > > > > over ?  Kill processes?
> > > > > >
> > > > > > That's one way,  but really, the issue needs some deep thought.
> > > > > > Leaving Linux exposed to a lock-out is rather frightening.
> > > > >
> > > > > What exactly is it that you're worried about here?
> > > >
> > > > Think about a DoS attack.
> > >
> > > Be more specific.  Are you talking about a fork bomb, a ICMP flood,
> > > what?
> >
> > How would you deal with a situation where the system hit the threads-max
> > ceiling?
>
> Nominally I would log the inability to successfully create a new
> process/thread, attempt to free some of my applications resources, and try
> again.

Consider this dilemma:
Runaway proc/s hit the limit.
Try to kill some and you are denied due to the resource limit.
Use some previously running app like top, hope it hasn't been killed by some 
OOM situation, try killing some procs and another one takes it's place 
because of the runaway situation.
Raise the limit, and it gets filled by the runaways.
You are pretty much stuck.

You may get around the problem by a user-space solution, but this will always 
run the risks associated with user-space.

> > The issue here is a general lack of proper kernel support for resource
> > limits.  The fork problem is just an example.
>
> Thats not really true.  As Mr. Helsley pointed out, CKRM is available

Matthew Helsley wrote:
> 	Have you looked at Class-Based Kernel Resource Managment (CKRM)
> (http://ckrm.sf.net) to see if it fits your needs? My initial thought is
> that the CKRM numtasks controller may help limit forks in the way you
> describe.

Thanks for the link!  CKRM is great!

Is there a CKRM-lite version?  This would make it easier to be included into 
the mainline, something that would concentrate on the pressing issues, like 
lock-out prevention, and leave all the management features as an option.

Thanks!

--
Al

