Return-Path: <linux-kernel-owner+w=401wt.eu-S1754507AbWLYPNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbWLYPNl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 10:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754514AbWLYPNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 10:13:40 -0500
Received: from sbcs.sunysb.edu ([130.245.1.15]:45100 "EHLO sbcs.cs.sunysb.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbWLYPNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 10:13:39 -0500
Date: Mon, 25 Dec 2006 10:13:10 -0500 (EST)
From: Nikolai Joukov <kolya@cs.sunysb.edu>
X-X-Sender: kolya@compserv1
To: Bryan Henderson <hbryan@us.ibm.com>
cc: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
In-Reply-To: <OF582D7197.D6F604B1-ON88257248.0069CC60-88257248.006AE165@us.ibm.com>
Message-ID: <Pine.GSO.4.53.0612250942340.25572@compserv1>
References: <OF582D7197.D6F604B1-ON88257248.0069CC60-88257248.006AE165@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Every stackable file system caches the data at its own level and
> > copies it from/to the lower file system's cached pages when necessary.
> > ...
> > this effectively reduces the system's cache memory size by two or more
> > times.
>
> It should not be that bad with a decent cache replacement policy; I
> wonder if observing the problem (that you corrected in the various ways
> you've described), you got some insight as to what exactly was happening.

I agree that appropriate replacement policies can partially eliminate
the double caching problem for stackable file systems.  In fact, that's
exactly what RAIF does: it forces the data pages of the lower file
systems to be evicted right after they are written and are not needed
anymore.  This solves the problem for most write-intensive workloads.
Without this optimization the situation is much worse because Linux is
trying to protect caches of different file systems from each other.  But,
as you mentioned, any cache replacement policy is optimized for some set
of workloads and is bad for some other set of workloads.  Also, caching
the data at multiple layers not just increases the memory consumption but
also adds CPU time overheads because of the data copying between the
pages.  I believe that the real solution to the problem is the ability to
share data pages between file systems.

Nikolai.
