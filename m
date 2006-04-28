Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWD1Mzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWD1Mzu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 08:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWD1Mzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 08:55:50 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:5612 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1030363AbWD1Mzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 08:55:49 -0400
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11]
	security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Andi Kleen <ak@suse.de>,
       Ken Brush <kbrush@gmail.com>, Neil Brown <neilb@suse.de>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060427223824.GE2909@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <17487.61698.879132.891619@cse.unsw.edu.au>
	 <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com>
	 <200604270615.20554.ak@suse.de> <20060427101734.GH3026@sorel.sous-sol.org>
	 <1146153827.5238.47.camel@moss-spartans.epoch.ncsc.mil>
	 <20060427223824.GE2909@sorel.sous-sol.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 28 Apr 2006 09:00:06 -0400
Message-Id: <1146229206.11817.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 15:38 -0700, Chris Wright wrote:
> * Stephen Smalley (sds@tycho.nsa.gov) wrote:
> > Not sure about the example here, as the type in that case would actually
> > be lost upon the cp by the unconfined process to the /tmp location, in
> > which case you have an issue for both AA and SELinux - the data has
> > become accessible under a different name and label which may now be
> > accessible beyond the original intent.
> 
> Point is, names matter as much as inodes do.  And it's possible to
> get improperly labelled data in canonical location for object (i.e.
> /etc/shadow).  Certainly requires unconfined help, but real people do
> things like that w/out fully understanding the impact.  You can fix the
> normal tools, but not all one-off admin tools.

The names don't matter as much as the real security properties of the
data, but I do agree that mislabeling of data is an issue, particularly
for a gradual rollout of MAC where we have to deal with the fact that
not everything will be confined and not all of userspace will be
properly instrumented.  However, I'd argue that this can be addressed,
in the short term through userspace tools like restorecond that leverage
inotify and in the long term through ever expanding application of MAC
to the system (as that becomes more feasible via the introduction of
appropriate tools and infrastructure to make management feasible, which
is already in progress).  Addressing it by introducing a flawed
mechanism into the kernel seems like a bad idea to me.

> > Of course, the real problem here
> > is that you have an unconfined process copying the data at all, at which
> > point you have no real guarantees about it, and the loss in label is the
> > least of your worries.
> 
> That's my point.  You can't meaningfully reason about the security of
> the system with unconfined processes.

Precisely.  And this is something that we recognize and are working
toward eliminating - the targeted policy is just a way of transitioning
MAC into Linux gradually until we have the necessary infrastructure and
tools to make it truly manageable.  Whereas other approaches seem to
presume that unconfined processes will always be present, and in fact,
will be the majority of the system.

-- 
Stephen Smalley
National Security Agency

