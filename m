Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUFJWGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUFJWGn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 18:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUFJWGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 18:06:43 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:1410 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262176AbUFJWGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 18:06:36 -0400
Date: Thu, 10 Jun 2004 17:05:44 -0500
From: Fernando Paredes <Fernando.Paredes@Sun.COM>
Subject: Re: Toshiba keyboard lockups
In-reply-to: <efc4b1ba19898906eb0aec7ac9c22fcd@stdbev.com>
To: linux-kernel@vger.kernel.org
Message-id: <40C8DB38.9030300@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040130
References: <40A162BA.90407@sun.com> <200405121149.37334.rjwysocki@sisk.pl>
 <40C7880C.4000401@sun.com> <200406101915.i5AJFCBu197611@car.linuxhacker.ru>
 <efc4b1ba19898906eb0aec7ac9c22fcd@stdbev.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To the benefit of developers, here are the tracebacks for today. I 
haven't experienced any lockups so far, BUT i have experienced two weird 
experiences:
1) The space key seemed to get stuck and it unstock by pressing <backspace>
2) The 'n' key stuck and unstuck itself, displaying about 5 'n' on my 
screen.

For both events I have an identified backtrace from 'dmesg' (thanks, to 
the traceback code in atkbd.c). There is another event there in the logs 
where I didn't notice in the keyboard.

As someone in this thread expressed earlier, it seems that the driver is 
requesting a keyboard reconnect. This shouldn't be hapenning, right?

Here are the traces with their desrcibing title:

----> Space key stuck until I pressed "BACKSPACE" <-----
serio: RESCAN || RECONNECT requested: 1!
Call Trace:
 [<c02b068c>] serio_queue_event+0x95/0x97
 [<c02b06a5>] serio_rescan+0x17/0x1b
 [<c02af4d7>] atkbd_interrupt+0x465/0x550
 [<c0113333>] scheduler_tick+0x1f/0x530
 [<c02b073f>] serio_interrupt+0x7b/0x7d
 [<c02b0f80>] i8042_interrupt+0xd0/0x14c
 [<c01058b9>] handle_IRQ_event+0x3a/0x64
 [<c0105c41>] do_IRQ+0xdc/0x1c0
 =======================
 [<c0104194>] common_interrupt+0x18/0x20
 [<c022c2b0>] acpi_processor_idle+0x13c/0x1cb
 [<c010201e>] default_idle+0x0/0x27
 [<c022c174>] acpi_processor_idle+0x0/0x1cb
 [<c010201e>] default_idle+0x0/0x27
 [<c01020a9>] cpu_idle+0x2e/0x37
 [<c04066b0>] start_kernel+0x15d/0x17a
 [<c0406402>] unknown_bootoption+0x0/0x129

atkbd.c: Unknown key released (translated set 2, code 0x39 on 
isa0060/serio0).
atkbd.c: Use 'setkeycodes 39 <keycode>' to make it known.
input: AT Translated Set 2 keyboard on isa0060/serio0

----> Some random event, nothing notable happened to the keyboard: <-----
serio: RESCAN || RECONNECT requested: 1!
Call Trace:
 [<c02b068c>] serio_queue_event+0x95/0x97
 [<c02b06a5>] serio_rescan+0x17/0x1b
 [<c02af4d7>] atkbd_interrupt+0x465/0x550
 [<c0113333>] scheduler_tick+0x1f/0x530
 [<c02b073f>] serio_interrupt+0x7b/0x7d
 [<c02b0f80>] i8042_interrupt+0xd0/0x14c
 [<c01058b9>] handle_IRQ_event+0x3a/0x64
 [<c0105c41>] do_IRQ+0xdc/0x1c0
 =======================
 [<c0104194>] common_interrupt+0x18/0x20
 [<c022c2b0>] acpi_processor_idle+0x13c/0x1cb
 [<c010201e>] default_idle+0x0/0x27
 [<c022c174>] acpi_processor_idle+0x0/0x1cb
 [<c010201e>] default_idle+0x0/0x27
 [<c01020a9>] cpu_idle+0x2e/0x37
 [<c04066b0>] start_kernel+0x15d/0x17a
 [<c0406402>] unknown_bootoption+0x0/0x129
 
 
