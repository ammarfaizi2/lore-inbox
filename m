Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRADS4C>; Thu, 4 Jan 2001 13:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131086AbRADSzw>; Thu, 4 Jan 2001 13:55:52 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:49669 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129830AbRADSzj>;
	Thu, 4 Jan 2001 13:55:39 -0500
Date: Thu, 4 Jan 2001 19:55:26 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Anton Blanchard <anton@linuxcare.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Benchmarking 2.2 and 2.4 using hdparm and dbench 1.1
In-Reply-To: <20010105004644.K13759@linuxcare.com>
Message-ID: <Pine.LNX.4.21.0101041940490.5827-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Anton Blanchard wrote:
> 
> > 1) Why does the hdbench numbers go down for 2.4 (only) when 32 MB is used?
> >    I fail to see how that matters, especially for the '-T' test.
> 
> When I did some tests long ago, hdparm was hitting the buffer cache hash
> table pretty hard in 2.4 compared to 2.2 because it is now smaller. However
> as davem pointed out, most things don't do such things so resizing the hash
> table just for this is a waste.

Where is the size defined, and is it easy to modify?

> Since the hash is based on RAM, it may end up being big enough on the 128M
> machine.

Maybe.  I have been experimenting some more, and I see that the less
memory i have, kswapd takes more and more CPU (more than 10% for some
cases) when I am doing a continuous read from a block device.

I noticed that /proc/sys/vm/freepages is not writable any more.  Is there
any reason for this?

> > The reason for doing the benchmarks in the first place is that my 32MB P90
> > at home really does perform noticeably worse with samba using 2.4 kernels
> > than using 2.2 kernels, and that bugs me.  I have no hard numbers for that
> > machine (yet).  If they will show anything extra, I will post them here.  
> 
> What exactly are you seeing?

I first noticed the slowdown because the load meter LEDs on my ethernet
hub did not go as high with 2.4 as it did with 2.2.  A simple test,
transferring a large file using smbclient, did in deed show a decrease in
performance, both for a localhost and a remote file transfer.  This in
spite of the tcp transfer rate beeing (much) higher in 2.4 than in 2.2.

> > Btw, has anyone else noticed samba slowdowns when going from 2.2 to 2.4?
> 
> I am seeing good results with 2.4 + samba 2.2 using tdb spinlocks.

Hmm...  I'm still using samba 2.0.7.  I'll try 2.2 to see if it
helps.  What are tdb spinlocks?

Have you actually compared the same setup with 2.2 and 2.4 kernels and a
single client transferring a large file, preferably from a slow server
with little memory?  Most samba servers that people benchmark are fast
computers with lots of memory.  So far, every major kernel upgrade has
given me a performance boost, even for slow computers, and I would hate to
see that trend break for 2.4...

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
