Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757677AbWKXLH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757677AbWKXLH1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 06:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757676AbWKXLH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 06:07:27 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11700 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757589AbWKXLH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 06:07:26 -0500
Date: Fri, 24 Nov 2006 11:13:13 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: Conke Hu <conke.hu@amd.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       arjan@infradead.org
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA
Message-ID: <20061124111313.5ec0a599@localhost.localdomain>
In-Reply-To: <456699CA.9060904@gmail.com>
References: <FFECF24D2A7F6D418B9511AF6F3586020108CE7D@shacnexch2.atitech.com>
	<45668ACF.1040101@gmail.com>
	<456699CA.9060904@gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Unlike Jmicron's case, this doesn't affect PCI bus scan.  Actually, it 
> does change class code but that's not as disruptive as Jmicron's case 
> and as long as ahci ignores class code, it doesn't really matter. 
> Driver can be chosen by changing loading order - this is both plus and 
> minus.

The load order is basically undefined. You want AHCI so we should do
this early. That means either putting the same gunk all over the kernel
(drivers/ide, drivers/ata/*ati* drivers/ata/ahci) or in one place.
 
> * As Arjan pointed out, that unlock-modify-lock sequence should be done 
> on resume too.  

The infrastructure for this is already handled by the pci resume quirk
patches I sent. 
