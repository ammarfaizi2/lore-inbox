Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbTLVPcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 10:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTLVPcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 10:32:10 -0500
Received: from bay8-dav66.bay8.hotmail.com ([64.4.26.201]:46858 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264384AbTLVPbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 10:31:47 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: "'Walt H'" <waltabbyh@comcast.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Mon, 22 Dec 2003 16:31:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <3FE70842.1020502@comcast.net>
Thread-Index: AcPInX2mHq0G0dVxQZGispdRnZtcPgAAiIaA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY8-DAV664uGmn5YHP000102fe@hotmail.com>
X-OriginalArrivalTime: 22 Dec 2003 15:31:46.0615 (UTC) FILETIME=[B5C0F470:01C3C8A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No problem I can see the whole boot log. The ATARAID driver never loads.
Could you force it to load somehow?

I get these messages:

PDC20271: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 12 for device 00.09.0
PCI: Sharing IRQ 12 with 00:04.2

PDC20271: not 100% native mode: will probe irqs later
	ide2: BM-DMA at ...
	ide3: BM-DMA at ...

then it finds the disks:

hde: WDC ...
hdg: WDC ... 

partition check:
hde: hde1, hde2
hdg: hdg1, hdg2

ide: late registration of driver
 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Walt H
Sent: den 22 december 2003 16:06
To: Nicklas Bondesson
Cc: linux-kernel@vger.kernel.org; andre@linux-ide.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
(PDC20271)

Nicklas Bondesson wrote:
> Do I have to include anything else than this??
> 
> <*> ATA/IDE/MFM/RLL support
>   IDE, ATA and ATAPI Block devices -->
> 	<*> PROMISE PDC202{68|69|70|71|75|76|77} support (NEW)
> 	[*] Special FastTrack Feature
> 
> 	<*> Support for IDE Raid Controllers (EXPERIMENTAL)
> 	<*> Support Promise software RAID (Fasttrak(tm)) (EXPERIMENTAL)
>  
> /Nicke
> 

I believe that should do it. dmesg doesn't have any info about the ataraid
driver being loaded? If it's scrolling out of the kernel buffer, you can try
bumping up the size through the kernel config. The option is under the
"Kernel Hacking" section and is CONFIG_LOG_BUF_SHIFT. Change it to 17 or 18
to be sure.
A reboot with this new kernel should give you a full dmesg afterward,
hopefully showing what's wrong with the ataraid stuff.

-Walt

PS. I don't remember when this took place, but there were some changes to
the promise drivers in 2.4 around 2.4.21 I think. There should be drivers
for both the older Promise and the newer. I remember always choosing both,
complete with pdcraid just to be sure.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
