Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263456AbSIQBke>; Mon, 16 Sep 2002 21:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263457AbSIQBke>; Mon, 16 Sep 2002 21:40:34 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:51183 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263456AbSIQBkc>; Mon, 16 Sep 2002 21:40:32 -0400
Message-ID: <02f401c25deb$e5f87bc0$1125a8c0@wednesday>
From: "jdow" <jdow@earthlink.net>
To: <root@chaos.analogic.com>
Cc: "jw schultz" <jw@pegasys.ws>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1020916082446.22214A-100000@chaos.analogic.com>
Subject: Re: Heuristic readahead for filesystems
Date: Mon, 16 Sep 2002 18:45:27 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Richard B. Johnson" <root@chaos.analogic.com>
> On Thu, 12 Sep 2002, jdow wrote:
> 
> > From: "Richard B. Johnson" <root@chaos.analogic.com>
> > 
> > > Then you are tuning a file-system for a single program
> > > like `ls`. Most real-world I/O to file-systems are not done
> > > by `ls` or even `make`. The extra read-ahead overhead is
> > > just that, 'overhead'. Since the cost of disk I/O is expensive,
> > > you certainly do not want to read any more than is absolutely
> > > necessary. There had been a lot so studies about this in the
> > > 70's when disks were very, very, slow. The disk-to-RAM speed
> > > ratio hasn't changed much even though both are much faster.
> > > Therefore, the conclusions of these studies, made by persons
> > > from DEC and IBM, should not have changed. From what I recall,
> > > all studies showed that read-ahead always reduced performance,
> > > but keeping what was already read in RAM always increased
> > > performance.
> > 
> > Dick, those studies are simply not meaningful. The speedup for
> > general applications that I generated in the mid 80s with a pair
> > of SCSI controllers for the Amiga was rather dramatic. At that
> > time every PC controller I ran down was reading 512 bytes per
> > transaction. They could not read contiguous sectors unless they
> > were VERY fast. For these readahead would generate no benefit.
> > (Even some remarkably expensive SCSI controllers for PCs fell
> > into that trap and defective mindset.) The controllers I re-
> > engineered were capable of reading large blocks of data multiple
> > sectors in size in a single transaction. I experimented with
> > several programs and discovered that a 16k readahead was about
> > my optimum compromise between the read time overhead vs the
> > transaction time overhead. I even found that for the average case
> > ONE buffer was sufficient, which boggled me. (As a developer I
> > was used to reading multiple files at a time to create object
> > files and linked targets.)
> 
> Well they could read contiguous sectors if the sector interleave
> was correctly determined and the correct interleave was set
> while low-level formatting. Now-days, interleave is either ignored
> or unavailable because there is a sector buffer that can contain
> an entire track of data. Some SCSI drives have sector buffers
> that can contain a whole cylinder of data.

When I say contiguous I mean contiguous not interleaved, sonny. I had
CP/M (and UCSD Pascal) reading physically contiguous sectors on the
disk with no lost speed. That means I read, with my DSSD format of
9 sectors each 512 bytes in size per side 18 full tracks 19 revolutions
of the disk. I did skew the sector numbers to allow for seeks. But I
did not interleave the tracks. It was not necessary with clean and
correct code. I rather resent the presumption that I am a dumb bitch
here.

> > Back in the 70s did anyone ever read more than a single block
> > at a time, other than me that is? (I had readahead in CP/M back
> > in the late 70s. But the evidence for that has evaporated I am
> > afraid. I repeatedly boggled other CP/M users with my 8" floppy
> > speeds as a result. I also added blocking and deblocking so I
> > could use large sectors for even more speed.)
> > 
> 
> When we were doing direct-to-disk data writing here at
> Analogic around 20 years ago, I experimented with changing
> the sector interleave to speed up disc I/O. The DEC disks
> in use at that time on our systems had ST-506 interfaces.
> I had made a similar utility, called Spin-Ok (a put-down
> of Spin-Right who stole my public-domain software and 
> made a commercial version), for the IBM/PC.

I had my CP/M hard disks also working on 1:1 with a somewhat
tweaked Morrow Designs controller and a good BIOS.

> I had to get the privatives from Digital so I could write
> a disk formatting driver. Our Chairman Bernie Gordon and
> DEC's chairman Ken Olson were not exactly buddies, but we
> were allowed to obtain information that might not be given
> to everybody.

Morrow Designs provided code. That made it easy. {^_-}

> Some DEC engineers were interested in the results of my experiments.
> It turned out that DEC's 1:1 interleave was no where near
> correct for the maximum data transfer rate. I don't remember the
> numbers, but I think the best speed was with a 5:1 or, perhaps,
> 3:1. Anyway experiments lead to using DEC file-system disks
> as well as raw disks.

<snicker> It all depends on how much overhead you install bewteen
individual sector read requests. I worked very hard to get that
overhead down to a bare minimum. I also discovered that having a
local buffer from which program read requests could take place
was an invaluable speedup technique. (So in effect I was doing
readahead back in my CP/M days. Oh, I also rewrote CP/M itself
for the exercise. It proved enteraining to add some of the MP/M
features into CP/M with automatic code relocation on TSRs so that
when any one was unloaded the others moved to remove any gaps in
the resultant memory map. It was rather fun. Thanks for reminding
me of it.)

> The file-system of the day was RMS. It had a fixed-length allocation
> map which was owned by a "file" called BITMAP.SYS. This map was
> contiguous and each bit in that map represented an allocation unit
> on the physical structure. I proposed to DEC engineering that any
> access to this file area, result in the entire map being read
> into memory. I am quite aware of the "not-invented-here" syndrome
> commonplace at Digital. However, one Engineer went to great lengths
> presenting data and the results of his group's tests on just that
> idea plus the idea of reading ahead, in general. It was shown, at
> least to my satisfaction 20 years ago, that any read-ahead was
> quite counter productive.

That sounds like the filesystem UCSD Pascal used. I had it doing
1:1 interleave very early on instead of the 2:1 that it came with.

> And the numbers were obvious! They didn't require any thought!

Oh really. {^_-}

> Somebody else on this thread asked for a URL! There wasn't any
> such thing when this work was going on. We had BBS Systems and
> 1200 baud modems, eventually up to 9600. However, I did search
> for some info. An interesing result is RAPID (Read Ahead for Parallel
> Independent Disks)
>  http://www.unet.univie.ac.at/~a9405327/glossary/node93.html
> 
> This was experimental and seems to have been abandoned in the
> late 1990s although it provided a lot of meat for several Masters
> and PhD thesis.

I'll have to take a look at it, David. (That was all back in my
RF Engineering days before I "formally" adopted software as a
hobby to get paid for indulging. I did things I bloody well knew
could be done how ever erroneously my knowledge existed. I tended
to do that with RF, too. But the field is wider for software so
I find software more fun these days.)
{^_^}

