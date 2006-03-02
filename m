Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWCBMdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWCBMdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWCBMdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:33:41 -0500
Received: from mail.dvmed.net ([216.237.124.58]:44215 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932237AbWCBMdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:33:41 -0500
Message-ID: <4406E61F.80306@pobox.com>
Date: Thu, 02 Mar 2006 07:33:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jens Axboe <axboe@suse.de>, Michael Monnerie <m.monnerie@zmi.at>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
References: <200603020023.21916@zmi.at> <200603021316.38077.ak@suse.de> <4406E226.4050806@pobox.com> <200603021326.33220.ak@suse.de>
In-Reply-To: <200603021326.33220.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 02 March 2006 13:16, Jeff Garzik wrote:
> 
> 
>>>Yes I've been thinking about adding a new sleeping interface to the IOMMU
>>>that would block for new space to handle this. If I did that - would
>>>libata be able to use it?
>>
>>No :(  We map inside a spin_lock_irqsave.
> 
> 
> Would it be easily possible to change that or is it difficult?
> 
> Also with the blocking interface there might be possible deadlock issues 
> because it will be essentially similar to allocating memory during IO.
> But I think it's probably safe.

The SCSI layer submits stuff to libata inside spin_lock_irqsave(), and 
from there we DMA-map and send straight to hardware.

So, changing the hot path to permit sleeping would be difficult and add 
needless complexity, IMO.

I would rather pay the penalty of resubmitting if the 
map-inside-spinlock fails, than to slow down the hot path.

	Jeff



