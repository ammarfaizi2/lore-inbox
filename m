Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161108AbVKDCuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbVKDCuN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 21:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbVKDCuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 21:50:13 -0500
Received: from www.eclis.ch ([144.85.15.72]:28361 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1161108AbVKDCuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 21:50:11 -0500
Message-ID: <436ACC89.2050900@eclis.ch>
Date: Fri, 04 Nov 2005 03:50:49 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: Len Brown <len.brown@intel.com>, macro@linux-mips.org,
       linux-kernel@vger.kernel.org, dean@arctic.org, zippel@linux-m68k.org
Subject: Re: NTP broken with 2.6.14
References: <4369464B.6040707@eclis.ch>	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>	 <43694DD1.3020908@eclis.ch>	 <1130976935.27168.512.camel@cog.beaverton.ibm.com>	 <43695D94.10901@eclis.ch>	 <1130980031.27168.527.camel@cog.beaverton.ibm.com>	 <43697550.7030400@eclis.ch>	 <1131046348.27168.537.camel@cog.beaverton.ibm.com>	 <436A7D4B.8080109@eclis.ch>	 <1131054087.27168.595.camel@cog.beaverton.ibm.com>	 <436A8ADB.2090307@eclis.ch>	 <1131058482.27168.612.camel@cog.beaverton.ibm.com>	 <436AA822.9060403@eclis.ch> <1131064846.27168.619.camel@cog.beaverton.ibm.com>
In-Reply-To: <1131064846.27168.619.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tested the 2.6.10-rc* kernels too. Here is the full list:

2.6.8      : ntpd working : low drift
2.6.9      : ntpd working : low drift
2.6.10-rc1 : ntpd working : low drift
2.6.10-rc2 : ntpd working : low drift
2.6.10-rc3 : ntpd failed  : high drift
2.6.10     : ntpd failed  : high drift
2.6.12     : ntpd failed  : high drift
2.6.14     : ntpd failed  : high drift

The picture is very clear: the problem start from the 2.6.10-rc3 kernel. 
All the kernel that make ntpd failed can be fixed by the "noapic" option 
to make ntpd working.

Log of kernels 2.6.8 to 2.6.10-rc2 say this:

kernel: ENABLING IO-APIC IRQs
kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
kernel: ..MP-BIOS bug: 8254 timer not connected to IO-APIC
kernel: ...trying to set up timer (IRQ0) through the 8259A ...  failed.
kernel: ...trying to set up timer as Virtual Wire IRQ... failed.
kernel: ...trying to set up timer as ExtINT IRQ... works.

Log of kernel 2.6.10-rc3 to 2.6.14 say this:

kernel: ENABLING IO-APIC IRQs
kernel: ..TIMER: vector=0x31 pin1=0 pin2=-1

I don't understand if the problem is the pin1 that change from 2 to 0 or 
if this is because the code to solve the "MP-BIOS bug" is not executed 
(maybe because it is not in the kernel anymore, I have not verified).

>>More fun now: it look like the BIOS actually used on this mainboard is 
>>not designed for it, but for an other board!!!
>>
>>The board is exactly this one "K7N2 Delta-L":
>>http://www.msi.com.tw/program/support/download/dld/spt_dld_detail.php?UID=436&kind=1
>>And according to MSI it must use a BIOS version 5.9. But when I enter 
>>into the BIOS setup the version info say "W6570MS V7.4 081203".
>>
>>Here is the BIOS version history: 
>>http://www.msi.com.tw/program/support/bios/bos/spt_bos_detail.php?UID=436&kind=1
>>The version 7.4 dated 2003-8-12 has a special note:
>>
>>1. Only for K7N2 Delta-ILSR
>>2. This BIOS cannot be used on K7N2 Delta-L
>>
>>Crasy. I use this board without any issue since around two years and 
>>only found the first problem when upgrading to the kernel 2.6.14!
> 
> 
> Heh. Yea, I'm amazed you were able to flash it and still have the system
> boot. I'd suggest making sure you have the proper and current BIOS, as
> its *very* difficult for folks to help debug problems on unofficial or
> unsupported hardware/firmware configs.
> 
> I believe ioapic support should function correctly regardless (or be
> blacklisted and with others reporting problems, its might not be just
> this BIOS issue), so after you get your BIOS sorted out, please let me
> know if the problem still persists.

After trying several time, I am unable to upgrade the BIOS of this 
machine. The flash utility hang all the system at the very beginning of 
the real access to programm the flash! This is maybe because I use a 
freedos image over pxelinux. I will try with a floppy and a MSDOS if I 
found such olds stuffs somehere.

Thanks a lot for the support,
-- 
Jean-Christian de Rivaz
