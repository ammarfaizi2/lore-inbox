Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbSKFB0n>; Tue, 5 Nov 2002 20:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265272AbSKFB0n>; Tue, 5 Nov 2002 20:26:43 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:9969 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265270AbSKFB0m>; Tue, 5 Nov 2002 20:26:42 -0500
Message-ID: <3DC87154.1030601@namesys.com>
Date: Tue, 05 Nov 2002 17:33:08 -0800
From: reiser <reiser@namesys.com>
Reply-To: reiser@namesys.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: Andreas Dilger <adilger@clusterfs.com>,
       Nikita Danilov <Nikita@namesys.com>,
       Tomas Szepe <szepe@pinerecords.com>,
       Alexander Zarochentcev <zam@namesys.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
References: <15816.20406.532821.177470@wombat.chubb.wattle.id.au>
In-Reply-To: <15816.20406.532821.177470@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:

>
>Some benchmarking done at Berkeley showed that for development loads,
>30seconds was too short to avoid excessive writes.
>
>See Roselli, Lorch and Anderson, `A Comparison of File System
>Workloads' in Usenix 2000.
>
>http://research.microsoft.com/~lorch/papers/fs-workloads/fs-workloads.html
>
>Their observations (summarised) were that most blocks die because of
>overwriting, not because of file deletes.  Their workloads show that
>for NT, the write timeout to avoid commits blocks that will soon
>become dead needs to be around a day; for typical Unix loads (web
>serving, research, software development), an hour is enough.  To catch
>75%, a timeout of around 11 minutes is needed.  30seconds worked only
>for webserving and undergraduate teaching workloads, and caught around
>40% for those workloads; for a research workload and NT fileserving,
>30seconds catches only 10-20% of the rewrites.
>
>See especially figure 3 in that paper.
>
>  
>
There is also a longer PhD thesis by her.  10 minutes is about as much 
work as I personally am willing to lose and try to remember.  Avoiding 
75% of writes instead of 20% is a substantial performance gain worth 
paying a cost for.  Unfortunately it is not easy to say if it is worth 
that much cost, but I suspect it is.  An approach we are exploring is 
for blocks to reach disk earlier than that if the device is not 
congested, on the grounds that if not much IO is occuring, then 
performance is not important.

Hans

