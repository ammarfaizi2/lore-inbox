Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWAQRGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWAQRGo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWAQRGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:06:44 -0500
Received: from host233.omnispring.com ([69.44.168.233]:42286 "EHLO
	iradimed.com") by vger.kernel.org with ESMTP id S1750915AbWAQRGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:06:43 -0500
Message-ID: <43CD2405.4070902@cfl.rr.com>
Date: Tue, 17 Jan 2006 12:06:13 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: io performance...
References: <43CB4CC3.4030904@fastmail.co.uk>
In-Reply-To: <43CB4CC3.4030904@fastmail.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2006 17:06:44.0538 (UTC) FILETIME=[64AFC1A0:01C61B88]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.51.1032-14211.000
X-TM-AS-Result: No--22.090000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you direct the program to use O_DIRECT?  If not then I believe the 
problem you are seeing is that the generic block layer is not performing 
large enough readahead to keep all the disks in the array reading at 
once, because the stripe width is rather large.  What stripe factor did 
you format the array using?


I have a sata fakeraid at home of two drives using a stripe factor of 64 
KB.  If I don't issue O_DIRECT IO requests of at least 128 KB ( the 
stripe width ), then throughput drops significantly.  If I issue 
multiple async requests of smaller size that totals at least 128 KB, 
throughput also remains high.  If you only issue a single 32 KB request 
at a time, then two requests must go to one drive and be completed 
before the other drive gets any requests, so it remains idle a lot of 
the time. 

Max Waterman wrote:
> Hi,
>
> I've been referred to this list from the linux-raid list.
>
> I've been playing with a RAID system, trying to obtain best bandwidth
> from it.
>
> I've noticed that I consistently get better (read) numbers from kernel 
> 2.6.8
> than from later kernels.
>
> For example, I get 135MB/s on 2.6.8, but I typically get ~90MB/s on later
> kernels.
>
> I'm using this :
>
> <http://www.sharcnet.ca/~hahn/iorate.c>
>
> to measure the iorate. I'm using the debian distribution. The h/w is a 
> MegaRAID
> 320-2. The array I'm measuring is a RAID0 of 4 Fujitsu Max3073NC 
> 15Krpm drives.
>
> The later kernels I've been using are :
>
> 2.6.12-1-686-smp
> 2.6.14-2-686-smp
> 2.6.15-1-686-smp
>
> The kernel which gives us the best results is :
>
> 2.6.8-2-386
>
> (note that it's not an smp kernel)
>
> I'm testing on an otherwise idle system.
>
> Any ideas to why this might be? Any other advice/help?
>
> Thanks!
>
> Max.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

