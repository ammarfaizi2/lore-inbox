Return-Path: <linux-kernel-owner+w=401wt.eu-S1752531AbWL2MpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbWL2MpK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 07:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbWL2MpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 07:45:10 -0500
Received: from smtp23.orange.fr ([193.252.22.30]:36852 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531AbWL2MpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 07:45:08 -0500
X-ME-UUID: 20061229124505443.6C27270000A0@mwinf2328.orange.fr
Message-ID: <45950DD1.2010208@free.fr>
Date: Fri, 29 Dec 2006 13:45:05 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.7) Gecko/20060405 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Rene Herman <rene.herman@gmail.com>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
References: <4592E685.5000602@gmail.com> <200612290000.12791.dtor@insightbb.com> <4594A4DC.5090404@gmail.com> <200612290028.01531.dtor@insightbb.com> <4594ADAD.1030400@gmail.com>
In-Reply-To: <4594ADAD.1030400@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29.12.2006 06:54, Rene Herman a écrit :
> Dmitry Torokhov wrote:
> 
>> On Friday 29 December 2006 00:17, Rene Herman wrote:
> 
>>> Yes, I do have that in my tree. From the looks of it it's probably 
>>> not surprising, but the following gets me blinking leds without the 
>>> spurious ACK messages. Maybe still useful to know?
>>>
>>> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
>>> index debe944..9c70d34 100644
>>> --- a/drivers/input/serio/i8042.c
>>> +++ b/drivers/input/serio/i8042.c
>>> @@ -371,7 +371,7 @@ static irqreturn_t i8042_interrupt(int i
>>>       if (unlikely(i8042_suppress_kbd_ack))
>>>           if (port_no == I8042_KBD_PORT_NO &&
>>>               (data == 0xfa || data == 0xfe)) {
>>> -            i8042_suppress_kbd_ack = 0;
>>> +            /* i8042_suppress_kbd_ack = 0; */
>>>               goto out;
>>
>> That would indicate that your keyboard generates multiple acks... I 
>> wonder
>> if you could boot with i8042.debug=1 and somehow capture the data flow
>> during panic (do you have a digital camera?).
> 
> Not even an analog camera, but with or without the above, I get a single:
> 
> " <7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [ 902]"
> 
> when it panics. During a full boot, I get:
> 
> ===
[snip]
> ===
> 
> Rene.
> 

Dmitry, 

How about this output? (got this after a kernel panic)

====
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35172]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35172]
atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying access hardware directly.
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35296]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35297]
atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying access hardware directly.
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35420]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35421]
atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying access hardware directly.
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35544]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [35545]
atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying access hardware directly.
===

~~
laurent

