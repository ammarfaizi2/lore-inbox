Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271446AbRHOVO5>; Wed, 15 Aug 2001 17:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271449AbRHOVOs>; Wed, 15 Aug 2001 17:14:48 -0400
Received: from atlrel1.hp.com ([156.153.255.210]:50148 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S271446AbRHOVOf>;
	Wed, 15 Aug 2001 17:14:35 -0400
Message-ID: <F341E03C8ED6D311805E00902761278C04728E8F@xfc04.fc.hp.com>
From: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: re: Performance 2.4.8 is worse than 2.4.x<8 (SPEC NFS results sho
	w this)
Date: Wed, 15 Aug 2001 17:14:09 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And the results for 2.4.9pre4 (not good)

            500     492     2.6   147693  300 3 U    5070624   1 48  2  2
2.0
           1000    1019     4.4   304713  299 3 U   10141248   1 48  2  2
2.0
           1500    1475     6.1   442446  300 3 U   15210624   1 48  2  2
2.0
peak IOPS: 22% of 2.4.5pre1 
TIMED OUT

response time kept going up, only two more SPEC runs (2500 IOPS) finished.

Erik

> -----Original Message-----
> From: HABBINGA,ERIK (HP-Loveland,ex1) 
> Sent: Monday, August 13, 2001 10:41 AM
> To: 'linux-kernel@vger.kernel.org'
> Subject: re: Performance 2.4.8 is worse than 2.4.x<8 (SPEC NFS results
> show this)
> 
> 
> Here are some SPEC SFS NFS testing 
> (http://www.spec.org/osg/sfs97) results I've been doing over 
> the past few weeks that shows NFS performance degrading since 
> the 2.4.5pre1 kernel.  I've kept the hardware constant, only 
> changing the kernel.  I'm prevented by management from 
> releasing our top numbers, but have given our results 
> normalized to the 2.4.5pre1 kernel.  I've also shown the 
> results from the first three SPEC runs to show the response 
> time trend.
> 
> Normally, response time should start out very low, increasing 
> slowly until the maximum load of the system under test is 
> reached.  Starting with 2.4.8pre8, the response time starts 
> very high, and then decreases.  Very bizarre behaviour.
> 
> The spec results consist of the following data (only the 
> first three numbers are significant for this discussion)
> - load.  The load the SPEC prime client will try to get out 
> of the system under test.  Measured in I/O's per second (IOPS).
> - throughput.  The load seen from the system under test.  
> Measured in IOPS
> - response time.  Measured in milliseconds
> - total operations
> - elapsed time.  Measured in seconds
> - NFS version. 2 or 3
> - Protocol. UDP (U) or TCP (T)
> - file set size in megabytes
> - number of clients
> - number of SPEC SFS processes
> - biod reads
> - biod writes
> - SPEC SFS version
> 
> The 2.4.8pre4 and 2.4.8 tests were invalid.  Too many (> 1%) 
> of the RPC calls between the SPEC prime client and the system 
> under test failed.  This is not a good thing.
> 
> I'm willing to try out any ideas on this system to help find 
> and fix the performance degradation.
> 
> Erik Habbinga
> Hewlett Packard
> 
> Hardware:
> 4 processors, 4GB ram
> 45 fibre channel drives, set up in hardware RAID 0/1
> 2 direct Gigabit Ethernet connections between SPEC SFS prime 
> client and system under test
> reiserfs
> all NFS filesystems exported with sync,no_wdelay to insure 
> O_SYNC writes to storage
> NFS v3 UDP
> 
> Results:
> 2.4.5pre1
>             500     497     0.8   149116  300 3 U    5070624  
>  1 48  2  2 2.0
>            1000    1004     1.0   300240  299 3 U   10141248  
>  1 48  2  2 2.0
>            1500    1501     1.0   448807  299 3 U   15210624  
>  1 48  2  2 2.0
> peak IOPS: 100% of 2.4.5pre1
> 
> 2.4.5pre2
>             500     497     1.0   149195  300 3 U    5070624  
>  1 48  2  2 2.0
>            1000    1005     1.2   300449  299 3 U   10141248  
>  1 48  2  2 2.0
>            1500    1502     1.2   449057  299 3 U   15210624  
>  1 48  2  2 2.0
> peak IOPS: 91% of 2.4.5pre1
> 
> 2.4.5pre3
>             500     497     1.0   149095  300 3 U    5070624  
>  1 48  2  2 2.0
>            1000    1004     1.1   300135  299 3 U   10141248  
>  1 48  2  2 2.0
>            1500    1502     1.2   449069  299 3 U   15210624  
>  1 48  2  2 2.0
> peak IOPS: 91% of 2.4.5pre1
> 
> 2.4.5pre4
>    wouldn't run (stale NFS file handle error)
> 
> 2.4.5pre5
>    wouldn't run (stale NFS file handle error)
> 
> 2.4.5pre6
>    wouldn't run (stale NFS file handle error)
> 
> 2.4.7
>             500     497     1.2   149206  300 3 U    5070624  
>  1 48  2  2 2.0
>            1000    1005     1.5   300503  299 3 U   10141248  
>  1 48  2  2 2.0
>            1500    1502     1.3   449232  299 3 U   15210624  
>  1 48  2  2 2.0
> peak IOPS: 65% of 2.4.5pre1
> 
> 2.4.8pre1
>    wouldn't run
> 
> 2.4.8pre4
>             500     497     1.1   149180  300 3 U    5070624  
>  1 48  2  2 2.0
>            1000    1002     1.2   299465  299 3 U   10141248  
>  1 48  2  2 2.0
>            1500    1502     1.3   449190  299 3 U   15210624  
>  1 48  2  2 2.0
> INVALID
> peak IOPS: 54% of 2.4.5pre1
> 
> 2.4.8pre6
>             500     497     1.1   149168  300 3 U    5070624  
>  1 48  2  2 2.0
>            1000    1004     1.3   300246  299 3 U   10141248  
>  1 48  2  2 2.0
>            1500    1502     1.3   449135  299 3 U   15210624  
>  1 48  2  2 2.0
> peak IOPS 55% of 2.4.5pre1
> 
> 2.4.8pre7
>             500     498     1.5   149367  300 3 U    5070624  
>  1 48  2  2 2.0
>            1000    1006     2.2   301829  300 3 U   10141248  
>  1 48  2  2 2.0
>            1500    1502     2.2   449244  299 3 U   15210624  
>  1 48  2  2 2.0
> peak IOPS: 58% of 2.4.5pre1
> 
> 2.4.8pre8
>             500     597     8.3   179030  300 3 U    5070624  
>  1 48  2  2 2.0
>            1000    1019     6.5   304614  299 3 U   10141248  
>  1 48  2  2 2.0
>            1500    1538     4.5   461335  300 3 U   15210624  
>  1 48  2  2 2.0
> peak IOPS: 48% of 2.4.5pre1
> 
> 2.4.8
>             500     607     7.1   181981  300 3 U    5070624  
>  1 48  2  2 2.0
>            1000     997     7.0   299243  300 3 U   10141248  
>  1 48  2  2 2.0
>            1500    1497     2.9   447475  299 3 U   15210624  
>  1 48  2  2 2.0
> INVALID
> peak IOPS: 45% of 2.4.5pre1
> 
> 2.4.9pre2
>    wouldn't run (NFS readdir errors)
> 
