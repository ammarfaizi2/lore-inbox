Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTJFV7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 17:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTJFV7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 17:59:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:40444 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261748AbTJFV7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 17:59:08 -0400
Message-ID: <3F81E5C7.1040104@onlinehome.de>
Date: Mon, 06 Oct 2003 23:59:35 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: getting timestamp of last interrupt?
References: <fa.fj0euih.s2sbop@ifi.uio.no> <fa.fvjdidn.13ni70f@ifi.uio.no> <3F7E46AB.3030709@onlinehome.de> <Pine.LNX.4.53.0310060843500.8593@chaos> <3F81B2A3.4040001@onlinehome.de> <Pine.LNX.4.53.0310061426080.11197@chaos> <3F81BCE9.2010808@onlinehome.de> <Pine.LNX.4.53.0310061507470.531@chaos>
In-Reply-To: <Pine.LNX.4.53.0310061507470.531@chaos>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> On Mon, 6 Oct 2003, Hans-Georg Thien wrote:
> 
> 
>>Richard B. Johnson wrote:
>>
>>
>>>On Mon, 6 Oct 2003, Hans-Georg Thien wrote:
>>>
>>>
>>>>[...]
>>>>I'm writing a kernel mode device driver (mouse).
>>>>
>>>>In that device driver I need the timestamp of the last event for another
>>>>kernel mode device (keyboard).
>>>>
>>>>I do not care if that timestamp is in jiffies or in gettimeofday()
>>>>format or whatever format does exist in the world. I am absolutely sure
>>>>I can convert it somehow to fit my needs.
>>>>
>>>>But since it is a kernel mode driver it can not -AFAIK- use the signal()
>>>>syscall.
>>>>
>>>>-Hans
>>>
>>>
>>>Then it gets real simple. Just use jiffies, if you can stand the [...]
>>
>>I fear that there is still some miss-understanding. Jiffies are totally
>>OK for me. I can use them without any conversion.
>>
>>I'll try to formulate the problem with some other words:
>>
>>I hope that there is is something like a "jiffie-counter" for the
>>keyboard driver, that stores the actual jiffies value whenever a
>>keyboard interrupt occurs.
>>
> 
> 
> Well the keyboard driver and the mouse driver are entirely
> different devices.
> 
yes, - I know

> The keyboard has a built-int CPU that generates scan-codes for
> every key-press/key-release. It also performs auto-repeat. The
> mouse generates mouse data at each interrupting event. This data
> represents direction and three key events. Wheel mouse have may
> have additional data, I haven't looked at them. They are not
> related in any way.
> 
yes, - I know

> 
> 
>>I hope too, that there is a way to query that "jiffie-counter" from
>>another kernel driver, so that I can write something like
>>
>>
>>mymouse_module.c
>>
>>...
>>void mouse_event(){
>>
>>    // get the current time in jiffies
>>    int now=jiffies;
>>
>>    // get the jiffie value of the last kbd event
>>    int last_kbd_event= ????;  // ... but how to do that ...
>>
>>    if ((now - last_kbd_event) > delay) {
>>	do_some_very_smart_things();
>>    }
>>   }
>>...
>>
> 
> 
> Now this pseudo-code shows a "last_kbd_event", not a mouse-
> event as shown in:
> 
yes, - I know =8))

It is because I want do some things with the mouse in relation to 
keyboard events.

> 
> [... a quite detailed explanation on mouse interrupts, mouse data ...]
yes, I know. But my question was: how can I get the timestamp of the 
last keyboard interrupt.

> When your module is un-installed, it needs to restore the
> previous (saved) value of that pointer.
> 
yes, - I know

> Whatever code you make that pointer point-to, must be
> interrupt-safe. It can get the jiffie-count and put it
> into a buffer, then return.
>
yes, - I know

Hey Richard, - what is so difficult to understand ?

Anyway, - have you read the email reply from Gabriel Paubert regarding 
this topic? Sounds very good for a 2.6.x kernel. It seems that I can use 
the /dev/input/event? device files. I have just modprobed the "evdev" 
module. It seems that I can get my timestamps by reading one of this 
files. Have to investigate still which one of them I have to use.

-Hans


