Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVFHQnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVFHQnC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVFHQlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:41:23 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:32016 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261371AbVFHQVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:21:55 -0400
Date: Wed, 8 Jun 2005 18:21:52 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG in i2c_detach_client
Message-Id: <20050608182152.17dfe9a2.khali@linux-fr.org>
In-Reply-To: <200506081033.12445.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
	<200506081033.12445.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> 2.6.12-rc5-mm1 didn't crash.
> 
> kernel BUG at include/linux/list.h:166!
> invalid operand: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c0319cd4>]    Not tainted VLI
> EFLAGS: 00010a83   (2.6.12-rc6-mm1)
> EIP is at i2c_detach_client+0xb4/0x110
> eax: dfc0bcc0   ebx: c15fc26c   ecx: c15fc264   edx: c04378d0
> esi: c15fc14c   edi: c0437720   ebp: 00000000   esp: dff81f10
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=dff80000 task=c14dca00)
> Stack: dfff6110 dfc0bdb4 00000286 00000286 c15fc26c c15fc14c c15fc160
> ffffffed
>        c031d512 c15fc160 c03edac1 c15fc26c 00000000 0000002d 00000001
>        0000002d c0437720 00000000 c0437c5c 00000001 00000000 c031b100
>        00000000 00000000
> Call Trace:
>  [<c031d512>] asb100_detect+0x442/0x520
>  [<c031b100>] i2c_detect+0x240/0x380
>  [<c031d0d0>] asb100_detect+0x0/0x520
>  [<c0319889>] i2c_add_driver+0x89/0xc0

I suspect you didn't "make oldconfig" before compiling 2.6.12-rc6-mm1.
You should have CONFIG_HWMON=Y in .config, and I don't see it. Note that
I can't explain why it results in the BUG right above, but it must be
related.

If "make oldconfig" doesn't help, try reverting:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc6/2.6.12-rc6-mm1/broken-out/gregkh-i2c-hwmon-03.patch

Thanks,
-- 
Jean Delvare
