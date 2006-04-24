Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWDXXzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWDXXzk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWDXXzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:55:40 -0400
Received: from THUNK.ORG ([69.25.196.29]:38798 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932131AbWDXXzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:55:39 -0400
Date: Mon, 24 Apr 2006 23:52:17 +0000
From: "Theodore Ts'o" <tytso@mit.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Neil Brown <neilb@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060424235215.GA5893@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Stephen Smalley <sds@tycho.nsa.gov>, Neil Brown <neilb@suse.de>,
	Chris Wright <chrisw@sous-sol.org>,
	James Morris <jmorris@namei.org>,
	Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de> <1145522524.3023.12.camel@laptopd505.fenrus.org> <20060420192717.GA3828@sorel.sous-sol.org> <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil> <20060421173008.GB3061@sorel.sous-sol.org> <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil> <17484.20906.122444.964025@cse.unsw.edu.au> <20060424070324.GA14720@thunk.org> <1145912876.14804.91.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145912876.14804.91.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 05:07:56PM -0400, Stephen Smalley wrote:
> > The goal of protecting against broken, buggy applications is a worthy
> > one.  If people can show that for a large set of stack overruns, or
> > other types of buggy applications, it is possible to evade AppArmor by
> > doing something clever, then AppArmor would need to be fixed or it's
> > not worth doing.  But if it can prevent a large class of buggy
> > applications from allowing an atttacker to escalate that bugginess
> > into a system penetration, then it has added value.
> 
> Does it have any hope of stopping an attacker who has designed his
> attack with full knowledge of AppArmor's design and implementation (no
> security through obscurity)?

Well, it also depends on your threat model, right?  What capabilities
are you assuming the attacker will have?  Does the attacker have an
account on the system?  Or has the attacker just exploited a stack
overrun in a network daemon, or a failure to check some input field
coming from the network, and the goal is to stop the attacker from
escalating that to gaining full root privs on the system.  

There is a big difference between assuming the attacker has full
knowledge of AppArmor's design and implementation, which granted, is a
fair assumpion (no security through obsecurity) and assuming the
attacker has full root privs, and still wanting to stop them (i.e.,
mandatory access controls).  You seem to be judging AppArmor with the
goals of SELinux, and that's not necessarily a fair comparison.   

A Hummer can go through 36 inches of standing water, where as a Prius
can not.  Does that mean that a Prius is a failure?  Only if you judge
it by the standards of the Hummer.  But from point of view of gas
mileage, the Prius will run circles around the Hummer....

> The problems with path-based mechanisms are technical in nature, not
> just philosophical.

If you restrict namespaces and chroot, then it solves that particular
problem.  It will be useless for software packages that use
namespaces, such as for example if a hypothetical future version of a
propietary source code management tool decided to use shared subtree
support.  There are however a huge number of software packages,
including most commercial/propietary packages that have to work across
a broad range of heterogenous systems, including AIX, Solaris, and
Linux, that won't be using namespaces and shared subtrees anytime
soon.

						- Ted
