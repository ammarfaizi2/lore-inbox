Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLOGwU>; Fri, 15 Dec 2000 01:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131341AbQLOGwL>; Fri, 15 Dec 2000 01:52:11 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19972 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129267AbQLOGvz>; Fri, 15 Dec 2000 01:51:55 -0500
Date: Thu, 14 Dec 2000 22:20:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell Cattelan <cattelan@thebarn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <3A398F84.2CD3039D@thebarn.com>
Message-ID: <Pine.LNX.4.10.10012142208420.1308-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Russell Cattelan wrote:
> 
> Ok one more wrinkle.
> sync_buffers calls ll_rw_block, this is going to have the same problem as
> calling ll_rw_block directly.

Good point. 

This actually looks fairly nasty to fix. The obvious fix would be to not
put such buffers on the dirty list at all, and instead rely on the VM
layer calling "writepage()" when it wants to push out the pages.
That would be the nice behaviour from a VM standpoint.

However, that assumes that you don't have any "anonymous" buffers, which
is probably an unrealistic assumption.

The problem is that we don't have any per-buffer "writebuffer()" function,
the way we have them per-page. It was never needed for any of the normal
filesystems, and XFS just happened to be able to take advantage of the
b_end_io behaviour.

Suggestions welcome. 

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
