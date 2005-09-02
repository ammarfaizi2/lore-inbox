Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbVIBVRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbVIBVRR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbVIBVRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:17:16 -0400
Received: from ns2.suse.de ([195.135.220.15]:30652 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161038AbVIBVRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:17:14 -0400
To: linux clustering <linux-cluster@redhat.com>, akpm@osdl.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: GFS, what's remaining
References: <20050901104620.GA22482@redhat.com>
	<20050901035939.435768f3.akpm@osdl.org>
	<1125586158.15768.42.camel@localhost.localdomain>
	<20050901132104.2d643ccd.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 02 Sep 2005 23:17:08 +0200
In-Reply-To: <20050901132104.2d643ccd.akpm@osdl.org>
Message-ID: <p73fysnqiej.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> 
> > > - Why GFS is better than OCFS2, or has functionality which OCFS2 cannot
> > >   possibly gain (or vice versa)
> > > 
> > > - Relative merits of the two offerings
> > 
> > You missed the important one - people actively use it and have been for
> > some years. Same reason with have NTFS, HPFS, and all the others. On
> > that alone it makes sense to include.
>  
> Again, that's not a technical reason.  It's _a_ reason, sure.  But what are
> the technical reasons for merging gfs[2], ocfs2, both or neither?

There seems to be clearly a need for a shared-storage fs of some sort
for HA clusters and virtualized usage (multiple guests sharing a
partition).  Shared storage can be more efficient than network file
systems like NFS because the storage access is often more efficient
than network access  and it is more reliable because it doesn't have a
single point of failure in form of the NFS server.

It's also a logical extension of the "failover on failure" clusters
many people run now - instead of only failing over the shared fs at
failure and keeping one machine idle the load can be balanced between
multiple machines at any time.

One argument to merge both might be that nobody really knows yet which
shared-storage file system (GFS or OCFS2) is better. The only way to
find out would be to let the user base try out both, and that's most
practical when they're merged.

Personally I think ocfs2 has nicer&cleaner code than GFS.
It seems to be more or less a 64bit ext3 with cluster support, while
GFS seems to reinvent a lot more things and has somewhat uglier code.
On the other hand GFS' cluster support seems to be more aimed
at being a universal cluster service open for other usages too,
which might be a good thing. OCFS2s cluster seems to be more 
aimed at only serving the file system.

But which one works better in practice is really an open question.

The only thing that should be probably resolved is a common API
for at least the clustered lock manager. Having multiple
incompatible user space APIs for that would be sad.

-Andi
