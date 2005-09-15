Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbVIOFh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbVIOFh1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 01:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbVIOFh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 01:37:27 -0400
Received: from mail.dvmed.net ([216.237.124.58]:56257 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030409AbVIOFh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 01:37:26 -0400
Message-ID: <43290893.7070207@pobox.com>
Date: Thu, 15 Sep 2005 01:37:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: izvekov@lps.ele.puc-rio.br
CC: linux-kernel@vger.kernel.org
Subject: Re: libata sata_sil broken on 2.6.13.1
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br> <60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

izvekov@lps.ele.puc-rio.br wrote:
> I managed to get a serial cable. Now follows the dmesg, from where libata
> starts until it dies.
> 
> ata1: SATA max UDMA/100 cmd 0xF881E080 ctl 0xF881E08A bmdma 0xF881E000 irq 11
> ata2: SATA max UDMA/100 cmd 0xF881E0C0 ctl 0xF881E0CA bmdma 0xF881E008 irq 11
> ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
> ata1(0): applying Seagate errata fix
> ata1: dev 0 configured for UDMA/100
> scsi0 : sata_sil
> irq 11: nobody cared (try booting with the "irqpoll" option)


This one is related to libata.  Known problem:
     http://bugzilla.kernel.org/show_bug.cgi?id=3880

Silicon Image 311x throws interrupts after we told the hardware to 
disable interrupts, but only for a few certain devices and/or PATA 
bridges.  I only have theories as to the solution.

I made a failed attempt to solve it here:
     http://search.luky.org/linux-kernel.2005/msg14830.html

This patch from Albert Lee might solve it, but the patch itself needs 
bug fixes:
     http://marc.theaimsgroup.com/?t=112628285200005&r=1&w=2

Also, defining ATA_IRQ_TRAP in include/linux/libata.h may work around 
the problem.

Plenty more info available on request.  Nothing changed in this area 
with regards to 2.6.12/2.6.13, so I presume that ACPI has simply exposed 
the existing problem for you.  :(

     Jeff


