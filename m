Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbTJPCLe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 22:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTJPCLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 22:11:34 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:35028 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S262560AbTJPCLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 22:11:32 -0400
Subject: Re: Transparent compression in the FS
From: Chris Meadors <clubneon@hereintown.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200310151854.TAA09370@mauve.demon.co.uk>
References: <200310151854.TAA09370@mauve.demon.co.uk>
Content-Type: text/plain
Message-Id: <1066270291.514.17.camel@clubneon.clubneon.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 15 Oct 2003 22:11:31 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A9xbv-0005eS-PM*AM6PhIMzC92*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-15 at 14:54, root@mauve.demon.co.uk wrote:

> I haven't got the original message (mail problems) so I'm responding here.
> 
> I misread your message, and thought you said compression.
> My Duron 1300 (hardly the fastest machine) compresses (gzip -1) at around
> 40Mb/sec (repetitive log-files that compress to 5% using gzip -1) and 
> 10Mb/sec on text (compressing to 40%).
> 
> On expansion, it decompresses compressed text at around 14Mb/sec (resulting
> in 30Mb/sec, around my disk speed), and logfiles at 110Mb/sec, which is 
> significantly faster.
> 
> This is with a single stick of PC133 RAM, and a tiny 64K cache.
> I would be very surprised if even a high end consumer machine couldn't handle
> 50Mb/sec.

chris@prime:/tmp$ dd if=/dev/urandom of=random_data bs=1024 count=100k
102400+0 records in
102400+0 records out
chris@prime:/tmp$ time gzip -9 random_data
 
real    0m10.572s
user    0m10.271s
sys     0m0.298s
chris@prime:/tmp$ time gunzip random_data.gz
 
real    0m1.506s
user    0m1.205s
sys     0m0.301s
chris@prime:/tmp$ time gzip -1 random_data
 
real    0m9.959s
user    0m9.632s
sys     0m0.326s
chris@prime:/tmp$ time gunzip random_data.gz
 
real    0m1.523s
user    0m1.218s
sys     0m0.305s


chris@prime:/tmp$ dd if=/dev/zero of=zero_data bs=1024 count=100k
102400+0 records in
102400+0 records out
chris@prime:/tmp$ time gzip -9 zero_data
 
real    0m2.947s
user    0m2.812s
sys     0m0.134s
chris@prime:/tmp$ time gunzip zero_data.gz
 
real    0m1.062s
user    0m0.920s
sys     0m0.142s
chris@prime:/tmp$ time gzip -1 zero_data
 
real    0m1.840s
user    0m1.717s
sys     0m0.123s
chris@prime:/tmp$ time gunzip zero_data.gz
 
real    0m0.707s
user    0m0.542s
sys     0m0.165s


I can get pretty close to 50MB/sec compressing a nice long string of
zeros.  Over 100MB/sec decompressing the same.  But from the first test,
spinning my wheels on relatively uncompressible data gets me no where
slowly.

Of course the disk subsystem of this machine is also a hardware RAID
array of 8 (4 per channel) 10,000 RPM SCSI U320 drives.  So I'm not
approaching the speeds that I can get from it anyway.

-- 
Chris

