Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbTFZBuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 21:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbTFZBuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 21:50:17 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:52233 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S265298AbTFZBuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 21:50:14 -0400
Date: Wed, 25 Jun 2003 19:00:40 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.73-mm1 XFS] restrict_chown and quotas
Message-ID: <20030626020039.GD11555@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030625095126.GD1745@thanes.org> <1056545505.1170.19.camel@laptop.americas.sgi.com> <20030625134129.GG1745@thanes.org> <1056551143.5779.0.camel@laptop.fenrus.com> <20030625153545.A16074@infradead.org> <1056553902.1416.61.camel@laptop.americas.sgi.com> <20030625161627.A20049@infradead.org> <1056554727.1174.86.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056554727.1174.86.camel@laptop.americas.sgi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 10:25:26AM -0500, Steve Lord wrote:
> On Wed, 2003-06-25 at 10:16, Christoph Hellwig wrote:
> > On Wed, Jun 25, 2003 at 10:11:40AM -0500, Steve Lord wrote:
> > > This is all backwards compatibility with folks expecting Irix behavior,
> > > and I think on Irix it is even a backwards compatibility thing. If we
> > > were not having a major power outage at work right now I could look
> > > at Irix and confirm this. Imposing different semantics on the rest of
> > > the filesystems did not seem like the right thing to do.
> > 
> > Actually there's a posix option group for finding out exactly that,
> > (see http://people.redhat.com/drepper/posix-option-groups.html#CHOWN_RESTRICTED)
> > but yeah it might be more of a legacy thing.
> > 
> > Adding a common sysctl for this would allow glibc to properly implement
> > patchconf(..., _PC_CHOWN_RESTRICTED), but it seems SuSv2/3 sais it must
> > be always defined:
> > 
> > http://www.opengroup.org/onlinepubs/007908799/xsh/chown.html
> 
> Thanks, I also found out that the unrestricted  chown behavior is the
> way AT&T system V did it originally. I vote for this being a legacy
> thing.

That is correct.  It had some utility when a process could
only be a member of one group at a time and for giving files
to someone else while keeping all others out.  Chown was
expected to disable s[ug]id bits.  The value of an
unrestricted chown is very small and will be eliminated by
ACLs.

Quotas turned it into a security issue.   With unrestricted
chown a user could chown large files to another (preferably
unlimited) uid and avoid the limits and usage charges.  It
also allows one user to sabotage another by causing that
user to go over quota on files he has no knowledge or control
over.  Quotas and unrestricted chown do not mix.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
