Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753834AbWKFVg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbWKFVg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbWKFVg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:36:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57048 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753834AbWKFVg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:36:58 -0500
Message-ID: <454FAAF8.8080707@redhat.com>
Date: Mon, 06 Nov 2006 15:36:56 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Jeff Layton <jlayton@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
 that offer x86 compatability
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com> <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de>
In-Reply-To: <20061106211134.GB691@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Mon, 6 November 2006 14:50:58 -0600, Eric Sandeen wrote:
>>> While you're at it, how about making last_ino per-sb instead of
>>> system-wide?  ino collisions after a wrap are just as bad as inos
>>> beyond 32bit.  And this should be a fairly simple method to reduce the
>>> risk.
>> Using a global counter for multiple filesystems should actually -reduce-
>> the chance of a collision on the same filesystem, since after you wrap the
>> recycled number may go to a different filesystem.
> 
> You're missing something.  The chance for a collision _per wrap_ is
> reduced, as you said.  But the number of wraps goes up.  Overall and
> for large numbers, the two effects compensate each other.

Well, one concern is an intentional exploit.  In which case "longer
time" and "shorter time" don't matter -so- much.  If it can happen at
all, it's bad, period.

OTOH if one filesystem (say, pipes) can wrap the numbers very quickly,
while other spaces are otherwise more immune, then having it global puts
everything using it at a bit more risk.

*shrug* I dunno, it's probably not worth arguing this point, it needs to
be fixed properly in any case. :)

-Eric
