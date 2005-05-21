Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVEUAsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVEUAsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 20:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVEUAsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 20:48:52 -0400
Received: from colo.lackof.org ([198.49.126.79]:29318 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261196AbVEUAs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 20:48:28 -0400
Date: Fri, 20 May 2005 18:51:39 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, akpm@osdl.org,
       T-Bone@parisc-linux.org, varenet@parisc-linux.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: patch tulip-natsemi-dp83840a-phy-fix.patch added to -mm tree
Message-ID: <20050521005139.GB2411@colo.lackof.org>
References: <200505101955.j4AJtX9x032464@shell0.pdx.osdl.net> <42881C58.40001@pobox.com> <20050516050843.GA20107@colo.lackof.org> <4288CE51.1050703@pobox.com> <20050516222612.GD9282@colo.lackof.org> <428E3372.403@pobox.com> <20050520211229.GA2411@colo.lackof.org> <428E57E2.2090204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428E57E2.2090204@pobox.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 05:34:26PM -0400, Jeff Garzik wrote:
> Yes, tg3 is awful in this regard.  I have made a bit of progress by 
> moving some of the stuff into a workqueue.

ah good! At some point I should re-install the fiber bcm5701 cards
I have and see if they work better then.

> >It's totally relevant.
> >Complaints (bug reports) and patches drive change.  That's how both
> >commercial *and* non-commercial developers prioritize.
> >
> >"Ingo and the real-time crowd" are a good example of a change
> >in priorities driven by non-commercial users.
> 
> No, these are commercial users.  Embedded space really cares about this 
> stuff.

Sorry - maybe VM support for VIVT cache is a better example?
(I'm thinking sparc/parisc support)

Almost everything I think of has some form of commercial interest
either directly (embedded, HA, infiniband, Server IO, ia64/amd64, etc)
or indirectly (sponsorships at Universities or sourceforge projects).

> >Understood. But they were not the first ones. Donald Becker has a fairly
> >well known digust for use of CPU spin loops.  But we can't eliminate
> >*all* udelay just becuase of the way HW is designed and has bugs.
> >I think it would be reasonable to get rid of many udelay calls
> >(replace them with PCI read delay loops like Donald has advocated)
> >and get the rest into a context where it matters less.
> >I have no objection to people fixing those sorts of issues.
> 
> If you recognize the issue, you should object to new changes adding new 
> issues!

And ignore fixes for existing issues.
"The enemy of good is perfect"

...
> >Not true. This patch brings the tulip driver into compliance with
> >published specs and makes the driver functional for parisc/mips/ia64 users.
> 
> Ok, yes, it fixes the tulip issue AND causes work for others.

But it's not new work.

In timer.c, tulip_restart_rxtx() is called right after tulip_select_media().
tulip_restart_rxtx() has a potential 1300 usec delay loop. About
the same as the code in tulip_select_media() needs.

I now appreciate much more that a RH employee (IIRC, John Linville)
submitted that patch indirectly on my behalf. I filed the original
bugzilla and provided the patch based on work by Charlie Brett.


> >The "whatever reason" is clearly decided by the mainline kernel maintainer.
> >If we treat other people's labor as "free", then the right answer is
> >to drop the patch and wait for some subset of "we" to do the extra legwork.
> 
> Um, this is how all kernel development works :)

*nod*

> Maintainers are not supposed to merge patches into upstream, if they 
> have flaws still remaining to be corrected.

Many patches are not this black and white.
All patches have to survive at least one subjective evaluation:
	Is the cure worse than the illness?


> >Several people care if tulip phy init works right. OTOH, I'm only aware of
> >one person who specifically cares if tulip is holding the CPU hostage for
> >1 or 2 ms during the occasional phy init.
> >
> >Is being a technology purist more important than moving forward with
> >what people care about?
> 
> There will _always_ be ugly patches that get hardware going for some users.

"ugly" is subjective.  Especially in the context of tulip phy init sequence.
Anyone who finds beauty in that chunk of code is truly twisted. :^)

(It just reflects the ugly mess of HW that too many vendors shipped.
I don't ever expect tulip driver to be "clean" here.)

> Tons of changes are kept outside the kernel until they are ready.  This 
> is just one more example.
> 
> Merging code into the kernel is a big deal.  That code will have to be 
> maintained for years, maybe decades.  "when in doubt, don't merge" is 
> generally the right answer.

Agreed.

> I don't want your patch to become an issue that embedded developers must 
> address (like the tg3 example above), causing further patching and 
> headache in that area.

Certainly. No problem with that.

BTW, which embedded developers still care about tulip driver?
One could use this patch as a litmus test to see how much they care. :^)

I was expecting they'd be using gigabit NICs, Wi-Fi, GSM,
or bluetooth these days.

thanks,
grant
