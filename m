Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264613AbRFPLjF>; Sat, 16 Jun 2001 07:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbRFPLiz>; Sat, 16 Jun 2001 07:38:55 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:9465 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264613AbRFPLip>;
	Sat, 16 Jun 2001 07:38:45 -0400
Date: Sat, 16 Jun 2001 13:38:15 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200106161138.NAA23923@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, root@norma.kjist.ac.kr
Subject: Re: 2.4.5-ac6 and 2.4.4-ac11 boot fails with APIC timer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jun 2001 11:27:53 +0900, <root@norma.kjist.ac.kr> wrote:

>> The message on the screen 
>>
>> calibrating APIC timer ..... 
>> .... CPU clock speed is 1395.7390MHz 
>> ... host bus clock speed is 0.0000 MHz 
>> cpu: 0, clocks: 0, slic: 0 
>>
>> Then nothing. I had to push the reset button at this point. 
>> ACPI and APM were disabled from the kernel config. 
>>
>> This boot failure messages was obtained from 
>> Pentium4 board GB-450(?) from Intel, NVIDIA M64 video. 
>> Sound Blaster 128 PCI. Netgear PNIC fast ethernet.... 
>>   
>> The same kernel was able to boot up the other Pentium 4 board from 
>> Gigabyte flawlessly. So, it depends on the motherboard manufacturers. 
>>
>> Regards to all. 
>>
>> G. Hugh Song 
>
>Replying to my own message:
>
>When I chose "No" to "APIC support on uniprocessors", the above error
>message disappeared and the machine booted up OK with 2.4.5-ac13.
>...
>I think that APIC thing was defined by Intel themselves.
>They should have implemented it the best.  How much penalty do I pay 
>by not choosing "yes" to "APIC support on uniprocessors"?

>From the part of the dmesg log you quoted I conclude that
(a) the NMI watchdog didn't kill you (good), but
(b) the calibration loop detects a 0MHz bus speed and then fails
    to produce the "CPU0:<T0: ...>" line, which means it hangs in
    arch/i386/kernel/apic.c:setup_APIC_timer(), probably because
    apic_read(APIC_TMCCT) always returns zero.

Anyway, you should disable CONFIG_X86_UP_APIC on your P4 for now.
You won't lose any performance due to this, only the possibility to
use the NMI watchdog.

/Mikael
