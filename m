Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWALMeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWALMeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWALMeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:34:13 -0500
Received: from mexforward.lss.emc.com ([168.159.213.200]:39999 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S964910AbWALMeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:34:12 -0500
Message-ID: <43C64C3B.5070704@emc.com>
Date: Thu, 12 Jan 2006 07:31:55 -0500
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Reuben Farrelly <reuben-lkml@reub.net>
CC: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
References: <20060111115616.GE3389@suse.de> <43C518BC.5090903@reub.net> <20060111145201.GS3389@suse.de> <20060111145504.GT3389@suse.de> <43C55B31.5000201@reub.net> <20060111194517.GE5373@suse.de> <20060111195349.GF5373@suse.de> <43C5D1CA.7000400@reub.net> <20060112080051.GA22783@htj.dyndns.org> <43C61598.7050004@reub.net> <20060112111846.GA19976@htj.dyndns.org> <43C645ED.40905@reub.net>
In-Reply-To: <43C645ED.40905@reub.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2006.01.12.035104
X-PerlMx-Spam: Gauge=, SPAM=1%, Reasons='EMC_FROM_00+ -3, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly wrote:

>
>
> On 13/01/2006 12:18 a.m., Tejun Heo wrote:
>
>> On Thu, Jan 12, 2006 at 09:38:48PM +1300, Reuben Farrelly wrote:
>> [--snip--]
>>
>>> [start_ordered       ] f7e8a708 -> c1b028fc,c1b029a4,c1b02a4c infl=1
>>> [start_ordered       ] f74b0e00 0 48869571 8 8 1 1 c1ba9000
>>> [start_ordered       ] BIO f74b0e00 48869571 4096
>>> [start_ordered       ] ordered=31 in_flight=1
>>> [blk_do_ordered      ] start_ordered f7e8a708->00000000
>>> [blk_do_ordered      ] seq=02 f74ccd98->f74ccd98
>>> [blk_do_ordered      ] seq=02 f74ccd98->f74ccd98
>>> [blk_do_ordered      ] seq=02 c1b028fc->00000000
>>> [blk_do_ordered      ] seq=02 c1b028fc->00000000
>>> [blk_do_ordered      ] seq=02 c1b028fc->00000000
>>
>>
>> Yeap, this one is the offending one.  0xf74ccd98 got requeued in front
>> of pre-flush while draining and when it finished it didn't complete
>> draining thus hanging the queue.  It seems like it's some kind of
>> special request which probably fails and got retried.  Are you using
>> SMART or something which issues special commands to drives?
>
>
> No SMART, although I should be (rebuilt the system a few months 
> ago..and must
> have missed it).
>
> Are there any other things which could be contributing to this?  
> <scratches head>
>
Could this be hdparm or something tweaking the drive write cache 
settings, etc?

ric

