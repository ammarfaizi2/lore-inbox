Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVD1SgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVD1SgF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVD1SgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:36:05 -0400
Received: from mail.tyan.com ([66.122.195.4]:28429 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262222AbVD1SfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:35:17 -0400
Message-ID: <3174569B9743D511922F00A0C943142309B079E4@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: x86-64 dual core mapping
Date: Thu, 28 Apr 2005 11:55:02 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Andi,

accoring to the code in arch/x86_64/setup.c

        /* When an ACPI SRAT table is available use the mappings from SRAT
           instead. */
        if (acpi_numa <= 0) {
                node = cpu_core_id[cpu];
                if (!node_online(node))
                        node = first_node(node_online_map);
                cpu_to_node[cpu] = node;
        } else {
                node = cpu_to_node[cpu];
        }


cpu_to_node[cpu] == cpu_core_id[cpu]

So you mean core id is node id?

YH

> -----Original Message-----
> From: YhLu 
> Sent: Thursday, April 21, 2005 7:19 PM
> To: 'Andi Kleen'
> Cc: linux-kernel@vger.kernel.org
> Subject: x86-64 dual core mapping
> 
> Andi,
> 
> I tried 2.6.12-rc3 with dual way dual cpus.
> 
> It seems right mapping should be
> CPU 0(2) -> Node 0 -> Core 0
> CPU 1(2) -> Node 0 -> Core 1
> CPU 2(2) -> Node 1 -> Core 0
> CPU 3(2) -> Node 1 -> Core 1
> 
> instead of
> 
> CPU 0(2) -> Node 0 -> Core 0
> CPU 1(2) -> Node 0 -> Core 0
> CPU 2(2) -> Node 1 -> Core 1
> CPU 3(2) -> Node 1 -> Core 1
> 
> YH
> 
> 
> 
> 
> CPU 0(2) -> Node 0 -> Core 0
> Using local APIC NMI watchdog using perfctr0 enabled ExtINT 
> on CPU#0 ENABLING IO-APIC IRQs Using IO-APIC 4 ...changing 
> IO-APIC physical APIC ID to 4 ... ok.
> Using IO-APIC 5
> ...changing IO-APIC physical APIC ID to 5 ... ok.
> Using IO-APIC 6
> ...changing IO-APIC physical APIC ID to 6 ... ok.
> Using IO-APIC 7
> ...changing IO-APIC physical APIC ID to 7 ... ok.
> Synchronizing Arb IDs.
> ..TIMER: vector=0x31 pin1=0 pin2=2
> testing the IO APIC.......................
> 
> 
> 
> 
> .................................... done.
> Using local APIC timer interrupts.
> Detected 12.564 MHz APIC timer.
> Booting processor 1/1 rip 6000 rsp ffff81007ff99f58 
> Initializing CPU#1 masked ExtINT on CPU#1
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 1(2) -> Node 0 -> Core 0
>  stepping 00
> Synced TSC of CPU 1 difference 30064769976 Booting processor 
> 2/2 rip 6000 rsp ffff81013ffa3f58 Initializing CPU#2 masked 
> ExtINT on CPU#2
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 2(2) -> Node 1 -> Core 1
>  stepping 00
> Synced TSC of CPU 2 difference 30064770021 Booting processor 
> 3/3 rip 6000 rsp ffff81007ff49f58 Initializing CPU#3 masked 
> ExtINT on CPU#3
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 3(2) -> Node 1 -> Core 1
>  stepping 00
> Synced TSC of CPU 3 difference 30064770021 Brought up 4 CPUs
