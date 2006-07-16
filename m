Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946076AbWGPBox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946076AbWGPBox (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 21:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946077AbWGPBox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 21:44:53 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:3389 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1946076AbWGPBox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 21:44:53 -0400
Date: Sat, 15 Jul 2006 19:41:46 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: raid io requests not parallel?
In-reply-to: <fa.di4ao4hbHlmvf0KHMl+KieWzn2E@ifi.uio.no>
To: Jonathan Baccash <jbaccash@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <44B9995A.4010402@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.di4ao4hbHlmvf0KHMl+KieWzn2E@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Baccash wrote:
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

Because it's RAID 1, I'm assuming. The data has to be written to both 
drives, unlike reads which can be satisfied from either one.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

