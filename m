Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUD1QFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUD1QFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 12:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUD1QFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 12:05:47 -0400
Received: from fmr05.intel.com ([134.134.136.6]:15792 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264791AbUD1QFc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:05:32 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
x-mimeole: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Bug#246149: kernel-image-2.6.5-1-686: pci_hotplug fails at boot
Date: Wed, 28 Apr 2004 08:51:40 -0700
Message-ID: <468F3FDA28AA87429AD807992E22D07E1175CE@orsmsx408.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Bug#246149: kernel-image-2.6.5-1-686: pci_hotplug fails at boot
Thread-Index: AcQtC5kX/ZLQ6PBCQAKthk0hVDrqoQALEiiw
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>,
       "Ruben Porras" <nahoo82@telefonica.net>, <246149@bugs.debian.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 28 Apr 2004 15:51:46.0028 (UTC) FILETIME=[B588DAC0:01C42D38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch should fix the problem seen in 2.6.5 kernel.  The same fix is
already in 2.6.6-rc2 kernel.

Thanks,
Dely 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Herbert Xu
Sent: Wednesday, April 28, 2004 3:19 AM
To: Ruben Porras; 246149@bugs.debian.org
Cc: Linux Kernel Mailing List; Andrew Morton
Subject: Re: Bug#246149: kernel-image-2.6.5-1-686: pci_hotplug fails at
boot

tags 246149 pending
quit

On Tue, Apr 27, 2004 at 04:44:23PM +0200, Ruben Porras wrote:
> Package: kernel-image-2.6.5-1-686
> Version: 2.6.5-2
> Severity: normal
>
> shpchp: acpi_shpchprm:\_SB_.PCI0 _CRS fail=0x300b
> shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _CRS fail=0x300b

This means that the adding of the bridges failed and therefore
we don't have any bridges.

> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> Unable to handle kernel NULL pointer dereference at virtual address
00000050
>  printing eip:
> e0a79719
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT 
> CPU:    0
> EIP:    0060:[<e0a79719>]    Not tainted
> EFLAGS: 00010292   (2.6.5-1-686) 
> EIP is at print_acpi_resources+0x9/0x140 [shpchp]
> eax: 00000000   ebx: 00000000   ecx: c02b5ef0   edx: 00000000
> esi: 00000000   edi: df736000   ebp: c02b7658   esp: df737f58
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 659, threadinfo=df736000 task=dfd0e660)
> Stack: c0120ce0 0000000a 00000400 e0a7c000 df737f90 de392680 c02e7e40
00000000 
>        e0a83560 e0a7986a 00000000 df736000 e0936070 e0a7c000 e0a8356c
c02b7670 
>        e0a83560 c02b7670 c01371c0 c034e688 00000001 e0a83560 40164000
0804ee38 
> Call Trace:
>  [<c0120ce0>] printk+0x130/0x190
>  [<e0a7986a>] shpchprm_print_pirt+0x1a/0x40 [shpchp]
>  [<e0936070>] shpcd_init+0x70/0x96 [shpchp]
>  [<c01371c0>] sys_init_module+0x100/0x210
>  [<c0109319>] sysenter_past_esp+0x52/0x71
> 
> Code: 8b 46 50 85 c0 0f 84 e3 00 00 00 48 0f 84 9f 00 00 00 89 34 

Now it tries to print the bridges which is NULL.

The following patch should fix the crash.

Thanks,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
