Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbUKJOch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUKJOch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbUKJOZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:25:43 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:44514 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261982AbUKJOVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:21:11 -0500
Date: Wed, 10 Nov 2004 14:20:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Brent Casavant <bcasavan@sgi.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>,
       "Adam J. Richter" <adam@yggdrasil.com>, <colpatch@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
In-Reply-To: <Pine.SGI.4.58.0411092020550.101942@kzerza.americas.sgi.com>
Message-ID: <Pine.LNX.4.44.0411101406360.2806-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004, Brent Casavant wrote:
> On Tue, 9 Nov 2004, Hugh Dickins wrote:
> 
> > Doesn't quite play right with what was my "NULL sbinfo" convention.
> 
> Howso?  I thought it played quite nicely with it.  We've been using
> NULL sbinfo as an indicator that an inode is from tmpfs rather than
> from SysV or /dev/zero.  Or at least that's the way my brain was
> wrapped around it.

That was the case you cared about, but remember I extended yours so
that tmpfs mounts could also suppress limiting, and get NULL sbinfo.

> The NULL sbinfo scheme worked perfectly for me, with very little hassle.

Yes, it would have worked just right for the important cases.

> > but they're two hints that I should rework that to get out of people's
> > way.  I'll do a patch for that, then another something like yours on
> > top, for you to go back and check.
> 
> Is this something imminent, or on the "someday" queue?  Just asking
> because I'd like to avoid doing additional work that might get thrown
> away soon.

I understand your concern ;)  I'm working on it, today or tomorrow.

> > I'm irritated to realize that we can't change the default for SysV
> > shared memory or /dev/zero this way, because that mount is internal.
> 
> Well, the only thing preventing this is that I stuck the flag into
> sbinfo, since it's an filesystem-wide setting.  I don't see any reason
> we couldn't add a new flag in the inode info flag field instead.  I
> think there would also be some work to set pvma.vm_end more precisely
> (in mpol_shared_policy_init()) in the SysV case.

It's not a matter of where to store the info, it's that we don't have
a user interface for remounting something that's not mounted anywhere.

Hugh

