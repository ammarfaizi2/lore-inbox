Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266422AbTGEVxO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 17:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbTGEVxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 17:53:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:50584 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266422AbTGEVxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 17:53:07 -0400
Message-ID: <3F074C25.5060004@gmx.at>
Date: Sun, 06 Jul 2003 00:07:33 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Wil Reichert <wilreichert@yahoo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: highpoint driver problem, 2.4.21-ac4
References: <4V9E.47E.39@gated-at.bofh.it>	<4V9E.47E.37@gated-at.bofh.it>	<4WyE.5oC.19@gated-at.bofh.it>	<3F04823A.5030403@gmx.at> <20030703184427.3cb71051.wilreichert@yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------070100040408000202030001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070100040408000202030001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wil Reichert wrote:
> Thats the kernel I'm using.

could you try the attachted patch, and report if this changes something?

bye,
wilfried

> 
> Wil
> 
> On Thu, 03 Jul 2003 21:21:30 +0200
> Wilfried Weissmann <Wilfried.Weissmann@gmx.at> wrote:
> 
> 
>>Wil Reichert wrote:
>> >>> The on-board Highpoint controller (HPT372A) on my DFI NF2 is
>> >>> having issue.  Loading the hptraid module results in a 'No such
>> >>> device' message while the hpt366 module segfaults and leaves an
>> >>> oops in my logs.  These errors occur regardless of the disk/raid
>> >>> configuration in the hpt BIOS.   Following are the oops trace, an
>> >>> lsmod, the .config and a lspci -vvv.
>> >>
>> >> The crash occurs in the hpt366 module. Loading hptraid will not
>> >> work because it depends on the kernel to claim the disks of the
>> >> raid volume (that is what hpt366 would do). I will add autoloading
>> >> of the ide-controller module in the next raid-driver release.
>> >> However, I do not know why the kernel oopses. You might want to try
>> >> to build the hpt366 code into the kernel instead of a module. If it
>> >> works it would probably mean that "ide_hwif_t *hwif" was not
>> >> properly initalized.
>> >
>> > I initially had all the hpt modules built into the kernel, but that
>> > would also produce an oops and die immediately after ID'ing the two
>> > drives I have on attached.  Would any more information be of use to
>> > you?
>>
>>2.4.21-ac4 contains several fixes for the hpt37x. Please try this patch out.
>>
>>bye,
>>Wilfried

--------------070100040408000202030001
Content-Type: text/plain;
 name="linux-2.4.21-ac4-idedmafix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.21-ac4-idedmafix.patch"

--- linux/drivers/ide/setup-pci.c.orig	2003-07-06 00:04:06.000000000 +0200
+++ linux/drivers/ide/setup-pci.c	2003-07-06 00:04:12.000000000 +0200
@@ -172,7 +172,7 @@ static int ide_setup_pci_baseregs (struc
  *	is already in DMA mode we check and enforce IDE simplex rules.
  */
 
-static unsigned long __init ide_get_or_set_dma_base (ide_hwif_t *hwif)
+static unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif)
 {
 	unsigned long	dma_base = 0;
 	struct pci_dev	*dev = hwif->pci_dev;

--------------070100040408000202030001--

