Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271969AbTG2SBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 14:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271845AbTG2R6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:58:47 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:27015 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S271939AbTG2R50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:57:26 -0400
Message-ID: <3F26B570.7020004@colorfullife.com>
Date: Tue, 29 Jul 2003 19:57:04 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andries.Brouwer@cwi.nl, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] select fix
References: <UTC200307291412.h6TECwA17034.aeb@smtp.cwi.nl> <20030729103630.7fb415cb.akpm@osdl.org>
In-Reply-To: <20030729103630.7fb415cb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Andries.Brouwer@cwi.nl wrote:
>  
>
>>-	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
>>+	if (!tty->stopped && tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
>> 		mask |= POLLOUT | POLLWRNORM;
>>    
>>
>
>Manfred sent a patch through esterday which addresses it this way:
>
>-	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
>+	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS &&
>+			tty->driver->write_room(tty) > 0)
>
>Any preferences?
>  
>
Who should implement tty->stopped? AFAICS tty->stopped is implemented in 
the drivers right now, and my patch would leave that unchanged.

--
    Manfred


