Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312928AbSECNja>; Fri, 3 May 2002 09:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312991AbSECNj3>; Fri, 3 May 2002 09:39:29 -0400
Received: from goose.mail.pas.earthlink.net ([207.217.120.18]:61076 "EHLO
	goose.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S312928AbSECNj1>; Fri, 3 May 2002 09:39:27 -0400
Date: Fri, 3 May 2002 09:38:56 -0400
To: gh@us.ibm.com
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020503093856.A27263@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Rumor is that on some workloads MQ it outperforms O(1), but it
> > > may be that the latest (post K3?) O(1) is catching up?

Is MQ based on the Davide Libenzi scheduler? 
(a version of Davide's scheduler is in the -aa tree).

> > I'd be interested to know what workloads ?

> AIM on large CPU count machines was the most significant I had heard
> about.  Haven't measured recently on database load - we made a cut to
> O(1) some time back for simplicity.  Supposedly volanomark was doing
> better for a while but again we haven't cut back to MQ in quite a while;
> trying instead to refine O(1).  Volanomark is something of a scheduling
> anomaly though - sender/receiver timing on loopback affects scheduling
> decisions and overall throughput in ways that may or may not be consistent
> with real workloads.  AIM is probably a better workload for "real life"
> random scheduling testing.

tbench 192 is an anomaly test too.  AIM looks like a nice
"mixed" bench.  Do you have any scripts for it?  I'd like 
to use AIM too.

A side effect of O(1) in ac2 and jam6 on the 4 way box is a decrease 
in pipe bandwidth and an increase in pipe latency measured by lmbench:

kernel                    Pipe bandwidth in MB/s - bigger is better
-----------------------  ------
2.4.16                   383.93
2.4.19-pre3aa2           316.88
2.4.19-pre5              385.56
2.4.19-pre5-aa1          345.93
2.4.19-pre5-aa1-2g-hio   371.87
2.4.19-pre5-aa1-3g-hio   355.97
2.4.19-pre7              462.80
2.4.19-pre7-aa1          382.90
2.4.19-pre7-ac2           85.66
2.4.19-pre7-jam6          66.41
2.4.19-pre7-rl           464.60
2.4.19-pre7-rmap13       453.24

kernel                   Pipe latency in microseconds - smaller is better
-----------------------  -----
2.4.16                   12.73
2.4.19-pre3aa2           13.58
2.4.19-pre5              12.98
2.4.19-pre5-aa1          13.46
2.4.19-pre5-aa1-2g-hio   12.83
2.4.19-pre5-aa1-3g-hio   13.08
2.4.19-pre7              10.71
2.4.19-pre7-aa1          13.32
2.4.19-pre7-ac2          31.95
2.4.19-pre7-jam6         29.51
2.4.19-pre7-rl           10.71
2.4.19-pre7-rmap13       10.75

More at:
http://home.earthlink.net/~rwhron/kernel/bigbox.html

-- 
Randy Hron

