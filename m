Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269219AbRGaJ0m>; Tue, 31 Jul 2001 05:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269226AbRGaJ0b>; Tue, 31 Jul 2001 05:26:31 -0400
Received: from mail.teraport.de ([195.143.8.72]:33155 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S269219AbRGaJ0T>;
	Tue, 31 Jul 2001 05:26:19 -0400
Message-ID: <3B6679B6.25B1D759@TeraPort.de>
Date: Tue, 31 Jul 2001 11:26:14 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: pworach@mysun.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: eepro100 2.4.7-ac3 problems (apm related)
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/31/2001 11:25:33 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/31/2001 11:25:47 AM,
	Serialize complete at 07/31/2001 11:25:47 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> eepro100 2.4.7-ac3 problems (apm related)
> 
> 
> Hi!
> 
> The eepro100 interface in my Fujitsy/Siemens Lifebook S-4546
> won't come up after a suspend, if I unload the module and load it again
> it works fine...
> "ioctl SIOCSIFFLAGS: No such device" is the error message.
> 
> This happend in 2.4.5 i think.
> 
> /Pawel
> 

 same here with an eepro100 inside a IBM Thinkpad570. Happened with
2.4.6-ac2. Since then I apply the appended patch after installing "-ac"
stuff. This completely disables power state handling for the device. Not
very clean, but I do not care in this particular case. It probably shows
a more principal issue with the eepro100. Kai - did you look deeper into
the issue?

Martin


diff -rc2 eepro100.c eepro100.c-ac3-orig
*** eepro100.c  Tue Jul 31 11:21:26 2001
--- eepro100.c-ac3-orig Tue Jul 31 11:20:56 2001
***************
*** 779,783 ****
 
        /* Put chip into power state D2 until we open() it. */
!       pci_set_power_state(pdev, 0); /* MKN */
 
        pci_set_drvdata (pdev, dev);
--- 779,783 ----
 
        /* Put chip into power state D2 until we open() it. */
!       pci_set_power_state(pdev, 2);
 
        pci_set_drvdata (pdev, dev);
***************
*** 1834,1838 ****
                printk(KERN_DEBUG "%s: %d multicast blocks dropped.\n",
dev->name, i);
 
!       pci_set_power_state(sp->pdev, 0); /* MKN */
 
        MOD_DEC_USE_COUNT;
--- 1834,1838 ----
                printk(KERN_DEBUG "%s: %d multicast blocks dropped.\n",
dev->name, i);
 
!       pci_set_power_state(sp->pdev, 2);
 
        MOD_DEC_USE_COUNT;

-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
