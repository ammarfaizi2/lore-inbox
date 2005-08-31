Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVHaK4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVHaK4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 06:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVHaK4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 06:56:35 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:30133 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932223AbVHaK4e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 06:56:34 -0400
Message-ID: <43158D03.6040004@rbcmail.ru>
Date: Wed, 31 Aug 2005 14:57:07 +0400
From: Vitaly Wool <vitalhome@rbcmail.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grigory Tolstolytkin <gtolstolytkin@dev.rtsoft.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: 8250 serial driver and PM
References: <43134BF8.1090706@dev.rtsoft.ru>
In-Reply-To: <43134BF8.1090706@dev.rtsoft.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grigory,
it's unclear from your letter where you take pnx4008_uart_pm from. Can 
you please elaborate?

What I would think of if I were you is adding a field 'pm' to struct 
plat_serial8250_port which is filled in in the architecture-specific 
part and setting up->pm accrodingly.
I'll send a patch that may be of a help for you shortly.

Best regards,
   Vitaly


Grigory Tolstolytkin wrote:

> Hi,
>
> I'm working on power management support for a particular ARM based 
> board and I've got a question:
> I want to add a board specific power management for standard uart 
> driver (serial8250). For this purpose there is a special hook defined 
> in uart_8250_port structure (drivers/serial/8250.c):
> ...
> >        /*
> >        * We provide a per-port pm hook.
> >         */
> >        void                    (*pm)(struct uart_port *port,
> >                                      unsigned int state, unsigned 
> int old);
> ...
>
> When driver goes into suspend/resume, serial8250_pm() function is 
> called and it checks for the hook and executes it if it exists. But I 
> didn't find a proper way to assign my own function to this hook.
> How this hook is supposed to be changed? Is there a way to correctly 
> initialize it and how it should be done?
> Whether it's a good way to initialize it, for example, in 
> serial8250_isa_init_ports():
> ...
>                up->mcr_mask = ~ALPHA_KLUDGE_MCR;
>                up->mcr_force = ALPHA_KLUDGE_MCR;
>
>                up->port.ops = &serial8250_pops;
>
> #ifdef CONFIG_ARCH_XXX
>                up->pm = pnx4008_uart_pm;
> #endif
>       }
> ...
>
> Or it's a bad manner?
>
> Any help appreciated,
>
> Thanks,
> Grigory.
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

