Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSJNGCq>; Mon, 14 Oct 2002 02:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbSJNGCq>; Mon, 14 Oct 2002 02:02:46 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:27842 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261839AbSJNGCo>; Mon, 14 Oct 2002 02:02:44 -0400
Date: Mon, 14 Oct 2002 07:09:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: lkml <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [patch] remove BKL from inode_setattr
In-Reply-To: <3DAA4FD6.A18DAFE6@digeo.com>
Message-ID: <Pine.LNX.4.44.0210140657240.9845-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Andrew Morton wrote:
> 
> Since April 05 of this year we've been holding the BKL across the
> vmtruncate call out of inode_setattr().  By accident it seems.

But until then, the lock_kernel was one level up in notify_change().

> This does not affect unlink().  It affects ftruncate() and open(O_TRUNC).

And the patch you give affects chown, chgrp, chmod, utime also:
removing a synchronization point if nothing more.  Could that matter?

> Given that the drop_inode() path does not take the BKL, I would
> suggest that it is safe to assume that the various filesystem's
> truncate code is safe without this additional VFS-level lock_kernel(),
> and that it can be simply removed.

Isn't doing it when the references have gone rather easier/safer
than when they remain?  I'm not sure your argument holds.

> Sound sane?

Of course I want you to be right!  But I don't see that you've made
a strong enough case yet.  Please show I'm being stupid, someone.

Hugh

