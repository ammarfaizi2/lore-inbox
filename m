Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbSL0UTq>; Fri, 27 Dec 2002 15:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbSL0UTq>; Fri, 27 Dec 2002 15:19:46 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:20134 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265095AbSL0UTp>;
	Fri, 27 Dec 2002 15:19:45 -0500
Message-ID: <3E0CB7CB.2030800@colorfullife.com>
Date: Fri, 27 Dec 2002 21:27:55 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] M68k net local_irq*() updates
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
> 
> 	skblen = skb->len;
> 
>-	save_flags(flags);
>-	cli();
>+	local_irq_save(flags);
> 
>
This would be the wrong thing (tm) for SMP: cli() gives a compile error 
for SMP, local_irq_save() creates the impression that the driver works 
on SMP systems. m68k is UP only, thus there is no need to fix it properly.

What about adding
+ #ifdef CONFIG_SMP
+ #error This driver does not work on SMP
+ #endif

Or a Kconfig dependency on !CONFIG_SMP?

--
    Manfred

