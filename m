Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbTGVIUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 04:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbTGVIUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 04:20:51 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:9179 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S267378AbTGVIUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 04:20:50 -0400
Date: Tue, 22 Jul 2003 10:35:36 +0200 (MEST)
Message-Id: <200307220835.h6M8Zaqd024427@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: rl@hellgate.ch
Subject: Re: APIC support prevents power off
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003 11:54:14 +0200, Roger Luethi wrote:
>On Mon, 21 Jul 2003 03:13:52 +0200, Mikael Pettersson wrote:
>> On Sun, 20 Jul 2003 16:36:13 +0200, Roger Luethi wrote:
>> >On some UP boards (e.g. ASUS A7A266) enabling support for local APICs keeps
>> >the machine from powering off on shutdown. It will just hang instead.
>> >
>> >This has been observed by others before [1]. A warning in the respective
>> >configuration note seems in order (or a proper fix if anybody has one).
>> 
>> Insufficient data to draw anti-local-APIC conclusions.
>> - ensure you have the latest BIOS
>
>I tend not to touch the BIOS unless I have reason to believe an update will
>fix an actual problem.

Powering off invokes the BIOS. BIOSen are known to have bugs.
You really should check if a BIOS update is available.

>> - if you're using APM, ensure that CPU_IDLE and DISPLAY_BLANK are
>>   disabled, and that APM isn't built as a module
>>   (these things are known to cause APM hangs in UP APIC systems)
>> - if you're using ACPI, try without ACPI, or at least with ACPI not
>>   doing any power management
>
>Your suggestions match my current configuration:

Your APM/ACPI config seems Ok, but what does CONFIG_SMP look like?
Enabling SMP disables APM's power off code, unless one boots with
apm=power-off.

Did your kernel have to actually enable the local APIC, or did
the BIOS boot us with it already enabled? Please send me a dmesg
from a boot with local APIC support enabled.

I can't seem to find any place where we disable the local APIC
on shutdown; reboot seems Ok but not poweroff (as far as I can see).
I think this might explain why some BIOSen hang at poweroff.

/Mikael
