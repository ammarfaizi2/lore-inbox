Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbTJPDB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 23:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbTJPDB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 23:01:56 -0400
Received: from CPE-24-163-213-80.mn.rr.com ([24.163.213.80]:38811 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S262640AbTJPDBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 23:01:52 -0400
Subject: Re: Transparent compression in the FS
From: Shawn <core@enodev.com>
To: Chris Meadors <clubneon@hereintown.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1066270291.514.17.camel@clubneon.clubneon.com>
References: <200310151854.TAA09370@mauve.demon.co.uk>
	 <1066270291.514.17.camel@clubneon.clubneon.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1066273302.22768.23.camel@www.enodev.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 15 Oct 2003 22:01:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You know, I've seen a lot of mostly-N/A benchmarks, but no real-world
examples. I've seen many folks talking back and forth about data
throughput, but little talk of I/O latency.

Regardless what your unloaded CPU can do, does anyone care to realize
that your CPU usually has to act on the data you're reading/writing from
said filesystem, probably at the expense of throughput?

Now, this is not to say that certain workloads wouldn't benefit
tremendously from compression, especially these days when we seem to
have processor to spare. I may have a giganimonstrous file full of zeros
I just need to read from and write to... I actually remember working
with "Jam drive" (a "Stacker" work-alike) on DOS which really did make
my little 33 Mhz box throw up X-appeal
(http://www.xtreme.it/xappeal.html) twice as fast... That was a good
real-world example relevant to me.

Anyway, I guess I'm not arguing for or against anything here. Just
trying to make people realize most of the benchmarks cited do NOT
represent the common scenario.

Also, I would hope that if ext3+compressFS existed I could mount a
compressed ext3 filesystem as vanilla ext3 and gunzip/bunzip2 a file I
know to be compressed to recover the data. Nice to have [back|for]ward
compatibility.

On Wed, 2003-10-15 at 21:11, Chris Meadors wrote:
> On Wed, 2003-10-15 at 14:54, root@mauve.demon.co.uk wrote:
> 
> > I haven't got the original message (mail problems) so I'm responding here.
> > 
> > I misread your message, and thought you said compression.
> > My Duron 1300 (hardly the fastest machine) compresses (gzip -1) at around
> > 40Mb/sec (repetitive log-files that compress to 5% using gzip -1) and 
> > 10Mb/sec on text (compressing to 40%).
> > 
> > On expansion, it decompresses compressed text at around 14Mb/sec (resulting
> > in 30Mb/sec, around my disk speed), and logfiles at 110Mb/sec, which is 
> > significantly faster.
> > 
> > This is with a single stick of PC133 RAM, and a tiny 64K cache.
> > I would be very surprised if even a high end consumer machine couldn't handle
> > 50Mb/sec.
> 
> chris@prime:/tmp$ dd if=/dev/urandom of=random_data bs=1024 count=100k
> 102400+0 records in
> 102400+0 records out
> chris@prime:/tmp$ time gzip -9 random_data
>  
> real    0m10.572s
> user    0m10.271s
> sys     0m0.298s
> chris@prime:/tmp$ time gunzip random_data.gz
>  
> real    0m1.506s
> user    0m1.205s
> sys     0m0.301s
> chris@prime:/tmp$ time gzip -1 random_data
>  
> real    0m9.959s
> user    0m9.632s
> sys     0m0.326s
> chris@prime:/tmp$ time gunzip random_data.gz
>  
> real    0m1.523s
> user    0m1.218s
> sys     0m0.305s
> 
> 
> chris@prime:/tmp$ dd if=/dev/zero of=zero_data bs=1024 count=100k
> 102400+0 records in
> 102400+0 records out
> chris@prime:/tmp$ time gzip -9 zero_data
>  
> real    0m2.947s
> user    0m2.812s
> sys     0m0.134s
> chris@prime:/tmp$ time gunzip zero_data.gz
>  
> real    0m1.062s
> user    0m0.920s
> sys     0m0.142s
> chris@prime:/tmp$ time gzip -1 zero_data
>  
> real    0m1.840s
> user    0m1.717s
> sys     0m0.123s
> chris@prime:/tmp$ time gunzip zero_data.gz
>  
> real    0m0.707s
> user    0m0.542s
> sys     0m0.165s
> 
> 
> I can get pretty close to 50MB/sec compressing a nice long string of
> zeros.  Over 100MB/sec decompressing the same.  But from the first test,
> spinning my wheels on relatively uncompressible data gets me no where
> slowly.
> 
> Of course the disk subsystem of this machine is also a hardware RAID
> array of 8 (4 per channel) 10,000 RPM SCSI U320 drives.  So I'm not
> approaching the speeds that I can get from it anyway.
