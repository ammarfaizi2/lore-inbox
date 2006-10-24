Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWJXJqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWJXJqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 05:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWJXJqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 05:46:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18375 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030230AbWJXJqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 05:46:44 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161012290.24237.68.camel@localhost.localdomain> 
References: <1161012290.24237.68.camel@localhost.localdomain> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata-sff: Allow for wacky systems 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 24 Oct 2006 10:44:36 +0100
Message-ID: <22963.1161683076@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> There are some Linux supported platforms that simply cannot hit the low
> I/O addresses used by ATA legacy mode PCI mappings. These platforms have
> a window for PCI space that is fixed by the board logic and doesn't
> include the neccessary locations.
> 
> Provide a config option so that such platforms faced with a controller
> that they cannot support simply error it and punt

Yep, that works:

warthog>grep ATA_LEGACY .config
CONFIG_NO_ATA_LEGACY=y

...
pata_hpt37x: BIOS has not set timing clocks.                                    
hpt37x: HPT371: Bus clock 33MHz.                                                
ata1: PATA max UDMA/133 cmd 0xE4000820 ctl 0xE400082A bmdma 0xE4000C00 irq 20   
ata2: PATA max UDMA/133 cmd 0xE4000830 ctl 0xE400082E bmdma 0xE4000C08 irq 20   
scsi0 : pata_hpt37x                                                             
ATA: abnormal status 0x7D on port 0xE4000827                                    
scsi1 : pata_hpt37x                                                             
ATA: abnormal status 0x8 on port 0xE4000837                                     
pata_it821x: controller in smart mode.                                          
ata3: PATA max MWDMA2 cmd 0xE4000838 ctl 0xE4000842 bmdma 0xE4000850 irq 22     
ata4: PATA max MWDMA2 cmd 0xE4000848 ctl 0xE4000846 bmdma 0xE4000858 irq 22     
scsi2 : pata_it821x                                                             
scsi3 : pata_it821x                                                             
...


David
