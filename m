Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUD1TOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUD1TOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUD1TO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:14:28 -0400
Received: from mrout1.yahoo.com ([216.145.54.171]:33034 "EHLO mrout1.yahoo.com")
	by vger.kernel.org with ESMTP id S265065AbUD1Sr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 14:47:57 -0400
Message-ID: <408FFC2A.3080504@bigfoot.com>
Date: Wed, 28 Apr 2004 11:47:06 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.5) Gecko/20031111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
References: <40853060.2060508@bigfoot.com> <200404281022.23878.kim@holviala.com> <408F697D.2010906@bigfoot.com> <200404280741.08665.dtor_core@ameritech.net>
In-Reply-To: <200404280741.08665.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> If I may chime in...
> 
> On Wednesday 28 April 2004 03:21 am, Erik Steffl wrote:
>  
> 
>>input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
>>input: ExPS/2 Generic Explorer Mouse on isa0060/serio1
>>input: PS2++ Logitech Mouse on isa0060/serio1
>>input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
>>input: ExPS/2 Generic Explorer Mouse on isa0060/serio1
>>input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
>>input: PS2++ Logitech Mouse on isa0060/serio1
>>input: PS/2 Generic Mouse on isa0060/serio1
>>input: PS/2 Generic Mouse on isa0060/serio1
>>input: ExPS/2 Generic Explorer Mouse on isa0060/serio1
>>
> 
> 
> So your mouse pretty much can work with any protocol... Now could you please

   it does NOT work with any protocol.

   there are two problems:

   wheel:

   turning of the wheel in both direction produces 8, 0, 0 (which seems 
to mean any button down), all other buttons produces 8, 0, 0 on button 
down and x, 0, 0 on button up (x depends on button).

   side button: produces exactly same numbers as middle button (clicking 
the wheel, 12, 0, 0 on button up).

   that's with most protocols, some protocols (ps2pp, bare, genps) 
ignore the wheel completely (as far as I can tell that's OK)

> re-load the module without any parameters and post the output of
> "cat /proc/bus/input/devices"

jojda:/home/erik# rmmod psmouse
jojda:/home/erik# modprobe -v psmouse
insmod /lib/modules/2.6.5/kernel/drivers/input/mouse/psmouse.ko
jojda:/home/erik# cat /proc/bus/input/devices
I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event0
B: EV=120003
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: LED=7

I: Bus=0011 Vendor=0002 Product=0020 Version=0038
N: Name="ImPS/2 Logitech Wheel Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 event1
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103

jojda:/home/erik#

> Also compile evbug module, insert it in the kernel (with psmouse loaded as
> well), hit all buttons again and post the excerpt of dmesg with evbug data.
> I want to make sure that your button is not identified correctly as opposed
> to some data lost in protocol transformation.

   ok, I'll try that (have nobody to push the mouse buttons right now)

> What protocol are you using in XFree?

   that's irrelevant, I got the results above without X running (by 
reading /dev/psaux). In case it might shed some light anyway, here's the 
X info: protocol is MouseManPlusPS/2, it worked with kernel 2.4.x. Now 
(with 2.6.5) X reports same results as you see above (using xev I see 
the wheel is no event, side button is button 2, just like wheel click)

	erik

