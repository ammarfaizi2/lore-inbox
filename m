Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315937AbSETMqd>; Mon, 20 May 2002 08:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSETMqc>; Mon, 20 May 2002 08:46:32 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:62962 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315937AbSETMqa>; Mon, 20 May 2002 08:46:30 -0400
Date: Mon, 20 May 2002 08:46:11 -0400
To: linux-kernel@vger.kernel.org
Cc: kravetz@us.ibm.com, jamagallon@able.es, rml@tech9.net
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020520084611.A14924@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, May 07, 2002 at 04:39:34PM -0700, Robert Love wrote:
> > It is just for pipes we previously used sync, no?

On Tue, 7 May 2002 16:48:57 -0700, Mike Kravetz wrote
> That's the only thing I know of that used it.

> I'd really like to know if there are any real workloads that
> benefited from this feature, rather than just some benchmark.
> I can do some research, but was hoping someone on this list
> might remember.  If there is a valid workload, I'll propose
> a patch.  

On Mon, 13 May 2002 02:06:31 +0200, J.A. Magallon wrote: 
> - Re-introduction of wake_up_sync to make pipes run fast again. No idea
> about this is useful or not, that is the point, to test it

2.4.19-pre8-jam2 showed slightly better performance on the quad Xeon
for most benchmarks with 25-wake_up_sync backed out.  However, it's
not clear to me 25-wake_up_sync was proper patch to backout for this
test, as there wasn't a dramatic change in Pipe latency or bandwidth
without it.  

There was a > 300% improvement lmbench Pipe bandwidth and latency 
comparing pre8-jam2 to pre7-jam6.  

Average of 25 lmbench runs on jam2 kernels, 12 on the others:
2.4.19-pre8-jam2-nowuos (backed out 25-wake_up_sync patch)

*Local* Communication latencies in microseconds - smaller is better
                                 AF     
kernel                   Pipe   UNIX   
-----------------------  -----  -----  
2.4.19-pre7-jam6         29.51  42.37  
2.4.19-pre8              10.73  29.94  
2.4.19-pre8-aa2          12.45  29.53  
2.4.19-pre8-ac1          35.39  45.59  
2.4.19-pre8-jam2          7.70  15.27  
2.4.19-pre8-jam2-nowuos   7.74  14.93  


*Local* Communication bandwidths in MB/s - bigger is better
                                   AF  
kernel                    Pipe    UNIX 
-----------------------  ------  ------
2.4.19-pre7-jam6          66.41  260.39
2.4.19-pre8              468.57  273.32
2.4.19-pre8-aa2          418.09  273.59
2.4.19-pre8-ac1          110.62  241.06
2.4.19-pre8-jam2         545.66  233.68
2.4.19-pre8-jam2-nowuos  544.57  246.53

The kernel build test, which applies patches through a pipe
and compiles with -pipe didn't reflect an improvement.

kernel                   average  min_time  max_time  runs  notes
2.4.19-pre7-jam6           237.0       235       239     3  All successful
2.4.19-pre8                239.7       238       241     3  All successful
2.4.19-pre8-aa2            237.7       237       238     3  All successful
2.4.19-pre8-ac1            239.3       238       241     3  All successful
2.4.19-pre8-jam2           240.0       238       241     3  All successful
2.4.19-pre8-jam2-nowuos    238.7       236       241     3  All successful

I don't know how much of the kernel build test is dependant on
pipe performance.  There is probably a better "real world"
measurement.  

On a single processor box, there was an improvement on kernel build
between pre7-jam6 and pre8-jam2.  That was only on one sample though.

Xeon page:
http://home.earthlink.net/~rwhron/kernel/bigbox.html

Latest on uniproc:
http://home.earthlink.net/~rwhron/kernel/latest.html

-- 
Randy Hron

