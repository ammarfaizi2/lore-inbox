Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292957AbSC3WUS>; Sat, 30 Mar 2002 17:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293151AbSC3WUJ>; Sat, 30 Mar 2002 17:20:09 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:27528 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S292957AbSC3WUB>; Sat, 30 Mar 2002 17:20:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Randy Hron <rwhron@earthlink.net>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: Linux 2.4.19-pre5
Date: Sat, 30 Mar 2002 17:25:46 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <20020330135333.A16794@rushmore> <E16rQNU-00007G-00@gull.prod.itd.earthlink.net> <1017524577.444.61.camel@psuedomode>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16rRCX-00068U-00@avocet.prod.itd.earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The sequential read max latency walls for various trees looks like:
> > tree		# of threads
> > rmap		128
> > ac		128
> > marcelo		32
> > linus		64
> > 2.5-akpm-everything	>128 
> > 2.4 read latency2	>128
> > 
> > read request was the unlucky max.  

> Is that to say an ac branch (which uses rmap) can do the 128 but is
> non-responsive?   

Thanks for testing!  The more the merrier. :)

unlucky max is the keyword above.    The average latency is okay
in general.  It's the requests that are waiting to get serviced that
may give the impression "it's locked up".   

> the feel i got when running the test was absolutely no effect on
> responsiveness even as the load hit 110.  

I see you did several runs, but the mail wrapped and it's hard to
read your results.   With 644 MB RAM, I wouldn't expect you to
see the "big latency" phenomenon with these scenerios:

128 MB datafiles 128 threads 
384 MB datafiles 1 thread
2048 MB datafiles 8 threads

> preempt patch for 2.4.19-pre4-ac3.  I guess I'll try with threads = 256

That's a good number and maybe a 4096MB datafile based on your RAM.
If you are lucky, only the test's I/O's will win the "unlucky max".
If you're not, just be patient, the machine will survive.

The big latency wall moved from 32 to 128 tiobench threads in 
2.4.19-pre9-ac3 after Alan put in rmap12e.

> just to see if this frozen feeling occurs in preempt kernels as well. 

Yeah, that will be interesting.  

> You dont seem to test them anywhere on your own site.  

Most of the tests I run measure throughput.   Tiobench has the nice
latency metric.  When I tested preempt, it generally had lower 
throughput.  Low latency is important and I'm glad Robert, 
Andrew, Ingo and all the others are improving the kernel in 
that respect.

If you're curious, there is a 2.4.18-pre3 preempt/lockbreak
and low-latency page at 
http://home.earthlink.net/~rwhron/kernel/pe.html
