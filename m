Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318790AbSG0RDz>; Sat, 27 Jul 2002 13:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318791AbSG0RDz>; Sat, 27 Jul 2002 13:03:55 -0400
Received: from mallaury.noc.nerim.net ([62.4.17.82]:43021 "HELO
	mallaury.noc.nerim.net") by vger.kernel.org with SMTP
	id <S318790AbSG0RDy>; Sat, 27 Jul 2002 13:03:54 -0400
Message-ID: <3D42D33F.7020507@inet6.fr>
Date: Sat, 27 Jul 2002 19:07:11 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020702
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf <ralf@hostweb.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Driver sis5513.c / sis630(ET)
References: <200207271706.22124.ralf@hostweb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf wrote:

>Hi Lionel,
>
>the driver works well with the motherboard "ASUS TUSI-M", bios 
>revision 1015.
>
>http://www.asus.com.tw/mb/socket370/tusi-m/specification.htm
>
>This board has the SIS630ET chipset (reported as 630 by 'lspci'):
>
>00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 
>30)
>00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] 
>(rev d0)
>00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
>00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 
>10/100 Ethernet (rev 84)
>00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 
>07)
>00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 
>07)
>
>The chipset SIS630ET supports UDMA100:
>
>http://www.sis.com/products/chipsets/integrated/socket370/630chart.htm
>
>With the driver version 0.13 it is set to UDMA66 and 'hdparm -t' 
>results in 35 MB/s.
>
>With this little change in the driver source the chip is set to 
>UDMA100 and 'hdparm -t' results in 45 MB/s.
>
>-       { "SiS630",     PCI_DEVICE_ID_SI_630,   ATA_100,                
>SIS5513_LATENCY },
>+       { "SiS630",     PCI_DEVICE_ID_SI_630,   ATA_66,         
>SIS5513_LATENCY
>
>  
>

Hum, my guess would have been ATA_100a.
6xy/7xy chipsets tends to be the same IDE wise and 730 is of ATA_100a type.
ATA_100a is an evolution of the chip design based on ATA_66, ATA_100 is 
a new design (timing registers moved).
Be careful, I can't guarantee that you are using correct timings, it 
might work, but it may also throw your data by the window if you don't 
pick the right timings configuration.
I'll ask precisions to SiS engineers.

hdparm -t only test read performance, and read timings are controlled by 
the drive, the IDE controller only sets *write* timings. So hdparm 
working does not guarantee anything...
If I'm wrong, the linux-kernel mailing list is CCed, I'd be corrected in 
an eye's blink...

LB.

