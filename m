Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWDYRjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWDYRjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDYRjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:39:18 -0400
Received: from mx1.suse.de ([195.135.220.2]:36759 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751251AbWDYRjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:39:17 -0400
Date: Tue, 25 Apr 2006 10:34:46 -0700
From: Tony Jones <tonyj@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Joshua Brindle <method@gentoo.org>, Andi Kleen <ak@suse.de>,
       Neil Brown <neilb@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060425173446.GA28479@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17484.20906.122444.964025@cse.unsw.edu.au> <444CCE83.90704@gentoo.org> <200604241526.03127.ak@suse.de> <444CD507.70004@gentoo.org> <444CEBC9.5030802@gentoo.org> <200604251712.k3PHCbnj002821@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604251712.k3PHCbnj002821@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 01:12:37PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 24 Apr 2006 11:16:25 EDT, Joshua Brindle said:
> 
> > To make this much more real, the /usr/sbin/named policy that ships with 
> > apparmor has the following line:
> > /** r,
> > Thats right, named can read any file on the system, I suppose this is 
> > because the policy relies on named being chrooted. So if for any reason 
> > named doesn't chroot its been granted read access on the entire 
> > filesystem.
> 
> Somebody *please* tell me I hallucinated the posting that said AppArmor
> restricts the use of chroot by confined processes...

Nope. I don't believe you've been chomping on any 'shrooms. The profile must 
grant the confined task 'capability sys_chroot', even if the task already has 
that capability in it's effective set.

> In any case, the incredibly brittle behavior of this policy in the face
> of chroot() failure (from the people who should *know* how to write AppArmor
> policy, no less) is just proof of why making it simple for non-experts to
> write policy is a Bad Idea....

I believe this was addressed in another post in this thread.

But yes, without the ability to either generate an absolute pathname or to
force a chrooted task into a distinct subprofile there currently exists (as 
mentioned in the overview and patch descriptions) an issue of name collision
within the one profile.  

Improvements clearly need to be made. This was the purpose of posting for 
feedback, but it's quite the claim to go from this to your above assertion of 
"proof".

Tony
