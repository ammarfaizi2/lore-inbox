Return-Path: <linux-kernel-owner+w=401wt.eu-S1752874AbWLQP6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbWLQP6x (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 10:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbWLQP6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 10:58:53 -0500
Received: from yumi.tdiedrich.de ([85.10.210.183]:3215 "EHLO yumi.tdiedrich.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873AbWLQP6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 10:58:52 -0500
Date: Sun, 17 Dec 2006 16:58:50 +0100
From: Tobias Diedrich <ranma@tdiedrich.de>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061217155850.GA2765@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma@tdiedrich.de>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	"Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <EB12A50964762B4D8111D55B764A8454E0DBDE@scsmsx413.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB12A50964762B4D8111D55B764A8454E0DBDE@scsmsx413.amr.corp.intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:

> There are two things that can be happening when OS does not see HPET in
> ACPI.
> - BIOS did enable HPET in chipset and did not communicate it to OS.
> - BIOS did nothing to enable HPET in chipset.
> 
> The quirk below tries to find the HPET base address in case 1. But in
> case 2 this will also fail as HPTC will be 0 below (Probably we can
> still assume default base address of 0xFED00000 and probe there. But I
> am still checking on that). I just added couple of chipset ids that I
> could test on...
> 
> On the systems that I tested, HPTC was zero (case 2 above) and patch
> below did not really help.
> 
> I am building on this patch to enable HPET in late init stage based on
> the the quirk information. Will be interesting to see what this patch
> says on other ICH based systems that don't have HPET info in ACPI.

In case anyone is interested, here is some information about the HPET on
nVidia MCP55:

With the recent update to BIOS Version 0609, ASUS has added HPET
Support and a Enable/Disable BIOS option for the M2N SLI Deluxe.

00:01.0 0601: 10de:0360 (rev a2)
00:01.0 ISA bridge: nVidia Corporation MCP55 LPC Bridge (rev a2)
00: de 10 60 03 0f 00 a0 00 a2 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 39 82
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 43 10 39 82 00 f0 ff fe fa 3e ff 00 fa 3e ff 00
                ^^^^^^^^^^^
                HPET base address
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfefff000

50: fa 3e ff 00 00 5a 62 02 00 00 00 01 00 00 ff ff
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 ff
70: 10 00 ff ff c5 80 00 00 00 00 44 19 40 06 00 03
                ^^
                c1 => HPET disabled
                c5 => HPET enabled
80: 09 10 00 00 82 0d 00 00 c0 00 00 01 f0 00 00 00
90: 80 08 00 00 00 00 00 00 21 47 95 86 ef cd ab 00
a0: 01 00 30 c0 00 00 00 00 00 00 00 00 00 00 00 00
b0: 90 02 ef 02 00 08 5f 08 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00

HTH,

-- 
Tobias						PGP: http://9ac7e0bc.uguu.de
