Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbTCCNDp>; Mon, 3 Mar 2003 08:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTCCNDp>; Mon, 3 Mar 2003 08:03:45 -0500
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48]:50370 "EHLO
	mallard.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263760AbTCCNDo>; Mon, 3 Mar 2003 08:03:44 -0500
Date: Mon, 3 Mar 2003 08:19:55 -0500
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63-mjb2 (scalability / NUMA patchset)
Message-ID: <20030303131955.GA4655@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pleeeeeeze remember to specify basic things such as the machine,
> amount of memory and especially the filesystem type in use.

>> on uniprocessor K6/2 475 Mhz with 384 MB ram
and two IDE drives on ext2.

Could it be a disk driver issue?  Maybe 2.4 has some IDE
enhancements that aren't in 2.5 yet.  Sounds crazy, but
this is my reasoning... 

On a quad Xeon with QLA2200, the QLogic driver makes the 
biggest difference for AIM7 dbase test.

Here is AIM7 dbase on quad Xeon with 3.75 GB ram over ext2:

AIM7 dbase workload
kernel                   Tasks   Jobs/Min         Real    CPU  
2.5.62-mm2               32     555.9            342.0   155.2 
2.4.21-pre4aa1           32     554.4            342.8   142.3 
2.4.21-pre4aa3           32     551.9            344.4   149.6 
2.4.21-pre4-ac3          32     473.8            401.2   147.7 
2.5.62                   32     473.6            401.3   148.2 
2.5.63-mjb2              32     472.5            402.3   161.5 
2.5.63                   32     471.6            403.1   153.1 
2.2.24-rc3               32     431.9            440.1   165.7 

2.5.62-mm2 has the feral driver.  aa has the QLogic 6.x driver.
Those two kernels rule AIM7 dbase and fserver on quad Xeon with
QLA2200.  I tested earlier 2.5 and aa with/without the newer
QLogic drivers.  It was _the_most_important_ factor for AIM7
dbase and fserver.  Perhaps AIM7 dbase and fserver really suck.
They seem rather impervious to other improvements in the kernel.

> Care to share your aim7 database methodology with me?

AIM7 dbase takes a mixture of AIM9 micro activities and runs 
them in proportion to what it's developers found a circa 1996 
database running.  

My methodology was:

0) Scratch head and look for benchmark that does more than one thing.
1) Stumble on AIM7 which purports to test database, fileserver, compute
   server and multiuser scalability.
2) Run AIM7 dbase to crossover
3) Find the lowest load where the Jobs/Minute is near it's peak.
4) Use result of 3) for max.  Divide into 8 smaller loads.
5) Test all kernels with the same load.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

