Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWHCSMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWHCSMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWHCSMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:12:39 -0400
Received: from ihug-mail.icp-qv1-irony4.iinet.net.au ([203.59.1.198]:27836
	"EHLO mail-ihug.icp-qv1-irony4.iinet.net.au") by vger.kernel.org
	with ESMTP id S932429AbWHCSMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:12:38 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.07,209,1151856000"; 
   d="scan'208"; a="840608451:sNHT14484852"
From: "Marc" <linux-kernel@liquid-nexus.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sata_promise / libata defaulting to UDMA/33
Date: Fri, 4 Aug 2006 02:12:36 +0800
Message-Id: <20060803180707.M8589@liquid-nexus.net>
In-Reply-To: <1154625289.23655.97.camel@localhost.localdomain>
References: <20060803163002.M27080@liquid-nexus.net> <1154625289.23655.97.camel@localhost.localdomain>
X-Mailer: Open WebMail 2.51 20050627
X-OriginatingIP: 192.168.127.244 (marc)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2006 18:14:49 +0100, Alan Cox wrote
> Ar Gwe, 2006-08-04 am 00:31 +0800, ysgrifennodd Marc:
> > Hi. 
> > 
> > I'm having great difficulty solving a problem I've encountered. I have a
> > Promise Fastrak TX4000 card:
> 
> We knock things down to UDMA33 if they are on an unsuitable cable. 
> The rest of the displayed data looks correct.
> 
> > ata2: PATA max UDMA/133 cmd 0xF8ABC280 ctl 0xF8ABC2B8 bmdma 0x0 irq 137
> 
> Controller does 133
> 
> > ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003
88:203f
> > ata2: dev 0 ATA-6, max UDMA/100, 312581808 sectors: LBA48
> 
> Devices does UDMA 100
> > <b>ata2: dev 0 configured for UDMA/33</b>
> 
> So this appears to be a cable confusion. One thing that was fixed in
> recent patches was a bug where if the core code decided something was
> PATA but the drive setup was in fact SATA it incorrectly clipped to
> UDMA33.
> 
> > I'm currently running kernel 2.6.17.3. In the controller's BIOS I've created 3
> > 'stripe' arrays with 1 disk per array, the BIOS shows the 3 drives as U5 (UDMA
> > mode 5 - which is UDMA/100 right?).
> 
> Correct
> 
> > I've searched high and low but haven't found an answer to this problem. Help
> > appreciated. Please - I'm getting dismal performance.
> 
> I think the needed patch is in 2.6.18-mm, not sure about 2.6.18-rc base.
> Jeff Garzik would be able to verify what has it merged.
> 
> -

Thank you. I've compiled and installed 2.6.18-rc3 and it now shows:

ata2: dev 0 configured for UDMA/100

Problem is the system locks up after a few minutes - not sure what's causing
that (no flashing keyboard LEDs so it's not a kernel panic). I'll try again
tomorrow - its very late here already!

Regards.

--
