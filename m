Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWDYRCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWDYRCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWDYRCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:02:41 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:37520 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932267AbWDYRCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:02:40 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Neil Brown <neilb@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <17485.55676.177514.848509@cse.unsw.edu.au>
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
	 <17485.55676.177514.848509@cse.unsw.edu.au>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Apr 2006 13:07:11 -0400
Message-Id: <1145984831.21399.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 18:10 +1000, Neil Brown wrote:
> But objects aren't the point.  Paths are.
> The primary goal of AppArmor isn't to protect objects.

Ok, please document this throughout all AppArmor documentation and
literature.  It will be a source of great encouragement to users.

>   That is
> secondary.  The primary goal is to stop applications from
> doing things that they weren't intended to do.  i.e. it is to watch
> their behaviour and make sure it doesn't deviate from what is
> intended.

What is intended goes beyond what names are used - it involves the
actual objects.  When /bin/su asks to open /etc/shadow, it wants the
real system shadow password file, not just any old file to
which /etc/shadow might happen to resolve.  Further, even at this
"primary" goal, AppArmor does a poor job wrt to already existing
virtualization or jail mechanisms AFAICS.  

> This will largely have the effect of protecting data, as protecting
> data is the intended secondary effect of AppArmor's primary mechanism
> which is behaviour control.

No, it won't protect the data.  You can't have it both ways.  Either you
are only controlling the use of paths and not concerned with the objects
(if so, please document as such, but I can't imagine Crispin et al
admitting to such a position), or you are controlling the objects and
thus protecting the data.  

> I think this text is fairly vague, and could be taken to mean several
> things. 
> I think the policies do define what resources can be accessed and does
> it using names.  "Anything with name X can be accessed".  Note that
> AppArmor profiles never say what cannot be accessed, only what can.

Um, that's problematic then.  If I can't determine what cannot be
accessed, then I can never know whether I have achieved my protection
goals.

> In that sense they are not primarily protecting things so in a sense
> they are not protecting any given file.  Nevertheless the net result
> is an increased level of data protection.

No, only the appearance of it.

> Maybe the documentation could be improved - that wouldn't be an
> uncommon situation.

Dollars to donuts that they won't be willing to document that AA doesn't
protect objects in their documentation.

> > If it isn't, then is anyone and everyone free to introduce other
> > path-based mechanisms in the kernel in the future?  Why has that been
> > frowned upon in the past if there really isn't anything wrong with it?
> 
> "path-based mechanisms" like open, unlink, mkdir, ....
> There are plenty of these in the kernel.

Pathname resolution is fine, obviously.  Regenerating pathnames in the
kernel and using them as part of your mechanism is...interesting.  Don't
confuse the userspace configuration and kernel-user interface with the
internal mechanisms.  Should inotify be calling d_path internally for
reporting to userspace?  

> "path-based mechanisms" like "You cannot truncate a file named /etc/shadow"?
> No, that would not be appropriate in the kernel as it is not well
> defined.

That is precisely what AppArmor does.

> However AppArmor doesn't (or shouldn't) do this.  It might say  "You
> cannot truncate a file that you found by looking up the name
> /etc/shadow", and I think that would be a valid and useful thing to
> do.

AA doesn't even do that - as most of the LSM hooks don't get the
vfsmount info propagated to them, they don't know what specific path
your application took to the file.  

>   It might not do what you want, but that all depends on what you
> want.   The things you can ask AppArmor to do are still useful and
> meaningful even if they are not the things that you might ask SELinux
> to do.

I don't see why you wouldn't use a jail-style mechanism if that is what
you want.

-- 
Stephen Smalley
National Security Agency

