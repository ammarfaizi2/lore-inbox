Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286202AbRLJIgg>; Mon, 10 Dec 2001 03:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286199AbRLJIgS>; Mon, 10 Dec 2001 03:36:18 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32782
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S286196AbRLJIf5>; Mon, 10 Dec 2001 03:35:57 -0500
Date: Mon, 10 Dec 2001 00:31:22 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
cc: linux-raid@vger.kernel.org
Subject: Re: IDE-DMA woes
In-Reply-To: <00fa01c1804e$0428ed40$140ba8c0@mistral>
Message-ID: <Pine.LNX.4.10.10112091910400.23503-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2001, Simon Turvey wrote:

> 
> >Like I told you in the other forum.  I have the solutions just my work is
> >being refused.  Don't know if I have absolutely pissed off the
> >king-penguin or what but there is no reason to submit when I know it is
> >not going to be accepted
> 
> Andre,
>     Any chance of some further details on this work.  AFAIKT you've been the
> foremost contributor of cutting-edge IDE updates for quite some time now.  I
> find it astonishing that Linus would have inexplicably started refusing your
> code.  At least point us in the right direction so we can try the new stuff
> out.
> 
> Simon

I am working on a final update right now.  This is after fixing the driver
to perform correct data-transport layers.  This is linux soft-raid 0 w/
four drives.  The are 4-20GB drives partitioned to make two md devices to
isolate peformance boundaries.

Writing superblocks and filesystem accounting information: done
No size specified, using 510 MB
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/sec

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     510    4096    1  84.75 57.1% 1.081 1.17% 79.80 43.9% 4.285 2.46%
   .     510    4096    2  78.88 52.8% 1.171 0.97% 73.64 48.8% 4.411 3.67%
   .     510    4096    4  74.04 51.3% 1.402 1.16% 73.77 51.9% 4.391 3.65%
   .     510    4096    8  67.93 47.9% 1.623 1.42% 71.43 52.1% 4.360 3.62%

File './Bonnie.943', size: 1073741824, volumes: 1
Writing with putc()...  done:   9709 kB/s  98.9 %CPU
Rewriting...            done:  49883 kB/s  41.4 %CPU
Writing intelligently...done:  99026 kB/s  50.0 %CPU
Reading with getc()...  done:   9663 kB/s  99.1 %CPU
Reading intelligently...done:  89632 kB/s  55.0 %CPU
Seeker 1...Seeker 2...Seeker 3...start 'em...done...done...done...
              ---Sequential Output (nosync)--- ---Sequential Input-- --Rnd Seek-
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04k (03)-
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec %CPU
       1*1024  9709 98.9 99026 50.0 49883 41.4  9663 99.1 89632 55.0  344.2  4.0


Wrote 38184 Meg / 78201343 blocks 0 Meg / 0 blocks
Device length: 40038825984 Bytes / 38184 Meg / 37 Gig
Total Diameter Sequential Pattern Write Test = 96.10 MB/Sec (397.35 Seconds)
Read 38183Meg (78198784 blocks)
Read failed on block number 78200832 at offset 40038825984 ( 0 / 512 )
  Error: Input/output error
Could not find block: 78200833 for reading.
  Error: Invalid argument
Read 38184Meg (78200833 blocks)
Device length: 40038825984 Bytes / 38184 Meg / 37 Gig
Total Diameter Sequential Pattern Read Test  = 75.68 MB/Sec (504.53 Seconds)
Device passed! Seek OverRun!

The test has an overrun on the last request under lseek, working on fixing.

The slower read rate is a direct result of using a pattern buffer check
and comparison (write/read/verify/compare/contest-errors).  Details later
but the drive(s) are faster than reported.  These rates are using EXT2 for
the FS.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project


