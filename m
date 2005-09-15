Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965285AbVIOVko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965285AbVIOVko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965286AbVIOVko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:40:44 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:65058 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965283AbVIOVkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:40:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ONtT49IJPR7dxX8oHBxqFINv3Gcjkeyu5nY7SLL5H41S2PoDRCcDXH3PNoyU4XheGAhutFhIwwfXMT9mU9BeYrDp5GhAPUfp6plmutBqkFSqNsdAcfeErj1V71z+mvaZ/0vheD5Xo3W64QsQIJP3ndkH1dHOY5uoKVlsyqc8aas=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: early printk timings way off
Date: Thu, 15 Sep 2005 23:42:24 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509152342.24922.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Early during boot the printk timings are way off : 

[4294667.296000] Linux version 2.6.14-rc1-git1 (juhl@dragon) (gcc version 3.3.6) #1 PREEMPT Thu Sep 15 22:25:37 CEST 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[4294667.296000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
[4294667.296000]  BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
[4294667.296000]  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[4294667.296000] 511MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 131052
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
[4294667.296000]   Normal zone: 126956 pages, LIFO batch:31
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: RSDP (v000 ASUS                                  ) @ 0x000f69e0
[4294667.296000] ACPI: RSDT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec000
[4294667.296000] ACPI: FADT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec080
[4294667.296000] ACPI: BOOT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec040
[4294667.296000] ACPI: DSDT (v001   ASUS A7M266   0x00001000 MSFT 0x0100000b) @ 0x00000000
[4294667.296000] Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: auto BOOT_IMAGE=2.6.14-rc1-git1 ro root=801 pci=usepirqmask
[4294667.296000] Initializing CPU#0
[4294667.296000] CPU 0 irqstacks, hard=c03d2000 soft=c03d1000
[4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)

^^^^^ These I can buy as the result of an uninitialized variable. Why are 
      we not initializing this counter to zero?

[    0.000000] Detected 1400.279 MHz processor.

^^^^^ Ok, we finally seem to have initialized the counter...

[   27.121583] Using tsc for high-res timesource

^^^^^ 27 seconds??? Something is off here. It certainly doesn't take 27 sec
      to get from the previous message to this one during the actual boot.
      What's up with that?

[   27.121620] Console: colour dummy device 80x25
[   27.122909] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
...

No big deal, but it sure would look better (and be actually useful for the 
first few messages) if things started out at zero and then actually 
increased sanely from the very beginning.  :-)


-- 
 Jesper Juhl <jesper.juhl@gmail.com>



