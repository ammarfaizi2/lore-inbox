Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbUDBQXw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 11:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbUDBQXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 11:23:52 -0500
Received: from mail.shareable.org ([81.29.64.88]:63893 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263281AbUDBQXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 11:23:50 -0500
Date: Fri, 2 Apr 2004 17:23:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Paul Eggert <eggert@CS.UCLA.EDU>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       bug-coreutils@gnu.org
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-ID: <20040402162338.GB32483@mail.shareable.org>
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de> <20040401220957.5f4f9ad2.ak@suse.de> <7w3c7nb4jb.fsf@sic.twinsun.com> <20040402011411.GE28520@mail.shareable.org> <87wu4yohtp.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wu4yohtp.fsf@penguin.cs.ucla.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Eggert wrote:
> > AFAIK there is no way to determine the stored resolution using file
> > operations alone.
> 
> Would it be easy to add one?  For example, we might extend pathconf so
> that pathconf(filename, _PC_MTIME_DELTA) returns the file system's
> mtime stamp resolution in nanoseconds.

pathconf() and fpathconf() are the obvious POSIXy interfaces for it.

Other possibilities are getxattr(), lgetxattr() and fgetxattr().

The only thing I don't like is that some cacheing algorithms will need
to make 2 system calls for each file being checked, instead of 1.  I
see no way around that, though.  At least the attribute approach would
allow all three (different) delta values to be read in one call (listxattr).

Is there a de facto standard interface used by another OS for this?

> I write "mtime" because I understand that some Microsoft file systems
> use different resolutions for mtime versus ctime versus atime, and
> mtime resolution is all that I need for now.

I didn't know that, thanks.

> Also, the NFSv3 protocol supports a delta quantity that tells the
> NFS client the mtime resolution on the NFS server, so if you assume
> NFSv3 or better the time stamp resolution is known for remote
> servers too.

Nice!

-- Jamie
