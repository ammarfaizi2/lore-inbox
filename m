Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbWBHN3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWBHN3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 08:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWBHN3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 08:29:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22713 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964850AbWBHN3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 08:29:43 -0500
Subject: Re: libATA  PATA status report, new patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOC.4.61.0602071947030.15961@math.ut.ee>
References: <20060207084347.54CD01430C@rhn.tartu-labor>
	 <1139310335.18391.2.camel@localhost.localdomain>
	 <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
	 <1139312330.18391.14.camel@localhost.localdomain>
	 <1139324653.18391.41.camel@localhost.localdomain>
	 <Pine.SOC.4.61.0602071947030.15961@math.ut.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Feb 2006 13:31:54 +0000
Message-Id: <1139405514.26270.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-07 at 19:50 +0200, Meelis Roos wrote:
> ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
> ata2: dev 0 ATAPI, max UDMA/33
> ata2: dev 0 configured for UDMA/33

So far so good.

> scsi1 : ata_piix
> ata2: command 0xa0 timeout, stat 0xd0 host_stat 0x24
> ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00

Tries to do a packet command, which is reasonable as its ATAPI but the
timeout is unexpected.

> int3: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c0148711>]    Not tainted VLI

The rest seems to be a generic problem with libata and early commands
timing out (I think the device is getting deleted before the command
completes).

