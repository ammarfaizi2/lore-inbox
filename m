Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWDQOAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWDQOAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWDQOAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:00:32 -0400
Received: from wasp.net.au ([203.190.192.17]:4075 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1750966AbWDQOAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:00:32 -0400
Message-ID: <44439FCE.50809@wasp.net.au>
Date: Mon, 17 Apr 2006 18:01:50 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 3.0a1 (X11/20060414)
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16.1 psmouse.c: TouchPad at isa0060/serio4/input0 lost sync
 at byte 1 and ACPI
References: <44437793.20908@wasp.net.au> <d120d5000604170522q54b4b6ftc263f16a649a99e7@mail.gmail.com>
In-Reply-To: <d120d5000604170522q54b4b6ftc263f16a649a99e7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 4/17/06, Brad Campbell <brad@wasp.net.au> wrote:
>> Apr 17 14:12:30 bklaptop kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
>> Apr 17 14:12:30 bklaptop last message repeated 4 times
>> Apr 17 14:12:30 bklaptop kernel: psmouse.c: issuing reconnect request
>>
>> I know it's related to ACPI as if I kill all apps that poll the acpi interface the problem goes
>> away. My issue is that when I do that, I sometimes forget to plug the machine in when it needs it
>> (or suspend it to change the battery) and it winds up dead with no warning. So I *really* need my
>> battery monitoring.
>>
>> I just don't recall having these problems, to this extent with earlier kernels. It's always been
>> there, but I guess since I passed about 2.6.13 or thereabouts it has just gotten worse. 2.6.16.1 is
>> almost unusable for serious work if I have anything monitoring the battery.
>>
> 
> I often do you have your apps polling battery? Changing to 1 or 2
> minutes might help.

All in all I have three apps that poll.. I've slowed them down a little and it still seems to 
co-incide with me typing or using the touchpad (Murphy is a swine like that). One polls once per 
minute, one polls every 30 seconds and one polls every 2 seconds!! (that one I can kill without 
losing any major functionality)

>> ACPI: Embedded Controller [EC0] (gpe 29) interrupt mode.
> 
> You can try changing EC to use polling mode (ec_intr=0) or even try disablig it.

I've used ec_intr=0 now and it has appeared to increase the reliability somewhat..
Just got my 1st set in dmesg while composing this e-mail, however I did not notice the mouse lockup 
or any keys stick. I did have a key stick about 15 mins ago, but it left no messages in the logs.

psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: issuing reconnect request

Have not figured out how to disable the ACPI ec yet, but I'll get my head in that code tonight and 
have a look around.

All in all it looks like a definite improvement. I'll keep playing. Many thanks!

(just had another key stick but again, nothing in the logs)

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
