Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbUKKSpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUKKSpM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUKKSnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:43:41 -0500
Received: from relay02.pair.com ([209.68.5.16]:37134 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S262358AbUKKSmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 13:42:44 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <4193B2A3.8020103@cybsft.com>
Date: Thu, 11 Nov 2004 12:42:43 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Remi Colinet <remi.colinet@free.fr>
CC: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-0
References: <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <4193D21A.7010809@free.fr>
In-Reply-To: <4193D21A.7010809@free.fr>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000600070909070407040404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000600070909070407040404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Remi Colinet wrote:
> Ingo Molnar wrote:
> 
>> i have released the -V0.7.25-0 Real-Time Preemption patch, which can be
>> downloaded from the usual place:
>>
>>    http://redhat.com/~mingo/realtime-preempt/
>>
>>
>>  
>>
> Hi,
> 
> I'm getting the following warning with V0.7.25-0
> 
> INSTALL sound/drivers/opl3/snd-opl3-lib.ko
> INSTALL sound/drivers/opl3/snd-opl3-synth.ko
> INSTALL sound/drivers/snd-dummy.ko
> INSTALL sound/drivers/snd-mtpav.ko
> INSTALL sound/drivers/snd-serial-u16550.ko
> INSTALL sound/drivers/snd-virmidi.ko
> INSTALL sound/pci/snd-sonicvibes.ko
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map 
> 2.6.10-rc1-mm3-RT-V0.7.25-0; fi
> WARNING: 
> /lib/modules/2.6.10-rc1-mm3-RT-V0.7.25-0/kernel/drivers/char/rtc.ko 
> needs unknown symbol rtc_close_event
> WARNING: 
> /lib/modules/2.6.10-rc1-mm3-RT-V0.7.25-0/kernel/drivers/char/rtc.ko 
> needs unknown symbol rtc_open_event
> [root@tigre01 im]#
> 
> .config file attached
> 
> Remi
> 

Damn. Here is the patch again. Last one was hosed by wrap. Sorry.

kr

--------------000600070909070407040404
Content-Type: text/plain;
 name="rtc.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtc.fix"

--- linux-2.6.10-rc1-mm3/drivers/char/rtc.c.orig	2004-11-11 11:35:00.898841565 -0600
+++ linux-2.6.10-rc1-mm3/drivers/char/rtc.c	2004-11-11 12:07:54.019642611 -0600
@@ -863,7 +863,9 @@
 	if(rtc_status & RTC_IS_OPEN)
 		goto out_busy;
 
+#ifdef RTC_IRQ
 	rtc_open_event();
+#endif
 	rtc_status |= RTC_IS_OPEN;
 
 	rtc_irq_data = 0;
@@ -920,7 +922,9 @@
 	rtc_irq_data = 0;
 	rtc_status &= ~RTC_IS_OPEN;
 	spin_unlock_irq (&rtc_lock);
+#ifdef RTC_IRQ
 	rtc_close_event();
+#endif
 	return 0;
 }
 

--------------000600070909070407040404--
