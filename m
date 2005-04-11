Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVDKW7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVDKW7X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDKW7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:59:23 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:19059 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261981AbVDKW7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:59:15 -0400
Message-ID: <425B013A.5020108@yahoo.com.au>
Date: Tue, 12 Apr 2005 08:59:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Processes stuck on D state on Dual Opteron
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <425A4999.9010209@yahoo.com.au> <425A7173.802@yahoo.com.au> <200504111505.44284.ctpm@rnl.ist.utl.pt>
In-Reply-To: <200504111505.44284.ctpm@rnl.ist.utl.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Martins wrote:

>    Right. I'm using two Seagate ATA133 disks (ide controler is AMD-8111) each 
> with 4 partitions, so I get 4 md Raid1 devices. The first one, md0, is for 
> swap. The rest are
> 
> ~$ df -h
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/md1              4.6G  1.9G  2.6G  42% /
> tmpfs                1005M     0 1005M   0% /dev/shm
> /dev/md3               32G  107M   30G   1% /home
> /dev/md2               31G  149M   29G   1% /var
> 
>   In these tests, /home on md3 is the working area for stress.
> 
>   The io scheduler used is the anticipatory. 
> 

OK.

> 
>   OK, I'll try them in a few minutes and report back.
>  

I'm not overly hopeful. If they fix the problem, then it's likely
that the real bug is hidden.

>   I'm curious as whether increasing the vm.min_free_kbytes sysctl value would 
> help or not in this case. But I guess it wouldn't since there is already some 
> free memory and also the alloc failures are order 0, right?
> 

Yes. And the failures you were seeing with my first patch were coming
from the mempool code anyway. We want those to fail early so they don't
eat into the min_free_kbytes memory.

You could try raising min_free_kbytes though. If that fixes it, then it
indicates there might be some problem in a memory allocation failure
path in software raid somewhere.

Thanks

-- 
SUSE Labs, Novell Inc.

