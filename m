Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261208AbSIPMpj>; Mon, 16 Sep 2002 08:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261211AbSIPMpj>; Mon, 16 Sep 2002 08:45:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:51338 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261208AbSIPMpi>; Mon, 16 Sep 2002 08:45:38 -0400
Date: Mon, 16 Sep 2002 08:52:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: jdow <jdow@earthlink.net>
cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Heuristic readahead for filesystems
In-Reply-To: <002a01c25aa3$f865b7a0$1125a8c0@wednesday>
Message-ID: <Pine.LNX.3.95.1020916082446.22214A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, jdow wrote:

> From: "Richard B. Johnson" <root@chaos.analogic.com>
> 
> > Then you are tuning a file-system for a single program
> > like `ls`. Most real-world I/O to file-systems are not done
> > by `ls` or even `make`. The extra read-ahead overhead is
> > just that, 'overhead'. Since the cost of disk I/O is expensive,
> > you certainly do not want to read any more than is absolutely
> > necessary. There had been a lot so studies about this in the
> > 70's when disks were very, very, slow. The disk-to-RAM speed
> > ratio hasn't changed much even though both are much faster.
> > Therefore, the conclusions of these studies, made by persons
> > from DEC and IBM, should not have changed. From what I recall,
> > all studies showed that read-ahead always reduced performance,
> > but keeping what was already read in RAM always increased
> > performance.
> 
> Dick, those studies are simply not meaningful. The speedup for
> general applications that I generated in the mid 80s with a pair
> of SCSI controllers for the Amiga was rather dramatic. At that
> time every PC controller I ran down was reading 512 bytes per
> transaction. They could not read contiguous sectors unless they
> were VERY fast. For these readahead would generate no benefit.
> (Even some remarkably expensive SCSI controllers for PCs fell
> into that trap and defective mindset.) The controllers I re-
> engineered were capable of reading large blocks of data multiple
> sectors in size in a single transaction. I experimented with
> several programs and discovered that a 16k readahead was about
> my optimum compromise between the read time overhead vs the
> transaction time overhead. I even found that for the average case
> ONE buffer was sufficient, which boggled me. (As a developer I
> was used to reading multiple files at a time to create object
> files and linked targets.)

Well they could read contiguous sectors if the sector interleave
was correctly determined and the correct interleave was set
while low-level formatting. Now-days, interleave is either ignored
or unavailable because there is a sector buffer that can contain
an entire track of data. Some SCSI drives have sector buffers
that can contain a whole cylinder of data.

> 
> Back in the 70s did anyone ever read more than a single block
> at a time, other than me that is? (I had readahead in CP/M back
> in the late 70s. But the evidence for that has evaporated I am
> afraid. I repeatedly boggled other CP/M users with my 8" floppy
> speeds as a result. I also added blocking and deblocking so I
> could use large sectors for even more speed.)
> 

When we were doing direct-to-disk data writing here at
Analogic around 20 years ago, I experimented with changing
the sector interleave to speed up disc I/O. The DEC disks
in use at that time on our systems had ST-506 interfaces.
I had made a similar utility, called Spin-Ok (a put-down
of Spin-Right who stole my public-domain software and 
made a commercial version), for the IBM/PC.

I had to get the privatives from Digital so I could write
a disk formatting driver. Our Chairman Bernie Gordon and
DEC's chairman Ken Olson were not exactly buddies, but we
were allowed to obtain information that might not be given
to everybody.

Some DEC engineers were interested in the results of my experiments.
It turned out that DEC's 1:1 interleave was no where near
correct for the maximum data transfer rate. I don't remember the
numbers, but I think the best speed was with a 5:1 or, perhaps,
3:1. Anyway experiments lead to using DEC file-system disks
as well as raw disks.

The file-system of the day was RMS. It had a fixed-length allocation
map which was owned by a "file" called BITMAP.SYS. This map was
contiguous and each bit in that map represented an allocation unit
on the physical structure. I proposed to DEC engineering that any
access to this file area, result in the entire map being read
into memory. I am quite aware of the "not-invented-here" syndrome
commonplace at Digital. However, one Engineer went to great lengths
presenting data and the results of his group's tests on just that
idea plus the idea of reading ahead, in general. It was shown, at
least to my satisfaction 20 years ago, that any read-ahead was
quite counter productive.

And the numbers were obvious! They didn't require any thought!

Somebody else on this thread asked for a URL! There wasn't any
such thing when this work was going on. We had BBS Systems and
1200 baud modems, eventually up to 9600. However, I did search
for some info. An interesing result is RAPID (Read Ahead for Parallel
Independent Disks)
 http://www.unet.univie.ac.at/~a9405327/glossary/node93.html

This was experimental and seems to have been abandoned in the
late 1990s although it provided a lot of meat for several Masters
and PhD thesis.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

