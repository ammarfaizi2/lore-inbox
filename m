Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264177AbUDBVHa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264180AbUDBVH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:07:29 -0500
Received: from mail.shareable.org ([81.29.64.88]:12694 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264177AbUDBVH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:07:28 -0500
Date: Fri, 2 Apr 2004 22:07:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Paul Eggert <eggert@CS.UCLA.EDU>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       bug-coreutils@gnu.org
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-ID: <20040402210722.GE653@mail.shareable.org>
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de> <20040401220957.5f4f9ad2.ak@suse.de> <7w3c7nb4jb.fsf@sic.twinsun.com> <20040402011411.GE28520@mail.shareable.org> <87wu4yohtp.fsf@penguin.cs.ucla.edu> <20040402162338.GB32483@mail.shareable.org> <87ad1uw1m2.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ad1uw1m2.fsf@penguin.cs.ucla.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Eggert wrote:
> Jamie Lokier <jamie@shareable.org> writes:
> > The only thing I don't like is that some cacheing algorithms will need
> > to make 2 system calls for each file being checked, instead of 1.
> 
> Do you mean for mtime versus atime (versus ctime)?  Yes, in that case
> getxattr etc. would be a better choice.

No, I mean that they currently call fstat().  In future they'd need to
call fstat()+getxattr().

If it's a per-filesystem quantity, then of course fstat() is all they
need.  So that would be great.

> Coreutils CVS assumes that the time stamp resolution is the same for
> all files within the same file system.  Is this a safe assumption
> under Linux?  I now worry that some NFS implementations might violate
> that assumption, if a remote host is exporting several native file
> systems, with different native resolutions, to the local host under a
> single mount point.  On the other hand, NFSv3 and NFSv4 clearly state
> that the time stamp resolution is a per-filesystem concept, so perhaps
> we should just consider that to be a buggy NFS server configuration.

Buugy, perhaps, but quite useful sometimes.  It's not a problem, if
we're clear that it's a per-filesystem quantity.  That kind of NFS
server configuration can advertise the coarsest timestamp resolution
of all the underlying filesystems.

NFS is not the only remote filesystem, and some like Samba can
certainly span multiple underlying filesystems without violating any
specificaiton.

With that in mind, we'd need to be clear that the resolution actually
stored may exceed the resolution advertised.  I don't know whether
that breaks coreutils' assumption.

-- Jamie
