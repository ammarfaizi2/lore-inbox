Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278810AbRKXRlv>; Sat, 24 Nov 2001 12:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278927AbRKXRlb>; Sat, 24 Nov 2001 12:41:31 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:22540 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S278810AbRKXRlY>; Sat, 24 Nov 2001 12:41:24 -0500
Date: Sat, 24 Nov 2001 18:41:19 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011124184119.C12133@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <Pine.LNX.4.33L.0111241138070.4079-100000@imladris.surriel.com> <20011124103642.A32278@vega.ipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20011124103642.A32278@vega.ipal.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Nov 2001, Phil Howard wrote:

> Now I can see a problem if the drive can't flush a write-back cache
> during the "power fade".  With some pretty big caches many drives
> have these days (although I wonder just how useful that is with OS
> caches being as good as they are), the time it takes to flush could
> be long (a few seconds ... and lights are out by then).  I sure hope
> all my drives do write-through caching or don't cache writes at all.

Well, the DTLA drives ship with their writeback cache ENABLED and
transparent remapping DISABLED by default, so putting /sbin/hdparm -W0
/dev/hdX into your boot sequence before mounting the first filesystem
r/w and before calling upon fsck is certainly not a bad idea with
those. Alternatively, you can use IBM's feature tool to reconfigure the
drive.

On a related issue, I asked a person with access to DARA OEM (2.5" HDD)
data to look up caching specifications, and IBM does not guarantee data
integrity for cached blocks that have not yet made it to the disk,
although the drives start to flush their caches immediately. So up to
(cache size / block size) blocks may be lost. With the write cache
turned off, the data loss is at most 1 block.

> I would think that as fast as these drives spin these days, they
> could finish a sector between the time the power fade is detected
> and the time the voltage is too low to have the correct write
> current and servo speed.  Obviously one problem with lighter weight
> platters is the momentum advantage is reduced for keeping the speed
> right as the power is declining (if the speed is an issue, which I
> am not sure of at all).

Well, I never saw big capacitors on disks, so they just go park and
that's about it. If DTLA corrupt their blocks in a way that low-level
formatting becomes necessary, those disk drives must be phased out at
once unless IBM update their firmware so to be able "this is a hard
checksum error, but actually, we can safely overwrite this block".

> OOC, do you think there is any real advantage to the 1m to 4m cache
> that drives have these days, considering the effective caching in
> the OS that all OSes these days have ... over adding that much
> memory to your system RAM?  The only use for caching I can see in
> a drive is if it has physical sector sizes greater than the logical
> sector write granularity size which would require a read-mod-write
> kind of operation internally.  But that's not really "cache" anyway.

Yes, these caches allow for bigger write requests or less latency
(didn't figure), doubling throughput on linear writes at least with IBM
DTLA and DJNA drives.

However, if it's really true that DTLA drives and their successor
corrupt blocks (generate bad blocks) on power loss during block writes,
these drives are crap.

HTH,
Matthias
