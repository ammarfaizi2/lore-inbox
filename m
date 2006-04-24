Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWDXET2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWDXET2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 00:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWDXET2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 00:19:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:1245 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751503AbWDXET1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 00:19:27 -0400
From: Neil Brown <neilb@suse.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon, 24 Apr 2006 14:18:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17484.20906.122444.964025@cse.unsw.edu.au>
Cc: Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
In-Reply-To: message from Stephen Smalley on Friday April 21
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	<1145470463.3085.86.camel@laptopd505.fenrus.org>
	<p73mzeh2o38.fsf@bragg.suse.de>
	<1145522524.3023.12.camel@laptopd505.fenrus.org>
	<20060420192717.GA3828@sorel.sous-sol.org>
	<1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	<20060421173008.GB3061@sorel.sous-sol.org>
	<1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday April 21, sds@tycho.nsa.gov wrote:
> On Fri, 2006-04-21 at 10:30 -0700, Chris Wright wrote:
> > * Stephen Smalley (sds@tycho.nsa.gov) wrote:
> > > Difficult to evaluate, when the answer whenever a flaw is pointed out is
> > > "that's not in our threat model."  Easy enough to have a protection
> > > model match the threat model when the threat model is highly limited
> > > (and never really documented anywhere, particularly in a way that might
> > > warn its users of its limitations).
> > 
> > I know, there's two questions.  Whether the protection model is valid,
> > and whether the threat model is worth considering.  So far, I've not
> > seen anything that's compelling enough to show AppArmor fundamentally
> > broken.  Ugly and inefficient, yes...broken, not yet.
> 
> Access control of any form requires unambiguous identification of
> subjects and objects in the system.   Paths don't achieve such
> identification.  Is that broken enough?  If not, what is?  What
> qualifies as broken?

I have to disagree with this.  Paths *do* achieve unambiguous
identification of something.  That something is ..... the path.

Think about the name of this system for a minute.  "AppArmor".
i.e. it is Armour for an Application.  It protects the application.
It doesn't (as far as I can tell: I'm not an expert and don't work on
this thing) claim to protect files.  It protects applications.

It protects them from doing the wrong thing - from doing something
they weren't designed to do.  i.e. it protects them from being
subverted by exploiting a bug.

A large part of the behaviour of an application is the path names that
it uses and what it does with them.  If an application started doing
unexpected things with unexpected paths (e.g. exec("/bin/sh") or
open("/etc/shadow",O_RDONLY)) then this is a sure sign that it has
been subverted and that AppArmor need to protect it, from itself.

Obviously the protection will not be complete.  The profiles describe
what the application is expected to do, and to some extent, this
description will be in general terms.  It might identify files that
can be written to, but not what will be written to them. etc.

While the protection against subversion cannot be complete, it can be
sufficient to dramatically reduce the chances of privilege
escalation.   There are lots of wrong things you can get an
application to do once you find an exploitable bug.  Many of these
will lead to a crash.  AppArmor will not try to protect against these
(I suspect).  There are substantially fewer that lead to privilege
escalation.   AppArmor focusses its effort in terms of profile design
on exactly these sorts of unplanned behaviours.

So I think you still haven't given convincing evidence that AppArmor
is broken by design.

NeilBrown
