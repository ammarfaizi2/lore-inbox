Return-Path: <linux-kernel-owner+w=401wt.eu-S964788AbWL2FSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWL2FSo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 00:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWL2FSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 00:18:44 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:53983 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964788AbWL2FSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 00:18:43 -0500
Message-ID: <4594A4DC.5090404@gmail.com>
Date: Fri, 29 Dec 2006 06:17:16 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
CC: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
References: <4592E685.5000602@gmail.com> <200612282240.00784.dtor@insightbb.com> <459497A3.8080001@gmail.com> <200612290000.12791.dtor@insightbb.com>
In-Reply-To: <200612290000.12791.dtor@insightbb.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>>> The change to suppress ACKs from paic blinking is already in Linus's
>>> tree. I just tried booting with root=/dev/sdg and I had leds blinking
>>> but no messages from atkbd were seen.
>>>
>>> Could it be that you loaded older kernel by accident? Does anybody
>>> else still seeing "Spurios ACK" messages during kernel panic?
>> Well, no, I'm really on 2.6.20-rc2, from a freshly cloned tree. And I do 
>> get atkbd.c complaining at me when I boot with root=/dev/wrong-device.
>>
>> Could you point me to the changeset in question? I couldn't find it 
>> searching for "leds" in the log.
>>
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=817e6ba3623de9cdc66c6aba90eae30b5588ff11

Yes, I do have that in my tree. From the looks of it it's probably not 
surprising, but the following gets me blinking leds without the spurious 
ACK messages. Maybe still useful to know?

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index debe944..9c70d34 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -371,7 +371,7 @@ static irqreturn_t i8042_interrupt(int i
  	if (unlikely(i8042_suppress_kbd_ack))
  		if (port_no == I8042_KBD_PORT_NO &&
  		    (data == 0xfa || data == 0xfe)) {
-			i8042_suppress_kbd_ack = 0;
+			/* i8042_suppress_kbd_ack = 0; */
  			goto out;
  		}

Rene.

