Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbSIZFxN>; Thu, 26 Sep 2002 01:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbSIZFxN>; Thu, 26 Sep 2002 01:53:13 -0400
Received: from thunk.org ([140.239.227.29]:45215 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262196AbSIZFxL>;
	Thu, 26 Sep 2002 01:53:11 -0400
Date: Thu, 26 Sep 2002 01:57:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ryan Cumming <ryan@completely.kicks-ass.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020926055755.GA5612@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ryan Cumming <ryan@completely.kicks-ass.org>,
	linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209251645.40575.ryan@completely.kicks-ass.org> <20020926032756.GA4072@think.thunk.org> <200209252223.13758.ryan@completely.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209252223.13758.ryan@completely.kicks-ass.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 10:23:11PM -0700, Ryan Cumming wrote:
>
> It seems to be running stable now. Linux 2.4.19, UP Athlon, GCC 3.2.

Just to humor me, can you try it with gcc 2.95.4?  I just want to
eliminate one variable....

> 3) While starting man(1), EXT3 began spewing messages in the form:
> "EXT3-fs error (device (ide0(3,2)): ext3_readdir: directory #4243459 contains 
> a hole at offset xxxxxx"

what directory was 4243459?  You can use the debugfs's ncheck command
to get back a pathname from an inode number?

Are you sure the filesystem was consistent before you started this
whole procedure?  

It sounds like you hadn't started modifying directories at this point
in the procedure.  Yet this error ("directory #XXXX contains a hole")
is printed by the non-indexed-directory version of readdir.  So that
would imply that the directory with the initial error reported on it
was not an indexed directory.....  very strange!

> The directory number stayed constant, but the offset was variable. fsck -fD 
> had -not- been run at this point.
> 4) On reboot, fsck reported:
> "Directory inode has unallocated block #xx"
> multiple times. fsck seemed to fully recover the filesystem. I rebooted again 
> for good measure.

What were the directory inode numbers, and what pathname did they map
to?

> 7) While KDE was trying to start, EXT3 dumped the following to the console:
> "EXT3-fs error (device ide(3,2)) in start_transaction: Journal has aborted"

This message will appear if previously some other part of ext2
reported a filesystem inconsistency.  So it's a symptom, and not the
root cause of the problem.

> 8) I rebooted, and fsck said:
> "Directory inode 131073,block3,offset 528: Directory corrupted"
> I wasn't so lucky this time, and a good portion of my home directory got 
> eaten.


Against, what was the pathnmae to the inode #131073?

This is strange, since I'm not seeing any of the problems that you're
seeing.  I'm going to need a lot more information if I'm going to have
a prayer of a chance of digging into it.

						- Ted
