Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVGEVtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVGEVtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVGEVrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:47:33 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:62216 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261976AbVGEVjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:39:36 -0400
Message-ID: <42CAFE0D.1070909@rainbow-software.org>
Date: Tue, 05 Jul 2005 23:39:25 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>,
       "=?ISO-8859-1?Q?Andr=E9_Tomt?=" <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
References: <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <Pine.LNX.4.58.0507051016420.3570@g5.osdl.org> <20050705191448.GB30235@suse.de>
In-Reply-To: <20050705191448.GB30235@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Jul 05 2005, Linus Torvalds wrote:
> 
>>
>>On Tue, 5 Jul 2005, Jens Axboe wrote:
>>
>>>Looks interesting, 2.6 spends oodles of times copying to user space.
>>>Lets check if raw reads perform ok, please try and time this app in 2.4
>>>and 2.6 as well.
>>
>>I think it's just that 2.4.x used to allow longer command queues. I think
>>MAX_NR_REQUESTS is 1024 in 2.4.x, and just 128 in 2.6.x or something like
>>that.
> 
> 
> But for this case, you only have one command in flight. hdparm is highly
> synchronous, my oread case is as well.
> 
> 
>>Also, the congestion thresholds are questionable: we consider a queue
>>congested if it is within 12% of full, but then we consider it uncongested
>>whenever it falls to within 18% of full, which I bet means that for some
>>streaming loads we have just a 6% "window" that we keep adding new
>>requests to (we wait when we're almost full, but then we start adding
>>requests again when we're _still_ almost full). Jens, we talked about this
>>long ago, but I don't think we ever did any timings.
> 
> 
> In theory, the ioc batching should handle that case. But as you can see
> from recent commits, I'm not very happy with how this currently works.
> It should not impact this testing, though.
> 
> 
>>Making things worse, things like this are only visible on stupid hardware
>>that has long latencies to get started (many SCSI controllers used to have
>>horrid latencies), so you'll never even see any difference on a lot of 
>>hardware.
> 
> 
> IDE still has much lower overhead per command than your average SCSI
> hardware. SATA with FIS even improves on this, definitely a good thing!
> 
> 
>>It's probably worth testing with a bigger request limit. I forget what the 
>>/proc interfaces are (and am too lazy to look it up), Jens can tell us ;)
> 
> 
> It's /sys/block/<device>/queue/nr_requests now, can be changed at will.
> 
Tested with default 128, 1024 and 4 (minimum) and no change.

-- 
Ondrej Zary
