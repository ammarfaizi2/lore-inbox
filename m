Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTELLR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 07:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbTELLR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 07:17:29 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:37008 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261788AbTELLR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 07:17:28 -0400
Date: Mon, 12 May 2003 12:30:38 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.net
Subject: Re: [PATCH] better ali1563 integrated ethernet support
Message-ID: <20030512113038.GA31870@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jgarzik@pobox.net
References: <200305111914.h4BJES3g007061@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305111914.h4BJES3g007061@hera.kernel.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 06:24:44PM +0000, Linux Kernel wrote:
 > ChangeSet 1.1111, 2003/05/11 14:24:44-04:00, dean@arctic.org
 > 
 > 	[PATCH] better ali1563 integrated ethernet support
 > 	
 > 	it turns out the tulip driver is a much better driver for the integrated
 > 	ali1563 ethernet than the dmfe driver... the dmfe driver gets tx timeouts
 > 	every ~15s and can't receive over 5MB/s.  but with the small tulip patch
 > 	below i'm seeing 11MB/s+ in both directions without problems.
 > 
 > diff -Nru a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
 > --- a/drivers/net/tulip/tulip_core.c	Sun May 11 12:14:32 2003
 > +++ b/drivers/net/tulip/tulip_core.c	Sun May 11 12:14:32 2003
 > @@ -223,6 +223,7 @@
 >  	{ 0x1626, 0x8410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 >  	{ 0x1737, 0xAB09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 >  	{ 0x17B3, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 > + 	{ 0x10b9, 0x5261, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DM910X },	/* ALi 1563 integrated ethernet */
 >  	{ } /* terminate list */
 >  };
 >  MODULE_DEVICE_TABLE(pci, tulip_pci_tbl);

 ...
  
 >  #if defined(__sparc__)
 >          /* DM9102A needs 32-dword alignment/burst length on sparc - chip bug? */
 > -        if (pdev->vendor == 0x1282 && pdev->device == 0x9102)
 > +	if ((pdev->vendor == 0x1282 && pdev->device == 0x9102)
 > +		|| (pdev->vendor == 0x10b9 && pdev->device == 0x5261))
 >                  csr0 = (csr0 & ~0xff00) | 0xe000;
 >  #endif

Integrated ALi 1563 on a sparc ?

		Dave

