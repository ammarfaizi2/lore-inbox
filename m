Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVA2ULQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVA2ULQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 15:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVA2ULQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 15:11:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:41397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbVA2ULG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 15:11:06 -0500
Message-ID: <41FBEBC5.8020404@osdl.org>
Date: Sat, 29 Jan 2005 12:02:13 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Jaco Kroon <jaco@kroon.co.za>, Andries Brouwer <aebr@win.tue.nl>,
       Linus Torvalds <torvalds@osdl.org>, sebekpi@poczta.onet.pl,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org> <20050127202947.GD6010@pclin040.win.tue.nl> <20050128131728.GA11723@ucw.cz> <41FA4A4A.4040308@kroon.co.za> <20050128183955.GA2640@ucw.cz>
In-Reply-To: <20050128183955.GA2640@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Fri, Jan 28, 2005 at 04:20:58PM +0200, Jaco Kroon wrote:
> 
>>Vojtech Pavlik wrote:
>>
>>>On Thu, Jan 27, 2005 at 09:29:47PM +0100, Andries Brouwer wrote:
>>>
>>>
>>>
>>>>>So what _might_ happen is that we write the command, and then 
>>>>>i8042_wait_write() thinks that there is space to write the data 
>>>>>immediately, and writes the data, but now the data got lost because the 
>>>>>buffer was busy.
>>>>
>>>>Hmm - I just answered the same post and concluded that I didnt understand,
>>>>so you have progressed further. I considered the same possibility,
>>>>but the data was not lost since we read it again later.
>>>>Only the ready flag was lost.
>>>
>>>
>>>What I believe is happening is that we're talking to SMM emulation of
>>>the i8042, which doesn't have a clue about these commands, while the
>>>underlying real hardware implementation does. And because of that they
>>>disagree on what should happen when the command is issued, and since the
>>>SMM emulation lazily synchronizes with the real HW, we only get the data
>>>back with the next command.
>>>
>>>I still don't have an explanation why both 'usb-handoff' and 'acpi=off'
>>>help, I'd expect only the first to, but it might be related to the SCI
>>>interrupt routing which isn't done when 'acpi=off'. Just a wild guess.
>>>
>>
>>Ok, I'm not too clued up with recent hardware and the BIOS programming 
>>that goes with it (being a system admin/application programmer), what 
>>exactly is usb-handoff?
> 
> 
> usb-handoff is a kernel option that enables a PCI quirk routine that
> takes the USB controller out of BIOS's hands. Until that is done (the
> linux USB drivers also do it, only later), the BIOS owns the USB
> controller and tries to emulate a PS/2 mouse and keyboard for systems
> which can't handle USB.
> 
> 
>> acpi=off obviously just turns all acpi support 
>>in the kernel off. 
> 
> 
> Indeed.
> 
> 
>>SCI is also a new abbreviation I haven't seen 
>>before.
> 
> 
> System Configuration Interrupt. In addition to SMI (System Management
> Interrupt), these are two interrupts the BIOS uses to do its job behind
> the operating system's back.

ACPI 2.0 spec says:
System Control Interrupt (SCI)
A system interrupt used by hardware to notify the OS of ACPI events. 
The SCI is an active, low, shareable, level interrupt.

-- 
~Randy
