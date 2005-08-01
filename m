Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVHAPMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVHAPMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVHAPMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:12:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:17646 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261299AbVHAPMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:12:07 -0400
Message-ID: <42EE3BC0.6010002@gmx.net>
Date: Mon, 01 Aug 2005 17:12:00 +0200
From: Otto Meier <gf435@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Driver for sata adapter promise sata300 tx4
References: <42EDE918.9040807@gmx.net> <42EE3501.7010107@gentoo.org>
In-Reply-To: <42EE3501.7010107@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:a9159ed0296f17902404cf1c2ac7671c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Otto Meier wrote:
>> This card use the sata chip pdc 40718 (as of my card)
>> the lastest sata_promise kernel with sata promise patch driver 
>> doesn't recognise
>> this card.
>>
>> I added the following line to static struct pci_device_id 
>> pdc_ata_pci_tbl[] in sata_promise.c:
>>
>> { PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>> board_20319 },
>>
>> and the card was recognised and seam to work without errors so far.
>
> Yes, this should be fine (this is a 4-port SATA card right?)
>
> Are you happy to produce and submit a patch yourself (read 
> Documentation/SubmittingPatches) or should I submit one for you?
>
> Thanks,
> Daniel
>
>
Yes you are right it is a 4-port sata-II 300 card (PDC40718 ). According to
the promise feature list it should support :

SATA300™ TX4 Highlights

    * Native Command Queuing (NCQ)
    * SATA Tagged Command Queuing (TCQ)
    * Large LBA support for drives above 137GB
    * Supports Serial ATAPI devices
    * Disk Activity LED Headers
    * Flexible future-proof upgrade for users with motherboards that
      only have a PCI interface


My question is also are these features (NCQ/TCQ) and the heigher 
datarate be supported by this
modification? or is only the basic feature set of sata 150 TX4 supported?

Here is the patch:

--- linux/drivers/scsi/sata_promise.c.orig 2005-08-01 17:09:48.474824778 
+0200
+++ linux/drivers/scsi/sata_promise.c 2005-07-31 12:57:06.415979512 +0200
@@ -183,6 +183,8 @@ static struct pci_device_id pdc_ata_pci_
board_20319 },
{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
board_20319 },
+ { PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+ board_20319 },
{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
board_20319 },



Thanks
Otto


