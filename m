Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWGGPyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWGGPyc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWGGPyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:54:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13993 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932128AbWGGPyb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:54:31 -0400
Subject: Re: 2.6.17-mm6 libata stupid question...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200607070428.k674S8Rf005209@turing-police.cc.vt.edu>
References: <200607070428.k674S8Rf005209@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 17:12:01 +0100
Message-Id: <1152288721.20883.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-07 am 00:28 -0400, ysgrifennodd Valdis.Kletnieks@vt.edu:
> [   34.412761] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
> [   34.413426] scsi0 : ata_piix
> [   34.720915] ata1.00: configured for UDMA/33
> [   34.872966] ata1.01: configured for UDMA/33
> There's only one minor detail - although the CD is (AFAIK) a UDMA/33 device,
> the hard drive and the controller are both able to do UDMA/100.

Until the very latest code the speed setting on the libata tree is
conservative and sets the speed per channel not per device. 

The fact you get the same response with drivers/ide rather suggests that
in this case the problem is cable detection. Tweak ata_piix to print out
the cable type it detects. If it thinks its a 40 pin cable you know
where to start.

> Now admittedly, the ide driver wasn't able to figure that out *either*, so
> in a /etc/rc script I had:   '/sbin/hdparm -X udma5'.  But alas, that doesn't
> work:

Right now speed setting by user apps isnt supported.

