Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWDYILQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWDYILQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWDYILQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:11:16 -0400
Received: from ns2.suse.de ([195.135.220.15]:26017 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750981AbWDYILO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:11:14 -0400
From: Neil Brown <neilb@suse.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue, 25 Apr 2006 18:10:36 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17485.55676.177514.848509@cse.unsw.edu.au>
Cc: Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
In-Reply-To: message from Stephen Smalley on Monday April 24
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	<1145470463.3085.86.camel@laptopd505.fenrus.org>
	<p73mzeh2o38.fsf@bragg.suse.de>
	<1145522524.3023.12.camel@laptopd505.fenrus.org>
	<20060420192717.GA3828@sorel.sous-sol.org>
	<1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	<20060421173008.GB3061@sorel.sous-sol.org>
	<1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	<17484.20906.122444.964025@cse.unsw.edu.au>
	<1145911526.14804.71.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday April 24, sds@tycho.nsa.gov wrote:
> On Mon, 2006-04-24 at 14:18 +1000, Neil Brown wrote:
> > On Friday April 21, sds@tycho.nsa.gov wrote:
> > > On Fri, 2006-04-21 at 10:30 -0700, Chris Wright wrote:
> > > > * Stephen Smalley (sds@tycho.nsa.gov) wrote:
> > > > > Difficult to evaluate, when the answer whenever a flaw is pointed out is
> > > > > "that's not in our threat model."  Easy enough to have a protection
> > > > > model match the threat model when the threat model is highly limited
> > > > > (and never really documented anywhere, particularly in a way that might
> > > > > warn its users of its limitations).
> > > > 
> > > > I know, there's two questions.  Whether the protection model is valid,
> > > > and whether the threat model is worth considering.  So far, I've not
> > > > seen anything that's compelling enough to show AppArmor fundamentally
> > > > broken.  Ugly and inefficient, yes...broken, not yet.
> > > 
> > > Access control of any form requires unambiguous identification of
> > > subjects and objects in the system.   Paths don't achieve such
> > > identification.  Is that broken enough?  If not, what is?  What
> > > qualifies as broken?
> > 
> > I have to disagree with this.  Paths *do* achieve unambiguous
> > identification of something.  That something is ..... the path.
> 
> A path is not an object; it is a way of referring to an object.  No need
> to reason about this abstractly - just look at the kernel's internal
> model; where are these mystical path objects and how are they
> implemented?  And as a way of referring to an object, paths are
> ambiguous identifiers.  Further, that ambiguity is leveraged by AppArmor
> to e.g. support multiple profiles for the same program via alternate
> paths.

But objects aren't the point.  Paths are.
The primary goal of AppArmor isn't to protect objects.  That is
secondary.  The primary goal is to stop applications from
doing things that they weren't intended to do.  i.e. it is to watch
their behaviour and make sure it doesn't deviate from what is
intended.   The usage of names is a significant element of the
behaviour of the application, so AppArmor watches what names an
application uses and stops it from using names that it isn't
authorised to use.

Again, it is *not* about protecting data (primarily).  It is about
stopping an application from doing what it isn't expected do.

This will largely have the effect of protecting data, as protecting
data is the intended secondary effect of AppArmor's primary mechanism
which is behaviour control.

> 
> > Think about the name of this system for a minute.  "AppArmor".
> > i.e. it is Armour for an Application.  It protects the application.
> > It doesn't (as far as I can tell: I'm not an expert and don't work on
> > this thing) claim to protect files.  It protects applications.
> 
> >From the AppArmor overview on the novellforge page:
> "AppArmor security policies completely define what system resources
> individual applications can access..."
> 
> >From the AppArmor FAQ:
> "AppArmor profiles are human-readable text files that mediate access to
> files and directories..."
> 
> Isn't that claiming to protect files?  If not, please make sure the end
> user documentation clearly says "AppArmor is not designed to protect
> files."

I think this text is fairly vague, and could be taken to mean several
things. 
I think the policies do define what resources can be accessed and does
it using names.  "Anything with name X can be accessed".  Note that
AppArmor profiles never say what cannot be accessed, only what can.
In that sense they are not primarily protecting things so in a sense
they are not protecting any given file.  Nevertheless the net result
is an increased level of data protection.

