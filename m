Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbUA3Rii (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUA3Rii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:38:38 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:46345 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263002AbUA3Rg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:36:56 -0500
Message-ID: <401A9716.3040607@techsource.com>
Date: Fri, 30 Jan 2004 12:40:38 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Helge Hafting <helgehaf@aitel.hist.no>, John Bradford <john@grabjohn.com>,
       chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au> <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk> <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk> <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk> <40195AE0.2010006@techsource.com> <401A33CA.4050104@aitel.hist.no> <401A8E0E.6090004@techsource.com> <Pine.LNX.4.55.0401301812380.10311@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0401301812380.10311@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Maciej W. Rozycki wrote:
> On Fri, 30 Jan 2004, Timothy Miller wrote:
> 
> 
>>>Another reason to drop VGA then - money.
>>
>>As soon as PC BIOS's don't require it, we can drop it.
> 
> 
>  No PC BIOS recognizes a VGA.  The PC/AT firmware uses int 0x10 to
> communicate with the console and as long as there is a handler there,
> console output works.  Most systems will actually run without a handler,
> too, but they'll usually complain to the speaker.  The handler is provided
> by the ROM firmware of the primary graphics adapter.
> 
>  Old PC/AT firmware actually did recognize a few display adapters, namely
> the CGA and the MDA which had no own firmware.  These days support for
> these option is often absent, even though the setup program may provide an
> option to select between CGA40/CGA80/MDA/none (the latter being equivalent
> to an option such as an EGA or a VGA, providing its own firmware).
> 

You're not entirely correct here.  I attempted to write a VGA BIOS for a 
card which did not have hardware support for 80x25 text.

I first tried intercepting int 0x10.  I quickly discovered that most DOS 
programs bypass int 0x10 and write directly to the display memory.  As a 
result, very little of what should have displayed actually did.

Next, I tried hanging off this timer interrupt.  I had two copies of the 
text display, "now" and "what it was before".  I would compare the 
characters and render any differences.  This worked quite well for DOS, 
but the instant ANY OS switched to protected mode, they took over the 
interrupt and all console messages stopped.  Actually, the same was true 
for int 0x10.

Even just the DOS shell command-line tends to bypass int 0x10 and write 
directly to display memory.

Furthermore, 640x480x16 simply won't happen at all without direct 
hardware support.  Some things rely on that (or mode X or whatever) for 
initial splash screens.

In the PC world, too many assumptions are made about the hardware for 
any kind of software emulation to work.

The suggestion that a general-purpose CPU on the graphics card could be 
used to emulate it is correct, but the logic area of the general-purpose 
CPU is greater than that of the dedicated VGA hardware.  Furthermore, 
you can't just "stick a Z80 onto the board", because multi-chip 
solutions up the board cost too much.

