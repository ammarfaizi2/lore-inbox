Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTK3STu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 13:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTK3STu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 13:19:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53428 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262369AbTK3STg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 13:19:36 -0500
Message-ID: <3FCA34A6.3010600@pobox.com>
Date: Sun, 30 Nov 2003 13:19:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Vojtech Pavlik <vojtech@suse.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de> <200311301758.53885.bzolnier@elka.pw.edu.pl> <3FCA2380.1050902@pobox.com> <20031130171006.GA10679@suse.de> <20031130175649.GA18670@ucw.cz> <20031130181723.GD6454@suse.de>
In-Reply-To: <20031130181723.GD6454@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sun, Nov 30 2003, Vojtech Pavlik wrote:
> 
>>On Sun, Nov 30, 2003 at 06:10:06PM +0100, Jens Axboe wrote:
>>
>>
>>>On Sun, Nov 30 2003, Jeff Garzik wrote:
>>>
>>>>Bartlomiej Zolnierkiewicz wrote:
>>>>
>>>>>On Sunday 30 of November 2003 17:51, Jens Axboe wrote:
>>>>>
>>>>>>>Tangent:  My non-pessimistic fix will involve submitting a single sector
>>>>>>>DMA r/w taskfile manually, then proceeding with the remaining sectors in
>>>>>>>another r/w taskfile.  This doubles the interrupts on the affected
>>>>>>>chipset/drive combos, but still allows large requests.  I'm not terribly
>>>>>>
>>>>>>Or split the request 50/50.
>>>>>
>>>>>
>>>>>We can't - hardware will lock up.
>>>>
>>>>Well, the constraint we must satisfy is
>>>>
>>>>	sector_count % 15 != 1
>>>
>>>	(sector_count % 15 != 1) && (sector_count != 1)
>>>
>>>to be more precise :)
>>
>>I think you wanted to say:
>>
>>	(sector_count % 15 != 1) || (sector_count == 1)
> 
> 
> Ehm no, I don't think so... To my knowledge, sector_count == 1 is ok. If
> not, the hardware would be seriously screwed (ok it is already) beyond
> software fixups.


Now that you've kicked my brain into action, yes, sector_count==1 is ok. 
  It's all about limiting the data FIS...  and with sector_count==1 
there is no worry about the data FIS in this case.

	Jeff


