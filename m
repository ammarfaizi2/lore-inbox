Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276920AbRJKVCf>; Thu, 11 Oct 2001 17:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276922AbRJKVCZ>; Thu, 11 Oct 2001 17:02:25 -0400
Received: from radium.jvb.tudelft.nl ([130.161.76.91]:5124 "HELO
	radium.jvb.tudelft.nl") by vger.kernel.org with SMTP
	id <S276920AbRJKVCN>; Thu, 11 Oct 2001 17:02:13 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
Date: Thu, 11 Oct 2001 23:02:53 +0200
Message-ID: <000001c15298$17f03790$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <E15rlb9-0004QK-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Your fix seems to have eliminated the problem. I found this strange, as
the device ids still did not match mine. So I added a PRINTK line in the
test, and found that _with_ your fix it DOES NOT get triggered. The ac
kernel WITH the bug however DOES trigger the test. 

So, as I have tested both your and Linus' driver (in which the whole
"if" was missing), one has to conclude that both the bug in de ac driver
AND the whole missing line in Linus' kernel made the test succeed, where
is actually SHOULD NOT succeed. So actually my NIC is perfectly ok, but
not in combination with a workaround for a bug it doesn't have ;) This
was what broke things.

So, the 10Mbit half-duplex workaround breaks stuff on the devices that
do not suffer from the bug. This is dangerous... ;)

Anyway, I'm upgraded to 100Mbit now, and the bug is fixed, so I'm happy
:)
Thanx for your help.

Regards,
- Robbert

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
> Sent: donderdag 11 oktober 2001 21:34
> To: Robbert Kouprie
> Cc: 'Alan Cox'; linux-kernel@vger.kernel.org
> Subject: Re: eepro100.c bug on 10Mbit half duplex (kernels 
> 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
> 
> 
> >        if ((pdev->device=0x2449) || ( (pdev->device > 0x1030) &&
>                       ^^^^^^^
> 
> Well thats a bug (just fixed)
> 
> > My device's id is: 	8086:1229 - Intel, 82557 [Ethernet Pro 100]
> > The present ids are: 	8086:1030 - 82559 InBusiness 10/100
> > 				8086:1031-1039 - are not listed in my db
> > 				8086:2449 - 82820 820 (Camino 2) Chipset
> > Ethernet
> > 
> > For one thing, in Linus' 2.4.12 the if condition at line 802 isn't
> > present at all, so that sure isn't gonna work.
> 
> Try enabling the test regardless and seeing if it helps on your box
> 
> 

