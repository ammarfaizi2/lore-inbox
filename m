Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265837AbUFOSqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbUFOSqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUFOSqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:46:14 -0400
Received: from denner.demon.co.uk ([80.176.227.19]:58863 "EHLO
	denner.demon.co.uk") by vger.kernel.org with ESMTP id S265837AbUFOSpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:45:53 -0400
Message-ID: <40CF43E3.3080504@denner.demon.co.uk>
Date: Tue, 15 Jun 2004 19:45:55 +0100
From: Matthew Denner <matt@denner.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 45 minute boot time with 2.6.4/2.6.6-mm5 kernel on 1.7GHz laptop
References: <40CEFC9E.2030508@denner.demon.co.uk> <16590.65369.579162.568380@alkaid.it.uu.se>
In-Reply-To: <16590.65369.579162.568380@alkaid.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.2 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> Matthew Denner writes:
>  > On Saturday I installed SuSE 9.1 Personal on my laptop and I'm beginning 
>  > to wonder whether this was a bad idea.  It takes my laptop (a Pentium-M 
>  > Centrino 1.7Ghz with 1GB DDR RAM and 40GB HDD) 45 minutes to boot (from 
>  > selecting "linux" in GRUB to having the KDE interface up and running). 
>  > It spends about 20-25 minutes in the boot procedure before it even gets 
>  > to starting X.  Yesterday I managed to tidy my front room, put some 
> 
> Sounds a lot like a BIOS MTRR problem we've seen before, where
> the BIOS fails to make the top-most part of physical RAM cacheable.
> 
> Send the contents of /proc/mtrr and the head of dmesg (the part
> that shows the physical memory map) to LKML.

I would have done this ealier, had I not broken everything with my last 
kernel rebuild and had to re-install!  Kernel is back to 2.6.4.

The output of /proc/mtrr is:

reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x20000000 ( 512MB), size= 256MB: write-back, count=1
reg02: base=0x30000000 ( 768MB), size= 128MB: write-back, count=1
reg03: base=0x38000000 ( 896MB), size=  64MB: write-back, count=1
reg04: base=0x3c000000 ( 960MB), size=  32MB: write-back, count=1
reg05: base=0x3e000000 ( 992MB), size=  16MB: write-back, count=1
reg06: base=0xf0000000 (3840MB), size=   4MB: write-combining, count=1

And the physical RAM map bit is:

BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003f7d0000 (usable)
  BIOS-e820: 000000003f7d0000 - 000000003f7df000 (ACPI data)
  BIOS-e820: 000000003f7df000 - 000000003f800000 (ACPI NVS)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
128MB vmalloc/ioremap area available.
119MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 260048
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 30672 pages, LIFO batch:7

If you need any more info please let me know.

Matt
