Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWDZWPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWDZWPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 18:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWDZWPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 18:15:52 -0400
Received: from ns.suse.de ([195.135.220.2]:22925 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964903AbWDZWPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 18:15:50 -0400
From: Neil Brown <neilb@suse.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 27 Apr 2006 08:15:30 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17487.61698.879132.891619@cse.unsw.edu.au>
Cc: Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11] security: AppArmor - Overview
In-Reply-To: message from Stephen Smalley on Tuesday April 25
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
	<1145984831.21399.74.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I feel we have reached the stage where the questions/comments being
made are actually directly relevant to AppArmor.  I'm afraid I cannot
proceed any further now because I am not a security expert.

I would like to summarise what I think are the key points that you
have raised, and hope that someone who has a deeper understanding of
these things might answer them, or point to answers.

1/ Does AppArmor's primary mechanism of confining an application to a
  superset of it's expected behaviour actually achieve its secondary
  gaol of protecting data?

  Possibly it would be better to ask "When does ..."  as I think it is
  easy to imagine application/profile pairs that clearly cannot allow
  harm, and application/profile pairs that clearly could allow harm.

2/ What advantages does AppArmor provide over techniques involving
   virtualisation or gaol mechanisms?  Are these advantages worth
   while?

3/ Is AppArmour's approach of using d_path to get a filename from a
   dentry valid and acceptable?  If not, how can it get a path?  Can
   suitable hooks be provided so that AppArmor can get a path in an
   acceptable way at the times when that is meaningful?

I believe that these are all good questions.  The last one is the only
one that it really relevant to linux-kernel I believe, however answers
to the first two might tell us how important it is to answer that last
one. 

Thanks for your input.

NeilBrown


.... yes, I am top posting.  The mail I am responding to is below.  I
have not added any commentary in there but have left it for easy
reference so you, dear readers, can decide for yourself whether the
questions I have provided above are relevant to the preceding
discussion.

On Tuesday April 25, sds@tycho.nsa.gov wrote:
> On Tue, 2006-04-25 at 18:10 +1000, Neil Brown wrote:
> > But objects aren't the point.  Paths are.
> > The primary goal of AppArmor isn't to protect objects.
> 
> Ok, please document this throughout all AppArmor documentation and
> literature.  It will be a source of great encouragement to users.
> 
> >   That is
> > secondary.  The primary goal is to stop applications from
> > doing things that they weren't intended to do.  i.e. it is to watch
> > their behaviour and make sure it doesn't deviate from what is
> > intended.
> 
> What is intended goes beyond what names are used - it involves the
> actual objects.  When /bin/su asks to open /etc/shadow, it wants the
> real system shadow password file, not just any old file to
> which /etc/shadow might happen to resolve.  Further, even at this
> "primary" goal, AppArmor does a poor job wrt to already existing
> virtualization or jail mechanisms AFAICS.  
> 
> > This will largely have the effect of protecting data, as protecting
> > data is the intended secondary effect of AppArmor's primary mechanism
> > which is behaviour control.
> 
> No, it won't protect the data.  You can't have it both ways.  Either you
> are only controlling the use of paths and not concerned with the objects
> (if so, please document as such, but I can't imagine Crispin et al
> admitting to such a position), or you are controlling the objects and
> thus protecting the data.  
> 
> > I think this text is fairly vague, and could be taken to mean several
> > things. 
> > I think the policies do define what resources can be accessed and does
> > it using names.  "Anything with name X can be accessed".  Note that
> > AppArmor profiles never say what cannot be accessed, only what can.
> 
> Um, that's problematic then.  If I can't determine what cannot be
> accessed, then I can never know whether I have achieved my protection
> goals.
> 
> > In that sense they are not primarily protecting things so in a sense
> > they are not protecting any given file.  Nevertheless the net result
> > is an increased level of data protection.
> 
> No, only the appearance of it.
> 
> > Maybe the documentation could be improved - that wouldn't be an
> > uncommon situation.
> 
> Dollars to donuts that they won't be willing to document that AA doesn't
> protect objects in their documentation.
> 
> > > If it isn't, then is anyone and everyone free to introduce other
> > > path-based mechanisms in the kernel in the future?  Why has that been
> > > frowned upon in the past if there really isn't anything wrong with it?
> > 
> > "path-based mechanisms" like open, unlink, mkdir, ....
> > There are plenty of these in the kernel.
> 
> Pathname resolution is fine, obviously.  Regenerating pathnames in the
> kernel and using them as part of your mechanism is...interesting.  Don't
> confuse the userspace configuration and kernel-user interface with the
> internal mechanisms.  Should inotify be calling d_path internally for
> reporting to userspace?  
> 
> > "path-based mechanisms" like "You cannot truncate a file named /etc/shadow"?
> > No, that would not be appropriate in the kernel as it is not well
> > defined.
> 
> That is precisely what AppArmor does.
> 
> > However AppArmor doesn't (or shouldn't) do this.  It might say  "You
> > cannot truncate a file that you found by looking up the name
> > /etc/shadow", and I think that would be a valid and useful thing to
> > do.
> 
> AA doesn't even do that - as most of the LSM hooks don't get the
> vfsmount info propagated to them, they don't know what specific path
> your application took to the file.  
> 
> >   It might not do what you want, but that all depends on what you
> > want.   The things you can ask AppArmor to do are still useful and
> > meaningful even if they are not the things that you might ask SELinux
> > to do.
> 
> I don't see why you wouldn't use a jail-style mechanism if that is what
> you want.
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
