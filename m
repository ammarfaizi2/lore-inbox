Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVCISci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVCISci (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVCISaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:30:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:7588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262169AbVCIS2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:28:43 -0500
Date: Wed, 9 Mar 2005 10:28:22 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309182822.GU5389@shell0.pdx.osdl.net>
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1sm35w3am.fsf@muc.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@muc.de) wrote:
> Greg KH <greg@kroah.com> writes:
> >
> > Rules on what kind of patches are accepted, and what ones are not, into
> > the "-stable" tree:
> >  - It must be obviously correct and tested.
> >  - It can not bigger than 100 lines, with context.
> 
> This rule seems silly. What happens when a security fix needs 150 lines? 
> 
> Better maybe a rule like "The patch should be the minimal and safest 
> change to fix an issue". But see below for an exception.

It's just a guideline to scope the work.  But a fixed size is probably
less meaningful than your wording.

> >  - It must fix only one thing.
> >  - It must fix a real bug that bothers people (not a, "This could be a
> >    problem..." type thing.)
> >  - It must fix a problem that causes a build error (but not for things
> >    marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
> >    security issue, or some "oh, that's not good" issue.  In short,
> >    something critical.
> >  - No "theoretical race condition" issues, unless an explanation of how
> >    the race can be exploited.
> >  - It can not contain any "trivial" fixes in it (spelling changes,
> >    whitespace cleanups, etc.)
> >  - It must be accepted by the relevant subsystem maintainer.
> 
> >  - It must follow Documentation/SubmittingPatches rules.
> 
> One rule I'm missing:
> 
> - It must be accepted to mainline. 

This can violate the principle of keeping fixes simple for -stable tree.
And Linus/Andrew don't want to litter mainline with patch series that
do simple fix followed by complete fix meant for developement branch.

> That is what big enterprise distributions often require and I think
> it's a good rule. Otherwise you risk code and feature set drift
> and we don't want to repeat the 2.4 mistakes again where some 
> subsystems had more fixes in 2.4 than 2.6.

I agree, it's a good rule, but these should be small, temporal diffs
from mainline.  For example, -ac tree will sometimes do the simpler fix,
whereas mainline does proper complete fix.

> Also your rules encourage to do different patches for -stable
> (e.g. with less comment changes etc.) than for mainline. I don't
> think that's a very good thing. Sometimes it is unavoidable
> and sometimes the mainline patches are just too big and intrusive,
> but in general it's imho best to apply the same patches
> to mainline and backport trees.  This has also the advantage
> that the patch is best tested as possible; slimmed down patches
> usually have a risk of malfunction.
> 
> If a mainline patch violates too many of your other rules
> ("Fixes one thing; doesn't do cosmetic changes etc.") perhaps
> the mainline patch just needs to be improved.

Good point.

> So in general there should be a preference to apply the same
> patch as mainline, unless it is very big.

Agreed.

> >  - Security patches will be accepted into the -stable tree directly from
> >    the security kernel team, and not go through the normal review cycle.
> >    Contact the kernel security team for more details on this procedure.
> 
> This also sounds like a bad rule. How come the security team has more
> competence to review patches than the subsystem maintainers?  I can
> see the point of overruling maintainers on security issues when they
> are not responsive, but if they are I think the should be still the
> main point of contact.

They don't, the security patches should still be reviewed by subsystem
maintainer.  Point here is, sometimes there's disclosure coordination
happening as well.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
