Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbUKITEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbUKITEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUKITEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:04:49 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:14104 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261623AbUKITEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:04:45 -0500
Date: Tue, 9 Nov 2004 19:04:25 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Brent Casavant <bcasavan@sgi.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>,
       "Adam J. Richter" <adam@yggdrasil.com>, <colpatch@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
In-Reply-To: <Pine.SGI.4.58.0411081314160.101942@kzerza.americas.sgi.com>
Message-ID: <Pine.LNX.4.44.0411091824070.5130-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, Brent Casavant wrote:
> On Wed, 3 Nov 2004, Martin J. Bligh wrote:
> 
> > Matt has volunteered to write the mount option for this, so let's hold
> > off for a couple of days until that's done.
> 
> I had the time to do this myself.  Updated patch attached below.

Looks pretty good to me.

Doesn't quite play right with what was my "NULL sbinfo" convention.
Given this mpol patch of yours, and Adam's devfs patch, it's becoming
clear that my "NULL sbinfo" was unhelpful, making life harder for both
of you to add things into the tmpfs superblock - unchanged since 2.4.0,
as soon as I mess with it, people come up with valid new uses for it.

Not to say that your patch or Adam's will go further (I've no objection
to the way Adam is using tmpfs, but no opinion on the future of devfs),
but they're two hints that I should rework that to get out of people's
way.  I'll do a patch for that, then another something like yours on
top, for you to go back and check.

I think the option should be "mpol=interleave" rather than just
"interleave", who knows what baroque mpols we might want to support
there in future?

I'm irritated to realize that we can't change the default for SysV
shared memory or /dev/zero this way, because that mount is internal.
But neither you nor Andi were wanting that, so okay, never mind;
could use his sysctl instead if the need emerges.

At one time (August) you were worried about MPOL_INTERLEAVE
overloading node 0 on small files - is that still a worry?
Perhaps you skirt that issue in recommending this option
for use with giant files.

There are quite a lot of mpol patches flying around, aren't there?
>From Ray Bryant and from Steve Longerbeam.  Would this tmpfs patch
make (adaptable) sense if we went either or both of those ways - or
have they been knocked on the head?  I don't mean in the details
(I think one of them does away with the pseudo-vma stuff - great!),
but in basic design - would your mount option mesh together well
with them, or would it be adding a further layer of confusion?

Hugh

