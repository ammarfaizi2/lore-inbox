Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWD0P7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWD0P7Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWD0P7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:59:25 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:34959 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S965161AbWD0P7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:59:24 -0400
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11]
	security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Andi Kleen <ak@suse.de>,
       Ken Brush <kbrush@gmail.com>, Neil Brown <neilb@suse.de>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060427101734.GH3026@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <17487.61698.879132.891619@cse.unsw.edu.au>
	 <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com>
	 <200604270615.20554.ak@suse.de>  <20060427101734.GH3026@sorel.sous-sol.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 27 Apr 2006 12:03:47 -0400
Message-Id: <1146153827.5238.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 03:17 -0700, Chris Wright wrote:
>   This means that policy which allows a subject the ability
> to write to the object whose handle is /tmp/my_unimportant_tmpfile may be
> a security problem if somebody in the system was tricked into a simple 'ln
> /etc/shadow /tmp/my_unimportant_tmpfile.'  In this case it's surprising
> that the same inode can have different permissions (esp. given traditional
> DAC uid/gid and mode bits are kept in inode) depending upon path taken.
> 
> The AA stance is that the policy will protect the confined process from
> doing such namespace manipulations eliminating the possibiilty of the
> confined process and giving itself a mechanism to privilege escalation.
> This is reasonable with the caveat that the channels available to the
> confined process to collude with (or coerce) an unconfined process are
> still pretty high-bandwidth.  One could argue that having unconfined
> processes is ill-advised.  SELinux targeted policy has the same basic
> issue (channel richness notwithstanding), which is why I'd expect truely
> security sensitive environments would use a strict policy.

Even in the absence of any "unconfined" processes, the potential for
collusion among multiple "confined" processes (via coordinated attack)
shouldn't be overlooked.  Thus, the base mechanism needs to be resilient
in the face of such collusion.

> I guess it's worth noting the AA atack is stopped by SELinux, while the
> opposite is also true.  A 'cp /etc/shadow /tmp; mv /tmp/shadow /etc' done
> by an unconfined process doesn't effect AA, while it kills the type
> label on /etc/shadow and could be an effective policy breach.  In each
> case somewhat subtle (i.e. not explicit relabel or policy change) can
> have holes.

Not sure about the example here, as the type in that case would actually
be lost upon the cp by the unconfined process to the /tmp location, in
which case you have an issue for both AA and SELinux - the data has
become accessible under a different name and label which may now be
accessible beyond the original intent.  If you had used appropriate
options to cp to preserve the attribute, then it would have preserved
the type throughout the transaction.  Of course, the real problem here
is that you have an unconfined process copying the data at all, at which
point you have no real guarantees about it, and the loss in label is the
least of your worries.

-- 
Stephen Smalley
National Security Agency

