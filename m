Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293670AbSCKKZK>; Mon, 11 Mar 2002 05:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293672AbSCKKZC>; Mon, 11 Mar 2002 05:25:02 -0500
Received: from [195.63.194.11] ([195.63.194.11]:8196 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S293670AbSCKKYw>;
	Mon, 11 Mar 2002 05:24:52 -0500
Message-ID: <3C8C857A.5090809@evision-ventures.com>
Date: Mon, 11 Mar 2002 11:22:50 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] BUG check in elevator.c:237
In-Reply-To: <Pine.LNX.4.44.0203081258500.5383-100000@netfinity.realnet.co.sz> <3C88A796.2070301@evision-ventures.com> <20020311094445.GC31108@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> That's nonsense too. I added the expiry hook to let lower levels decide
> what should happen when an interrupt timeout occurs. So there's been
> _no_ interrupt if we enter this from the timer handler.

No interrupt from the same drive right.

>>And plase guess whot? CD-ROM is the only driver which is using
>>this facility. Please have a look at the last
>>
> 
> Right, it was added to handle long commands like format unit etc.

Hmm seeks on tapes can take awfully long as well...

>>argument of ide_set_handler(). The second argument is the
>>interrutp handler for a command. The third is supposed to be
>>the poll timerout function. But if you look at the
>>actual poll function found in ide-cd.c (and only there).
>>You may as well feel to try to just execute its commands directly in
>>ide_timer_expiry, thus reducing tons of possible races ind the
>>overall intr handling found currently there.
>>
> 
> I don't know what tangent you are going off on here, I think you should
> re-read this code a lot more carefully. There's no polling going on
> here.

I think the term polling used by me is the only problem here ;-).
(I consider every command controll which goes without irq notification
just polling... whatever it polls once or not ;-).

