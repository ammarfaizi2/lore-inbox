Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289365AbSBEKMm>; Tue, 5 Feb 2002 05:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289369AbSBEKMe>; Tue, 5 Feb 2002 05:12:34 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:24474 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S289365AbSBEKMU>; Tue, 5 Feb 2002 05:12:20 -0500
Message-ID: <3C5FB047.79FEAE1@oracle.com>
Date: Tue, 05 Feb 2002 11:13:27 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gunther Mayer <gunther.mayer@gmx.net>
CC: linux-kernel@vger.kernel.org, jdthood@yahoo.co.uk
Subject: Re: modular floppy broken in 2.5.3
In-Reply-To: <E16XU69-0005MJ-00@the-village.bc.nu> <3C5EC4E4.B5A6E84F@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunther Mayer wrote:
> 
> Alan Cox wrote:
> 
> > > It turns out this is due to the new PnPBIOS kernel config option:
> > >
> > > [asuardi@dolphin asuardi]$ grep PnPBIOS /proc/ioports
> > > 03f0-03f1 : PnPBIOS PNP0c01
> > > 0600-067f : PnPBIOS PNP0c01
> > > 0680-06ff : PnPBIOS PNP0c01
> > >   0800-083f : PnPBIOS PNP0c01
> > >   0840-084f : PnPBIOS PNP0c01
> > > 0880-088f : PnPBIOS PNP0c01
> > > f400-f4fe : PnPBIOS PNP0c01
> > >
> > > But since modular floppy was working before without setting any
> > >  ioport parameter I'm not entirely sure this is a "feature".
> >
> > Its a mix of fp and pnpbios things that need untangling. PnPBIOS should
> > register the resource as not in use, floppy should allocate the right
> 
> PNPNIOS is right to reserve PNP0C01 as "used". Else there will be hangs
> when drivers poke in io space (e.g. laptops tend to have special
> hardware which doesn't like to be touched).
> 
> PNPBIOS should not reserve 3f0/3f1 as a _workaround_ for this BIOS bug.
> 
> The BIOS probably wants to tell you there is a superio chip at 0x3f0
> (try http://home.t-online.de/home/gunther.mayer/lssuperio-0.63.tar.gz).

And here it goes...


lssuperio V0.63 (EXPERIMENTAL)

Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370, 2E, 4E ...
SMSC chip at EFER=0x3f0 key=0x55 id=09 rev=08
oldid=0x00 oldrev=0x00
 LDN 0(     FDC): io=0x3f0, irq= 6, dma= 1
 LDN 1(reserved): Disabled.
 LDN 2(reserved): Disabled.
 LDN 3(     LPT): io=0x378, irq= 7, dma=No
 LDN 4(  UART_A): io=0x3f8, irq= 4, dma=No
 LDN 5(  UART_B): io=0x3e8, io2=0x290, irq= 4, dma= 3
 LDN 6(reserved): io=0x0, irq= 8, dma=No
 LDN 7(     KBC): io=0x0, irq= 1, irq2=12, dma=No
 LDN 8(reserved): Disabled.
 LDN 9(Gameport): Disabled.
 LDN a(     PME): Disabled.
 LDN b( MPU-401): Disabled.
LPT mode=ECP FIFO thresh.=7
SMSC chip type 37n958
National Semiconductor Super-IO detection,now testing port 2E,4E,15C,26E,398 ...ITE Super-IO detection testing ports 2E,4E,279,370/371 ...
ALI Super-IO detection testing ports 370,398,3F0 ...
Intel Super-IO detection testing ports 26E, 398 ...

--alessandro

 "this machine will, will not communicate
   these thoughts and the strain I am under
  be a world child, form a circle before we all go under"
                         (Radiohead, "Street Spirit [fade out]")
