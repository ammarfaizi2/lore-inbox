Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTHWRAE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbTHWQ7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:59:17 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:52475 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263267AbTHWPui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 11:50:38 -0400
Date: Sat, 23 Aug 2003 17:50:35 +0200 (MEST)
Message-Id: <200308231550.h7NFoZtr022365@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: patrick@dreker.de
Subject: Re: nforce2 lockups
Cc: kenton.groombridge@us.army.mil, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003 14:48:06 +0200, Patrick Dreker <patrick@dreker.de> wrote:
>Am Samstag, 23. August 2003 14:20 schrieb Mikael Pettersson <mikpe@csd.uu.se> 
>zum Thema Re: nforce2 lockups:
>> On Sat, 23 Aug 2003 10:41:46 +0900, kenton.groombridge@us.army.mil wrote:
>> Passing nolapic to a kernel which doesn't recognise it causes it to
>> simply be passed through to init, with no error message.
>> So either you used non-standard versions of 2.4.22-rc2/2.6.0-test3,
>> or nolapic wasn't the thing that fixed your nforce2 board.
>It probably was a combination of the other measures mentioned in my mail then. 
>I have (had) the same problems, and one has to completely avoid the local 
>APIC it seems. Passing noapic and disabling APIC Mode in the BIOS did not do 
>that (2.6.0-test3 + acpi20030730). 
...
>> "noapic" (note: no "l") might very well fix your board, but that's
>see above. noapic had no effect on the freezes. On boot it still said "found 
>and enabling local APIC"

Of course it did. "noapic" and BIOS APIC mode relate to the I/O-APIC,
not the local APIC.

My guess is that your BIOS or graphics card can't handle the local
APIC, presumably due to a crap SMM# handler or you using APM's
CPU_IDLE or DISPLAY_BLANK options.

So the solution for your board is to forcibly avoid the local APIC.
A DMI blacklist entry would do that, as would configuring the
kernel without local APIC support (!SMP && !UP_APIC).

Kernel 2.6.0-test4 supports "nolapic", so that's an option too.
I'll send that patch to Marcelo for 2.4.23-pre so it should be
in 2.4 eventually.

As for getting the DMI blacklist rule in, you or someone else
with that board has to run dmidecode and prepare & test a patch.

/Mikael
