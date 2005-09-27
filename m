Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVI0BDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVI0BDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 21:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVI0BDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 21:03:09 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:17674 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964793AbVI0BDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 21:03:08 -0400
Date: Mon, 26 Sep 2005 21:05:22 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resource limits
Message-ID: <20050927010522.GB4522@localhost.localdomain>
References: <200509251712.42302.a1426z@gawab.com> <200509262032.14613.a1426z@gawab.com> <20050926175148.GA3797@hmsreliant.homelinux.net> <200509262326.10305.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509262326.10305.a1426z@gawab.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 11:26:10PM +0300, Al Boldi wrote:
> Neil Horman wrote:
> > On Mon, Sep 26, 2005 at 08:32:14PM +0300, Al Boldi wrote:
> > > Neil Horman wrote:
> > > > On Mon, Sep 26, 2005 at 05:18:17PM +0300, Al Boldi wrote:
> > > > > Rik van Riel wrote:
> > > > > > On Sun, 25 Sep 2005, Al Boldi wrote:
> > > > > > > Too many process forks and your system may crash.
> > > > > > > This can be capped with threads-max, but may lead you into a
> > > > > > > lock-out.
> > > > > > >
> > > > > > > What is needed is a soft, hard, and a special emergency limit
> > > > > > > that would allow you to use the resource for a limited time to
> > > > > > > circumvent a lock-out.
> > > > > >
> > > > > > How would you reclaim the resource after that limited time is
> > > > > > over ?  Kill processes?
> > > > >
> > > > > That's one way,  but really, the issue needs some deep thought.
> > > > > Leaving Linux exposed to a lock-out is rather frightening.
> > > >
> > > > What exactly is it that you're worried about here?
> > >
> > > Think about a DoS attack.
> >
> > Be more specific.  Are you talking about a fork bomb, a ICMP flood, what?
> 
> How would you deal with a situation where the system hit the threads-max 
> ceiling?
> 
Nominally I would log the inability to successfully create a new process/thread,
attempt to free some of my applications resources, and try again.

> > preventing resource starvation/exhaustion is often handled in a way thats
> > dovetailed to the semantics of how that resources is allocated (i.e. you
> > prevent syn-flood attacks differently than you manage excessive disk
> > usage).
> 
> The issue here is a general lack of proper kernel support for resource 
> limits.  The fork problem is just an example.
> 
Thats not really true.  As Mr. Helsley pointed out, CKRM is available to provide
a level of class based resource management if you need it. By default you can
also create a level of resource limitation with ulimits as I mentioned.  But no
matter what you do, the only way you can guarantee that a system will be able to
provide the resources your workload needs is to limit the number of resources
your workload asks for, and in the event it asks for too much, make sure it can
handle the denial of the resource gracefully.

Thanks and regards
Neil

> Thanks!
> 
> --
> Al
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
