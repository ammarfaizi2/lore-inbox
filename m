Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264171AbUDBUpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 15:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbUDBUpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 15:45:23 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:55468 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S264171AbUDBUpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 15:45:22 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       bug-coreutils@gnu.org
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
	<20040401220957.5f4f9ad2.ak@suse.de> <7w3c7nb4jb.fsf@sic.twinsun.com>
	<20040402011411.GE28520@mail.shareable.org>
	<87wu4yohtp.fsf@penguin.cs.ucla.edu>
	<20040402162338.GB32483@mail.shareable.org>
From: Paul Eggert <eggert@CS.UCLA.EDU>
Date: Fri, 02 Apr 2004 12:45:09 -0800
In-Reply-To: <20040402162338.GB32483@mail.shareable.org> (Jamie Lokier's
 message of "Fri, 2 Apr 2004 17:23:38 +0100")
Message-ID: <87ad1uw1m2.fsf@penguin.cs.ucla.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> pathconf() and fpathconf() are the obvious POSIXy interfaces for it.
> Other possibilities are getxattr(), lgetxattr() and fgetxattr().

I didn't know about getxattr etc.  They would work too.

> The only thing I don't like is that some cacheing algorithms will need
> to make 2 system calls for each file being checked, instead of 1.

Do you mean for mtime versus atime (versus ctime)?  Yes, in that case
getxattr etc. would be a better choice.

How hard would this be to do?  (Is it something you can do?  :-)

Coreutils CVS assumes that the time stamp resolution is the same for
all files within the same file system.  Is this a safe assumption
under Linux?  I now worry that some NFS implementations might violate
that assumption, if a remote host is exporting several native file
systems, with different native resolutions, to the local host under a
single mount point.  On the other hand, NFSv3 and NFSv4 clearly state
that the time stamp resolution is a per-filesystem concept, so perhaps
we should just consider that to be a buggy NFS server configuration.

> Is there a de facto standard interface used by another OS for this?

Not as far as I know, no.
