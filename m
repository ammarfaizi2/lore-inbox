Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267980AbRGVOW1>; Sun, 22 Jul 2001 10:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267981AbRGVOWQ>; Sun, 22 Jul 2001 10:22:16 -0400
Received: from ns.hobby.nl ([212.72.224.8]:1285 "EHLO hgatenl.hobby.nl")
	by vger.kernel.org with ESMTP id <S267980AbRGVOWI>;
	Sun, 22 Jul 2001 10:22:08 -0400
Date: Sun, 22 Jul 2001 16:07:55 +0200
From: toon@vdpas.hobby.nl
To: linux-kernel@vger.kernel.org
Cc: Hans Reiser <reiser@namesys.com>
Subject: Re: Interesting disk throughput performance problem
Message-ID: <20010722160754.A4027@vdpas.hobby.nl>
In-Reply-To: <20010721233313.A15232@sackheads.org> <3B5A9AD8.FADBA3CF@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B5A9AD8.FADBA3CF@namesys.com>; from reiser@namesys.com on Sun, Jul 22, 2001 at 01:20:24PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 22, 2001 at 01:20:24PM +0400, Hans Reiser wrote:
> 
> I'm just guessing here, but is write caching active on one but not the other?

What do you mean?
That he should activate the write caching in all his drives?
I thought that was plain stupid and wrong, because the filesystem
expects journal data to hit the disk immedialtely. The journal
is written synchronously, isn't it?
So I would expect you to advise everybody to deactivate any
caching in drives and controllers. An the we are back with
Jimmie's question: the throughput performance of his drives
is bad, and the (theoretically) fastest drive is worst.

Regards,
Toon (running a newsserver with reiserfs-3.5.32 on top of LVM-0.9.1-beta7 on
top of DAC960 hardware RAID5 with write-caching turned off, using linux-2.2.19)

> Jimmie Mayfield wrote:
> > 
> > Hi.  I'm running into some disk throughput issues that I can't explain.
> > Hopefully someone reading this can offer an explanation.
> > 
> > One of my machines is running 2.4.5 and has 2 hard drives: a 7200 rpm
> > ATA100 Maxtor and a 5400 rpm ATA33 IBM.  Each drive is a master on its own
> > controller (AMI CMD649 as found on the IWill KT266-R).  Both drives contain
> > reiserfs 3.6x filesystems.
> > 
> > By all local benchmarks, the 7200 rpm drive is the faster drive.  But this
> > doesn't seem to be the case for large files originating from remote clients.
> > Witness:
> > 
> > My crude test involves scp'ing a 100MB file from another machine on my home
> > network over 100bT ethernet.
> > 
> > 1)  scp to the 5400rpm drive:  roughly 10MB/sec.
> > 2)  scp to the 7200rpm drive:  roughly 2MB/sec.
> > 
> > I've tried 'tail' and 'notail' mount options with no change (as expected since
> > this is a single large file).  I suspect that the machine would become CPU-bound
> > somewhere in the 20MB/sec range (see below for my reasoning).
> > 
> > I see the same sort of behavior using Samba though not nearly as
> > pronounced (the 5400rpm drive is merely 2x as fast as the 7200rpm drive).
> > 
> > Okay.  Since the test involved 2 separate drives with different geometries,
> > I figured this might be due to physical block location.  Perhaps the file
> > is getting allocated to the fastest cylinders on the 5400 rpm drive and
> > the slowest cylinders on the 7200 rpm drive.  Or it could be a fragmentation
> > issue.
> > 
> > So I tried the test locally:  with the file stored on the 5400rpm drive,
> > scp it to localhost and write it to the 7200rpm drive.  Results were a little
> > below 10MB/sec (CPU near 100% presumably due to encrypting/decrypting on
> > the fly).
> > 
> > Any ideas why the 7200rpm drive performs so poorly for remote clients but
> > performs wonderfully well when those same operations are performed locally?
> > 
> > Jimmie
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