----> 'n' key stuck for 2 seconds (4 'n's appeared..actually there were 
two events here, not sure if they're related) <-----
Call Trace:
 [<c02b068c>] serio_queue_event+0x95/0x97
 [<c02b06a5>] serio_rescan+0x17/0x1b
 [<c02af4d7>] atkbd_interrupt+0x465/0x550
 [<c0113333>] scheduler_tick+0x1f/0x530
 [<c02b073f>] serio_interrupt+0x7b/0x7d
 [<c02b0f80>] i8042_interrupt+0xd0/0x14c
 [<c01058b9>] handle_IRQ_event+0x3a/0x64
 [<c0105c41>] do_IRQ+0xdc/0x1c0
 =======================
 [<c0104194>] common_interrupt+0x18/0x20
 [<c022c2b0>] acpi_processor_idle+0x13c/0x1cb
 [<c010201e>] default_idle+0x0/0x27
 [<c010201e>] default_idle+0x0/0x27
 [<c01020a9>] cpu_idle+0x2e/0x37
 [<c04066b0>] start_kernel+0x15d/0x17a
 [<c0406402>] unknown_bootoption+0x0/0x129

serio: RESCAN || RECONNECT requested: 1!
Call Trace:
 [<c02b068c>] serio_queue_event+0x95/0x97
 [<c02b06a5>] serio_rescan+0x17/0x1b
 [<c02b070a>] serio_interrupt+0x46/0x7d
 [<c02b0f80>] i8042_interrupt+0xd0/0x14c
 [<c02b1112>] i8042_timer_func+0x0/0x23
 [<c02b1131>] i8042_timer_func+0x1f/0x23
 [<c011ea46>] run_timer_softirq+0xcb/0x1b0
 [<c012615d>] rcu_process_callbacks+0x108/0x114
 [<c011ab75>] __do_softirq+0x81/0x83
 [<c0106590>] do_softirq+0x43/0x52
 =======================
 [<c0105cd2>] do_IRQ+0x16d/0x1c0
 [<c0104194>] common_interrupt+0x18/0x20
 [<c022c2b0>] acpi_processor_idle+0x13c/0x1cb
 [<c010201e>] default_idle+0x0/0x27
 [<c010201e>] default_idle+0x0/0x27
 [<c01020a9>] cpu_idle+0x2e/0x37
 [<c04066b0>] start_kernel+0x15d/0x17a
 [<c0406402>] unknown_bootoption+0x0/0x129


Jason Munro wrote:

>On 2:15:12 pm 06/10/04 Oleg Drokin <green@linuxhacker.ru> wrote:
>  
>
>>Hello!
>>
>>Fernando Paredes <Fernando.Paredes@sun.com> wrote:
>>
>>FP> Applied these patches. Nothing while tail'ing /var/log/messages.
>>Nothing FP> in the root console that I can see either.
>>FP> Patched the source to 2.6.6. Still get the same lockups, totally
>>random. FP> Any more ideas?
>>
>>Not sure if I have exact problem like you do, but at least I have
>>something similar. Once in a while keyboard suddenly stopps working,
>>touchpad still work though (I have Toshiba Satellite Pro (centrino
>>based) laptop here). I figured out that if I leave the keyboard for
>>some time (up to 2 minutes), it starts to work again, at least this
>>was the case with XFree 4.4, during those no-keyboard times, mouse
>>cursor was moving with small jumps (when keyboard works it moves
>>smoothly). I upgraded to FC2 (and hence to xorg X server) today, and
>>lockup happened once already, the "wait for some time" strategy did
>>not work, so I remembered initially I thought this was something bad
>>pressed on keyboard 
>>    
>>
>
>I have had similar issues with a toshiba laptop keyboard with 2.6+ kernels
>for awhile. I have found that repeating the last key combination pressed
>will "unlock" it. No logs or dmesg entries are produced when the lockup
>occurs.
>
>
>Its a Toshiba Satellite 1410-S173, currently running 2.6.7-rc2-mm2
>
>\__ Jason Munro
> \__ jason@stdbev.com
>  \__ http://hastymail.sourceforge.net/
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

-- 

<http://www.sun.com/software>                      <http://java.sun.com>
*Fernando Paredes
Identity & Collaboration
Sun Microsystems de México
Prol. Reforma #600-110, Col. Santa Fe, México D.F. 01210
Tel Dir: 52 + (55) 5258 6152
Fax: 52 + (55) 5258 6199*

