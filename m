Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262108AbREZAZd>; Fri, 25 May 2001 20:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262202AbREZAZX>; Fri, 25 May 2001 20:25:23 -0400
Received: from dewey.mindlink.net ([204.174.16.4]:60684 "EHLO
	dewey.paralynx.net") by vger.kernel.org with ESMTP
	id <S262108AbREZAZF>; Fri, 25 May 2001 20:25:05 -0400
Subject: Re: PROBLEM: Alpha SMP Low Outbound Bandwidth
From: Jay Thorne <Yohimbe@userfriendly.org>
To: George France <france@handhelds.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01052519312101.28075@shadowfax.middleearth>
In-Reply-To: <990827407.27355.2.camel@gracie.userfriendly.org>
	<01052518523300.28075@shadowfax.middleearth>
	<990831934.27357.4.camel@gracie.userfriendly.org> 
	<01052519312101.28075@shadowfax.middleearth>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 25 May 2001 17:25:03 -0700
Message-Id: <990836703.27355.6.camel@gracie.userfriendly.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 May 2001 19:31:21 -0400, George France wrote:
> On Friday 25 May 2001 19:05, Jay Thorne wrote:
> > On 25 May 2001 18:52:33 -0400, George France wrote:
> > > Hello Jay,
> > >
> > > I see that you are using the tulip driver.  Could you try the de4x5
> > > driver??
> >
> > Its worse: reports 3.1 MBs and 1.6 MBs
> 
> wuftp is not exactly a performance benchmark, have you tried 'netperf'?
> 
> --George

While I agree with you completely that wuftpd is not exactly a
performance leader, this is the simplest way to recreate a problem I was
having with a much more complex setup involving apache and SMP and a
whole bunch of things. 

I posted 2 weeks ago and got no response, I assume because everyone
thought it was my software. After reducing the problem to eliminate the
possibility that my code is the real problem, I'm left with a quite
repeatable state. I have two nearly identical machines, one with 466 mhz
cpus the other with 400mhz, and they both do the same thing. The
via-rhine performs similarly to the de4x5.

Netperf is a pretty good idea. Should not be a cpu bottleneck. Thats a
good thing. So pretty much the same results as wu-ftpd: Note that I used
the 466 mhz quad with a via-rhine, since the 400 locked up and was still
fscking when I started this test.

             Recv   Send    Send                          
             Socket Socket  Message  Elapsed              
             Size   Size    Size     Time     Throughput  
             bytes  bytes   bytes    secs.    10^6bits/sec  

To alpha     87380  16384  16384    10.02      39.25   
x86 local    87380  16384  16384    9.99      559.46
alpha local  87380  16384  16384    10.01     547.27   
alp to x86   87380  16384  16384    10.01      25.77   
another x86  87380  16384  16384    9.99      553.67   
to same x86  87380  16384  16384    10.00      82.79   
and back     87380  16384  16384    10.00      93.89   

But Wu-ftpd is an easy to set up test bench, and is ubiquitous enough
that anyone with an alpha running SMP can test it. Note that this
software and the server in question were tested to run at 10+ megabytes
per second with x86 boxes. The server is a PIII500 running 2.4.4, so its
not like I'm comparing apples to oranges. The second x86 is an athlon
600.

So even factoring out wuftp is not helping much here. I'm fairly
convinced that something is strange because after the de4x5 test, the
box locked up. So either a> I have two identically boned 4 cpu boxen
or b> the interprocessor/locking/resource management has some kind of
problem. Note that under uniprocessor I get near identical to x86
performance, clock for clock and no lock ups.


-- 
--
Jay Thorne Manager, Systems & Technology, UserFriendly Media, Inc.

