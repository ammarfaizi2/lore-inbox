Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262611AbSI0TLY>; Fri, 27 Sep 2002 15:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262609AbSI0TLY>; Fri, 27 Sep 2002 15:11:24 -0400
Received: from magic.adaptec.com ([208.236.45.80]:64177 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262608AbSI0TLW>; Fri, 27 Sep 2002 15:11:22 -0400
Date: Fri, 27 Sep 2002 13:16:16 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Andrew Morton <akpm@digeo.com>
cc: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doingfile
   transfers
Message-ID: <2561606224.1033154176@aslan.btc.adaptec.com>
In-Reply-To: <3D94AC8B.4AB6EB09@digeo.com>
References: <200209271721.g8RHLTn05231@localhost.localdomain>
 <2543856224.1033153019@aslan.btc.adaptec.com> <3D94AC8B.4AB6EB09@digeo.com>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Which unfortunately characterizes only a single symptom without breaking
>> it down on a transaction by transaction basis.  We need to understand
>> how many writes were queued by the OS to the drive between each read to
>> know if the drive is actually allowing writes to pass reads or not.
>> 
> 
> Given that I measured a two-second read latency with four tags,
> that would be about 60 megabytes of write traffic after the
> read was submitted.  Say, 120 requests.  That's with a tag
> depth of four.

I still don't follow your reasoning.  Your benchmark indicates the
latency for several reads (cat kernel/*.c), not the per-read latency.
The two are quite different and unless you know the per-read latency and
whether it was affected by filling the drive's entire cache with
pent up writes (again these are writes that are above and beyond
those still assigned tags) you are still speculating that writes
are passing reads.

If you can tell me exactly how you ran your benchmark, I'll find the
information I want by using a SCSI bus analyzer to sniff the traffic
on the bus.

--
Justin
