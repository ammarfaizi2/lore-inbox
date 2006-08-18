Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbWHRO6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbWHRO6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWHRO6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:58:09 -0400
Received: from smtp7.libero.it ([193.70.192.90]:12727 "EHLO smtp7.libero.it")
	by vger.kernel.org with ESMTP id S1030456AbWHRO6I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:58:08 -0400
From: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "Linux Kernel ML" <linux-kernel@vger.kernel.org>
Subject: R: R: How to avoid serial port buffer overruns?
Date: Fri, 18 Aug 2006 16:58:07 +0200
Message-ID: <NBBBIHMOBLOHKCGIMJMDIEKFFNAA.g.tomassoni@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <44E5CF1A.6000506@shaw.ca>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Messaggio originale-----
> Da: Robert Hancock [mailto:hancockr@shaw.ca]
> Inviato: venerdì 18 agosto 2006 16.31
> A: Giampaolo Tomassoni
> Cc: Linux Kernel ML
> Oggetto: Re: R: How to avoid serial port buffer overruns?
>
> IRQ_HANDLED vs. IRQ_NONE has no effect on what interrupt handlers are 
> called, etc. It is only used to detect if an interrupt is firing without 
> being handled by any driver, in this case the kernel can detect this and 
> disable the interrupt.
> 
> I'm not sure exactly why the driver is returning IRQ_HANDLED all the 
> time, but edge-triggered interrupts are always tricky and there may be a 
> case where it can't reliably detect this. Returning IRQ_HANDLED is the 
> safe thing to do if you cannot be sure if your device raised an 
> interrupt or not.

Oh, I see. This in handle_IRQ_event in /kernel/irq/handle.c confirms what you said:

        do {
                ret = action->handler(irq, action->dev_id, regs);
                if (ret == IRQ_HANDLED)
                        status |= action->flags;
                retval |= ret;
                action = action->next;
        } while (action);

There is no escape from the loop when the handler returns IRQ_HANDLED.

Thanks,

	giampaolo

> 
> -- 
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
> 

