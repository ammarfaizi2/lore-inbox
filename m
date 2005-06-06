Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVFFUuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVFFUuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVFFUuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:50:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38414 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261669AbVFFUuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:50:07 -0400
Date: Mon, 6 Jun 2005 21:30:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Brent Casavant <bcasavan@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       Robin Holt <holt@sgi.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem: restore superblock info
In-Reply-To: <20050606150742.F19925@chenjesu.americas.sgi.com>
Message-ID: <Pine.LNX.4.61.0506062122500.5122@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0506062043470.5000@goblin.wat.veritas.com> 
    <20050606150742.F19925@chenjesu.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 06 Jun 2005 20:29:20.0590 (UTC) 
    FILETIME=[6B5056E0:01C56AD6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2005, Brent Casavant wrote:
> On Mon, 6 Jun 2005, Hugh Dickins wrote:
> 
> > @@ -1607,15 +1582,17 @@ static int shmem_statfs(struct super_blo
> > -	if (sbinfo) {
> > -		spin_lock(&sbinfo->stat_lock);
> > +	spin_lock(&sbinfo->stat_lock);
...
> 
> This is the only change I'm at all concerned about.

Thanks for noticing, I hadn't really considered that.

> I'm not sure how frequent statfs operations occur in practice (I suspect
> infrequently),

Infrequently, yes.  I think infrequently to the point of never in
the case that concerns you: correct if I'm wrong, someone, but I think
there's actually no handle by which user can statfs shm's internal mount.

> however simply changing the existing code from "if (sbinfo)"
> to "if (sbinfo->max_blocks || sbinfo->max_inodes)" would be an appropriate
> remedy if there is a real problem.

Hadn't thought of that, yes, can do if there's a real problem.

> That said, I'm not all that concerned about it, as my fuzzy memory
> indicates it was the lock/unlock around the statistics updates which
> caused the primary lock contention.

That's right, and certainly this shmem_statfs locking change didn't
show up when you retested for me (thank you!) all those months ago.

Hugh
