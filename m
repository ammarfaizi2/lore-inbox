Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWIDLkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWIDLkV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWIDLkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:40:21 -0400
Received: from [81.2.110.250] ([81.2.110.250]:18363 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964803AbWIDLkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:40:19 -0400
Subject: Re: PATA drivers queued for 2.6.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <44FC0779.9030405@garzik.org>
References: <44FC0779.9030405@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 13:02:43 +0100
Message-Id: <1157371363.30801.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-04 am 07:01 -0400, ysgrifennodd Jeff Garzik:
> The following must be in all caps, though:
> 
> drivers/ide IS STILL THE PATA DRIVER SET THAT USERS AND DISTROS SHOULD 
> CHOOSE.

Except optionally for the following for chips not handled by or broken
totally in drivers/ide:

	pata_mpiix - some early pentium era laptops
	pata_oldpiix - original "PIIX" chipset
	pata_radisys - embedded chipset

The other apparently "libata only" chips are pata_jmicron and
pata_optidma. There are patches to handle these as "generic" PCI IDE in
the base 2.6.18 tree already so only features will be lost (eg mode
switching). As Jeff implies distributions should be using drivers/ide
for the Jmicron PATA and the Opti DMA PATA for now.

> * /dev/sdX supports fewer partitions than /dev/hdX (16 versus 64, IIRC)
> 
> * /dev/sdX does not support all the HDIO_xxx ioctls that /dev/hdX does. 
>   In practice, the ioctls we ignored are ones that very few people care 
> about.

Add "/dev/sr*" does not support partitions. (That needs fixing anyway)
    
> * ARM, PPC and other non-x86 platform drivers are severely 
> under-represented.

libata needs changes for this too. I have some stuff saved from the
older discussions to look at.

> As an aside, I would love to see paride updated to use libata, but we 
> can probably count the number of paride users on one hand these days...

and thats without using fingers or thumbs.


-- 
VGER BF report: H 0.235691
