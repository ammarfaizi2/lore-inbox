Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSHAOov>; Thu, 1 Aug 2002 10:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSHAOov>; Thu, 1 Aug 2002 10:44:51 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:22231 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S314584AbSHAOot>; Thu, 1 Aug 2002 10:44:49 -0400
Subject: Re: Linux v2.4.19-rc5
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Steven Cole <scole@lanl.gov>
In-Reply-To: <3D48F915.3FADA08F@zip.com.au>
References: <20020801074953.GJ1644@suse.de>
	<Pine.LNX.4.44.0208010406230.1728-100000@freak.distro.conectiva>
	<20020801081010.GA1096@suse.de>  <3D48F915.3FADA08F@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 01 Aug 2002 08:45:20 -0600
Message-Id: <1028213120.3085.88.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 03:02, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > ...
> > > Anyway, lets wait for the numbers.
> > 
> > It just 'feels' like the sort of change that might have odd side
> > effects.
> 
> It's almost impossible to get READA to do anything.  For example, in
> current 2.5, if a READA attempt is actually aborted, end_buffer_io_sync
> reports a "buffer I/O error".  Every time. And nobody has reported this.
> 
> It _is_ possible to hit this in 2.5, because of ext2_preread_inode().
> 
> Probably, also it's possible to hit it in 2.4 with hundreds of processes
> all issuing ext3 directory readahead.  But it's pretty remote.

I've never seen this on 2.4.19-rc3 and I've been beating on it pretty
hard, running dbench 128 many times.  However, 2.5 is another story.

This might not be the best thread to report this, but since the subject 
came up, I'm getting the following message with recent 2.5.x kernels
whenever I run relatively large numbers of dbench clients.  

Buffer I/O error on device sd(8,8), logical block XXXXXXX

where logical block repeats 0-6 times.  This behavior is repeatable, but
only occurs under fairly high load.  I ran dbench with increasing numbers
of clients, with the following results:

dbench clients	Buffer I/O error messages
>=48		0
52		1
56		0
64		0
80		11
96		9
112		7
128		4

This particular run was with 2.5.29 with rmap13b and slabLRU patches, but the behavior with 2.5.29-vanilla was similar.  Kernel is SMP, no preempt,
and /dev/sda8 where dbench was running was mounted ext2.
The test box is 2-way p3, SCSI, 1GB memory.

Time to go beat on -rc5 and see if anything falls out.

Steven




