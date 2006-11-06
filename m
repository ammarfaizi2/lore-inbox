Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753808AbWKFVML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbWKFVML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbWKFVMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:12:10 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:29148 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1753808AbWKFVMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:12:09 -0500
Date: Mon, 6 Nov 2006 22:11:34 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Jeff Layton <jlayton@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061106211134.GB691@wohnheim.fh-wedel.de>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com> <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <454FA032.1070008@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 November 2006 14:50:58 -0600, Eric Sandeen wrote:
> > 
> > While you're at it, how about making last_ino per-sb instead of
> > system-wide?  ino collisions after a wrap are just as bad as inos
> > beyond 32bit.  And this should be a fairly simple method to reduce the
> > risk.
> 
> Using a global counter for multiple filesystems should actually -reduce-
> the chance of a collision on the same filesystem, since after you wrap the
> recycled number may go to a different filesystem.

You're missing something.  The chance for a collision _per wrap_ is
reduced, as you said.  But the number of wraps goes up.  Overall and
for large numbers, the two effects compensate each other.

For not-so-large numbers, you can get by without the wrap by having
this per-sb.  And if you have just one or two wrapping filesystems, at
least the others are protected.  It's not much, but it is a simple
thing to do.

> To fix this properly, we'd need some sort of checking that the inode number
> isn't currently being used on the filesystem in question before it's
> assigned to the new inode.

Absolutely.  Thinking about it, iget() already has a lot of what is
needed - except that it can block and has side effects we don't really
want.  Sounds more complicated, but I would love to be proven wrong
here. :)

Jörn

-- 
Joern's library part 7:
http://www.usenix.org/publications/library/proceedings/neworl/full_papers/mckusick.a
