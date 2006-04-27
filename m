Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751716AbWD0Wi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbWD0Wi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWD0Wi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:38:56 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:17027 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751716AbWD0Wiz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:38:55 -0400
Date: Thu, 27 Apr 2006 15:38:24 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chris Wright <chrisw@sous-sol.org>, Karl MacMillan <kmacmillan@tresys.com>,
       Andi Kleen <ak@suse.de>, Ken Brush <kbrush@gmail.com>,
       Neil Brown <neilb@suse.de>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060427223824.GE2909@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17487.61698.879132.891619@cse.unsw.edu.au> <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com> <200604270615.20554.ak@suse.de> <20060427101734.GH3026@sorel.sous-sol.org> <1146153827.5238.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146153827.5238.47.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> Even in the absence of any "unconfined" processes, the potential for
> collusion among multiple "confined" processes (via coordinated attack)
> shouldn't be overlooked.  Thus, the base mechanism needs to be resilient
> in the face of such collusion.

Yes, good point.

> > I guess it's worth noting the AA atack is stopped by SELinux, while the
> > opposite is also true.  A 'cp /etc/shadow /tmp; mv /tmp/shadow /etc' done
> > by an unconfined process doesn't effect AA, while it kills the type
> > label on /etc/shadow and could be an effective policy breach.  In each
> > case somewhat subtle (i.e. not explicit relabel or policy change) can
> > have holes.
> 
> Not sure about the example here, as the type in that case would actually
> be lost upon the cp by the unconfined process to the /tmp location, in
> which case you have an issue for both AA and SELinux - the data has
> become accessible under a different name and label which may now be
> accessible beyond the original intent.

Point is, names matter as much as inodes do.  And it's possible to
get improperly labelled data in canonical location for object (i.e.
/etc/shadow).  Certainly requires unconfined help, but real people do
things like that w/out fully understanding the impact.  You can fix the
normal tools, but not all one-off admin tools.

> If you had used appropriate
> options to cp to preserve the attribute, then it would have preserved
> the type throughout the transaction.

Hehe, why would I do that if I'm trying to get unconfined process to
break the label? ;-)

> Of course, the real problem here
> is that you have an unconfined process copying the data at all, at which
> point you have no real guarantees about it, and the loss in label is the
> least of your worries.

That's my point.  You can't meaningfully reason about the security of
the system with unconfined processes.
