Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753447AbWKFUvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbWKFUvD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753783AbWKFUvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:51:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27052 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753780AbWKFUvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:51:00 -0500
Message-ID: <454FA032.1070008@redhat.com>
Date: Mon, 06 Nov 2006 14:50:58 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Jeff Layton <jlayton@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
 that offer x86 compatability
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com> <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de>
In-Reply-To: <20061106202313.GA691@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Mon, 6 November 2006 13:47:23 -0500, Jeff Layton wrote:
>> On Mon, 2006-11-06 at 11:22 -0700, Matthew Wilcox wrote:
>>> On Mon, Nov 06, 2006 at 01:12:05PM -0500, Jeff Layton wrote:
>>>> The attached patch remedies this by making the last_inode counter be an
>>>> unsigned int on kernels that have ia32 compatability mode enabled.
>>> ... and this only happens on ia64/x86_64 kernels, not sparc64, ppc64,
>>> s390x, parisc64 or mips64?
>> Here's a new (untested) patch that replaces the ia32 specific
>> compatability mode defines with CONFIG_COMPAT, as suggested by Matthew.
> 
> While you're at it, how about making last_ino per-sb instead of
> system-wide?  ino collisions after a wrap are just as bad as inos
> beyond 32bit.  And this should be a fairly simple method to reduce the
> risk.

Using a global counter for multiple filesystems should actually -reduce-
the chance of a collision on the same filesystem, since after you wrap the
recycled number may go to a different filesystem.

Simply making it a per-sb counter makes it worse, because wrapped inodes
will always go to the same filesystem.

To fix this properly, we'd need some sort of checking that the inode number
isn't currently being used on the filesystem in question before it's
assigned to the new inode.

-Eric
