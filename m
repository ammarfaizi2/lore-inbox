Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbQL3Uh5>; Sat, 30 Dec 2000 15:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135519AbQL3Uhr>; Sat, 30 Dec 2000 15:37:47 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5016 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135170AbQL3Uhd>;
	Sat, 30 Dec 2000 15:37:33 -0500
Date: Sat, 30 Dec 2000 15:06:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@innominate.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <00123020452307.00966@gimli>
Message-ID: <Pine.GSO.4.21.0012301503290.4082-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Dec 2000, Daniel Phillips wrote:

> When I saw you put in the if (PageDirty) -->writepage and related code
> over the last couple of weeks I was wondering if you realize how close
> we are to having generic deferred file writing in the VFS.  I took some
> time today to code this little hack and it comes awfully close to doing
> the job.  However, *** Warning, do not run this on a machine you care
> about, it will mess it up ***.
> 
> The advantages of deferred file writing are pretty obvious.  Right now
> we are deferring just the writeout of data to the disk, but we can also
> defer the disk mapping, so that metadata blocks don't have to stay
> around in cache waiting for data blocks to get mapped into them one at
> a time - a whole group can be done in one flush.

Except that we've got file-expanding writes outside of ->i_sem. Thanks, but
no thanks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
