Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154468-14823>; Sat, 1 May 1999 09:31:00 -0400
Received: by vger.rutgers.edu id <153939-14821>; Sat, 1 May 1999 09:30:39 -0400
Received: from vesuri.helsinki.fi ([128.214.205.10]:2966 "EHLO vesuri.Helsinki.FI" ident: "amlaukka") by vger.rutgers.edu with ESMTP id <153993-14821>; Sat, 1 May 1999 09:30:33 -0400
From: Aki M Laukkanen <amlaukka@cc.helsinki.fi>
Message-Id: <199905011407.RAA10153@vesuri.Helsinki.FI>
Subject: Re: Performance Comparison
To: linux-kernel@vger.rutgers.edu
Date: Sat, 1 May 1999 17:07:18 +0300 (EET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: owner-linux-kernel@vger.rutgers.edu

Matthew Vanecek wrote:
> Pardon my insolence, but perhaps someone could enlighten me as to what
> this has to do with compiling?  From what I could read in the original

Alan probably misread the original message because HINT benchmark indeed
doesn't test compiling speed of a compiler or anything like that.  HINT 
is presented in this paper:

http://www.scl.ameslab.gov/Publications/HINT/ComputerPerformance.html

Basically the benchmark does a lot of heavy number crunching with a
variable data size. As the figure in the original message showed, it
is quite memory intensive. 

As we were in compilers I ran the benchmark with two different versions
of EGCS and different optimization flags. The results are shown by this
figure: 

http://www.cs.helsinki.fi/Aki.Laukkanen/hint-benchmark.gif

As with any other benchmark the compiler used does show in the results
but not terribly much. To be completely certain the benchmark should be
compiled with the same compiler, version and optimization flags which I
think wasn't the case with Otto Solares' test runs but this can't
explain all the differences.

The data size varies from about 160 bytes to over 40 megabytes with my
configuration which is a P133 (classic)/256kB L2/32 MB ram running 2.2.5-ac6.
The drop in the curve with very small data sizes I think is atleast partly
resulting from the overhead caused by the gettimeofday() calls. This is
a variable which varies from operating system to another.

The effect of the L1 cache can be seen quite clearly in this figure
though. The performance starts dropping quite sharply at around 7500
bytes. This corresponds nicely with the cache size of 8kB. The missing
500 bytes can be well explained by stack usage etc. There is an odd
quirk at 5500 bytes though, any ideas?

The curve for the segment covering the L2 cache is a lot less defined
though. This is I think where page coloring could possibly help. Once it
starts running from the main memory the curve is relatively stable
until at about 25 MB when the curve drops sharply because of swapping.

> light on, possible problems that could be addressed.  Especially if the
> benchmarks were run with a credible benchmarks package.

Yes, I agree. I suggest more people to try the HINT benchmark. The code
is ANSI-C and seems generally professional quite unlike the bytemark
benchmark.

-- 
D.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
