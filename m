Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268702AbUJKGkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbUJKGkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 02:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268703AbUJKGkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 02:40:23 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:8345 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S268702AbUJKGkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 02:40:19 -0400
Date: Mon, 11 Oct 2004 00:39:55 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] find_isa_irq_pin can't be __init
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <000a01c4af5d$1ee3c740$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=original; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.fq3ot7q.1fgua9u@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Confirmed, taking the __init off find_isa_irq_pin prevents the oops on 
reboot for me.


----- Original Message ----- 
From: "Dave Jones" <davej@redhat.com>
Newsgroups: fa.linux.kernel
To: <torvalds@osdl.org>; <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, October 10, 2004 4:58 PM
Subject: [PATCH] find_isa_irq_pin can't be __init


> As spotted by one of our Fedora users, we sometimes
> oops during shutdown (http://www.roberthancock.com/kerneloops.png)
> because disable_IO_APIC() wants to call find_isa_irq_pin(),
> which we threw away during init.
>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
> --- linux-2.6.8/arch/i386/kernel/io_apic.c~ 2004-10-10 
> 18:54:27.490567168 -0400
> +++ linux-2.6.8/arch/i386/kernel/io_apic.c 2004-10-10 
> 18:54:44.660956872 -0400
> @@ -745,7 +745,7 @@ static int __init find_irq_entry(int api
> /*
>  * Find the pin to which IRQ[irq] (ISA) is connected
>  */
> -static int __init find_isa_irq_pin(int irq, int type)
> +static int find_isa_irq_pin(int irq, int type)
> {
>  int i;
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

