Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWGUCLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWGUCLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 22:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWGUCLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 22:11:06 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:26556 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030431AbWGUCLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 22:11:04 -0400
Message-ID: <44C037B3.4080707@garzik.org>
Date: Thu, 20 Jul 2006 22:10:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Ed Lin <ed.lin@promise.com>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       hch <hch@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, promise_linux <promise_linux@promise.com>
Subject: Re: [PATCH] Promise 'stex' driver
References: <NONAMEBMcvsq9IcVux1000001f9@nonameb.ptu.promise.com> <44BFF539.4000700@garzik.org> <1153439728.4754.19.camel@mulgrave> <44C01CD7.4030308@garzik.org> <20060721010724.GB24176@suse.de> <44C02D1E.4090206@garzik.org> <20060721013822.GA25504@suse.de>
In-Reply-To: <20060721013822.GA25504@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Jul 20 2006, Jeff Garzik wrote:
>> Jens Axboe wrote:
>>> On Thu, Jul 20 2006, Jeff Garzik wrote:
>>>> James Bottomley wrote:
>>>>> On Thu, 2006-07-20 at 17:27 -0400, Jeff Garzik wrote:
>>>>>> Since _no individual SCSI driver_ uses the block layer
>>>>>> tagging, it is likely that some instability and core kernel
>>>>>> development
>>>>>> will occur, in order to make that work.
>>>>> That's not quite true: 53c700 and tmscsim both use it ... I could with
>>>>> the usage were wider, but at least 53c700 has pretty regular and
>>>>> constant usage ... enough I think to validate the block tag code (it's
>>>>> been using it for the last three years).
>>>> Not for the case being discussed in this thread, adapter-wide tags.
>>> That just means the map is shared, otherwise there should be little if
>>> any difference.
>>>
>>>> AFAICS, no file in include/scsi/* or drivers/scsi/* ever calls 
>>>> blk_queue_init_tags() with a non-NULL third arg.
>>> grpe again, it's in scsi_tcq.h.
>> What tree are you looking at?
>>
>> There is only one user in the entire tree, and NULL is hardcoded as the 
>> third arg.  This is 2.6.18-rc2:
> 
> Sorry, missed your non-NULL statement, I thought you meant in generel.
> 
> As long as you get the locking right for the map access, there's really
> nothing that seperates shared vs non-shared tag mappings. So I don't
> think it's a big deal.
> 
> If we don't encourage new drivers to use the block layer tagging, we
> might as well not bother with it.

I don't disagree it's a good thing to have.

I only assert that a --completely unused-- sub-feature cannot be a merge 
requirement for a new driver.  That's an unreasonable standard.  We have 
a driver that is clean and works with all well-known and well-used APIs.

As I discovered painfully via libata, using an unused API upstream 
(->eh_strategy_handler) can often be a destabilizing or limiting factor.

You _hope_ that this feature works, but it's far better IMO to debug an 
unused core feature upstream.  If the upstream driver breaks when 
host-wide blktag support is added, then it's trivial to find where the 
breakage occurred: the stex blktag-update patch.

	Jeff



