Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315936AbSENRy1>; Tue, 14 May 2002 13:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315935AbSENRy0>; Tue, 14 May 2002 13:54:26 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:35186 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S315936AbSENRxs>; Tue, 14 May 2002 13:53:48 -0400
Date: Tue, 14 May 2002 12:53:47 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205141753.MAA70930@tomcat.admin.navo.hpc.mil>
To: elladan@eskimo.com, Christoph Hellwig <hch@infradead.org>,
        Elladan <elladan@eskimo.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elladan <elladan@eskimo.com>:
> I went to google and attempted to find information about the root
> reserve space for ext2, as a user wondering about the feature would.  I
> couldn't find any documentation that states it's purely a fragmentation
> and convenience feature.  I did, however, find documents stating
> otherwise.  Note how even Documentation/filesystems/ext2.txt states that
> it's a security feature?
> 
> If this is not a security feature, Documentation/filesystems/ext2.txt
> needs to be changed.  Eg., 
> 
> "In ext2, there is a mechanism for reserving a certain number of blocks
> for a particular user (normally the super-user).  This is intended to
> keep the filesystem from filling up entirely, which helps combat
> fragmentation.  The super-user may still use this space.  Note that this
> is not a security feature, and is only provided for convenience -
> various methods exist where a user may circumvent this reservation and
> use the space if they so wish.  Quotas or separate filesystems should be
> used if reliable space limits are needed."
> 

If the root file system is ext2, it does become a security issue since
currently active logs will continue to record log entries until the
filesystem is absolutly filled. I should say, if the log device fills up,
since the log directory is usually /var/log, or /var/adm. Some logs show
up in etc, but that really depends on the configuration. It IS usefull if the
filesystem is "full" due to attacks - daemons tend to terminate themselves,
and their log entry indicates what the problem was. If it is an attack, then
it's a security issue.

The only reason it helps fragmentation (subject to actual implementor
statements) is that the filesystem code will use every scavanged block
possible under saturation. When the filesystem gets cleand up later,
these excessively fragmented files will remain, and continue to cause
access delays.

Naturally, deleting (or backup/restore) the file(s) cleans up the fragmentation.

> 
> 1. http://web.mit.edu/tytso/www/linux/ext2intro.html
> 
> Design and Implementation of the Second Extended Filesystem
> 
> [....] Ext2fs reserves some blocks for the super user (root). Normally,
> 5% of the blocks are reserved. This allows the administrator to recover
> easily from situations where user processes fill up filesystems.
> 
> 
> 2. Documentation/filesystems/ext2.txt
> 
> Reserved Space
> --------------
> 
> In ext2, there is a mechanism for reserving a certain number of blocks
> for a particular user (normally the super-user).  This is intended to
> allow for the system to continue functioning even if non-priveleged
> users fill up all the space available to them (this is independent of
> filesystem quotas).  It also keeps the filesystem from filling up
> entirely which helps combat fragmentation.

True, but this is a side effect caused by stopping user allocations.
 
> 3. Note what mke2fs prints:
> 
> 3275 blocks (5.00%) reserved for the super user
> 
> It does not say "reserved to combat fragmentation"
> 

It shouldn't have to. This is a tuneable value, and can be set to 0.
(tune2fs).

The "super user" is also an option. It defaults to the user "root", but
can be specified to be a user OR a group by tune2fs (-g option for group,
-u option for user).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
