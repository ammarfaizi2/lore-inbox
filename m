Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267272AbRGKLCB>; Wed, 11 Jul 2001 07:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267273AbRGKLBv>; Wed, 11 Jul 2001 07:01:51 -0400
Received: from mail.teraport.de ([195.143.8.72]:44160 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S267272AbRGKLBm>;
	Wed, 11 Jul 2001 07:01:42 -0400
Message-ID: <3B4C3211.79A07C5A@TeraPort.de>
Date: Wed, 11 Jul 2001 13:01:37 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Patrick Mochel <mochel@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        saw@saw.sw.com.sg
Subject: Re: 2.4.6.-ac2: Problems with eepro100
In-Reply-To: <Pine.LNX.3.96.1010709163526.15260A-100000@mandrakesoft.mandrakesoft.com>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/11/2001 01:01:30 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/11/2001 01:01:37 PM,
	Serialize complete at 07/11/2001 01:01:37 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> On Mon, 9 Jul 2001, Kai Germaschewski wrote:
> 
> > On Mon, 9 Jul 2001, Patrick Mochel wrote:
> >
> 
> Do a register dump of working and dead-after-PM-transition, including
> PCI config registers, and look for differences.  Also look for
> differences in your host and PCI-PCI bridge PCI config registers.

 Instructions on how to do the dumps? Sorry, I have not been that deep
into these matters until now :-)

 Just as an experiment, I modified the 246-ac2 eepro100.c driver to
never set the devive into D2 mode. As a result, I can now ifconfig
down/up as much as I want without killing the network. So I guess it is
really PM related.

*** eepro100.c-ac2      Mon Jul  9 12:30:53 2001
--- eepro100.c  Wed Jul 11 12:47:07 2001
***************
*** 780,782 ****
        /* Put chip into power state D2 until we open() it. */
!       pci_set_power_state(pdev, 2);
 
--- 780,782 ----
        /* Put chip into power state D2 until we open() it. */
!       pci_set_power_state(pdev, 0); /*MKN*/
 
***************
*** 1835,1837 ****
 
!       pci_set_power_state(sp->pdev, 2);
 
--- 1835,1837 ----
 
!       pci_set_power_state(sp->pdev, 0); /* MKN */


Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
