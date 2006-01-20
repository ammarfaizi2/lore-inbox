Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWATF6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWATF6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 00:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWATF6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 00:58:41 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:65155 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1030311AbWATF6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 00:58:40 -0500
X-Sasl-enc: dZmK8eJWDGQPwTCujUpTcd8XKlOopwxTWKukz2SWQx5q 1137736719
Message-ID: <43D07C08.5000903@fastmail.co.uk>
Date: Fri, 20 Jan 2006 13:58:32 +0800
From: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
User-Agent: Thunderbird 1.6a1 (Macintosh/20060117)
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: io performance...
References: <43CB4CC3.4030904@fastmail.co.uk> <43CD2405.4070902@cfl.rr.com> <43CDED23.5060701@fastmail.co.uk> <43CE5C7A.5060608@cfl.rr.com>
In-Reply-To: <43CE5C7A.5060608@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> Right, the kernel does not know how many disks are in the array, so it 
> can't automatically increase the readahead.  I'd say increasing the 
> readahead manually should solve your throughput issues.

Any guesses for a good number?

We're in RAID10 (2+2) at the moment on 2.6.8-smp. These are the block 
numbers I'm getting using bonnie++ :

ra	wr	rd
256	68K	46K
512	67K	59K
640	67K	64K
1024	66K	73K
2048	67K	88K
3072	67K	91K
8192	71K	96K
9216	67K	92K
16384	67K	90K

I think we might end up going for 8192.

We're still wondering why rd performance is so low - seems to be the 
same as a single drive. RAID10 should be the same performance as RAID0 
over two drives, shouldn't it?

Max.

> 
> Max Waterman wrote:
>>
>> I left the stripe size at the default, which, I believe, is 64K bytes; 
>> same as your fakeraid below.
>>
>> I did play with 'blockdev --setra' too.
>>
>> I noticed it was 256 with a single disk, and, with s/w raid, it 
>> increased by 256 for each extra disk in the array. IE for the raid 0 
>> array with 4 drives, it was 1024.
>>
>> With h/w raid, however, it did not increase when I added disks. Should 
>> I use 'blockdev --setra 320' (ie 64 x 5 = 320, since we're now running 
>> RAID5 on 5 drives)?
>>
> 

