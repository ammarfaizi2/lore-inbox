Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314375AbSDRPU1>; Thu, 18 Apr 2002 11:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314376AbSDRPU0>; Thu, 18 Apr 2002 11:20:26 -0400
Received: from bitmover.com ([192.132.92.2]:60875 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314375AbSDRPUZ>;
	Thu, 18 Apr 2002 11:20:25 -0400
Date: Thu, 18 Apr 2002 08:20:25 -0700
From: Larry McVoy <lm@bitmover.com>
To: Kent Borg <kentborg@borg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Versioning File Systems?
Message-ID: <20020418082025.N2710@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Kent Borg <kentborg@borg.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020418110558.A16135@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 11:05:58AM -0400, Kent Borg wrote:
> Seriously, I have a server in the basement with a pair of 60 GB RAID 1
> disks the protect me against likely hardware failure, but they don't
> protect me against: "# rm rf /*".  They don't even let me easily back
> out a bad RPM from Red Hat.

To protect agains rm -rf /, you need backups, not raid.  We do that here
with scripts which just mirror the whole file system to a different drive
every night.  Saves us a ton of grief and gives us a very simplistic 
version control system, I do stuff like

	diff foo.c /nightly/$PWD

all the time for data which isn't in a version control system.

> I guess I am suggesting the (more constructive) discussions over
> desirable Bitkeeper and CVS features consider what it would mean for a
> filesystem to absorb some of the key underlying features of each.

It's certainly a fun space, file system hacking is always fun.  There
doesn't seem to be a good match between file system operations and
SCM operations, especially stuff like checkin.  write != checkin.
But you can handle that with

	echo "I'm done" >> foo.c/checkin

i.e., when the file is treated as a directory, use the rest of the 
pathname as the operation.  Could be cool.

One other thing you might consider, is gluing an SCM system into
the user level NFS server.  That has the nice attribute that you
can export your file system/SCM system.  And/Or samba.

The real issue with all of this is that you can make it work 
locally by extending your pathname sematics or some other
thing, but I've never figured out how to make it work remotely
without hacking the remote OS.  Cross platform is important,
at least it is commercially.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
