Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVH2RzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVH2RzO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVH2RzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:55:08 -0400
Received: from RT-soft-1.Moscow.itn.ru ([80.240.96.90]:22953 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1751187AbVH2RzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:55:06 -0400
Message-ID: <43134BF8.1090706@dev.rtsoft.ru>
Date: Mon, 29 Aug 2005 21:55:04 +0400
From: Grigory Tolstolytkin <gtolstolytkin@dev.rtsoft.ru>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 8250 serial driver and PM
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on power management support for a particular ARM based board 
and I've got a question:
I want to add a board specific power management for standard uart driver 
(serial8250). For this purpose there is a special hook defined in 
uart_8250_port structure (drivers/serial/8250.c):
...
 >        /*
 >        * We provide a per-port pm hook.
 >         */
 >        void                    (*pm)(struct uart_port *port,
 >                                      unsigned int state, unsigned int 
old);
...

When driver goes into suspend/resume, serial8250_pm() function is called 
and it checks for the hook and executes it if it exists. But I didn't 
find a proper way to assign my own function to this hook.
How this hook is supposed to be changed? Is there a way to correctly 
initialize it and how it should be done?
Whether it's a good way to initialize it, for example, in 
serial8250_isa_init_ports():
...
                up->mcr_mask = ~ALPHA_KLUDGE_MCR;
                up->mcr_force = ALPHA_KLUDGE_MCR;

                up->port.ops = &serial8250_pops;

#ifdef CONFIG_ARCH_XXX
                up->pm = pnx4008_uart_pm;
#endif
       }
...

Or it's a bad manner?

Any help appreciated,

Thanks,
Grigory.

