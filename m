Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbRGKLoF>; Wed, 11 Jul 2001 07:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbRGKLno>; Wed, 11 Jul 2001 07:43:44 -0400
Received: from mail.teraport.de ([195.143.8.72]:47232 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S267282AbRGKLnh>;
	Wed, 11 Jul 2001 07:43:37 -0400
Message-ID: <3B4C3BE4.324B3264@TeraPort.de>
Date: Wed, 11 Jul 2001 13:43:32 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: mike@tuxnami.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kai@tp1.ruhr-uni-bochum.de, jgarzik@mandrakesoft.com
Subject: Re: Problems with eepro100 and kernel 2.4.6
In-Reply-To: <3B4C1E5B.C859CF6D@TeraPort.de>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/11/2001 01:43:25 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/11/2001 01:43:32 PM,
	Serialize complete at 07/11/2001 01:43:32 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch wrote:
> 
> >I have just upgraded from Linux Kernel 2.4.5 to 2.4.6 and I have a small annoying problem with >the eepro100 driver. Every time I put my system into an APM suspend and
> >then resume the machine, the driver stops working and will not let me bring up the interface >until I remove the module and reinstall it. I am using the exact same config as I
> >did in 2.4.5. Computer is a Compaq Armada M700. I inserted in this message what I do at the >command line and my syslog. It's not a big issue, just something that is a little
> >annoying.
> >
> >Mike Crawford
> Mike,
> 
>  this one maybe related to the report I did on Monday (2.4.6.-ac2:
> Problems with eepro100), although my problems only started (surfaced)
> when going from 2.4.6-ac1 to -ac2. What kind of system do you have?
> Laptop? Which make?
> 
> Martin

Mike,

 could you just check out this small patch? It disables putting the
eepro100 into D2 mode at all. Not a solution, but maybe a hint if it
scares away the problem.


% linux-2.4.6-ac2/drivers/net > diff -rc1 eepro100.c-orig eepro100.c***
eepro100.c-orig     Wed Jul 11 13:39:40 2001
--- eepro100.c  Wed Jul 11 13:27:43 2001
***************
*** 1854,1856 ****
 
!       pci_set_power_state(sp->pdev, 2);
 
--- 1854,1856 ----
 
!       pci_set_power_state(sp->pdev, 0); /* MKN */


Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
