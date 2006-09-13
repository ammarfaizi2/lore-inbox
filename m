Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbWIMAsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbWIMAsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 20:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbWIMAsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 20:48:43 -0400
Received: from xenotime.net ([66.160.160.81]:37266 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030442AbWIMAsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:48:42 -0400
Date: Tue, 12 Sep 2006 17:49:34 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Nico Schottelius <nico-kernel20060910@schottelius.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17.13 Uninitialized variable / printf timing
Message-Id: <20060912174934.acb55c70.rdunlap@xenotime.net>
In-Reply-To: <20060910170837.GA18697@schottelius.org>
References: <20060910170837.GA18697@schottelius.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Sep 2006 19:08:37 +0200 Nico Schottelius wrote:

> Hello!
> 
> When booting 2.6.17.13 on my Geode, kprintf enabled with timing output,
> it looks a bit strange (the first 24 lines):
> 
> --------------------------------------------------------------------------------
> 
>   Booting 'Zwerg - 2.6.17.13'
>                 
> root (hd0,1)    
>  Filesystem type is jfs, partition type 0x83
> kernel /usr/src/linux-2.6.17.13/arch/i386/boot/bzImage root=/dev/hda2
> console=t
> tyS0,38400      
>    [Linux-bzImage, setup=0x1400, size=0x10afff]
>                 
> [42949372.960000] Linux version 2.6.17.13-zwerg (root@buche) (gcc
> version 4.1.2 20060613 (prerelease) (Debian 4.1.1-5)) #1 Sun Sep 10
> 16:15:23 UTC 2006
> [42949372.960000] BIOS-provided physical RAM map:
> [42949372.960000]  BIOS-e820: 0000000000000000 - 000000000009fc00
> (usable)
> [42949372.960000]  BIOS-e820: 000000000009fc00 - 00000000000a0000
> (reserved)
> [42949372.960000]  BIOS-e820: 00000000000f0000 - 0000000000100000
> (reserved)
> [42949372.960000]  BIOS-e820: 0000000000100000 - 0000000008000000
> (usable)
> [42949372.960000]  BIOS-e820: 00000000fff0000 - 0000000100000000
> (reserved)
> [42949372.960000] 128MB LOWMEM available.
> [42949372.960000] DMI not present or invalid.
> [42949372.960000] ACPI: Unable to locate RSDP
> [42949372.960000] Allocating PCI resources starting at 10000000 (gap:
> 08000000:f7f00000)
> [42949372.960000] Built 1 zonelists
> [42949372.960000] Kernel command line: root=/dev/hda2
> console=ttyS0,38400
> [42949372.960000] No local APIC present or hardware disabled
> [42949372.960000] Initializing CPU#0
> [42949372.960000] PID hash table entries: 1024 (order: 10, 4096 bytes)
> [    0.000000] Detected 266.663 MHz processor.
> [   20.718339] Using tsc for high-res timesource
> [   20.718638] Console: colour dummy device 80x25
> [   21.045363] Dentry cache hash table entries: 16384 (order: 4, 65536
> bytes)
> [   21.067257] Inode-cache hash table entries: 8192 (order: 3, 32768
> bytes)
> [   21.129713] Memory: 127256k/131072k available 333k kernel code, 3420k
> reserved, 498k data, 124k init, 0k highmem)
> [   21.161087] Checking if this processor honours the WP bit even in
> supervisor mode... Ok.
> [   21.328007] Calibrating delay using timer specific routine.. 534.16
> BogoMIPS (lpj=2670830)
> [   21.353474] Mount-cache hash table entries: 512
> [   21.368758] CPU: NSC Unknown stepping 01
> [   21.380743] Checking 'hlt' instruction... OK.
> [   21.394059] SMP alternatives: switching to UP code
> [   21.408503] Freeing SMP alternatives: 0k freed
> [...]
> --------------------------------------------------------------------------------
> 
> Just wanted to ask whether this is ...
>    a) wanted
>    b) not yet seen
>    c) nothing one should care about

It's intentional.  It helps with checking for code that cares
about timer^W jiffy rollovers.  The kernel starts "time" at -5 minutes
then the jiffy count rolls over soon.  From include/linux/jiffies.h:

/*
 * Have the 32 bit jiffies value wrap 5 minutes after boot
 * so jiffies wrap bugs show up earlier.
 */
#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

---
~Randy
