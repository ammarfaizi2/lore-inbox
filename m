Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263561AbRFAPUG>; Fri, 1 Jun 2001 11:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263557AbRFAPT5>; Fri, 1 Jun 2001 11:19:57 -0400
Received: from sun.plan9.de ([213.69.218.222]:19121 "EHLO mailout.plan9.de")
	by vger.kernel.org with ESMTP id <S263561AbRFAPTu>;
	Fri, 1 Jun 2001 11:19:50 -0400
Date: Fri, 1 Jun 2001 17:18:48 +0200
From: Marc Lehmann <pcg@goof.com>
To: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Au-Ja <doelf@au-ja.de>, Yiping Chen <YipingChen@via.com.tw>,
        support@msi.com.tw, info@msi-computer.de, support@via-cyrix.de,
        John R Lenton <john@grulic.org.ar>
Subject: Re: VIA's Southbridge bug: Latest (pseudo-)patch
Message-ID: <20010601171848.F467@cerebro.laendle>
Mail-Followup-To: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Au-Ja <doelf@au-ja.de>, Yiping Chen <YipingChen@via.com.tw>,
	support@msi.com.tw, info@msi-computer.de, support@via-cyrix.de,
	John R Lenton <john@grulic.org.ar>
In-Reply-To: <20010519110721.A1415@pua.nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20010519110721.A1415@pua.nirvana>; from Axel.Thimm@physik.fu-berlin.de on Sat, May 19, 2001 at 11:07:21AM +0200
X-Operating-System: Linux version 2.4.5 (root@cerebro) (gcc version 2.95.2.1 19991024 (release)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 11:07:21AM +0200, Axel Thimm <Axel.Thimm@physik.fu-berlin.de> wrote:
> if( KT133A || KT133 || KX133 ) {
>   if( Mainboard=="Epox 8KTA-3(+)" && BIOS>="8kt31417" )
>     return 0; /* EPOX already fixed it their way. */
> #ifdef NEW_PATCH
>   Offset 76: Set bit5=0 and bit4=1 ("every PCI master grand")
> #else /* this is already part of 2.4.4 */
>   Offset 70: Set bit1=0 ("PCI Delay Transaction = 0")

one thing I found out using triel and error is that setting "PCI Delay
Transaction" to enabled causes data corruption on WRITE to my ide drives
connected to an Promise Ultra 100 PCI controlelr (I didn't get any
corruption on the devices connected to the via ide interface, presumably
because my bios already had the right fix).

So, while the every pci master grant setting apperently fixes the internal
via ide interface corruption the PCI Delay Transaction option also must be
buggy (or my promise controller is) and causes data corruption at least
with an additional promise ultra 100.

board: asus cuv4x-d (Apollo MVP3 AGP + via686b southbridge)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
