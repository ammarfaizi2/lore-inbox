Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267760AbTATCNF>; Sun, 19 Jan 2003 21:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267761AbTATCNF>; Sun, 19 Jan 2003 21:13:05 -0500
Received: from holomorphy.com ([66.224.33.161]:48264 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267760AbTATCNE>;
	Sun, 19 Jan 2003 21:13:04 -0500
Date: Sun, 19 Jan 2003 18:21:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: setup_ioapic_ids_from_mpc()
Message-ID: <20030120022159.GK780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, akpm@zip.com.au
References: <20030119130118.GC770@holomorphy.com> <20030120011906.GJ780@holomorphy.com> <94060000.1043029068@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94060000.1043029068@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Use NUMA-Q specific MP OEM tables to program the physical APIC ID's of
>> the IO-APIC's. This fixes boot-time panic()'s on NUMA-Q's in the stock
>> version of setup_ioapic_ids_from_mpc().

On Sun, Jan 19, 2003 at 06:17:48PM -0800, Martin J. Bligh wrote:
> I think you can just skip this whole routine altogether on NUMA-Q,
> it's all pre-programmed for us by firmware. Much smaller patch ;-)


Don't touch IO-APIC physid's on NUMA-Q. The BIOS pre-programs them.

 io_apic.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)


--- mm1-2.5.59/arch/i386/kernel/io_apic.c	2003-01-17 01:04:43.000000000 -0800
+++ mpc-2.5.59-1/arch/i386/kernel/io_apic.c	2003-01-19 18:19:13.000000000 -0800
@@ -1438,7 +1438,8 @@ void disable_IO_APIC(void)
  * by Matt Domsch <Matt_Domsch@dell.com>  Tue Dec 21 12:25:05 CST 1999
  */
 
-static void __init setup_ioapic_ids_from_mpc (void)
+#ifndef CONFIG_X86_NUMAQ
+static void __init setup_ioapic_ids_from_mpc(void)
 {
 	struct IO_APIC_reg_00 reg_00;
 	unsigned long phys_id_present_map;
@@ -1531,6 +1532,9 @@ static void __init setup_ioapic_ids_from
 			printk(" ok.\n");
 	}
 }
+#else
+static void __init setup_ioapic_ids_from_mpc(void) { }
+#endif
 
 /*
  * There is a nasty bug in some older SMP boards, their mptable lies
