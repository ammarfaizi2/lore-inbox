Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319009AbSICX1C>; Tue, 3 Sep 2002 19:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319010AbSICX1C>; Tue, 3 Sep 2002 19:27:02 -0400
Received: from warden-b.diginsite.com ([208.29.163.249]:42395 "HELO
	wardenb.diginsite.com") by vger.kernel.org with SMTP
	id <S319009AbSICX1A>; Tue, 3 Sep 2002 19:27:00 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Date: Tue, 3 Sep 2002 16:24:00 -0700 (PDT)
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <200209032242.g83MglG21464@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44.0209031623010.1889-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

but now you are changing the on-disk format of each filesystem.

good luck in getting microsoft to change NTFS to allow you to do this (let
alone the others like XFS and JFS that are maintaining compatability with
other operating systems)

David Lang

 On Wed, 4 Sep 2002, Peter T. Breuer wrote:

> Date: Wed, 4 Sep 2002 00:42:47 +0200 (MET DST)
> From: Peter T. Breuer <ptb@it.uc3m.es>
> To: Anton Altaparmakov <aia21@cantab.net>
> Cc: Peter T. Breuer <ptb@it.uc3m.es>, david.lang@digitalinsight.com,
>      linux-kernel@vger.kernel.org
> Subject: Re: (fwd) Re: [RFC] mount flag "direct"
>
> "Anton Altaparmakov wrote:"
> [snip detailed description for which I am extremely grateful]
> > Ok, so to do a 1 byte read, we just had to perform over 10-20 reads from
> > very different disk locations (we are talking several seconds _just_ in
> > seek times, never mind read times!), we had to allocate a lot of memory
> > buffers to store metadata which we have read from disk temporarily, as well
> > as a lot of memory in order to be able to decompress the mapping pair
> > arrays which tell us the logical to physical block mapping.
> >
> > I am completely serious, we are talking at least hundreds of milliseconds
> > possibly even several seconds to read that single byte.
> >
> > What was that about 50GiB/sec performance again...?
>
> Let's maintain a single bit in the superblock that says whether  any
> directory structure or whatever else we're worried about has been
> altered (ecch, well, it has to be a timestamp, never mind ..). Before
> every read we check this "bit" ondisk. If it's not set, we happily dive
> for our data where we expect to find it. Otherwise we go through the
> rigmarole you describe.
>
> Maybe our programs aren't going to do unexpected things with the file
> structures. Maybe our file systems satisfy assumptions like not
> moving existing data ondisk to make room for other data. I'd be willing
> to only consider such systems as sane enough to work with in a
> distributed shared environment.
>
> Can we improve the single-bit approach? Yes. The FS is a tree. When
> we make a change in it we can set a bit everywhere above the change,
> all the way to the root. When we observe the root bot changed, we
> can begin to retrace the path to our data, but abandon the retrace
> when the bit-trail we are following down towards our data turns cold.
>
> No?
>
> Peter
>
