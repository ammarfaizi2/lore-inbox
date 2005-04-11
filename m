Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVDKQrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVDKQrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVDKQja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:39:30 -0400
Received: from ciistr2.ist.utl.pt ([193.136.128.2]:53212 "EHLO
	ciistr2.ist.utl.pt") by vger.kernel.org with ESMTP id S261851AbVDKQiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:38:50 -0400
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Processes stuck on D state on Dual Opteron
Date: Mon, 11 Apr 2005 15:05:44 +0100
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <425A4999.9010209@yahoo.com.au> <425A7173.802@yahoo.com.au>
In-Reply-To: <425A7173.802@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504111505.44284.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 11 April 2005 13:45, Nick Piggin wrote:
>
> No luck yet (on SMP i386). How many disks are you using in each
> raid1 array? You are using one array for swap, and one mounted as
> ext3 for the working area of the `stress` program, right?
>

   Right. I'm using two Seagate ATA133 disks (ide controler is AMD-8111) each 
with 4 partitions, so I get 4 md Raid1 devices. The first one, md0, is for 
swap. The rest are

~$ df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/md1              4.6G  1.9G  2.6G  42% /
tmpfs                1005M     0 1005M   0% /dev/shm
/dev/md3               32G  107M   30G   1% /home
/dev/md2               31G  149M   29G   1% /var

  In these tests, /home on md3 is the working area for stress.

  The io scheduler used is the anticipatory. 

> Neil, have you had a look at the traces? Do they mean much to you?
>
> Claudio - I have attached another patch you could try. It has a more
> complete set of mempool and related memory allocation fixes, as well
> as some other recent patches I had which reduces atomic memory usage
> by the block layer. Could you try if you get time? Thanks.

  OK, I'll try them in a few minutes and report back.
 
  I'm curious as whether increasing the vm.min_free_kbytes sysctl value would 
help or not in this case. But I guess it wouldn't since there is already some 
free memory and also the alloc failures are order 0, right?

 Thanks

Claudio

