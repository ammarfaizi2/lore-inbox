Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131748AbRCUTXh>; Wed, 21 Mar 2001 14:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131746AbRCUTX3>; Wed, 21 Mar 2001 14:23:29 -0500
Received: from viper.haque.net ([64.0.249.226]:48266 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S131756AbRCUTXT>;
	Wed, 21 Mar 2001 14:23:19 -0500
Date: Wed, 21 Mar 2001 14:22:15 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Andreas Dilger <adilger@turbolinux.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ext2_unlink fun
In-Reply-To: <200103211731.f2LHVEX19566@webber.adilger.int>
Message-ID: <Pine.LNX.4.32.0103211414540.19449-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Andreas Dilger wrote:

> It would be nice to determine _why_ you can't unlink these files.  If
> it was just an issue of size > 2GB, you should get EFBIG error or so.
> People have been reporting undeletable files several times now...  Before
> you reformat, could you do some debugging?

If someone guides me, I can do all the debugging you want.

>
> It appears a reasonable spot to get the EIO from is in ext2_delete_entry()
> where we are validating the de in ext2_check_dir_entry().  Can you check
> your syslog for any error messages, like:
>
> 	ext2_delete_entry: bad entry in directory X: 199908231702.txt ...

Only message I have is EXT2-fs warning (device ide0(3,3)): ext2_unlink:
Deleting nonexistent file (1343506), 0


> Obviously e2fsck doesn't fix the problem?  Could you run debugfs on this
> filesystem, cd to the "mac3dfx/news/1999/08" directory, and "stat" each
> of these broken files?  This may help to identify what is wrong with the
> files that e2fsck isn't fixing.

Correct, this was after running e2fsck. I'll try running it again when I
get home. Here is debugfs stat output for one of the broken files.
Again, I havent run e2fsck a second time yet.

debugfs:  stat 199908231702.txt
Inode: 1343489   Type: bad type    Mode:  0000   Flags: 0x0
Version/Generation: 0
User:     0   Group:     0   Size: 0
File ACL: 0    Directory ACL: 0
Links: 0   Blockcount: 0
Fragment:  Address: 0    Number: 0    Size: 0
ctime: 0x00000000 -- Wed Dec 31 19:00:00 1969
atime: 0x00000000 -- Wed Dec 31 19:00:00 1969
mtime: 0x00000000 -- Wed Dec 31 19:00:00 1969
BLOCKS:



I'll send the results of what I get after running a fsck again in about
6 hours.


Thanks for your help.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

