Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264590AbRFPHiK>; Sat, 16 Jun 2001 03:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264591AbRFPHh7>; Sat, 16 Jun 2001 03:37:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50818 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264590AbRFPHho>;
	Sat, 16 Jun 2001 03:37:44 -0400
Date: Sat, 16 Jun 2001 03:37:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac14
In-Reply-To: <oupzob9q84y.fsf@pigdrop.muc.suse.de>
Message-ID: <Pine.GSO.4.21.0106160322510.10605-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 Jun 2001, Andi Kleen wrote:

> "David S. Miller" <davem@redhat.com> writes:
> 
> > Alan Cox writes:
> >  > Because right now I dont consider the 2.4.6 page cache ext2 stuff safe
> >  > enough to merge. I'm letting someone else be the sucide squad.. so far it
> >  > looks like it is indeed fine but I want to wait and see more yet
> > 
> > If it means anything it has already withstanded a few
> > cerebus-->fsck_check-->cerebus rounds on machines here
> > in my lab.
> 
> ... it also seems to make ppc not boot anymore.

OK, after looking at the bug report things smell very strange:

	* kernel had barfed on lookup for /dev/console.
	* kernel had found /dev - right inode number, etc.
	* read_cache_page(inode->i_mapping, n, ext2_readpage) on it
gave all-zeroes for each page within first 32Kb (size of /dev on box in
question).
	* filesystem is not corrupted.
	* all that stuff had happened with cold caches.
	* kernel was 2.4.6-pre3 + some unspecified modifications.

Very odd. Could somebody try vanilla 2.4.6-pre1 on a PPC box? I _really_
doubt that it might be an architecture-specific problem in directory
code - it would simply fail the lookup for  /dev in that case.

I'll try to find a PPC nearby, but it may be tricky on weekend. So if
somebody wants to help... Notice that problem was on read-only mount,
so it can be tested without risking fs corruption - just try to boot
with init=/bin/sh and do ls -lR, etc.

