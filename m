Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129799AbQLQMvT>; Sun, 17 Dec 2000 07:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbQLQMvK>; Sun, 17 Dec 2000 07:51:10 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:37135 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129799AbQLQMu4>;
	Sun, 17 Dec 2000 07:50:56 -0500
Date: Sun, 17 Dec 2000 04:20:18 -0800 (PST)
From: Chris Mason <mason@suse.com>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <3A3C0EB2.6F8FD302@thebarn.com>
Message-ID: <Pine.LNX.4.10.10012170414020.30931-100000@home.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2000, Russell Cattelan wrote:
> >
> I'm curious about this.
> Does the mean reiserFS is doing all of it's own buffer management?
> 
> This would seem a little redundant with what is already in the kernel?
> 
For metadata only reiserfs does its own write management.  The buffers
come from getblk. We just don't mark the buffers dirty for flushing by
flush_dirty_buffers()

This has the advantage of avoiding races against bdflush and friends, and
makes it easier to keep track of which buffers have actually made their
way to disk.  It has all of the obvious disadvantages with respect to
memory pressure.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
