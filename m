Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUCKSAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUCKSAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:00:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31416 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261501AbUCKSAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:00:01 -0500
Message-ID: <4050A913.50809@pobox.com>
Date: Thu, 11 Mar 2004 12:59:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.4-rc-bk3: hdparm -X locks up IDE
References: <200403111614.08778.vda@port.imtp.ilyichevsk.odessa.ua> <200403111552.26315.bzolnier@elka.pw.edu.pl> <20040311144812.GC6955@suse.de> <200403111607.39235.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403111607.39235.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Thursday 11 of March 2004 15:48, Jens Axboe wrote:
> 
>>On Thu, Mar 11 2004, Bartlomiej Zolnierkiewicz wrote:
>>
>>>On Thursday 11 of March 2004 15:14, Denis Vlasenko wrote:
>>>
>>>>I discovered that hdparm -X <mode> /dev/hda can lock up IDE
>>>>interface if there is some activity.
>>>
>>>Known bug and is on TODO but fixing it ain't easy.
>>>Thanks for a report anyway.
>>
>>Wouldn't it be possible to do the stuff that needs serializing from the
>>end_request() part and get automatic synchronization with normal
>>requests?
> 
> 
> That's the way to do it (REQ_SPECIAL) but unfortunately on some chipsets
> we need to synchronize both channels (whereas we don't need to serialize
> normal operations).

blk_stop_queue() on all queues attached to the hardware?

You need to synchronize anyway for the rare hardware that reports itself 
as "simplex" -- one DMA engine for both channels.

	Jeff




