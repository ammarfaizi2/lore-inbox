Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312358AbSCaUGQ>; Sun, 31 Mar 2002 15:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312363AbSCaUGH>; Sun, 31 Mar 2002 15:06:07 -0500
Received: from gw.wmich.edu ([141.218.1.100]:31949 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S312358AbSCaUFt>;
	Sun, 31 Mar 2002 15:05:49 -0500
Subject: Re: Linux 2.4.19-pre5
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Randy Hron <rwhron@earthlink.net>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <E16reZK-0001IL-00@pintail.mail.pas.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 31 Mar 2002 15:05:36 -0500
Message-Id: <1017605142.641.119.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-03-31 at 07:42, Randy Hron wrote:
> > In this test I wanted to see this lag.  
> 
> Just to be clear on what the "max latency" number is, it's the I/O
> request within tiobench that waited the longest.  I.E. The process notes
> the time before it's ready to make the request, then notes the time
> after the request is fullfilled.  With a 2048MB file and a 4096 byte
> block, there may be over 500,000 requests.  
> 
> It's a relatively small number of requests that have the big latency
> wait, so depending on the I/O requests your other applications make
> during the test, a long wait may not be obvious, unless one or your
> I/O's gets left at the end of the queue for a long time. 
> 
> This is sometimes referred to as a "corner case".  
> 
> The point where the "# of threads" manifests the "big latency
> wall" is to note a dramatic change in longest I/O latency. This
> point varies between the kernel trees.
> 
> The "big latency phenomenon" has been in the 2.4 tree at least
> since 2.4.17 which is the first kernel I have this measurement
> for.  It probably goes back much further.
> 
> read_latency2
> -------------
> I tested read_latency2 with 2.4.19-pre5.    pre5 vanilla hits
> a wall at 32 tiobench threads for sequential reads.  With
> read_latency2, the wall is around 128.
> 
> For random reads, pre5 hits a wall at 64 threads.  With
> read_latency2, the wall is not apparent even with 128 threads.
> 
> read_latency2 appears to reduce sequential write latency
> too, but not as dramatically as in the read tests.
> 


I think the preempt kernel shows is that the big latency phenomenon does
not manifest. Rather, if there is a latency spike, it's effect does not
hurt the preempt kernel because that latency is contained within that
process only, it will not effect other processes.  At least that's what
I observed with tiobench.   Do you have any tests specifically that
you'd like me to run to somehow show this wall?    I understand that
there is a latency problem in the kernels ... but the factor that makes
the big difference is whether this is detrimental to things not creating
the problem.  You said it makes the box look like it's halted in your
tests, I saw no such thing.  

Heh, maybe i'm confused on your definition of the wall.  I understand
the latency wall as the point where latency makes the computer
unreactive to the user. If this is true then the preempt kernel has no
wall as far as I can see, at normal priorities it is always reactive to
the user with tiobench.  

If it's just a point where latency >2s is above a certain arbituary
number, then it really depends on the media you're running the io test
on.  

Also, how is it possible to get >100% cpu efficiency, as shown in some
of my results for tiobench? 

Perhaps you see this wall because of how the kernel decides what to swap
in and out of it's swap space.  If you keep your swapfile on the drive
you're testing on, you would create periods which nothing responds as
the system tries swapping it back in, as well as slowing down your
test.   I keep swap on a separate drive on a different controller.
Although, I get little swap activity, couple KB during the test after a
few runs.  Ok, i'm out of ideas.

