Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVACXff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVACXff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVACXdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:33:35 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:49805 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261949AbVACX3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:29:03 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-mm1 [failure on AMD64]
Date: Tue, 4 Jan 2005 00:29:15 +0100
User-Agent: KMail/1.7.1
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103100725.GA17856@infradead.org> <200501030919.20670.jbarnes@engr.sgi.com>
In-Reply-To: <200501030919.20670.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501040029.15623.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 3 of January 2005 18:19, Jesse Barnes wrote:
> On Monday, January 3, 2005 2:07 am, Christoph Hellwig wrote:
> > > add-page-becoming-writable-notification.patch
> > >   Add page becoming writable notification
> >
> > David, this still has the bogus address_space operation in addition to
> > the vm_operation.  page_mkwrite only fits into the vm_operations scheme,
> > so please remove the address_space op.  Also the code will be smaller
> > and faster witout that indirection..
> 
> And apparently it's broken on NUMA.  I couldn't find 
> generic_file_get/set_policy in my tree, which builds with CONFIG_NUMA 
> enabled.

On a dual-Opteron w/ NUMA I had to apply the Jesse's patch to compile the 
kernel, but it does not boot.  It only prints this to the serial console:

Bootdata ok (command line is root=/dev/sdb3 vga=792 earlyprintk=ttyS0,57600 
console=ttyS0,57600 console=tty0)
Linux version 2.6.10-mm1 (rafael@chimera) (gcc version 3.3.4 (pre 3.3.5 
20040809)) #1 SMP Mon Jan 3 23:09:30 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
kernel direct mapping tables upto ffff810100000000 @ 8000-c000
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 already present. Skipping
Node 1 already present. Skipping
No NUMA configuration found
Faking a node at 0000000000000000-000000003fff0000
Bootmem setup node 0 0000000000000000-000000003fff0000
No mptable found.
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfc9fe000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xfc9fe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfc9ff000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xfc9ff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
CPU 1: aperture @ f0000000 size 128 MB

and then it goes into an infinite loop that writes some garbage to the 
framebuffer (yellow lines on top of the screen).

On a UP AMD64 it boots, but then it does not work appropriately (eg. at KDE 
startup the box hangs for a while and I get the message like "The process for 
the file protocol has terminated unexpectedly" and desktop icons are not 
displayed, and I get a "cpu overload" message from arts etc.).

Please let me know if you need more information.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
