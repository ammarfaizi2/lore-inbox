Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267123AbTGGR0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267136AbTGGR0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:26:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:8161 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267123AbTGGR0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:26:37 -0400
Message-ID: <3F09B0B6.5060605@gmx.at>
Date: Mon, 07 Jul 2003 19:41:10 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Wil Reichert <wilreichert@yahoo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: highpoint driver problem, 2.4.21-ac4
References: <4V9E.47E.39@gated-at.bofh.it>	<4V9E.47E.37@gated-at.bofh.it>	<4WyE.5oC.19@gated-at.bofh.it>	<3F04823A.5030403@gmx.at>	<20030703184427.3cb71051.wilreichert@yahoo.com>	<3F074C25.5060004@gmx.at> <20030706132507.240683d1.wilreichert@yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------070802060408070109060909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070802060408070109060909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wil Reichert wrote:
 >> could you try the attachted patch, and report if this changes
 >> something?
 >
 >
 > Applied patch & rebuilt with hpt366 as a module.  No more oops, dmesg
 > prints the following:
 >
 > HPT372A: IDE controller at PCI slot 01:0b.0 HPT372A: chipset revision
 > 2 HPT372A: not 100% native mode: will probe irqs later hpt: HPT372N
 > detected, using 372N timing. FREQ: 126 PLL: 45 hpt: no known IDE
 > timings, disabling DMA. hpt: no known IDE timings, disabling DMA.

it looks like the controller is detected as a HPT372N instead of a 
HPT372A. the attached patch disables this check.

 >
 > It has 2 drives attached to it, neither seems to be found.
 >
 > Other things: the 2.5.xx seems to work ok and my board supports some
 > 'RAID 1.5' which seems to be nothing more than PR crap and some
 > firmware hacks.  Could that cause problems?

raid 15 is a mirrored raid 5, which should provide high availability and 
good performance (even in the case of a disk failure). but in this case 
it is nothing more than a software solution. ;)

 >
 > Wil

bye,
wilfried

--------------070802060408070109060909
Content-Type: text/plain;
 name="linux-2.4.21-ac4-ignore-hpt372n.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.21-ac4-ignore-hpt372n.patch"

--- linux/drivers/ide/pci/hpt366.c.orig	2003-07-07 19:19:25.000000000 +0200
+++ linux/drivers/ide/pci/hpt366.c	2003-07-07 19:19:55.000000000 +0200
@@ -889,8 +889,10 @@ static int __init init_hpt37x(struct pci
 		did = inb(dmabase + 0x22);
 		rid = inb(dmabase + 0x28);
 	
+#if 0
 		if((did == 4 && rid == 6) || (did == 5 && rid > 1))
 			is_372n = 1;
+#endif
 	}
 		
 	/*

--------------070802060408070109060909--

