Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278696AbRJXSIp>; Wed, 24 Oct 2001 14:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278695AbRJXSIi>; Wed, 24 Oct 2001 14:08:38 -0400
Received: from green.csi.cam.ac.uk ([131.111.8.57]:55537 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S278694AbRJXSIT>; Wed, 24 Oct 2001 14:08:19 -0400
Date: Wed, 24 Oct 2001 19:08:28 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@green.csi.cam.ac.uk>
To: Rik van Riel <riel@conectiva.com.br>
cc: Jan Kara <jack@suse.cz>, Neil Brown <neilb@cse.unsw.edu.au>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: <Pine.LNX.4.33L.0110241540090.3690-100000@imladris.surriel.com>
Message-ID: <Pine.SOL.4.33.0110241855590.12478-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, Rik van Riel wrote:
> On Wed, 24 Oct 2001, James Sutherland wrote:
>
> > Yep, you're right: you'd need to ascend the target directory tree,
> > increasing the cumulative size all the way up, then do the move and
> > decrement the old location's totals in the same way. All wrapped up in a
> > transaction (on journalled FSs) or have fsck rebuild the totals on a dirty
> > mount. Fairly clean and painless on a JFS,
>
> It's only clean and painless when you have infinite journal
> space. When your filesystem's journal isn't big enough to
> keep track of all the quota updates from an arbitrarily deep
> directory tree, you're in big trouble.

Good point. You should be able to do it in constant space, though:
identify the directory being modified, and the "height" to which you have
ascended so far. That'll allow you to back out or redo the transaction
later, which is enough I think?


James.

