Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTKEXYm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 18:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTKEXYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 18:24:42 -0500
Received: from zok.SGI.COM ([204.94.215.101]:39057 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263290AbTKEXYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 18:24:41 -0500
Date: Wed, 5 Nov 2003 15:24:38 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [DMESG] cpumask_t in action
Message-ID: <20031105232438.GA24817@sgi.com>
Mail-Followup-To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org
References: <B05667366EE6204181EABE9C1B1C0EB58023A6@scsmsx401.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB58023A6@scsmsx401.sc.intel.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 03:18:29PM -0800, Chen, Kenneth W wrote:
> > Dentry cache hash table entries: 33554432 (order: 14, 268435456 bytes)
> > Inode-cache hash table entries: 33554432 (order: 14, 268435456 bytes)
> > IP: routing cache hash table of 8388608 buckets, 131072Kbytes
> > TCP: Hash tables configured (established 67108864 bind 65536)
> > swapper: page allocation failure. order:17, mode:0x20
> 
> Does these hash tables really need to that big? 33 million dentry and
> inode entry? Same thing with network, unless the machine is loaded
> with several gigabit cards, these hash table seems to be exceedingly
> large.

This one only has two gige cards:

tg3.c:v2.2 (August 24, 2003)
PCI: Found IRQ 54 for device 0000:01:04.0
ACPI: No IRQ known for interrupt pin A of device 0000:01:04.0 - using IRQ 54
eth0: Tigon3 [partno(030-1771-000) rev 0105 PHY(5701)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 08:00:69:13:e6:a7
PCI: Found IRQ 66 for device 0000:11:04.0
ACPI: No IRQ known for interrupt pin A of device 0000:11:04.0 - using IRQ 66
eth1: Tigon3 [partno(030-1771-000) rev 0105 PHY(5701)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 08:00:69:13:e4:a4
PCI: Found IRQ 53 for device 0000:01:03.0
ACPI: No IRQ known for interrupt pin A of device 0000:01:03.0 - using IRQ 53

As for the dentry and inode-cache tables, yes they're probably too big,
and they're also allocated on node 0 rather than being spread out.

Jesse
