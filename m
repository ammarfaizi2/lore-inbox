Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268719AbTCCTCp>; Mon, 3 Mar 2003 14:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268720AbTCCTCg>; Mon, 3 Mar 2003 14:02:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:33520 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268719AbTCCTB5>;
	Mon, 3 Mar 2003 14:01:57 -0500
Date: Mon, 3 Mar 2003 11:08:34 -0800
From: Andrew Morton <akpm@digeo.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63-mjb2 (scalability / NUMA patchset)
Message-Id: <20030303110834.031e6d98.akpm@digeo.com>
In-Reply-To: <20030303131955.GA4655@rushmore>
References: <20030303131955.GA4655@rushmore>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2003 19:12:17.0936 (UTC) FILETIME=[CEC9D100:01C2E1B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
>
> > Pleeeeeeze remember to specify basic things such as the machine,
> > amount of memory and especially the filesystem type in use.
> 
> >> on uniprocessor K6/2 475 Mhz with 384 MB ram
> and two IDE drives on ext2.

Ah, thanks.

> Could it be a disk driver issue?  Maybe 2.4 has some IDE
> enhancements that aren't in 2.5 yet.

Well I tested the AIM7 dbase workload yesterday on 256MB IDE.  2.4 and 2.5
have the same throughput, down to a fraction of one percent.  The entire
working set appeared to be around 200MB so there was no reading from disk at
all.  Just 25 minutes of trickling out very slow O_SYNC writes.  The thing is
dominated by disk seek time.

> Here is AIM7 dbase on quad Xeon with 3.75 GB ram over ext2:
> 
> AIM7 dbase workload
> kernel                   Tasks   Jobs/Min         Real    CPU  
> 2.5.62-mm2               32     555.9            342.0   155.2 
> 2.4.21-pre4aa1           32     554.4            342.8   142.3 
> 2.4.21-pre4aa3           32     551.9            344.4   149.6 
> 2.4.21-pre4-ac3          32     473.8            401.2   147.7 
> 2.5.62                   32     473.6            401.3   148.2 
> 2.5.63-mjb2              32     472.5            402.3   161.5 
> 2.5.63                   32     471.6            403.1   153.1 
> 2.2.24-rc3               32     431.9            440.1   165.7 
> 
> 2.5.62-mm2 has the feral driver.  aa has the QLogic 6.x driver.

Well if there is any difference in drive caching policy then one would expect
to see large differences.  Using writeback caching in the disk (which is
considered cheating) would speed things up.  But I'd be surprised if
2.5-vs-2.4 IDE affected the drive's caching policy.

> Those two kernels rule AIM7 dbase and fserver on quad Xeon with
> QLA2200.  I tested earlier 2.5 and aa with/without the newer
> QLogic drivers.  It was _the_most_important_ factor for AIM7
> dbase and fserver.  Perhaps AIM7 dbase and fserver really suck.
> They seem rather impervious to other improvements in the kernel.

Yes, they do.

> > Care to share your aim7 database methodology with me?
> 
> AIM7 dbase takes a mixture of AIM9 micro activities and runs 
> them in proportion to what it's developers found a circa 1996 
> database running.  

AIM7 dbase would probably be more interesting if it created a larger working
set.

