Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274508AbRIYGDG>; Tue, 25 Sep 2001 02:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274509AbRIYGCz>; Tue, 25 Sep 2001 02:02:55 -0400
Received: from ljbc.wa.edu.au ([203.59.143.14]:19183 "HELO gamma.ljbc")
	by vger.kernel.org with SMTP id <S274508AbRIYGCq>;
	Tue, 25 Sep 2001 02:02:46 -0400
Date: Tue, 25 Sep 2001 14:00:55 +0800 (WST)
From: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
To: Nicholas Knight <tegeran@home.com>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
In-Reply-To: <20010925044949.JNOU8313.femail42.sdc1.sfba.home.com@there>
Message-ID: <Pine.LNX.4.30.0109251335520.18440-100000@gamma.student.ljbc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Sep 2001, Nicholas Knight wrote:

> On Monday 24 September 2001 05:11 pm, Matthias Andree wrote:
> > On Mon, 24 Sep 2001, Nicholas Knight wrote:
> > > Would you like to read the rest of my message please? Cheap UPS's
> > > can provide protection against power failures. If your data is that
> > > valuble, you can afford a cheap UPS to give you 5 minutes to shut
> > > down.
> >
> > No UPS can protect you from system crashes. The problem is, with the
> > drive cache on, the drive will acknowledge having written the data
> > early and reorder its writes, but who makes guarantees it can write
> > its whole 2 MB to disk should the power fail? No-one. ATA6 drafts
> > have a NOTE that says, the FLUSH CACHE command may take longer than
> > 30 s to complete.
> >
> > Journalling File systems don't get you anywhere if the drive reorders
> > its blocks before the write (I presume, most will do), they may
> > instead turn the whole partition to junk without notice, because any
> > assumptions as to the on-disk structure don't hold.
> >
> > > > Linear writing as dd mostly does is BTW something which should
> > > > never be affected by write caches.
> > >
> > > Explain the numbers then.
> >
> > I can't, any explanation right now would be conjecture. I can
> > reproduce the numbers on my IBM DTLA-307045 (Promise) and on my
> > Western Digital CAC420400D (VIA KT133, the disk looks like an IBM
> > DJNA-352030 OEM, though).
> >
> > However, would you care to elaborate how switching OFF the cache
> > should harm data, provided you don't need to cater for power outages
> > (UPS attached, e. g.)?
>
> It's a very remote possability of failure, like most instances where
> write-cache would cause problems. Catastrophic failure of the IDE cable
> in mid-write will cause problems. If write cache is enabled, the write
> stands a higher chance of having made it to the drive before the cable
> died, with it off, it stands a higher chance of NOT having made it
> entirely to the drive.

Catastrophic failure of the IDE cable???.
What are you doing to the poor thing, jumping on it?

Anyway, with a UPS, the issue of IDE device write caching is fairly moot.
As long as power is applied, any write issued to the drive will be
completed regardless of whether write caching is on or off. I am fairly
certain the write caching is pretty conservative, which is write as soon
as possible after elavating with other write requests and giving read
requests priority.

I can imagine how it improves sequenial write performace too. With the
write cache off, the computer cannot send another write request to the IDE
device until the last one had finished. By the time the computer is told
the request was finished and it has sent a new request to the drive, the
disk would have spun out of the place it was supposed to be placed. The
drive will then have to wait for the disk to spin around fully again
before doing the write. With the write cache enabled, several requests can
be placed into the drive buffer and written in the single revolution of
the drive.

Beau Kuiper
kuib-kl@ljbc.wa.edu.au


