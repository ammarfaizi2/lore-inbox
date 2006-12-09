Return-Path: <linux-kernel-owner+w=401wt.eu-S1758492AbWLIWaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758492AbWLIWaY (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 17:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758738AbWLIWaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 17:30:24 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55288 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758492AbWLIWaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 17:30:23 -0500
Date: Sat, 9 Dec 2006 14:30:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix numerous kcalloc() calls, convert to kzalloc().
Message-Id: <20061209143014.40051036.akpm@osdl.org>
In-Reply-To: <457B3346.2020008@s5r6.in-berlin.de>
References: <Pine.LNX.4.64.0612090950580.14897@localhost.localdomain>
	<457B3346.2020008@s5r6.in-berlin.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Dec 2006 23:05:58 +0100
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> >  fs/ocfs2/dlm/dlmrecovery.c          |    6 +++---
> >  fs/ocfs2/localalloc.c               |    2 +-
> >  fs/ocfs2/slot_map.c                 |    2 +-
> >  fs/ocfs2/suballoc.c                 |    6 +++---
> >  fs/ocfs2/super.c                    |    6 +++---
> >  fs/ocfs2/vote.c                     |    4 ++--
> >  include/linux/gameport.h            |    2 +-
> >  kernel/relay.c                      |    4 ++--
> >  net/sunrpc/svc.c                    |    2 +-
> >  sound/pci/hda/patch_realtek.c       |    4 ++--
> >  34 files changed, 91 insertions(+), 91 deletions(-)
> 
> This should really be split up and submitted separately. All the subsystems
> are constantly changing. Although merging these kinds of changes manually
> after eventual conflicts, it's still manual work for the maintainers which
> would be avoided by a little bit extra work by the submitter. A maintainer
> could get a merge conflict on a 100 lines long hunk because of an 8 lines
> long hunk that got upstream on a different route.

Well actually..  With a patch like this, if any hunk clashes with a subsystem
maintainer's tree I'll usually just drop that hunk, or I'll fix it up so
that it applies to the maintainer's devel tree and won't merge it until the
maintainer has merged with mainline.

Or, if the maintainer is being sluggish, I'll just drop the problematic hunk
and I'll merge the rest with Linus.

IOW, what I merge with Linus is that part of the patch which doesn't
conflict with any of the subsystem trees.


Of course, if your subsystem tree isn't in -mm then you lose.
