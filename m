Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266350AbUFZSHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266350AbUFZSHY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 14:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUFZSHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 14:07:24 -0400
Received: from web13911.mail.yahoo.com ([216.136.174.59]:38828 "HELO
	web13911.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266350AbUFZSGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 14:06:54 -0400
Message-ID: <20040626180653.6009.qmail@web13911.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Sat, 26 Jun 2004 11:06:53 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: 2.6.7-mm2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[accidentially posted on linux-net :-(]

>> ...
>> bk-acpi.patch
>
>OK, ACPI seems to have progressed in a non-forward direction here.
>
>If anyone has weird problems, please do a `patch -p1 -R' of
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm2/broken-out/bk-acpi.patch
>
>USB doesn't come up:
Hi,

-mm2 has definitely introduced some weird behaviour related to ACPI
and Local-APIC. I reported similar probs already for -mm1. I now did
some more experiments.

Problem is that my HP/Omnibook-6100 hangs during boot when the kernel
config has local APIC enabled. Before 2.6.7-mm specifying "nolapic" on
the boot command would solve the problem. It still does for 2.6.7 and
2.6.7-bk6.

With 2.6.7-mm1/mm2 specifying "nolapic" no longer helps. The system
hangs at boot - just at a different spot than without "nolapic".

Without nolapic:

>>>
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI-0179: *** Warning: The ACPI AML in your computer contains
errors, please nag the manufacturer to correct it.
ACPI-0182: *** Warning: Allowing relaxed access to fields; turn on
CONFIG_ACPI_DEBUG for details.
<<<

With "nolapic":

>>>
Checking if this processor honours the WP bit even in supervisor
mode... Ok.
Calibrating delay loop...
<<<

The only way to make the system boot again (except not enabling local
APIC in the kernel config :-) is to specify "acpi=off". Also, Len Brown
has a patch floating around that forces disabling of local APIC if it
was disabled initially by the BIOS (sometimes BIOS seems to know better
...). This patch still works. Apparently is does something different
than "nolapic".

So, I reverted th mm2 acpi-patch, but that seems not to be the
culprit.

Here is a collection of boot options that do not work:

-none-
nolapic
noapic
nolapic noapic
nolapic acpi=off
noapic nolapic acpi=off

Specifiying "acpi=off" works. Hope this gives some idea to someone.
".config" is included.

I do not care personally to much about local APIC on my notebook.
Still it would be fine if one could have it enabled in the config file.
Makes things a bit easier.

Cheers
Martin


=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
