Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWALMjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWALMjV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWALMjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:39:21 -0500
Received: from tornado.reub.net ([202.89.145.182]:4538 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S964912AbWALMjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:39:21 -0500
Message-ID: <43C64DF6.7060604@reub.net>
Date: Fri, 13 Jan 2006 01:39:18 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060111)
MIME-Version: 1.0
To: Ric Wheeler <ric@emc.com>
CC: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
References: <20060111115616.GE3389@suse.de> <43C518BC.5090903@reub.net> <20060111145201.GS3389@suse.de> <20060111145504.GT3389@suse.de> <43C55B31.5000201@reub.net> <20060111194517.GE5373@suse.de> <20060111195349.GF5373@suse.de> <43C5D1CA.7000400@reub.net> <20060112080051.GA22783@htj.dyndns.org> <43C61598.7050004@reub.net> <20060112111846.GA19976@htj.dyndns.org> <43C645ED.40905@reub.net> <43C64C3B.5070704@emc.com>
In-Reply-To: <43C64C3B.5070704@emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/01/2006 1:31 a.m., Ric Wheeler wrote:
> Reuben Farrelly wrote:
>> On 13/01/2006 12:18 a.m., Tejun Heo wrote:
>>> On Thu, Jan 12, 2006 at 09:38:48PM +1300, Reuben Farrelly wrote:
>>> [--snip--]
>>>
>>>> [start_ordered       ] f7e8a708 -> c1b028fc,c1b029a4,c1b02a4c infl=1
>>>> [start_ordered       ] f74b0e00 0 48869571 8 8 1 1 c1ba9000
>>>> [start_ordered       ] BIO f74b0e00 48869571 4096
>>>> [start_ordered       ] ordered=31 in_flight=1
>>>> [blk_do_ordered      ] start_ordered f7e8a708->00000000
>>>> [blk_do_ordered      ] seq=02 f74ccd98->f74ccd98
>>>> [blk_do_ordered      ] seq=02 f74ccd98->f74ccd98
>>>> [blk_do_ordered      ] seq=02 c1b028fc->00000000
>>>> [blk_do_ordered      ] seq=02 c1b028fc->00000000
>>>> [blk_do_ordered      ] seq=02 c1b028fc->00000000
>>>
>>>
>>> Yeap, this one is the offending one.  0xf74ccd98 got requeued in front
>>> of pre-flush while draining and when it finished it didn't complete
>>> draining thus hanging the queue.  It seems like it's some kind of
>>> special request which probably fails and got retried.  Are you using
>>> SMART or something which issues special commands to drives?
>>
>>
>> No SMART, although I should be (rebuilt the system a few months 
>> ago..and must
>> have missed it).
>>
>> Are there any other things which could be contributing to this?  
>> <scratches head>
>>
> Could this be hdparm or something tweaking the drive write cache 
> settings, etc?

hdparm isn't configured on the box by me or called by initscripts in Fedora 
either, AFAIK.

reuben

