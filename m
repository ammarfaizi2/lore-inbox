Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWDUUa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWDUUa4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWDUUa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:30:56 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:23474 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751355AbWDUUal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:30:41 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Valdis.Kletnieks@vt.edu
Cc: Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <200604212006.k3LK6LtH015500@turing-police.cc.vt.edu>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <1145470463.3085.86.camel@laptopd505.fenrus.org>
	 <p73mzeh2o38.fsf@bragg.suse.de>
	 <1145522524.3023.12.camel@laptopd505.fenrus.org>
	 <20060420192717.GA3828@sorel.sous-sol.org>
	 <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	 <20060421173008.GB3061@sorel.sous-sol.org>
	 <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	 <200604212006.k3LK6LtH015500@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 21 Apr 2006 16:35:04 -0400
Message-Id: <1145651704.21749.305.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 16:06 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 21 Apr 2006 14:07:33 EDT, Stephen Smalley said:
> > On Fri, 2006-04-21 at 10:30 -0700, Chris Wright wrote:
> > > * Stephen Smalley (sds@tycho.nsa.gov) wrote:
> > > > Difficult to evaluate, when the answer whenever a flaw is pointed out is
> > > > "that's not in our threat model."  Easy enough to have a protection
> > > > model match the threat model when the threat model is highly limited
> > > > (and never really documented anywhere, particularly in a way that might
> > > > warn its users of its limitations).
> > > 
> > > I know, there's two questions.  Whether the protection model is valid,
> > > and whether the threat model is worth considering.  So far, I've not
> > > seen anything that's compelling enough to show AppArmor fundamentally
> > > broken.  Ugly and inefficient, yes...broken, not yet.
> > 
> > Access control of any form requires unambiguous identification of
> > subjects and objects in the system.   Paths don't achieve such
> > identification.  Is that broken enough?  If not, what is?  What
> > qualifies as broken?
> 
> I'd be willing to at least *listen* to an argument of the form "paths are
> in general broken, but we have constraints X, Y, and Z on the system such
> that the broken parts never manifest" (for instance, a restriction on
> hardlinks that prevents hardlinking 2 files unless the resulting security
> domains of the two paths would be identical).

IIUC, AppArmor does impose such constraints, but only from the
perspective of an individual program's profile.  Upon link(2), they
check that the program had link permission to the old link name and that
both the old link name and new link name have consistent permissions in
the profile, and they prohibit or limit by capability the ability to
manipulate the namespace by confined programs.  But this doesn't mean
that another program running under a different profile can't create such
a link (if allowed to do so by its profile, of course), or that an
unconfined process cannot do so.  There is no real "system policy" or
system-wide security properties with AppArmor; you can only look at it
in terms of individual programs (which themselves are identified by path
too).

> However, I'll say up front that such an argument would only suffice to
> move it from "broken" to "very brittle in face of changes" (for instance,
> would such a hardlink restriction cause collateral damage that an attacker
> could exploit?  How badly does it fail in the face of a misdesigned policy?)

Indeed.  I think Thomas Bleher made a good assessment of it in:
https://lists.ubuntu.com/archives/ubuntu-hardened/2006-March/000143.html

-- 
Stephen Smalley
National Security Agency

