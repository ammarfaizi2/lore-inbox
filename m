Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263928AbUFCT43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUFCT43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 15:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264205AbUFCT43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 15:56:29 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:20967 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S263928AbUFCT41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 15:56:27 -0400
Message-ID: <40BFBAA1.4080301@drdos.com>
Date: Thu, 03 Jun 2004 17:56:17 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: submit_bh leaves interrupts on upon return
References: <40BE93DC.6040501@drdos.com> <20040603085002.GG28915@suse.de> <40BF8E1F.1060009@drdos.com> <20040603165250.GO1946@suse.de> <40BF9124.6080807@drdos.com> <20040603170328.GQ1946@suse.de> <Pine.LNX.4.58.0406031025070.3403@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406031025070.3403@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Thu, 3 Jun 2004, Jens Axboe wrote:
>
>  
>
>>On Thu, Jun 03 2004, Jeff V. Merkey wrote:
>>    
>>
>>>Sounds like I need to move to 2.6. I noticed the elevator is coalescing 
>>>quite well, and since I am posting mostly continguous runs of sectors, 
>>>what ends up at the adapter level would probably not change much much 
>>>between 2.4 and 2.6 since I am maxing out the driver request queues as 
>>>it is (255 pending requests of 32 scatter/gather elements of 256 sector 
>>>runs). 2.6 might help but I suspect it will only help alleviate the 
>>>submission overhead, and not make much difference on performance since 
>>>the 3Ware card does have an upward limit on outstanding I/O requests.
>>>      
>>>
>>That's correct, it just helps you diminish the submission overhead by
>>pushing down 256 sector entities in one go. So as long as you're io
>>bound it won't give you better io performance, of course. If you are
>>doing 400MiB/sec it should help you out, though.
>>    
>>
>
>Well, if Jeff does almost exclusively contiguous stuff and submits them in
>order, then the coalescing will make sure that even on 2.4.x the queues
>don't get too long, and he probably won't see the pathological cases.
>
>		Linus
>-
>
Linus,

This seems to be the case.

Jeff




>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


