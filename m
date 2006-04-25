Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751616AbWDYQlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbWDYQlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWDYQlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:41:16 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:43401 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751611AbWDYQlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:41:15 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Neil Brown <neilb@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20060424235215.GA5893@thunk.org>
References: <1145470463.3085.86.camel@laptopd505.fenrus.org>
	 <p73mzeh2o38.fsf@bragg.suse.de>
	 <1145522524.3023.12.camel@laptopd505.fenrus.org>
	 <20060420192717.GA3828@sorel.sous-sol.org>
	 <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	 <20060421173008.GB3061@sorel.sous-sol.org>
	 <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	 <17484.20906.122444.964025@cse.unsw.edu.au>
	 <20060424070324.GA14720@thunk.org>
	 <1145912876.14804.91.camel@moss-spartans.epoch.ncsc.mil>
	 <20060424235215.GA5893@thunk.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Apr 2006 12:45:33 -0400
Message-Id: <1145983533.21399.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 23:52 +0000, Theodore Ts'o wrote:
> On Mon, Apr 24, 2006 at 05:07:56PM -0400, Stephen Smalley wrote:
> > Does it have any hope of stopping an attacker who has designed his
> > attack with full knowledge of AppArmor's design and implementation (no
> > security through obscurity)?
> 
> Well, it also depends on your threat model, right?  What capabilities
> are you assuming the attacker will have?  Does the attacker have an
> account on the system?  Or has the attacker just exploited a stack
> overrun in a network daemon, or a failure to check some input field
> coming from the network, and the goal is to stop the attacker from
> escalating that to gaining full root privs on the system. 

AppArmor doesn't do a very good job there either; its mediation is very
incomplete (nothing over IPC or many other inter-process operations),
and its ambiguous identification of objects leaves it prone to
coordinated attacks.  Why not just use a jail-style mechanism if that is
what you want, ala VServer or OpenVZ?

> There is a big difference between assuming the attacker has full
> knowledge of AppArmor's design and implementation, which granted, is a
> fair assumpion (no security through obsecurity) and assuming the
> attacker has full root privs, and still wanting to stop them (i.e.,
> mandatory access controls).  You seem to be judging AppArmor with the
> goals of SELinux, and that's not necessarily a fair comparison.   

But AA specifically emphasizes that it controls capabilities so that
even a uid 0 process is "confined" by it.  

> If you restrict namespaces and chroot, then it solves that particular
> problem.  It will be useless for software packages that use
> namespaces, such as for example if a hypothetical future version of a
> propietary source code management tool decided to use shared subtree
> support.  There are however a huge number of software packages,
> including most commercial/propietary packages that have to work across
> a broad range of heterogenous systems, including AIX, Solaris, and
> Linux, that won't be using namespaces and shared subtrees anytime
> soon.

pam_namespace in Fedora Core.  Not to mention that the restrictions you
mention only solve the problem within the jail, which is fine if we are
only talking about jail mechanisms.  Not so good for any kind of real
MAC.

-- 
Stephen Smalley
National Security Agency

