Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSJ1ElH>; Sun, 27 Oct 2002 23:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbSJ1ElH>; Sun, 27 Oct 2002 23:41:07 -0500
Received: from ns.suse.de ([213.95.15.193]:19211 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262876AbSJ1ElG>;
	Sun, 27 Oct 2002 23:41:06 -0500
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: New nanosecond stat patch for 2.5.44
References: <20021027121318.GA2249@averell.suse.lists.linux.kernel> <20021027214913.GA17533@clusterfs.com.suse.lists.linux.kernel> <aphqqo$261$1@cesium.transmeta.com.suse.lists.linux.kernel> <3DBC9194.5090006@nortelnetworks.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Oct 2002 05:47:25 +0100
In-Reply-To: Chris Friesen's message of "28 Oct 2002 02:26:03 +0100"
Message-ID: <p73wuo3rwyq.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> writes:

> H. Peter Anvin wrote:
> 
> > We probably need to revamp struct stat anyway, to support a larger
> > dev_t, and possibly a larger ino_t (we should account for 64-bit ino_t
> > at least if we have to redesign the structure.)  At that point I would
> > really like to advocate for int64_t ts_sec and uint32_t ts_nsec and
> > quite possibly a int32_t ts_taidelta to deal with leap seconds... I'd
> > personally like struct timespec to look like the above everywhere.
> 
> For filesystems can we get away with just the 64-bit nanoseconds?  By my 
> calculations that gives something like 584 years--do we need to worry 
> about files older than that?

The current timestamps on 32bit systems are 32bit. 64bit nanoseconds
would take the same room as 32bit second + 32bit nanosecond. And it would
be incompatible with current glibc (which the additional nanosecond
fields are perfectly compatible - they are zeroed currently). Also glibc
would need to convert it to a timespec for Solaris compatbility anyways
and need an unnecessary division for that.

The same thing applies to file system storage. Storing in nanoseconds
(like e.g. NTFS or CIFS do - they store 64bit in 100ns units since 1601) 
would require slow divisions to convert from the user visible format,
needs the same space and has no advantage as far as I can see.

-Andi
