Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTLCXm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTLCXm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:42:57 -0500
Received: from stinkfoot.org ([65.75.25.34]:8832 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S262762AbTLCXmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:42:01 -0500
Message-ID: <3FCE74B0.9010506@stinkfoot.org>
Date: Wed, 03 Dec 2003 18:41:36 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: HT apparently not detected properly on 2.4.23
References: <3FCE2F8E.90104@stinkfoot.org> <20031203224023.GV8039@holomorphy.com>
In-Reply-To: <20031203224023.GV8039@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> On Wed, Dec 03, 2003 at 01:46:38PM -0500, Ethan Weinstein wrote:
> 
>>With 2.4.22, my Supermicro X5DPL-iGM-O (E7501 chipset) with 2 
>>xeons@2.4ghz and hypertherading enabled shows 4 cpu's in 
>>/proc/cpuinfo|proc/interrupts, with:
>>CONFIG_ACPI=y
>>CONFIG_ACPI_HT_ONLY=y
>>The same config with 2.4.23 only shows 2 cpus, even with:
>>CONFIG_NR_CPUS=4
>>Also, I believe this has been reported before, but the system only seems 
>>to interrupt on CPU0 with either kernel, unless I apply a patch I found 
>>here:
>>http://www.hardrock.org/kernel/2.4.22/irqbalance-2.4.22-MRC.patch
>>or run the `irqbalance' program.. which I don't care to do.  This 
>>problem _seems_ to be isolated to the Supermicro, as HT does seem 
>>properly detected on several other SMP systems I have at work (compaq 
>>ML370/ML380) with 2.4.23
> 
> You probably have sparse physical APIC ID's.
> 
Ok, setting CONFIG_NR_CPUS=8 does indeed solve the HT issue, looks like 
it was the numbering scheme:

Dec  3 18:32:28 spicymeatball kernel: CPU 0 (0x0000) enabled
Dec  3 18:32:28 spicymeatball kernel: Processor #0 Pentium 4(tm) 
XEON(tm) APIC version 16
Dec  3 18:32:28 spicymeatball kernel: LAPIC (acpi_id[0x0001] id[0x6] 
enabled[1])
Dec  3 18:32:28 spicymeatball kernel: CPU 1 (0x0600) enabled
Dec  3 18:32:28 spicymeatball kernel: Processor #6 Pentium 4(tm) 
XEON(tm) APIC version 16
Dec  3 18:32:28 spicymeatball kernel: LAPIC (acpi_id[0x0002] id[0x1] 
enabled[1])
Dec  3 18:32:28 spicymeatball kernel: CPU 2 (0x0100) enabled
Dec  3 18:32:28 spicymeatball kernel: Processor #1 Pentium 4(tm) 
XEON(tm) APIC version 16
Dec  3 18:32:28 spicymeatball kernel: LAPIC (acpi_id[0x0003] id[0x7] 
enabled[1])
Dec  3 18:32:28 spicymeatball kernel: CPU 3 (0x0700) enabled
Dec  3 18:32:28 spicymeatball kernel: Processor #7 Pentium 4(tm) 
XEON(tm) APIC version 16

But we're still only interrupting on CPU0 with this kernel.


-Ethan


