Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276745AbRJKTT1>; Thu, 11 Oct 2001 15:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276738AbRJKTSs>; Thu, 11 Oct 2001 15:18:48 -0400
Received: from radium.jvb.tudelft.nl ([130.161.76.91]:18191 "HELO
	radium.jvb.tudelft.nl") by vger.kernel.org with SMTP
	id <S276702AbRJKTSk>; Thu, 11 Oct 2001 15:18:40 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
Date: Thu, 11 Oct 2001 21:19:19 +0200
Message-ID: <003301c15289$a03130a0$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <E15rjR4-000400-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked a bit deeper. In linux-2.4.10-ac11/drivers/net/eepro100.c:

line 802:
       if ((pdev->device=0x2449) || ( (pdev->device > 0x1030) &&
(pdev->device < 0x1039) )) 
               sp->chip_id = 1;

line 1358:
        /* workaround for hardware bug on 10 mbit half duplex */

        if ((sp->partner==0) && (sp->chip_id==1)) {
                wait_for_cmd_done(ioaddr + SCBCmd);
                outb(0 , ioaddr + SCBCmd);
        }

Maybe we need another device id at line 802? The work-around seems to
stay untriggered this way.
 
My device's id is: 	8086:1229 - Intel, 82557 [Ethernet Pro 100]
The present ids are: 	8086:1030 - 82559 InBusiness 10/100
				8086:1031-1039 - are not listed in my db
				8086:2449 - 82820 820 (Camino 2) Chipset
Ethernet

For one thing, in Linus' 2.4.12 the if condition at line 802 isn't
present at all, so that sure isn't gonna work.

Regards,
- Robbert

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
> Sent: donderdag 11 oktober 2001 19:16
> To: Robbert Kouprie
> Cc: 'John Gluck'; linux-kernel@vger.kernel.org
> Subject: Re: eepro100.c bug on 10Mbit half duplex (kernels 
> 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
> 
> 
> > files. It would always lockup after said amount of traffic, 
> but only in
> > 10 Mbit half duplex mode. Also, I have the 82557, not the 
> 82558 chip.
> > 
> > The problem looks a lot like what should be fixed in this 
> changelog line
> > from 2.4.9-ac13:
> 
> Check the workaround is being activated for your eepro100..
> 

