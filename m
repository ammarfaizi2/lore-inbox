Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262843AbRFQUrc>; Sun, 17 Jun 2001 16:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262868AbRFQUrW>; Sun, 17 Jun 2001 16:47:22 -0400
Received: from ns.suse.de ([213.95.15.193]:1292 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262843AbRFQUrK>;
	Sun, 17 Jun 2001 16:47:10 -0400
Date: Sun, 17 Jun 2001 22:47:19 +0200
From: Olaf Hering <olh@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac14
Message-ID: <20010617224719.D20397@suse.de>
In-Reply-To: <oupzob9q84y.fsf@pigdrop.muc.suse.de> <Pine.GSO.4.21.0106160322510.10605-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.GSO.4.21.0106160322510.10605-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Jun 16, 2001 at 03:37:15AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, Alexander Viro wrote:

> 
> 
> On 16 Jun 2001, Andi Kleen wrote:
> 
> > "David S. Miller" <davem@redhat.com> writes:
> > 
> > > Alan Cox writes:
> > >  > Because right now I dont consider the 2.4.6 page cache ext2 stuff safe
> > >  > enough to merge. I'm letting someone else be the sucide squad.. so far it
> > >  > looks like it is indeed fine but I want to wait and see more yet
> > > 
> > > If it means anything it has already withstanded a few
> > > cerebus-->fsck_check-->cerebus rounds on machines here
> > > in my lab.
> > 
> > ... it also seems to make ppc not boot anymore.
> 
> OK, after looking at the bug report things smell very strange:
> 
> 	* kernel had barfed on lookup for /dev/console.
> 	* kernel had found /dev - right inode number, etc.
> 	* read_cache_page(inode->i_mapping, n, ext2_readpage) on it
> gave all-zeroes for each page within first 32Kb (size of /dev on box in
> question).
> 	* filesystem is not corrupted.
> 	* all that stuff had happened with cold caches.
> 	* kernel was 2.4.6-pre3 + some unspecified modifications.
> 
> Very odd. Could somebody try vanilla 2.4.6-pre1 on a PPC box? I _really_
> doubt that it might be an architecture-specific problem in directory
> code - it would simply fail the lookup for  /dev in that case.
> 
> I'll try to find a PPC nearby, but it may be tricky on weekend. So if
> somebody wants to help... Notice that problem was on read-only mount,
> so it can be tested without risking fs corruption - just try to boot
> with init=/bin/sh and do ls -lR, etc.

Al,

the pre2 didnt boot on the POWER3 SMP box. pre3 does (runs in 32bit
mode).
It could be a compiler bug because we have some trouble right now with
our toolchain on ppc32.
Right now it runs pre3 fine with a binary from the same compiler etc.

I have seen this only on that box.
Is it possible that a ppc64 writes some bogus values to the disk? I had
a ppc64 binary running but I wasnt too excited about it because it
misses some essential stuff like autofs. So I booted the 2.4.2 ppc32
kernel again with no trouble for a while..



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
