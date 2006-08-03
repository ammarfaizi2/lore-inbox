Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWHCQz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWHCQz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWHCQz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:55:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43969 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932436AbWHCQz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:55:28 -0400
Subject: Re: sata_promise / libata defaulting to UDMA/33
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc <linux-kernel@liquid-nexus.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060803163002.M27080@liquid-nexus.net>
References: <20060803163002.M27080@liquid-nexus.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 18:14:49 +0100
Message-Id: <1154625289.23655.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-04 am 00:31 +0800, ysgrifennodd Marc:
> Hi. 
> 
> I'm having great difficulty solving a problem I've encountered. I have a
> Promise Fastrak TX4000 card:

We knock things down to UDMA33 if they are on an unsuitable cable. The
rest of the displayed data looks correct.

> ata2: PATA max UDMA/133 cmd 0xF8ABC280 ctl 0xF8ABC2B8 bmdma 0x0 irq 137

Controller does 133

> ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 88:203f
> ata2: dev 0 ATA-6, max UDMA/100, 312581808 sectors: LBA48

Devices does UDMA 100
> <b>ata2: dev 0 configured for UDMA/33</b>

So this appears to be a cable confusion. One thing that was fixed in
recent patches was a bug where if the core code decided something was
PATA but the drive setup was in fact SATA it incorrectly clipped to
UDMA33.

> I'm currently running kernel 2.6.17.3. In the controller's BIOS I've created 3
> 'stripe' arrays with 1 disk per array, the BIOS shows the 3 drives as U5 (UDMA
> mode 5 - which is UDMA/100 right?).

Correct

> I've searched high and low but haven't found an answer to this problem. Help
> appreciated. Please - I'm getting dismal performance.

I think the needed patch is in 2.6.18-mm, not sure about 2.6.18-rc base.
Jeff Garzik would be able to verify what has it merged.


