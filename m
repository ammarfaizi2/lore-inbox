Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbUCRWEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 17:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbUCRWD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 17:03:28 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:49584 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263219AbUCRWCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 17:02:41 -0500
Date: Fri, 19 Mar 2004 05:58:41 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Michael Frank" <mhf@linuxmail.org>, "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: 2.6.x atkbd.c moaning
Cc: akpm@osdl.org, anton@samba.org,
       "kernel mailing list" <linux-kernel@vger.kernel.org>
References: <opr41z9zel4evsfm@smtp.pacific.net.th> <20040318120114.GN28212@krispykreme> <opr42hoctn4evsfm@smtp.pacific.net.th> <opr42nq0a24evsfm@smtp.pacific.net.th> <20040318195819.GB4248@ucw.cz> <opr42ry9kk4evsfm@smtp.pacific.net.th> <20040318210737.GA4494@ucw.cz> <opr42uy0wi4evsfm@smtp.pacific.net.th>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr42vb3wk4evsfm@smtp.pacific.net.th>
In-Reply-To: <opr42uy0wi4evsfm@smtp.pacific.net.th>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004 05:50:50 +0800, Michael Frank <mhf@linuxmail.org> wrote:

> On Thu, 18 Mar 2004 22:07:37 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
>
>> On Fri, Mar 19, 2004 at 04:46:11AM +0800, Michael Frank wrote:
>>
>>> >>The Unknown key release msg is introduced in 2.6.1 with i8042
>>> >>changesets from 1.33 to 1.35 (likely 1.34 as Anton suggested). Guess i
>>> >>did not think much of it as it was "smaller" but "blaming xfree"
>>> >>during boot since 2.6.2 caught my attention.
>>> >
>>> >XFree86 was fixed (post 4.4) thanks to this message. kbdrate is also
>>> >fixed in the current version. With latest XFree86 and latest kbd package
>>> >you shouldn't be getting this message anymore.
>>>
>>> I appreciate the message when X-old or kbdrate-old is running but not
>>> during boot right after HD init. Please see dmesg.
>>>
>>> I updated to kbd-1.12-1 Change kdbrate does still create messages.
>>> Will look for later package. Which version?
>>
>> Are you running kbdrate on the console?
>
> Console, ssh, serial console, xterm - all the same

Retested with USB compiled in it is working fine too, so that
fixes mouse and keyboard issues.

>
> Above is the latest package I could find for redhat.
>
>>
>>> >Can you give details on the mouse and the machine? I seem to have missed
>>> >them.
>>>
>>> Mouse is a noname USB mouse connected via an PS2 Adapter to the PS2 port.
>>> Dmesg included.
>>
>> Ok. Does it have a wheel and extra buttons?
>
> It has a wheel (which works with kde, opera..) and 2 buttons.
> Wheel is a wheel only (no button).
>
> BTW this USB mouse would not work with USB on 2.4 using modular USB.
>
>>
>>> >>The serious issue with the mouse is that it does not recover and stays
>>> >>out of sync and interprets further movement as random coordinates/button
>>> >>clicks.
>>> >
>>> >Does unloading and reloading the psmouse module help?
>>>
>>> No, once sync lost, unload, load psmouse no use and
>>> unplug, plug mouse no use too.
>>
>> Interesting. Since the driver shouldn't be keeping any state, unplugging
>> and replugging the mouse should be well enough.
>>
>>> But: unload, remove mouse, plug mouse, load is OK
>>> except setting for acceleration is too low.
>>>
>>> Looks like psmouse reset no work on 2.6.
>>
>> I'll take a look at this code path then.
>>
>> Btw, please try with USB support compiled into the kernel. We might be
>> seeing yet another incarnation of the "Legacy USB emulation" problem.
>
> Compiled in core, ohci, hid.
>
> PCI: Found IRQ 6 for device 0000:00:03.0
> ohci_hcd 0000:00:03.0: OHCI Host Controller
> ohci_hcd 0000:00:03.0: irq 6, pci mem df80d000
> ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
> usb usb1: Product: OHCI Host Controller
> usb usb1: Manufacturer: Linux 2.6.4-mhf195 ohci_hcd
> usb usb1: SerialNumber: 0000:00:03.0
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> PCI: Found IRQ 9 for device 0000:00:03.1
> ohci_hcd 0000:00:03.1: OHCI Host Controller
> ohci_hcd 0000:00:03.1: irq 9, pci mem df80f000
> ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
> usb usb2: Product: OHCI Host Controller
> usb usb2: Manufacturer: Linux 2.6.4-mhf195 ohci_hcd
> usb usb2: SerialNumber: 0000:00:03.1
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> drivers/usb/core/usb.c: registered new driver hiddev
> drivers/usb/core/usb.c: registered new driver hid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> mice: PS/2 mouse device common for all mice
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: AT Translated Set 2 keyboard on isa0060/serio0
>
> Both PS2 mouse and USB mouse working :)
>
> But when plugging the mouse hotplug wanna load floppy driver ;)
> (System has no floppy). IIRC This was recently discussed.
>
> Interrupts are not shared. IRQ5 would go to EHCI, 7 to PRN.
>
>            CPU0
>    0:     549460          XT-PIC  timer
>    1:         12          XT-PIC  i8042
>    2:          0          XT-PIC  cascade
>    4:        368          XT-PIC  serial
>    6:        574          XT-PIC  ohci_hcd
>    8:          1          XT-PIC  rtc
>    9:          0          XT-PIC  ohci_hcd
>   11:       8999          XT-PIC  eth0
>   12:       1121          XT-PIC  i8042
>   14:       5181          XT-PIC  ide0
> NMI:          0
> ERR:          0
>
> APIC buggy, ACPI more buggy. Keyboard  no work at all with
> ACPI on this board. DSDT has more bugs than a tropical jungle.
>
>>
>>>  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 > hda4
>>> mice: PS/2 mouse device common for all mice
>>> serio: i8042 AUX port at 0x60,0x64 irq 12
>>> input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
>>> serio: i8042 KBD port at 0x60,0x64 irq 1
>>> input: AT Translated Set 2 keyboard on isa0060/serio0
>>> atkbd.c: Unknown key released (translated set 2, code 0x7a on
>>> isa0060/serio0).
>>> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
>>> atkbd.c: Unknown key released (translated set 2, code 0x7a on
>>> isa0060/serio0).
>>> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
>>> atkbd.c: Unknown key released (translated set 2, code 0x7a on
>>> isa0060/serio0).
>>> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
>>> atkbd.c: Unknown key released (translated set 2, code 0x7a on
>>> isa0060/serio0).
>>> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
>>> atkbd.c: Unknown key released (translated set 2, code 0x7a on
>>> isa0060/serio0).
>>> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
>>> NET: Registered protocol family 2
>>
>> This indeed looks like it. Why do you specify "nousb" on the kernel
>> command line?
>>
>
> USB is not used much and too much trouble to keep running when not in use ;)
> USB does not work with swsusp. USB breaks reboot on some hardware too.
>
> I load USB and hotplug by script only when needed.
>
> I recently had a case with swsusp user leaving usbcore and hotplug
> resulting in breaking a notebooks internal keyboard...
>
> Regards
> Michael


