Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265067AbTIDOvS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbTIDOvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:51:18 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:7562 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265067AbTIDOvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:51:13 -0400
Date: Thu, 04 Sep 2003 07:48:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>, venkatesh.pallipadi@intel.com,
       Dave H <haveblue@us.ibm.com>
Subject: Re: [PATCH] linux-2.6.0-test4_cyclone-hpet-fix_A0
Message-ID: <27100000.1062686879@[10.10.2.4]>
In-Reply-To: <1062659651.2246.11.camel@laptop.cornchips.homelinux.net>
References: <1062649798.1312.1519.camel@cog.beaverton.ibm.com> <20030903225939.77630b19.akpm@osdl.org> <1062659651.2246.11.camel@laptop.cornchips.homelinux.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Also, while apparently unrelated, but touching code from the HPET patch,
>> > I'm seeing some form of memory corruption on the 16way x440 which is
>> > overwriting the wait_timer_tick pointer in apic.c I added some
>> > initialized corruption pad variables around the pointer and they're
>> > definitely being trampled. I'll have to look into it further tomorrow.
>> 
>> Hum.  Please do this:
>> 
>> mnm:/usr/src/25> nm -n vmlinux|grep -3 wait_timer_tick
>> c043b360 D using_apic_timer
>> c043b380 d lapic_sysclass
>> c043b3e0 d device_lapic
>> c043b41c D wait_timer_tick
>> c043b420 D nmi_watchdog
>> c043b424 d nmi_hz
>> c043b440 d nmi_sysclass
> 
> [jstultz@elm3a16 cyclone-hpet-fix]$ nm -n vmlinux | grep -6 wait_timer_tick
> c03977e0 D mp_bus_id_to_pci_bus
> c0397860 D boot_cpu_physical_apicid
> c0397864 D boot_cpu_logical_apicid
> c0397868 D bios_cpu_apicid
> c0397870 D using_apic_timer
> c0397874 D corruption_pad1
> c0397878 D wait_timer_tick
> c039787c D corruption_pad2
> c0397880 D nmi_watchdog
> c0397884 d nmi_hz
> c0397888 d nmi_print_lock
> c03978a0 d ioapic_lock
> c03978a4 D sis_apic_bug
> 
> I can send you the whole System.map if needed, but
> mp_bus_id_to_pci_bus[] looks suspicious to me. 

Well, that looks like a reasonable aspersion to cast. Stick  MAX_MP_BUSSES
to something silly like 4096, and see what happens. Is any of it > 32
not set to -1 anymore?

M.

