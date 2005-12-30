Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVL3QhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVL3QhU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 11:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVL3QhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 11:37:20 -0500
Received: from [202.67.154.148] ([202.67.154.148]:49284 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S932217AbVL3QhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 11:37:19 -0500
Message-ID: <43B5623D.7080402@ns666.com>
Date: Fri, 30 Dec 2005 17:37:17 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark v Wolher <trilight@ns666.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <43B53EAB.3070800@ns666.com> <9a8748490512300627w26569c06ndd4af05a8d6d73b6@mail.gmail.com> <43B557D7.6090005@ns666.com>
In-Reply-To: <43B557D7.6090005@ns666.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark v Wolher wrote:
> 
> Jesper Juhl wrote:
> 
>>On 12/30/05, Trilight <trilight@ns666.com> wrote:
>>
>>
>>>Hiya,
>>>
>>>I'm using the 2.6.14.5 kernel and i notice that the system freezes
>>>sometimes, within 24 hours usually, a total freeze, no mouse/keyb
>>>reaction. Also i notice that apps crash randomly sometimes.
>>>
>>
>>When did this start to happen? Was it OK with a previous kernel
>>version? if it was ok with a previous version, then what was that
>>version?
>>Was it OK before you added a particular piece of hardware? If so, what
>>hardware? Have you tried removing that hardware to see if the problem
>>goes away?
>>
>>
>>
>>>What can i do to investigate this ?
>>>
>>
>>A few things you can try :
>>
>>1) Start by providing some more info. Some details on your
>>hardware/software. Something like the following + whatever else you
>>consider relevant :
>> - name and version of your Linux distribution
>> - output of the  scripts/ver_linux  script found in the kernel source
>> - your kernels .config file
>> - full  dmesg  output after boot
>> - Motherboard name/model
>> - output of  cat /proc/cpuinfo
>> - output of  cat /proc/meminfo
>> - output of  lspci -vv
>> - output of  lsusb
>>
>>2) Tell us what you have already tried in order to try and resolve the
>>problem, including your results with the various things you've tried.
>>
>>3) Try building/running a kernel with the various debug options found
>>in the kernel hacking section turned on and see if that results in
>>more details in dmesg/logs etc and provide the extra info if any.
>>
>>4) Try building a 2.6.15-rc7-git4 kernel with the same config and see
>>if that one also has problems.
>>
>>Make sure your hardware is OK, CPU not overheating, RAM is OK (run
>>memtest86 with all tests enabled overnight) etc.
>>
>>Try removing all extra hardware components in your system you don't
>>need for the system to boot and see if the problem then goes away. If
>>it does, try adding back hardware one piece at a time and re-test,
>>find out if it's related to a certain piece of hardware or a specific
>>driver.
> 
> 
> <..>
> 
> Thanks for the advise !
> 
> About the memory test, i did that, 7 full passes, no errors, it's 512mb
> ecc memory btw. I'm going to let it, when i go to sleep, run the whole
> night.
> 
> hardware:
> 
> System is a dell precision workstation 650, dual xeon 2.4ghz w/HT, intel
> E7505 motherboard.
> 
> distro: debian sarge
> kernel: vanilla 2.6.14.5
> 
> for the rest there is nothing special to see in dmesg output, lspci or
> with lsusb. cpuinfo shows everything what it should show.
> 
> Memoinfo:
> 
> MemTotal:       512528 kB
> MemFree:          8760 kB
> Buffers:          2656 kB
> Cached:         236216 kB
> SwapCached:       2052 kB
> Active:         390480 kB
> Inactive:        54756 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       512528 kB
> LowFree:          8760 kB
> SwapTotal:     4883680 kB
> SwapFree:      4864064 kB
> Dirty:             112 kB
> Writeback:           0 kB
> Mapped:         388988 kB
> Slab:            23320 kB
> CommitLimit:   5139944 kB
> Committed_AS:   518952 kB
> PageTables:       1912 kB
> VmallocTotal:   515796 kB
> VmallocUsed:     25496 kB
> VmallocChunk:   487120 kB
> 
> 
> Other findings;
> 
> - all kernels had the same issue, except (not 100 % sure) 2.4.2X kernels
> - tried acpi=noirq without success and many many other acpi options &
> combo's
> - nvidia binary driver replaced by kernel nv driver but without success
> 
> I have no reason to suspect the tvcard which is a terratec value with a
> bt878 chip, support in the kernel. But on the other hand it could be the
> tvcard, but i see no relation to anything with it. I tried also using
> DAC snoop in the bios but no good.
> 
> None of the issue's occur when using windows xp pro/rhel enterprise 4
> 
> I'm going to let the memory test on for the whole night, i'll also
> compile the kernel with debugging options on. But i don't think the
> debugging options will matter since nothing is logged when the freeze
> occurs.
> 


I'm not sure what to make of this, but it looks like only 1 cpu is kept
busy with interrupts:


           CPU0       CPU1       CPU2       CPU3
  0:    1033372          0          0          0    IO-APIC-edge  timer
  1:      10346          0          0          0    IO-APIC-edge  i8042
  7:          0          0          0          0    IO-APIC-edge  parport0
  8:    4795679          0          0          0    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
 14:         29          0          0          0    IO-APIC-edge  ide0
 15:         21          0          0          0    IO-APIC-edge  ide1
169:      12646          0          0          0   IO-APIC-level  eth0
177:     166090          0          0          0   IO-APIC-level  bttv0
185:         59          0          0          0   IO-APIC-level
uhci_hcd:usb4
193:      76030          0          0          0   IO-APIC-level  ide2, ide3
201:          5          0          0          0   IO-APIC-level
ehci_hcd:usb1
209:     681735          0          0          0   IO-APIC-level
uhci_hcd:usb2, nvidia
217:     465677          0          0          0   IO-APIC-level
uhci_hcd:usb3
225:          0          0          0          0   IO-APIC-level  Intel
82801DB-ICH4
233:      33792          0          0          0   IO-APIC-level  EMU10K1
NMI:          0          0          0          0
LOC:    1033319    1033572    1033571    1033570
ERR:          0
MIS:          0

