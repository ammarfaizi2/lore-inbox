Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbVKPNYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbVKPNYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbVKPNYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:24:04 -0500
Received: from mail.dvmed.net ([216.237.124.58]:51891 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030321AbVKPNYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:24:03 -0500
Message-ID: <437B32E5.5030707@pobox.com>
Date: Wed, 16 Nov 2005 08:23:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Mike Christie <michaelc@cs.wisc.edu>, Tejun Heo <htejun@gmail.com>,
       linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379B28E.9070708@gmail.com> <4379C062.3010302@pobox.com> <20051115120016.GD7787@suse.de> <437A2814.1060308@cs.wisc.edu> <20051115184131.GJ7787@suse.de> <20051116124035.GX7787@suse.de> <437B2C61.7080605@pobox.com> <20051116131333.GA7787@suse.de>
In-Reply-To: <20051116131333.GA7787@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Nov 16 2005, Jeff Garzik wrote:
> 
>>Jens Axboe wrote:
>>
>>>I updated that patch, and converted IDE and SCSI to use it. See the
>>>results here:
>>>
>>>http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=shortlog;h=blk-softirq
>>>
>>>The main change from the version posted last october is killing the
>>>'slightly' overdesigned completion queue hashing.
>>
>>Nifty, I like.  Comments:
>>
>>* use of spin_lock_irq() in all completion paths now makes me nervous.
> 
> 
> Should be fine from the paths originating from blk_done_softirq(), as we
> know interrupts are enabled in the first place. But generally I agree,
> whenever in doubt always always use the irq saving variants.
> 
> 
>>* certainly it's what SCSI does now, but is a softirq really necessary? 
>> Using a tasklet would kill all that per-cpu code, and notifier.
> 
> 
> It would work fine with a tasklet of course, but it's going to generate
> a _lot_ of traffic on io busy systems so I felt a dedicated softirq was
> the way to go.

fair enough.  ACK.

	Jeff



