Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318435AbSIPBX7>; Sun, 15 Sep 2002 21:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318502AbSIPBX7>; Sun, 15 Sep 2002 21:23:59 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:41378 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S318435AbSIPBX6>;
	Sun, 15 Sep 2002 21:23:58 -0400
Date: Mon, 16 Sep 2002 03:28:53 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209160128.DAA04146@harpo.it.uu.se>
To: arysin@myrealbox.com, linux-kernel@vger.kernel.org
Subject: Re: turning off APIC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002 14:28:44 +0300, Andriy Rysin wrote:
>If APIC is compiled in the kernel (wich is the case with most 
>distributions) when I start kernel with "noapic" option, APIC is getting 
>enabled anyway and only later gets disabled. This causes problems on 
>some VAIO notebooks - it seems like BIOS gets confused if APIC was 
>turned on (particularly on my laptop when I try to reboot from Linux it 
>hangs saying that thera problems with keyboard). That would be much 
>better to have an option to turn it off in the boot options and not to 
>recompile the kernel. Could somebody comment this please?
>Please CC me on this email address.

Which APIC? local or I/O? Please be specific.
"noapic" does not and never has had anything to do with the
local APIC, only the I/O APIC. There is currently no kernel
option for preventing the local APIC from being enabled if
the kernel was built with local APIC support.

You have four options:
1. Recompile with CONFIG_SMP=n and CONFIG_X86_LOCAL_APIC=n.
2. Run dmidecode on your Vaio, dig out the identification strings,
   and add them to arch/i386/kernel/dmi_scan.c's local APIC
   blacklist.
3. Add a __setup in arch/i386/kernel/apic.c after the declaration
   for dont_enable_local_apic, which sets it to 1.
4. Tell Sony to fix the Vaio's BIOS.

/Mikael
