Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030541AbWAGS5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbWAGS5H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbWAGS5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:57:07 -0500
Received: from mail.gmx.de ([213.165.64.21]:57474 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030541AbWAGS5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:57:06 -0500
Date: Sat, 7 Jan 2006 19:57:05 +0100 (MET)
From: "Lukas Postupa" <postupa@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <1134649915.12421.37.camel@localhost.localdomain>
Subject: Re: HPT374 RAID bus controller SATA, only UDMA 33
X-Priority: 3 (Normal)
X-Authenticated: #21388368
Message-ID: <15290.1136660225@www72.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2005 12:31:55 +0000, Alan Cox wrote:


> > my SAMSUNG 250GB drive connected to HPT374 RAID bus > > controller
(SATA) is only working at UDMA 33.
> 
> 
> Force ata66 support on. See Documentation/ide.txt
> 

I tried to force ata66 but this doesn't work.
Drive still remains at UDMA 33.

But setting CONFIG_IDEDMA_PCI_AUTO to [ n ] (kernel 2.6.14.4) skips UDMA 33
detection and leads to this output:

hdk: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63 /*
before:  ,UDMA(33) */

Then after booting:

$hdparm -d 1 /dev/hdk

/dev/hdk:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)

$hdparm -t /dev/hdk

/dev/hdk:
 Timing buffered disk reads:  162 MB in  3.02 seconds =  53.71 MB/sec

now this looks much better :)

By the way: Is there a trick setting DMA without CONFIG_IDEDMA_PCI_AUTO = [
y ] at boot time independent from init scripts?

regards,

Lukas

-- 
DSL-Aktion wegen groﬂer Nachfrage bis 28.2.2006 verl‰ngert:
GMX DSL-Flatrate 1 Jahr kostenlos* http://www.gmx.net/de/go/dsl
