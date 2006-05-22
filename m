Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWEVMbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWEVMbK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 08:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWEVMbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 08:31:10 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:61131 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750791AbWEVMbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 08:31:09 -0400
Date: Mon, 22 May 2006 14:31:05 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Vladimir Dvorak <dvorakv@vdsoft.org>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPUx
In-Reply-To: <4471AC63.8060406@vdsoft.org>
Message-ID: <Pine.LNX.4.61.0605221427160.11108@yvahk01.tjqt.qr>
References: <44716A5F.3070208@vdsoft.org> <p73k68e71kd.fsf@verdi.suse.de>
 <4471A777.2020404@vdsoft.org> <200605221403.16464.ak@suse.de>
 <4471AC63.8060406@vdsoft.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I also have this [a similar] message; it is produced repeatedly between 2.5 
and 5 seconds whenever the ISDN card is dialled in:
May 22 14:28:18 shanghai kernel: APIC error on CPU0: 02(02)

Linux shanghai 2.6.17-rc4 #1 Sat May 20 00:06:16 CEST 2006 i686 athlon 
i386 GNU/Linux



>>>>>Debian 3.1
>>>>>Linux mailserver 2.6.8-3-686-smp #1 SMP Thu Feb 9 07:05:39 UTC 2006 i686
>>>>That's an ancient kernel.
>>>Yes, I agree.
>>> ... but the latest in Debian/Sarge. :-)
>>>Do you, Andi,  thing that upgrade to latest vanilla one ( from
>>>kernel.org ) should solve this problem ?
>>Probably not.
>>>>
>>>>>GNU/Linux
>>>>>Hardware:
>>>>>Intel SR1200
>>>>>
>>>>If it's an <=P3 class machine: most likely you have noise on the APIC bus.
>>>>
>>>Yes, you are right :
>>>cat /proc/cpuinfo
>>>...
>>>model name      : Intel(R) Pentium(R) III CPU family      1133MHz
>>>...
>>>
>>>"Noise on APIC bus" means - " a lot of interrupts from devices" ?

Yep.

14:29 shanghai:~ > (while :; do cat /proc/interrupts |grep -i hisax; sleep 
1; done)
193:    1111340   IO-APIC-level  SiS SI7012, HiSax
193:    1113106   IO-APIC-level  SiS SI7012, HiSax
193:    1114857   IO-APIC-level  SiS SI7012, HiSax
193:    1116599   IO-APIC-level  SiS SI7012, HiSax
193:    1118328   IO-APIC-level  SiS SI7012, HiSax
193:    1120093   IO-APIC-level  SiS SI7012, HiSax
193:    1121858   IO-APIC-level  SiS SI7012, HiSax
193:    1123608   IO-APIC-level  SiS SI7012, HiSax
(Hisax: CONFIG_HISAX_NETJET=y)

The problem goes away with noapic or acpi=off, but of course that also 
means you don't have IRQs > 15.

>>Usually a crappy/broken/misdesigned motherboard.

Elitegroup L7S7A2 here.

>And, probably, the latest question related to this topic:
>
>Can "noapic" or "nolapic" solve this ? Does it mean ( with these
>parameters ) that devices will start to use 8259 interrupt controller
>instead APIC ?
>
>Is harmfull put "noapic" on "nolapic" to cmdline ?


Jan Engelhardt
-- 
