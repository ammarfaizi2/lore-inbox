Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262299AbSI1Scw>; Sat, 28 Sep 2002 14:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262306AbSI1Scw>; Sat, 28 Sep 2002 14:32:52 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:33798 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262299AbSI1Scv>; Sat, 28 Sep 2002 14:32:51 -0400
Date: Sat, 28 Sep 2002 19:38:06 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Sleeping function called from illegal context...
Message-ID: <20020928183806.GA56692@compsoc.man.ac.uk>
References: <20020927233044.GA14234@kroah.com> <1033174290.23958.17.camel@phantasy> <20020928145418.GB50842@compsoc.man.ac.uk> <3D95E14D.9134405C@digeo.com> <20020928172449.GA54680@compsoc.man.ac.uk> <1033237664.22582.167.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033237664.22582.167.camel@phantasy>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17vMTf-000M7E-00*2PFRvzUgQ/w* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 02:27:44PM -0400, Robert Love wrote:

> > NMI interrupt handler cannot block so it trylocks against a spinlock
> > instead. Buffer processing code needs to block against concurrent NMI
> > interrupts so takes the spinlock for them. All actual blocks on the
> > spinlock are beneath a down() on another semaphore, so a sleep whilst
> > holding the spinlock won't actually cause deadlock.
> 
> If all accesses to the spinlock are taken under a semaphore, then the
> spinlock is not needed (i.e. the down'ed semaphore provides the same
> protection), or am I missing something?
> 
> If this is not the case - e.g. there are other accesses to these locks -
> then you cannot sleep, no?

The other accessors are spin_trylock()ers, as I mentioned. They will not
block but they are not under the semaphore.

The spinlock cannot be a semaphore because NMI interrupts do not take to
kindly to up()

regards
john

-- 
"When your name is Winner, that's it. You don't need a nickname."
	- Loser Lane
