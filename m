Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTKZOkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 09:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263816AbTKZOkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 09:40:10 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:44541 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263203AbTKZOkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 09:40:00 -0500
Message-ID: <3FC4BB3B.7010109@softhome.net>
Date: Wed, 26 Nov 2003 15:39:55 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
References: <3FC358B5.3000501@softhome.net> <Pine.LNX.4.53.0311251510310.6584@chaos> <3FC3E2F4.4080809@softhome.net> <Pine.LNX.4.53.0311260745190.9601@chaos> <3FC4A8BA.9070907@softhome.net> <Pine.LNX.4.53.0311260829340.9730@chaos>
In-Reply-To: <Pine.LNX.4.53.0311260829340.9730@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
> Here is a dynamic allocation scheme that doesn't fail with
> the usual, i.e., less that 1/2 megabyte temporary storage. It
> also automatically frees the RAM it's allocated.
> 
> int function(void *what, size_t len)
> {
>     char tmp[len];
>     ;;;;;
>     return 0;
> }
> 

    You want to say that space is always allocated?
    And how can you make graceful error handling if there is no memory left?
    malloc() has return value, mlock() has return value. So there is at 
least room for error handling. But in your case if you will by mistake 
will run second instance of application - what will happend? I suppose 
crash or welcome oom_killer. Both not nice.

> 
> If you need really large buffers and have only a single
> thread, you can still allocate memory at compile-time, i.e.,
> 
> char scratch[0x10000000];
> 

   I was thinking about this - it has a lot of adavantages and one very 
big disadvantage: you need to recompile app to scale system, you cannot 
make this a command line/configuration parameter.

> 
>>   Embedded? with swap?!?
>>   What you have smoken?! - take me to your dealer!-)))
>>
> 
> Absolutely. A RAM-Disk on non-paged RAM. It allows individual
> tasks to keep track of a valuable resource with minimum
> overhead. It would be nicer if there was a "get free pages"
> function call but you can make a driver for a virtual device
> that returns such information. Then you don't need the
> RAM disk to keep track of virtual memory
> 

   A-ha. A la mtd/rw flash.
   Intersting idea.

   Let's say: I'm working on embedded system - but it is less embedded 
than other embedded systems ;-)

   Thanks for your advices in any way - probably something can be used 
in future.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

