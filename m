Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbUK2UqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbUK2UqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 15:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUK2UqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 15:46:20 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:43949 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261801AbUK2UqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 15:46:10 -0500
Message-ID: <41AB5C80.10605@tmr.com>
Date: Mon, 29 Nov 2004 12:29:36 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Chandler <alan@chandlerfamily.org.uk>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
References: <200411232149.31701.alan@chandlerfamily.org.uk><200411232149.31701.alan@chandlerfamily.org.uk> <200411262339.01306.alan@chandlerfamily.org.uk>
In-Reply-To: <200411262339.01306.alan@chandlerfamily.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Chandler wrote:
> On Tuesday 23 November 2004 21:49, Alan Chandler wrote:
> 
> 
>>Before, I thought my hardware was a little out of spec - now I think there
>>is something else at play here.
>>
> 
> 
> Firstly, I think there might be another race condition like the one Alan Cox 
> found.  I attach a patch below with the fix for that (against 2.6.10-rc2, an 
> including Alan's patch)   I'm not 100% sure its necessary, but it seems fix a 
> variation I have been seeing.
> 
> With it in place, and apart from the ongoing issue - see below, I have managed 
> to remove the delay in drive_is_ready() altogether without any ill effects.
> 
> [my reading of the ATA spec is that 400ns is needed after reading the status 
> reg before IRQ is removed, I had wondered whether it would be better to 
> record the time here and then check whether we had used up the 400ns just 
> before returning from the interrupt state]

The method is sound, I did some industrial control in a previous job and 
used a back-to-back timer in a similar way. Just before starting an 
operation I checked to see that it wasn't too soon and did a delay if so.

Depending on the path through the code, it may be easier to get right by 
just putting in the delay.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

