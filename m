Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWDYVUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWDYVUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWDYVUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:20:42 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:18651 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751570AbWDYVUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:20:41 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tony Jones <tonyj@suse.de>
Cc: Andi Kleen <ak@suse.de>, jwcart2@epoch.ncsc.mil,
       Neil Brown <neilb@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060425181158.GB28479@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <17485.55676.177514.848509@cse.unsw.edu.au>
	 <1145968949.17374.10.camel@moss-lions.epoch.ncsc.mil>
	 <200604251443.57885.ak@suse.de>
	 <1145977265.21399.16.camel@moss-spartans.epoch.ncsc.mil>
	 <20060425181158.GB28479@suse.de>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Apr 2006 17:25:09 -0400
Message-Id: <1146000309.21399.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 11:11 -0700, Tony Jones wrote:
> Maybe it will have to grow to handle more operations.  SELinux has grown in
> terms of it's features and what it protects.  Clearly you have benefitted
> from being open sourced for an extended period of time.  I'm sure you'd love
> to debate the history of this :) but there doesn't seem much productive point.

Well, for what it is worth, I think that even in its first public
release in 2000, SELinux provided mediation of more operations than AA
does even now, even if we exclude network controls from consideration
(since SubDomain had some form of network controls in the past that were
temporarily dropped due to LSM limitations).

> But I agree, it isn't clear how the AA scheme applies to all forms of kernel
> operations.

Yes, and this is the real point - it is a question of whether the
underlying model (if it can even be said to have one) generalizes.  With
SELinux, there is a well-defined model and it does generalize.  With AA,
I just don't see it.

> Because it presumes that the application can easily be configured to function
> in a jail.

I'd expect even more compatibility issues with AA-style access controls
than a jail/virtualization approach.

> How do you propose handling in a namespace the ability to create new files.
> I can see how you could perhaps create a fixed scratch area inside the 
> namespace, but what if the application wants to create /var/lib/foo/bar.xxx
> 
> You have obviously read the AppArmor docs. How would you propose to handle 
> (approximately) the expressiveness of AppArmor policy. Also what does 
> /srv/www/htdocs/**.html equate to when this namespace is configured for the 
> application. Does the task need to be torn down and restarted if you populate 
> more files?
> 
> The issue of namespaces being a better way of doing all of this has been raised
> a couple of times.  It is an interesting idea for sure. I responded to one of
> the posts with the same (above) questions but havn't yet seen a reply.

I don't know whether existing jail/virtualization solutions can fully
replicate your functionality, but be careful not to confuse the actual
requirements with your current implementation and UI.  And you have to
weigh the gains in robustness against any potential loss in
expressiveness.

> Other LSM hooks are an option also.  Clearly if we can add new hooks at more
> optimal locations where pathnames are available it would be preferable to
> the current scheme and (qualifier: the devil is in the details) probably 
> preferable to trying to pass vfsmounts fully into the existing hooks.

Not sure what this would look like, but if your module still ends up
calling d_path or equivalent on every open, then it seems problematic
regardless.

-- 
Stephen Smalley
National Security Agency

