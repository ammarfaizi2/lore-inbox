Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWJRLYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWJRLYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 07:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWJRLYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 07:24:36 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:8578 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751467AbWJRLYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 07:24:35 -0400
Message-ID: <45360ECE.3070107@emc.com>
Date: Wed, 18 Oct 2006 07:23:58 -0400
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: Jens Axboe <jens.axboe@oracle.com>,
       Jakob Oestergaard <jakob@unthought.net>,
       Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com> <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <20061018095125.GE24452@kernel.dk> <45360952.5020307@aitel.hist.no>
In-Reply-To: <45360952.5020307@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.10.18.35442
X-PerlMx-Spam: Gauge=, SPAM=0%, Reasons='EMC_BODY_1+ -3, EMC_BODY_PROD_1+ -3, EMC_FROM_0+ -2, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_419_AGREE 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Helge Hafting wrote:

> Jens Axboe wrote:
>
>> While that may make some sense internally, the exported interface would
>> never be workable like that. It needs to be simple, "give me foo kb/sec
>> with max latency bar for this file", with an access pattern or assumed
>> sequential io.
>>
>> Nobody speaks of iops/sec except some silly benchmark programs. I know
>> that you are describing pseudo-iops, but it still doesn't make it more
>> clear.
>> Things aren't as simple
>>   
>
> How about "give me 10% of total io capacity?"  People understand
> this, and the io scheduler can then guarantee this by ensuring
> that the process gets 1 out of 10 io requests as long as it
> keeps submitting enough.
>
> The admin can then set a reasonable percentage depending on
> the machine's capacity.
>
> Helge Hafting

The tricky part is that when you mix up workloads, you blow the drive's 
ability to minimize head seek & rotational latency.  For example, I have 
measured almost a 10x decrease when I mix one serious workload (reading 
each file in a large file system as fast as you can) with a moderate 
write workload.

All a long winded way of saying that what we might be able to do in the 
worst case is to give an even portion of that worst case IO capability 
which is  itself only 10% of the best case  (i.e., 1% of the non-shared 
best case) ;-)

Some of the high ends arrays (like the EMC Symmetrix, IBM Shark, Hitachi 
boxes, etc) are much better at this sharing since they have massive 
amounts of nonvolatile DRAM & lots of algorithmic ability to tease apart 
individual streams internally.  Note that they have to do this since 
they are connected up to many different hosts.

It might be interesting to thinking about how we would tweak things for 
this specific class of arrays as a special case,

ric

