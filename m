Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269934AbUJNApa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269934AbUJNApa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 20:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269938AbUJNApa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 20:45:30 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:18669 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S269934AbUJNAp0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 20:45:26 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Clock inaccuracy seen on NVIDIA nForce2 systems
Date: Wed, 13 Oct 2004 20:45:22 -0400
User-Agent: KMail/1.7
Cc: Jesse Stockall <stockall@magma.ca>, Andy Currid <ACurrid@nvidia.com>
References: <8E5ACAE05E6B9E44A2903C693A5D4E8A01C45AC2@hqemmail02.nvidia.com> <1097701839.5500.111.camel@homer.blizzard.org>
In-Reply-To: <1097701839.5500.111.camel@homer.blizzard.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410132045.23042.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.58.180] at Wed, 13 Oct 2004 19:45:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 October 2004 17:10, Jesse Stockall wrote:
>On Wed, 2004-10-13 at 16:30, Andy Currid wrote:
>> A possible cause of this behavior is a clock synchronization issue
>> that can arise on some nForce2 systems when interrupts are routed
>> through the IOAPIC, and Spread Spectrum (SS) clocking is enabled.
>> Under certain conditions, this can cause the IOAPIC to issue
>> multiple interrupts to the CPU when it should have issued only
>> one.
>>
>> If you are experiencing clock inaccuracy on nForce2 hardware, take
>> the following steps to determine if this issue may be the cause:
>>
>> 1. Determine if the hardware you are using may be affected by this
>>    problem. The problem is limited to MCP2 and MCP2-T hardware; it
>> does not affect MCP2-S or any nForce3 hardware. MCP2 and MCP2-T
>> hardware may be identified by the PCI device ID of the ISA bridge,
>> which is 0x0060 for these devices.
>>
>>    To read the bridge device ID, use 'lspci -n -s 0:1.0' . The
>> output should be of the form '0000:00:01.0 Class 0601: 10de:0060
>> (rev a3)'. The device ID of the bridge in this example is "0060"
>> following the NVIDIA PCI vendor ID "10de".
>>
>>    If your ISA bridge device ID is not 0x0060, then this issue is
>> not the cause of any clock inaccuracy you are experiencing.
>
>lspci -n -s 0:1.0
>
>output:  0000:00:01.0 Class 0601: 10de:0060 (rev a3)
>
>> 2. Otherwise, examine the output from 'cat /proc/interrupts'. If
>> IRQ0 (the timer) is shown to be in PIC mode rather than IOAPIC
>> mode, then this issue is not the cause of any clock inaccuracy you
>> are experiencing.
>
>cat /proc/interrupts
>
>output: 0:  179117760    IO-APIC-edge  timer
>
>> 3. Otherwise, reboot your system and enter BIOS SETUP. Check if
>> your BIOS has a Front Side Bus (FSB) Spread Spectrum (SS) clocking
>> option. On many systems, this option is located in the "Advanced
>> Chipset Features" menu. If the option is present and enabled,
>> disable it. Boot Linux and observe the system clock over several
>> hours to verify if this has improved its accuracy.
>
>Both Front Side Bus and AGP spread spectrum are disabled.
>
>The system is running 2.6.9-rc4 and has been up for 2 days. I'm
> showing an offset of -32 seconds and growing.
>
>Jesse

This, given the accuracy of the clock crystals used in todays 
motherboard is not surprising.  For that reason I run ntpdate 4x a 
day, which keeps me within a second *most* of the time.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
