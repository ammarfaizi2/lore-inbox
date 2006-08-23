Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbWHWSR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWHWSR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 14:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWHWSR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 14:17:28 -0400
Received: from [168.159.213.200] ([168.159.213.200]:30019 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S965093AbWHWSR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 14:17:27 -0400
Message-ID: <44EC9B65.5030600@emc.com>
Date: Wed, 23 Aug 2006 14:16:05 -0400
From: Ric Wheeler <ric@emc.com>
Reply-To: ric@emc.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Akinobu Mita <mita@miraclelinux.com>,
       linux-kernel@vger.kernel.org, okuji@enbug.org
Subject: Re: [patch 4/5] fail-injection capability for disk IO
References: <20060823113243.210352005@localhost.localdomain> <20060823113317.722640313@localhost.localdomain> <20060823120355.GD5893@suse.de> <20060823102741.b927e092.akpm@osdl.org> <20060823180118.GY5893@suse.de>
In-Reply-To: <20060823180118.GY5893@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.8.23.105443
X-PerlMx-Spam: Gauge=, SPAM=2%, Reasons='EMC_FROM_0+ -2, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Aug 23 2006, Andrew Morton wrote:
> 
>>On Wed, 23 Aug 2006 14:03:55 +0200
>>Jens Axboe <axboe@suse.de> wrote:
>>
>>
>>>On Wed, Aug 23 2006, Akinobu Mita wrote:
>>>
>>>>This patch provides fail-injection capability for disk IO.
>>>>
>>>>Boot option:
>>>>
>>>>	fail_make_request=<probability>,<interval>,<times>,<space>
>>>>
>>>>	<probability>
>>>>
>>>>		specifies how often it should fail in percent.
>>>>
>>>>	<interval>
>>>>
>>>>		specifies the interval of failures.
>>>>
>>>>	<times>
>>>>
>>>>		specifies how many times failures may happen at most.
>>>>
>>>>	<space>
>>>>
>>>>		specifies the size of free space where disk IO can be issued
>>>>		safely in bytes.
>>>>
>>>>Example:
>>>>
>>>>	fail_make_request=100,10,-1,0
>>>>
>>>>generic_make_request() fails once per 10 times.
>>>
>>>Hmm dunno, seems a pretty useless feature to me.
>>
>>We need it.  What is the FS/VFS/VM behaviour in the presence of IO
>>errors?  Nobody knows, because we rarely test it.  Those few times where
>>people _do_ test it (the hard way), bad things tend to happen.  reiserfs
>>(for example) likes to go wobble, wobble, wobble, BUG.
> 
> 
> You misunderstood me - a global parameter is useless, as it makes it
> pretty impossible for people to use this for any sort of testing (unless
> it's very specialized). I didn't say a feature to test io errors was
> useless!
> 
> 
>>>Wouldn't it make a lot
>>>more sense to do this per-queue instead of a global entity?
>>
>>Yes, I think so.  /sys/block/sda/sda2/make-it-fail.
> 
> 
> Precisely.
> 

I think that this is very useful for testing file systems.

What this will miss is the error path through the lower levels of the IO 
path (i.e., the libata/SCSI error handling confusion that Mark Lord has 
been working on patches for would need some error injection at or below 
the libata level).

We currently test this whole path with either weird fault injection gear 
to hit the s-ata bus or the old fashion pile of moderately flaky disks 
that we try hard not to fix or totally kill.

It would be really useful to get something (target mode SW disk? libata 
or other low level error injection?) to test this whole path in software...

ric


