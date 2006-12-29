Return-Path: <linux-kernel-owner+w=401wt.eu-S964962AbWL2F4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWL2F4U (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 00:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWL2F4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 00:56:20 -0500
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:55363 "EHLO
	smtpq3.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964962AbWL2F4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 00:56:19 -0500
Message-ID: <4594ADAD.1030400@gmail.com>
Date: Fri, 29 Dec 2006 06:54:53 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
CC: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
References: <4592E685.5000602@gmail.com> <200612290000.12791.dtor@insightbb.com> <4594A4DC.5090404@gmail.com> <200612290028.01531.dtor@insightbb.com>
In-Reply-To: <200612290028.01531.dtor@insightbb.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

> On Friday 29 December 2006 00:17, Rene Herman wrote:

>> Yes, I do have that in my tree. From the looks of it it's probably not 
>> surprising, but the following gets me blinking leds without the spurious 
>> ACK messages. Maybe still useful to know?
>>
>> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
>> index debe944..9c70d34 100644
>> --- a/drivers/input/serio/i8042.c
>> +++ b/drivers/input/serio/i8042.c
>> @@ -371,7 +371,7 @@ static irqreturn_t i8042_interrupt(int i
>>   	if (unlikely(i8042_suppress_kbd_ack))
>>   		if (port_no == I8042_KBD_PORT_NO &&
>>   		    (data == 0xfa || data == 0xfe)) {
>> -			i8042_suppress_kbd_ack = 0;
>> +			/* i8042_suppress_kbd_ack = 0; */
>>   			goto out;
> 
> That would indicate that your keyboard generates multiple acks... I wonder
> if you could boot with i8042.debug=1 and somehow capture the data flow
> during panic (do you have a digital camera?).

Not even an analog camera, but with or without the above, I get a single:

" <7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [ 902]"

when it panics. During a full boot, I get:

===
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:06' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
drivers/input/serio/i8042.c: 20 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 65 <- i8042 (return) [1]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: 5a <- i8042 (return) [1]
drivers/input/serio/i8042.c: a7 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 74 <- i8042 (return) [1]
drivers/input/serio/i8042.c: a8 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 54 <- i8042 (return) [1]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
drivers/input/serio/i8042.c: a5 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: a5 <- i8042 (flush, aux) [252]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [252]
drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [252]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [252]
drivers/input/serio/i8042.c: 65 -> i8042 (parameter) [252]
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [252]
input: PC Speaker as /class/input/input4
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [255]
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, 0, 1) [256]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, 0, 1) [258]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [258]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [261]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [261]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [264]
drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [264]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [267]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [267]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [270]
drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [270]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 0, 1) [273]
input: AT Translated Set 2 keyboard as /class/input/input5
===

Rene.

