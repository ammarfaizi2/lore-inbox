Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWD1MX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWD1MX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 08:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWD1MX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 08:23:56 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:9374 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1030368AbWD1MXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 08:23:53 -0400
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11]
	security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andi Kleen <ak@suse.de>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Ken Brush <kbrush@gmail.com>,
       Neil Brown <neilb@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <200604281347.28185.ak@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <ef88c0e00604271058q203d0553sf45401914a892799@mail.gmail.com>
	 <1146223713.11817.7.camel@moss-spartans.epoch.ncsc.mil>
	 <200604281347.28185.ak@suse.de>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 28 Apr 2006 08:28:19 -0400
Message-Id: <1146227299.11817.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 13:47 +0200, Andi Kleen wrote:
> On Friday 28 April 2006 13:28, Stephen Smalley wrote:
> 
> > So you are only worried about script kiddies?  Further, once someone
> > crafts an exploit specifically targeting AA, knowing full well its
> > limitations, that exploit will become fodder for the kiddies as well.
> > If a security mechanism only prevents attacks that weren't designed
> > against it, what good is it aside from a temporary stopgap?
> 
> The same could be said about selinux. Or what are you doing
> to e.g. stop DOS attacks? Nothing is 100% water tight. The question
> is just if the subsets of controls it implements matches the requirements of 
> the administrator. These requirements both include easiness of use
> and security. Usually there is a tradeoff there and it's not the
> same for everybody.

I can't say I follow your reasoning.  AA and SELinux are both access
control mechanisms; DOS attacks are largely outside the scope of either.
They are both concerned with preventing unauthorized disclosure of
information (confidentiality) and unauthorized modification of data
(integrity), not with ensuring availability of service.  Neither will be
perfect in achieving such goals, but we can legitimately ask whether one
mechanism is so fundamentally flawed as to never be able to achieve the
goals in the face of an adversary with full knowledge of the mechanism.
And I think that AA qualifies here, again due to incomplete mediation
(so the attacker knows precisely where to strike) and ambiguous
identifiers (so the attacker knows precisely how to overcome the
intended protection).

Let's suppose that SELinux and AA are both widely deployed and used, and
attackers therefore craft attacks targeting each of them.  In the
SELinux case, let's say they find a flaw in the policy configuration,
and exploit it.  Solution?  Improve the policy configuration.  No
mechanism change required.  In the AA case, same issue applies to
situations where only the profile is in error.  But if the attacker
exploits the absence of mediation of a given operation in AA, or
exploits the use of ambiguous identifiers, then there is no fix for AA
without revisiting the base mechanism, and in the latter case at least,
revisiting the design.  See the difference?  That's not to say that
people won't find flaws in each, but the question is whether one is
fundamentally limited by design, and whether this means that ultimately
AA will cease to be relevant as a protection mechanism because attackers
will simply evolve to attack its inherent limitations.  I don't see an
evolutionary path for AA; it is a dead end by its own design.

-- 
Stephen Smalley
National Security Agency

