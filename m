Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312427AbSC3V1p>; Sat, 30 Mar 2002 16:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312397AbSC3V1f>; Sat, 30 Mar 2002 16:27:35 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:19909 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S312510AbSC3V1V>; Sat, 30 Mar 2002 16:27:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Randy Hron <rwhron@earthlink.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: Linux 2.4.19-pre5
Date: Sat, 30 Mar 2002 16:33:01 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <20020330135333.A16794@rushmore> <3CA616B2.1F0D8A76@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16rQNU-00007G-00@gull.prod.itd.earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > run.  More importantly, read_latency2 drops max latency
> > with 32-128 tiobench threads from 300-600+ seconds
> > down to 2-8 seconds.  (2.4.19-pre5 is still unfair
> > to some read requests when threads >= 32)
> 
> These numbers are surprising.  The get_request starvation
> change should have smoothed things out.   Perhaps there's
> something else going on, or it's not working right.  If
> you could please send me all the details to reproduce this
> I'll take a look.  Thanks.

There was an improvement (reduction) in max latency
during sequential _writes after get_request starvation 
went in.  Tiobench didn't show an improvement for seq _read 
max latency though.  read_latency2 makes the huge difference.

The sequential read max latency walls for various trees looks like:
tree		# of threads
rmap		128
ac		128
marcelo		32
linus		64
2.5-akpm-everything	>128 
2.4 read latency2	>128

I.E. tiobench with threads > the numbers above would probably
give the impression the machine was locked up or frozen if your
read request was the unlucky max.  The average latencies are 
generally reasonable.  It's the max, and % of high latency
requests that varies most between the trees.

Using the updated tiobench.pl in 
http://prdownloads.sourceforge.net/tiobench/tiobench-0.3.3.tar.gz
(actually - http://home.earthlink.net/~rwhron/kernel/tiobench2.pl
which is very similar to the one in tiobench-0.3.3) 

On the 4 way 4GB box:
./tiobench.pl --size 8192 --numruns 3 --block 16384 --threads 1 \
--threads 32 --threads 64 --threads 128 --threads 256.

On the k6-2 with 384M ram:
/tiobench.pl --size 2048 --numruns 3 --threads 8 --threads 16 \
--threads 32 --threads 64 --threads 128

> http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre5/

Thanks for updating read_latency2!  I'm trying it and your other
patches on 2.4.19-pre5. :)
