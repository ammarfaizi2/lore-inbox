Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSHAUP0>; Thu, 1 Aug 2002 16:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317002AbSHAUP0>; Thu, 1 Aug 2002 16:15:26 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:23492 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S316996AbSHAUPY>; Thu, 1 Aug 2002 16:15:24 -0400
Subject: Re: Linux v2.4.19-rc5
From: Steven Cole <elenstev@mesatop.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Steven Cole <scole@lanl.gov>
In-Reply-To: <Pine.LNX.4.44.0208010406230.1728-100000@freak.distro.conectiva>
References: <Pine.LNX.4.44.0208010406230.1728-100000@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 01 Aug 2002 14:15:45 -0600
Message-Id: <1028232945.3147.99.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 01:14, Marcelo Tosatti wrote:
> 
> On Thu, 1 Aug 2002, Jens Axboe wrote:
> 
> > On Thu, Aug 01 2002, Marcelo Tosatti wrote:
> > > <akpm@zip.com.au> (02/08/01 1.663)
> > > 	[PATCH] disable READA
> >
> > Since -rc5 is not to be found yet, I don't know what version of this
> > made it in. Is READA just being disabled on SMP, or was it the general
> > #if 0 change that got included?
> 
> Its being disabled on UP and SMP. I dont like having such readahead IO
> mode working only for UP.
> 
> > I'm asking since plain disabling READA might have nasty performance
> > effects. Andrew, I bet you did some numbers on this, care to share?
> 
> If thats true (the performance effects) I'll release -final with IMO not
> very coherent READA semantics :)
> 
> Anyway, lets wait for the numbers.

Marcelo,

Here are some dbench numbers, from the "for what it's worth" department.
This was done with SMP kernels, on a dual p3 box, SCSI disk, ext2.
The first column is dbench clients.  The numbers are throughput
in MB/sec.  The 2.5.29 kernel had a few RR-supplied smp fixes.
Looks like for this limited test, 2.4.19-rc5 holds up pretty well.
I've also ran this set of tests several times on -rc5 using ext3
and data=writeback, and everything looks fine.

Steven

		2.4.19-rc2	2.4.19-rc5	2.5.29

1		114.616		113.402		112.668
2		173.234		183.829		175.148
3		185.995		187.411		184.63
4		185.447		186.891		188.199
6		191.115		191.439		191.787
8		191.962		191.551		191.53
10		192.984		194.036		194.923
12		183.847		185.73		195.328
16		183.609		183.439		196.224
20		181.519		179.956		193.681
24		183.509		183.387		194.09
28		176.04		175.832		169.326
32		174.583		163.09		137.815
36		155.04		164.154		121.861
40		155.37		156.028		102.014
44		152.546		138.171		91.6088
48		146.419		135.447		84.3884
52		139.788		125.968		89.2374
56		113.933		122.592		81.021
64		110.792		106.484		84.648
80				87.4692		60.6054
96				87.7201		57.9622
112				74.9503		49.468
128				67.2649		47.0254



