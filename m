Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVCITt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVCITt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVCITry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:47:54 -0500
Received: from colin2.muc.de ([193.149.48.15]:49668 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262190AbVCIToC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:44:02 -0500
Date: 9 Mar 2005 20:44:01 +0100
Date: Wed, 9 Mar 2005 20:44:01 +0100
From: Andi Kleen <ak@muc.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Greg KH <greg@kroah.com>, torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309194401.GD17918@muc.de>
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de> <20050309182822.GU5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309182822.GU5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 10:28:22AM -0800, Chris Wright wrote:
> * Andi Kleen (ak@muc.de) wrote:
> > Greg KH <greg@kroah.com> writes:
> > >
> > > Rules on what kind of patches are accepted, and what ones are not, into
> > > the "-stable" tree:
> > >  - It must be obviously correct and tested.
> > >  - It can not bigger than 100 lines, with context.
> > 
> > This rule seems silly. What happens when a security fix needs 150 lines? 
> > 
> > Better maybe a rule like "The patch should be the minimal and safest 
> > change to fix an issue". But see below for an exception.
> 
> It's just a guideline to scope the work.  But a fixed size is probably
> less meaningful than your wording.
> 
> > >  - It must fix only one thing.
> > >  - It must fix a real bug that bothers people (not a, "This could be a
> > >    problem..." type thing.)
> > >  - It must fix a problem that causes a build error (but not for things
> > >    marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
> > >    security issue, or some "oh, that's not good" issue.  In short,
> > >    something critical.
> > >  - No "theoretical race condition" issues, unless an explanation of how
> > >    the race can be exploited.
> > >  - It can not contain any "trivial" fixes in it (spelling changes,
> > >    whitespace cleanups, etc.)
> > >  - It must be accepted by the relevant subsystem maintainer.
> > 
> > >  - It must follow Documentation/SubmittingPatches rules.
> > 
> > One rule I'm missing:
> > 
> > - It must be accepted to mainline. 
> 
> This can violate the principle of keeping fixes simple for -stable tree.
> And Linus/Andrew don't want to litter mainline with patch series that
> do simple fix followed by complete fix meant for developement branch.

But it risks code drift like we had in 2.4 with older kernels 
having more fixes than the newer kernel. And that way lies madness.

I think it is very very important to avoid this.

If you prefer you can rewrite the rule like

"Fix must in mainline first. In exceptional cases when the fix 
in mainline is too intrusive or risky a simpler version of the patch
can be applied to stable. In this case the mainline fix must be already
accepted. For most cases the full fix should be applied to avoid code drift"


> I agree, it's a good rule, but these should be small, temporal diffs
> from mainline.  For example, -ac tree will sometimes do the simpler fix,
> whereas mainline does proper complete fix.

You make it sound like all patches are super complicated and 
not suitable for backporting.

>From my experiences maintaining distribution kernel most mainline changes
can be just completely backported. 

> 
> > >    the security kernel team, and not go through the normal review cycle.
> > >    Contact the kernel security team for more details on this procedure.
> > 
> > This also sounds like a bad rule. How come the security team has more
> > competence to review patches than the subsystem maintainers?  I can
> > see the point of overruling maintainers on security issues when they
> > are not responsive, but if they are I think the should be still the
> > main point of contact.
> 
> They don't, the security patches should still be reviewed by subsystem
> maintainer.  Point here is, sometimes there's disclosure coordination
> happening as well.

Ok, how does it coordinate with the vendor-sec process? 
And at what point is the subsystem maintainer notified.

The security thing seems to be still quite half backed to me...

-Andi

