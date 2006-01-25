Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWAYGgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWAYGgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 01:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWAYGgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 01:36:44 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:35200 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751043AbWAYGgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 01:36:43 -0500
X-Sasl-enc: 5A2ZhEZdr+6FmUjlvkjz4O/pIDObpLx63S+3/Gk0RLAa 1138171001
Message-ID: <43D71C75.2050807@fastmail.co.uk>
Date: Wed, 25 Jan 2006 14:36:37 +0800
From: Max Waterman <davidmaxwaterman@fastmail.co.uk>
User-Agent: Thunderbird 1.6a1 (Macintosh/20060122)
MIME-Version: 1.0
To: Ian Soboroff <isoboroff@acm.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: io performance...
References: <43CB4CC3.4030904@fastmail.co.uk> <43CD2405.4070902@cfl.rr.com>	<43CDED23.5060701@fastmail.co.uk> <43CE5C7A.5060608@cfl.rr.com>	<43D07C08.5000903@fastmail.co.uk> <9cfek33vwvo.fsf@nist.gov>
In-Reply-To: <9cfek33vwvo.fsf@nist.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Soboroff wrote:
> Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk> writes:
> 
>> Phillip Susi wrote:
>>> Right, the kernel does not know how many disks are in the array, so
>>> it can't automatically increase the readahead.  I'd say increasing
>>> the readahead manually should solve your throughput issues.
>> Any guesses for a good number?
>>
>> We're in RAID10 (2+2) at the moment on 2.6.8-smp. These are the block
>> numbers I'm getting using bonnie++ :
>>
>> [...]
>> We're still wondering why rd performance is so low - seems to be the
>> same as a single drive. RAID10 should be the same performance as RAID0
>> over two drives, shouldn't it?
> 
> I think bonnie++ measures accesses to many small files (INN-like
> simulation) and database accesses.  These are random accesses, which
> is the worst access pattern for RAID.  Seek time in a RAID equals the
> longest of all the drives in the RAID, rather than the average.  So
> bonnie++ is domninated by your seek time.

You think so? I had assumed when bonnie++'s output said 'sequential 
access' that it was the opposite of random, for example (raid0 on 5 
drives) :

> +---------------------------------------------------------------------------------------------------------------------------------------------------+
> |                     |Sequential Output             |Sequential Input    |         |     |Sequential Create           |Random Create               |
> |---------------------+------------------------------+--------------------|Random   |-----+----------------------------+----------------------------|
> |          |Size:Chunk|Per Char |Block     |Rewrite  |Per Char |Block     |Seeks    |Num  |Create  |Read     |Delete   |Create  |Read     |Delete   |
> |          |Size      |         |          |         |         |          |         |Files|        |         |         |        |         |         |
> |---------------------+---------+----------+---------+---------+----------+---------+-----+--------+---------+---------+--------+---------+---------|
> |                     |K/sec|%  |K/sec |%  |K/sec|%  |K/sec|%  |K/sec |%  |/ sec|%  |     |/   |%  |/ sec|%  |/ sec|%  |/   |%  |/ sec|%  |/ sec|%  |
> |                     |     |CPU|      |CPU|     |CPU|     |CPU|      |CPU|     |CPU|     |sec |CPU|     |CPU|     |CPU|sec |CPU|     |CPU|     |CPU|
> |---------------------+-----+---+------+---+-----+---+-----+---+------+---+-----+---+-----+----+---+-----+---+-----+---+----+---+-----+---+-----+---|
> |hostname  |2G        |48024|96 |121412|13 |59714|10 |47844|95 |200264|21 |942.8|1  |16   |4146|99 |+++++|+++|+++++|+++|4167|99 |+++++|+++|14292|99 |
> +---------------------------------------------------------------------------------------------------------------------------------------------------+

Am I wrong? If so, what exactly does 'Sequential' mean in this context?

Max.
