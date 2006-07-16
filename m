Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWGPFq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWGPFq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 01:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWGPFq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 01:46:59 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:12041 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750738AbWGPFq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 01:46:59 -0400
Message-ID: <44B9D2CA.8040306@argo.co.il>
Date: Sun, 16 Jul 2006 08:46:50 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jonathan Baccash <jbaccash@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: raid io requests not parallel?
References: <e0e4cb3e0607151704o479371afpc9332a08fb84ba09@mail.gmail.com>
In-Reply-To: <e0e4cb3e0607151704o479371afpc9332a08fb84ba09@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jul 2006 05:46:56.0770 (UTC) FILETIME=[3FA34620:01C6A89B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Baccash wrote:
>
> I'm using kernel linux-2.6.15-gentoo-r1, and I noticed performance of
> the software RAID-1 is not as good as I would have expected on my two
> SATA drives, and I was wondering if anyone has an idea what may be
> happening. The test I run is 1024 16k direct-IO reads/writes from
> random locations within a 1GB file (on a RAID-1 partition), with my
> disk caches set to
> write-through mode. In the MT (multi-threaded) case, I issue them from
> 8 threads (so it's 128 requests per thread):
>
> Random read: 10.295 sec
> Random write: 19.142 sec
> MT Random read: 5.276 sec
> MT Random write: 19.839 sec
>
> As expected, the multi-threaded reads are 2x as fast as single-threaded
> reads. But I would have expected (assuming the write to both disks can
> occur in parallel) that the random writes are about the same speed (10
> seconds) as the single-threaded random reads, for both the
> single-threaded and multi-threaded write cases. The fact that the
> multi-threaded reads were
> twice as fast indicates to me that read requests can occur in parallel.
>
> So.... why doesn't the raid issue the writes in parallel? Thanks in
> advance for any help.
>
The writes are issued in parallel, but both disks have to be written.  
Each head has to service 1024 write requests (compared to just 512 read 
requests).


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

