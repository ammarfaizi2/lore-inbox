Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130270AbRAJOu4>; Wed, 10 Jan 2001 09:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131987AbRAJOuq>; Wed, 10 Jan 2001 09:50:46 -0500
Received: from zeus.kernel.org ([209.10.41.242]:14784 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131575AbRAJOul>;
	Wed, 10 Jan 2001 09:50:41 -0500
Date: Wed, 10 Jan 2001 14:47:35 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010110144735.E10633@redhat.com>
In-Reply-To: <200101091341.HAA52016@tomcat.admin.navo.hpc.mil> <20010109150635.C8824@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109150635.C8824@athlon.random>; from andrea@suse.de on Tue, Jan 09, 2001 at 03:06:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 09, 2001 at 03:06:35PM +0100, Andrea Arcangeli wrote:
> On Tue, Jan 09, 2001 at 07:41:21AM -0600, Jesse Pollard wrote:
> > Not exactly valid, since a file could be created in that "pinned" directory
> > after the rmdir...
> 
> In 2.2.x no file can be created in the pinned directory after the rmdir.

In 2.2, at least some of that protection was in ext2 itself.  POSIX
mandates that a deleted directory has no dirents, so readdir() must
not return even "." or "..".  ext2 achieved this by truncating the dir
to size==0, and by refusing to add dirents to the resulting completely
empty directory.

Do we have enough protection to ensure this for other filesystems?

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
