Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129375AbRAWJi1>; Tue, 23 Jan 2001 04:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAWJiR>; Tue, 23 Jan 2001 04:38:17 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:44930 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S129375AbRAWJiC>;
	Tue, 23 Jan 2001 04:38:02 -0500
Date: Tue, 23 Jan 2001 09:37:59 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <3A6D4872.3CCA957B@idb.hist.no>
Message-ID: <Pine.SOL.4.21.0101230927280.28898-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Helge Hafting wrote:

> James Sutherland wrote:
> > 
> > On Mon, 22 Jan 2001, Helge Hafting wrote:
> > 
> > > And when the next user wants the same webpage/file you read it from
> > > the RAID again? Seems to me you loose the benefit of caching stuff in
> > > memory with this scheme. Sure - the RAID controller might have some
> > > cache, but it is usually smaller than main memory anyway.
> > 
> > Hrm... good point. Using "main memory" (whose memory, on a NUMA box??) as
> > a cache could be a performance boost in some circumstances. On the other
> > hand, you're eating up a chunk of memory bandwidth which could be used for
> > other things - even when you only cache in "spare" RAM, how do you decide
> > who uses that RAM - and whether or not they should?
> 
> If we will need it again soon - cache it.  If not, consider 
> your device->device scheme.  What we will need is often impossible to
> know,
> so approximations like LRU is used.  You could have a object table
> (probably a file table or disk block table) counting how often various
> files/objects are referenced.  You can then decide to use RAID->NIC
> transfers for something that haven't been read before, and memory
> cache when something is re-read for the nth time in a given time
> interval.

I think my compromise of sending it to both simultaneously is better: if
you do reuse it, you've just got a cache hit (win); if not, you've just
burned some RAM bandwidth, which isn't a catastrophe.

> This might be a win, maybe even a big win under some circumstances.  
> But considering how it works only for a few devices only, and how
> complicated it is, the conclusion becomes don't do it for 
> standard linux.  

Eh? This is a hardware system - Linux has very little hardware in it :-)

> You may of course try to make super-performance servers that work for
> a special hw combination, with a single very optimized linux driver
> taking care of the RAID adapter, the NIC(s), the fs, parts of the
> network stack and possibly the web server too.

Actually, I'd like it to be a much more generic thing. If you get an
"intelligent" NIC, it will have, say, a StrongARM processor on it. Why
shouldn't the code running on that processor be supplied by the kernel, as
part of the NIC driver? Given a powerful enough CPU on the NIC, you could
offload a useful chunk of the Linux network stack to it.

Or a RAID adapter - instead of coming with the manufacturer's proprietary
code for striping etc., upload Linux's own RAID software to the CPU. Run
some subset of X's primitives on the graphics card. On an I2O-type system
(dedicated ARM processor or similar for handling I/O), run the low-level
caching stuff, perhaps, or some of the FS code.

Over the next few years, we'll see a lot of little baby CPUs in our PCs,
on network cards, video cards etc. I'd like to see Linux able to take
advantage of this sort of off-load capability where possible.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