Maybe the documentation could be improved - that wouldn't be an
uncommon situation.

> 
> > It protects them from doing the wrong thing - from doing something
> > they weren't designed to do.  i.e. it protects them from being
> > subverted by exploiting a bug.
> > 
> > A large part of the behaviour of an application is the path names that
> > it uses and what it does with them.  If an application started doing
> > unexpected things with unexpected paths (e.g. exec("/bin/sh") or
> > open("/etc/shadow",O_RDONLY)) then this is a sure sign that it has
> > been subverted and that AppArmor need to protect it, from itself.
> 
> Um, no.  You are trying to protect the rest of the system from
> misbehavior by the application.  You aren't protecting the application
> at all - you have already said it has been subverted, and it is then
> free to corrupt or leak any information it normally has legitimate
> access to.  And since you don't care about information flow, you can't
> actually guarantee that the rest of the system isn't corrupted by the
> application misbehavior; any of your unconfined processes may become the
> conduit by which the corruption spills over into the rest of the system.

I have a knife with which to eat my dinner, but the moment I move
it more than 10cm from my plate, a robotic hand reaches out and
immobilised my hand and hence the knife.  Who is being protected?

Not me I guess, because the sinful desire to kill has already taken
over my brain, though maybe I am being protected from life in prison
for murder.

Not you because you could still come and jump onto my knife and impale
yourself, or someone could grab your arm and drag your wrist along the
blade spilling much of your blood.

So maybe nobody is being protected.  But somehow, fewer people die
when the robot arm is active.

This is how AppArmor works.  It doesn't try to guarantee that no file
will be corrupted or leak.  It doesn't try to ensure that no bug can ever
be exploited.  But it does try to minimise harm.  And it succeeds.

And remember, the robot didn't grab the knife.  It grabbed my hand.
That is a bit like checking pathnames rather than inodes.  It doesn't
provide a guarantee of "knife will not enter a body" just as AppArmor
doesn't guarantee that "file will not be changed".  But is still tends
to produce the desired result.

> 
> > While the protection against subversion cannot be complete, it can be
> > sufficient to dramatically reduce the chances of privilege
> > escalation.   There are lots of wrong things you can get an
> > application to do once you find an exploitable bug.  Many of these
> > will lead to a crash.  AppArmor will not try to protect against these
> > (I suspect).  There are substantially fewer that lead to privilege
> > escalation.   AppArmor focusses its effort in terms of profile design
> > on exactly these sorts of unplanned behaviours.
> 
> I don't see how it achieves such prevention with the limitations I've
> already noted, which are design limitations, not just characteristics of
> the implementation.
> 

I don't see how you can say that.  If you can stop a process from
calling
  exec("/bin/sh"),
and there is no doubt that AppArmor can implement that policy for you,
then you have achieved a degree of prevention.  It is clearly not
complete.   There are a great many more things that AppArmor can
prevent an application from performing.  Each one increases the level
of prevention.  Maybe it doesn't reach 100% prevention of all
undesirable acts.  But it is still useful.

> > So I think you still haven't given convincing evidence that AppArmor
> > is broken by design.
> 
> If it isn't, then is anyone and everyone free to introduce other
> path-based mechanisms in the kernel in the future?  Why has that been
> frowned upon in the past if there really isn't anything wrong with it?

"path-based mechanisms" like open, unlink, mkdir, ....
There are plenty of these in the kernel.

"path-based mechanisms" like "You cannot truncate a file named /etc/shadow"?
No, that would not be appropriate in the kernel as it is not well
defined.
However AppArmor doesn't (or shouldn't) do this.  It might say  "You
cannot truncate a file that you found by looking up the name
/etc/shadow", and I think that would be a valid and useful thing to
do.  It might not do what you want, but that all depends on what you
want.   The things you can ask AppArmor to do are still useful and
meaningful even if they are not the things that you might ask SELinux
to do.

NeilBrown

[Opinions in this article are mine and do not necessarily reflect the
 official position of SuSE, Novell, or anyone else.  They might not 
 even be mine tomorrow...]
