Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVGNTDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVGNTDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVGNTBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:01:10 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:46358 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261688AbVGNS7b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:59:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kt/kZhh+OySAMCA/WkAXRUMdkLAsRafSnMhFaAE3omH/o3y03+SNTBSRWkp6RSOZVcjRmdyx5M9eBJS3aCskgDDvy7rnVhe+EGVf67mlAJmAwfqzwuulz+qi5H7JuspQrvCktJxWxZJ4et3cbG7pjQFtCzlfdJKULeMtKOedgZY=
Message-ID: <2ea3fae1050714115867e042a8@mail.gmail.com>
Date: Thu, 14 Jul 2005 11:58:40 -0700
From: yhlu <yinghailu@gmail.com>
Reply-To: yhlu <yinghailu@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: [LinuxBIOS] NUMA support for dual core Opteron
Cc: Li-Ta Lo <ollie@lanl.gov>, "Ronald G. Minnich" <rminnich@lanl.gov>,
       Stefan Reinauer <stepan@openbios.org>, discuss@x86-64.org,
       LinuxBIOS <linuxbios@openbios.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050714184821.GJ23619@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2ea3fae10507141058c476927@mail.gmail.com>
	 <1121365786.3317.6.camel@logarithm.lanl.gov>
	 <20050714184821.GJ23619@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI in Tyan S4881 (8 ways dual core 875 cpu ) with LinuxBIOS I got
also the 1G mem hole is enabled.

So the kernel should be OK with read NUMA directly from HW.

YH

Firmware type: LinuxBIOS
old bootloader convention, maybe loadlin?
Bootdata ok (command line is apic=debug ramdisk_size=65536
root=/dev/ram0 rw console=tty0 console=ttyS0,115200n8 )
Linux version 2.6.12 (root@tst288xsuse9) (gcc version 3.3.3 (SuSE
Linux)) #8 SMP Fri Jun 24 12:41:43 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000000e48 (reserved)
 BIOS-e820: 0000000000000e48 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 00000000000f0400 (reserved)
 BIOS-e820: 0000000000100000 - 00000000c0000000 (usable)
 BIOS-e820: 0000000100000000 - 0000000840000000 (usable)
Scanning NUMA topology in Northbridge 24
Number of nodes 8
Node 0 MemBase 0000000000000000 Limit 000000013fffffff
Node 1 MemBase 0000000140000000 Limit 000000023fffffff
Node 2 MemBase 0000000240000000 Limit 000000033fffffff
Node 3 MemBase 0000000340000000 Limit 000000043fffffff
Node 4 MemBase 0000000440000000 Limit 000000053fffffff
Node 5 MemBase 0000000540000000 Limit 000000063fffffff
Node 6 MemBase 0000000640000000 Limit 000000073fffffff
Node 7 MemBase 0000000740000000 Limit 000000083fffffff
node 1 shift 24 addr 140000000 conflict 0
node 1 shift 25 addr 1fe000000 conflict 0
node 3 shift 26 addr 3fc000000 conflict 0
node 7 shift 27 addr 7f8000000 conflict 0
Using node hash shift of 28
Bootmem setup node 0 0000000000000000-000000013fffffff
Bootmem setup node 1 0000000140000000-000000023fffffff
Bootmem setup node 2 0000000240000000-000000033fffffff
Bootmem setup node 3 0000000340000000-000000043fffffff
Bootmem setup node 4 0000000440000000-000000053fffffff
Bootmem setup node 5 0000000540000000-000000063fffffff
Bootmem setup node 6 0000000640000000-000000073fffffff
Bootmem setup node 7 0000000740000000-000000083fffffff

in LB
Setting variable MTRR 0, base:    0MB, range: 32768MB, type WB
Setting variable MTRR 1, base: 32768MB, range: 1024MB, type WB
Setting variable MTRR 2, base: 3072MB, range: 1024MB, type UC


On 7/14/05, Andi Kleen <ak@suse.de> wrote:
> > AFIAK, for x86_64 kernel, it will try to read NUMA configuration from
> > HW directory. We don't have to export any ACPI table.
> 
> It doesn't work for dual core or 8 sockets for some reason. Since the SRAT
> code works fine and is in general more future proof we never tracked down
> why. Patches welcome.
> 
> However you'll likely need ACPI for other reasons anyways, e.g. for
> better power saving.
> 
> -Andi
> 
>
