Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVIWIhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVIWIhW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 04:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVIWIhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 04:37:22 -0400
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([82.235.130.100]:37344
	"EHLO lexbox.fr") by vger.kernel.org with ESMTP id S1750812AbVIWIhV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 04:37:21 -0400
Subject: RE: How to Force PIO mode on sata promise (Linux 2.6.10)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-class: urn:content-classes:message
Date: Fri, 23 Sep 2005 10:34:41 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <17AB476A04B7C842887E0EB1F268111E026FC5@xpserver.intra.lexbox.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to Force PIO mode on sata promise (Linux 2.6.10)
thread-index: AcW/lQIaBPdvyNsxSDq6i8mlo/LjSwAeYucg
From: "David Sanchez" <david.sanchez@lexbox.fr>
To: "Bill Davidsen" <davidsen@tmr.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

I've reduced the UDMA level step by step until the problem seems disappeared.
Finally with UDMA/25 I don't detect error after 1000 copies. I consider that this solution corrects the symptom but not the cause...

I try memtest for mips arch and all is ok.
I try 3 promise controllers: the problem was NOT resolved.
I try more than 4 kind of disk: the problem was NOT resolved.
I try to connect the disk on the pata port and on the sata port: the problem was NOT resolved.
More when I connect the disk to the IDE interface, it doesn't work at all (maybe bad driver implementation)...

David

My embedded system:
	* AMD Development Board AU1550 (mips32) + hdd connected to the pata port of the Promise PDC20579 controller.
	* Kernel2.6.10 + libata patch + busybox 1.0


-----Message d'origine-----
De : linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] De la part de Bill Davidsen
Envoyé : jeudi 22 septembre 2005 18:45
À : David Sanchez
Cc : Jeff Garzik; linux-kernel@vger.kernel.org
Objet : Re: How to Force PIO mode on sata promise (Linux 2.6.10)

David Sanchez wrote:
> Hi Chris,
> It was a good idea but it doesn't resolve the problem...
> 
> I add my card into the dma_black_list of the libata to force DMA disabled and the problem seems to no more appear...maybe PIO is so slow that the data has no time to be corrupted...
> But I can NOT affirm that the problem is the DMA. 
> 
> I try the linux kernel 2.4,2.6.11, 2.6.12 and 2.6.13. More I try 2 different toolchains and the problem persists...
> 
> Another idea??

You disable DMA and the problem goes away, that seems to point to DMA as 
the problem, and since others aren't having the same problem with the 
DMA code in the kernel it certainly suggests the DMA hardware really is 
the problem, or is causing it. It's remotely possible that the kernel 
has a bug in the code just for your controller, although unlikely.

Have you run memtest86 on your memory? I have seen cases where memory 
was marginal and using CPU and DMA was enough to cause it to fail, but 
only when people had played with the memory timing in the BIOS. I 
suspect the SATA disk has a higher datarate than anything else in your 
system, so it could trigger some marginal cases in the memory system. 
Unlikely, but possible.

ideas:
   test your memory if you haven't
   Check that your BIOS is up-to-date
   check your BIOS memory timing settings
   See if the controller came with tools to adjust DMA timing
   try writing to a PATA drive while reading from the SATA
     to generate high DMA rate, look for corruption there
   try another controller of the same type
   try another controler of another supported type
     to see that it's not your drive
   accept that your controller *belongs* on the blacklist

Since you asked for ideas, these are probably in order of easy to difficult.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/





