Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTKRQLh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 11:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTKRQLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 11:11:37 -0500
Received: from pop.gmx.de ([213.165.64.20]:62917 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263697AbTKRQLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 11:11:33 -0500
X-Authenticated: #4512188
Message-ID: <3FBA458D.2010803@gmx.de>
Date: Tue, 18 Nov 2003 17:15:09 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
CC: john stultz <johnstul@us.ibm.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, cat@zip.com.au,
       gawain@freda.homelinux.org, gene.heskett@verizon.net,
       papadako@csd.uoc.gr
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
References: <1069071092.3238.5.camel@localhost.localdomain>	 <3FB8C92E.7030201@gmx.de>  <200311172046.17736.schlicht@uni-mannheim.de>	 <1069104441.11424.1979.camel@cog.beaverton.ibm.com> <3FB950EE.10806@gmx.de>	 <1069109719.11424.1994.camel@cog.beaverton.ibm.com> <1069110272.11438.2000.camel@cog.beaverton.ibm.com> <3FBA1D78.8060502@gmx.de>
In-Reply-To: <3FBA1D78.8060502@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:

 >>
 >> After sending out multiple patches I should have been more clear. Just
 >> to avoid confusion:
 >>
 >> * the init_cpu_khz patch goes along side Thomas' patch.
 >> * the more experimental sched_clock() -> monotonic_clock() patch I just
 >> sent out for testing replaces Thomas' patch.
 >
 >
 >
 >
 > I now tried the second one and it seems to work, tough I am not sure 
whether the performance is as good as APCI timer deavt. It seems that 
now CPU Hz is not shown anymore. Have a look at my dmesg:
 >
 >
 > Linux version 2.6.0-test9-love3 (root@tachyon) (gcc-Version 3.3.2 
20031022 (Gentoo Linux 3.3.2-r2, propolice)) #16 Tue Nov 18 13:54:04 CET 
2003
 > BIOS-provided physical RAM map:
 >  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 >  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 >  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 >  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 >  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 >  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 >  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 >  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 >  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
 > 127MB HIGHMEM available.
 > 896MB LOWMEM available.
 > On node 0 totalpages: 262128
 >   DMA zone: 4096 pages, LIFO batch:1
 >   Normal zone: 225280 pages, LIFO batch:16
 >   HighMem zone: 32752 pages, LIFO batch:7
 > DMI 2.2 present.
 > ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6b60
 > ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
 > ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
 > ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff79c0
 > ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
 > ACPI: PM-Timer IO Port: 0x4008
 > Building zonelist for node : 0
 > Kernel command line: root=/dev/hde6 hdg=none vga=0x51A 
video=vesa:mtrr,ywrap elevator=cfq
 > ide_setup: hdg=none
 > current: c0499a60
 > current->thread_info: c0528000
 > Initializing CPU#0
 > PID hash table entries: 4096 (order 12: 32768 bytes)
 > Using <NULL> for high-res timesource


[snip]

So I deactivated the PM timer again and my computer is much faster 
again. Haven prime in the background taking 100% doesn't noticeable 
affect deskop performance. But I think I know where the problem lies:

current: c0499a60
current->thread_info: c0528000
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2004.698 MHz processor.
Using tsc for high-res timesource


In above dmesg you can see that nothing was used as timesource, but here 
in current dmesg tsc is used. Is this normal or a bug? Need I pass a 
kernel paramtere when pm timer is enbaled?

bye

Prakash


