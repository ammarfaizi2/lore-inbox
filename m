Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271448AbRHOVMR>; Wed, 15 Aug 2001 17:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271447AbRHOVL5>; Wed, 15 Aug 2001 17:11:57 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:53010 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S271446AbRHOVLw>;
	Wed, 15 Aug 2001 17:11:52 -0400
Date: Wed, 15 Aug 2001 17:11:40 -0400
From: Theodore Tso <tytso@mit.edu>
To: David Ford <david@blue-labs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 problems in 2.4
Message-ID: <20010815171140.A9017@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Ford <david@blue-labs.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3B72CAF5.8010101@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B72CAF5.8010101@blue-labs.org>; from david@blue-labs.org on Thu, Aug 09, 2001 at 01:40:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 01:40:05PM -0400, David Ford wrote:
> Ok, the problem appears to have been fixed.  I venture the bug is likely 
> in the e2fs tools for the simple reason that on the last time I took the 
> machine down for maintenance, I ran e2fsck five times and got different 
> results for the first three runs.  Now before everyone flys off the 
> handle with their favorite flamethrower, the server was in single user 
> mode with nothing else running but the kernel threads.  There weren't 
> any processes left and lsof was also clean.  I have also been forcing 
> fsck on boot every time.

If you have a problem like this in the future, please download and
compile the latest e2fsprogs (1.23 WIP 9-Aug-2001), and use the
command "e2image -r /dev/xxx raw-image-file".  This will create a raw
image file which is a sparse file containing only the filesystem
metadata.  Try running fsck on that, and see if you are continuing to
get differing results between runs.  If so, then you've isolated away
from it being a hardware problem.  Then, if you don't mind letting me
see the directory names/hierarchy in your filesystem, bzip2 the
resulting filesystem and send it to me, along with an indication of
the size of the filesystem.

That will allow me to debug the problem at my end, without my needing
to see any of your file data, as well as making the compressed
filesystem image small enough that it should be feasible to ship it
over the net.

Many thanks,

						- Ted
