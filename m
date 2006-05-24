Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWEXJfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWEXJfm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 05:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWEXJfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 05:35:42 -0400
Received: from sigrand.ru ([80.66.88.167]:28055 "EHLO mail.sigrand.com")
	by vger.kernel.org with ESMTP id S932557AbWEXJfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 05:35:41 -0400
Date: Wed, 24 May 2006 16:35:30 +0700
From: art <art@sigrand.ru>
X-Mailer: The Bat! (v1.38e) S/N A1D26E39 / Educational
Reply-To: art <art@sigrand.ru>
Organization: Sigrand LLC
X-Priority: 3 (Normal)
Message-ID: <19691.060524@sigrand.ru>
To: linux-kernel@vger.kernel.org
Subject: Problem with TLB mcheck!
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux community!
Please CC to me personaly, because I'am not subsribed yet.

I am relatively new Linux kernel (just work with some network adapter
drivers) and my english is poor, so excuse me if something wrong.
I work with Infineon ADM5120 chip (MIPS32 processor, little endian,
using tlb), setting embedded Linux on it.
Almost everything is work now (I port some drivers). But there is big
problem ( sg16lan is my network driver module):

[4294714.623000] sg16lan.c: shdsl_interrupt wake up dsl0
[4294714.627000] sg16lan.c: shdsl_interrupt wake up dsl0
[4294714.628000] Got mcheck at c0096604
[4294714.628000] Cpu 0
[4294714.628000] $ 0   : 00000000 10008400 00000000 00000000
[4294714.628000] $ 4   : c0098384 c00aa26c 00000001 00000001
[4294714.628000] $ 8   : 81261fe0 00008400 00000000 80318000
[4294714.628000] $12   : 0000000c 00 00000078 00000000
[4294714.628000] $16   : 000000d1 0000aea8 8038a220 8038a000
[4294714.628000] $20   : 80323420 80030000 00000002 8038a220
[4294714.628000] $24   : 00000000 802c0000
[4294714.628000] $28   : 81260000 81261e60 00003fde c0096604
[4294714.628000] Hi    : 00000280
[4294714.628000] Lo    : 00000230
[4294714.628000] epc   : c0096604 store_download+0x424/0x4fc [sg16lan]     Not tainted
[4294714.628000] ra    : c0096604 store_download+0x424/0x4fc [sg16lan]
[4294714.628000] Status: 10208403    KERNEL EXL IE
[4294714.628000] Cause : 00800060
[4294714.628000] PrId  : 0001800b
[4294714.628000]
[4294714.628000] Index:  4 pgmask=4kb va=c0094000 asid=b2
[4294714.628000]                        [pa=003d4000 c=3 d=1 v=1 g=1]
[4294714.628000]                        [pa=003d5000 c=3 d=1 v=1 g=1]
[4294714.628000]
[4294714.628000] Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
[4294714.628000]

Panic occures when I work with big memory arrays (about 100Kb), when load firmware in the insmod-ed
driver. BUT! if driver is staticaly compiled in kernel all is ok.
I have try loading with two variants:
1. request_firmware call (it allocates memory with valloc)
2. ioctl call (it allocate memory with kalloc).
The same thing (if driver insmoded - panic, if staticaly compiled -
all work correctly).

IMHO this is Memory Management subsystem problem, because ported
driver is work fine on x86 processor and can not be reason of the
problem. But I can be wrong!
Where can I look and whom ask the questions??

I woud be thankful for any help.
Thanks anyway, Artem


