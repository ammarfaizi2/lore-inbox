Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135568AbRDTRdD>; Fri, 20 Apr 2001 13:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135575AbRDTRcy>; Fri, 20 Apr 2001 13:32:54 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:43269 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135568AbRDTRck>; Fri, 20 Apr 2001 13:32:40 -0400
Message-ID: <3AE072E3.9D16ED6C@t-online.de>
Date: Fri, 20 Apr 2001 19:33:23 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PNP BIOS and parport_pc - dma found but not used
In-Reply-To: <Pine.LNX.4.33.0104192348510.1119-100000@portland>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:
> 
> Hello, Gunther!
> 
> On Thu, 19 Apr 2001, Gunther Mayer wrote:
> 
> > > PnPBIOS: Parport found PNPBIOS PNP0401 at io=0378,0778 irq=7 dma=-1
> >                                                                ^^^^^^ culprit !
> 
> For some reason I'm not getting that message anymore. PnPBIOS is in the
> kernel, parport_pc is a module. This time I rebooted with the parport_pc
> module already installed, as opposed to the first time when I compiled and
> inserted it without a reboot.

Did you load "insmod pnpbios" the first time (as opposed to built-in)?

> 
> I'm puzzled. Just in case, it's my .config:
> http://www.red-bean.com/~proski/linux/config
> 
> Anyway, the result is still the same, just without this message.
> 
> > 1) Search for the right two-digit PNP handle for device "0104d041":
> 
> this is 01.
> 
> >    cat /proc/bus/pnb/devices
> 
> 01      0104d041        07:01:00        0080
> 02      0105d041        07:00:02        0180
> 06      0007d041        01:02:00        0003
> 08      010cd041        05:00:00        0003
> 09      0000d041        08:00:01        0003
> 0a      0001d041        08:02:01        0003
> 0b      000bd041        08:03:01        0003
> 0c      0303d041        09:00:00        000b
> 0d      040cd041        0b:01:00        0003
> 0e      0002d041        08:01:01        0003
> 0f      0008d041        08:80:00        0003
> 10      030ad041        06:04:00        0003
> 11      020cd041        08:80:ff        0003
> 
> > 2) Send cat /proc/bus/pnp/01 | od -tx1
> 
> 0000000 2a 00 00 22 80 00 47 01 78 03 78 03 00 08 47 01
             ^^
             This is "NO DMA" (we map this in parport to -1, which means Unknown).
Your PNPBIOS is buggy, this should be "08" for dma=3


> 0000020 78 07 78 07 00 08 79 00 30 2a 0a 00 22 80 00 47
                                        ^^
                                        Possible settings are: 08|02 i.e. dma=3|1
> 0000040 01 bc 03 bc 03 00 03 47 01 bc 07 bc 07 00 03 30
> 0000060 2a 0a 00 22 80 00 47 01 78 03 78 03 00 08 47 01
> 0000100 78 07 78 07 00 08 30 2a 0a 00 22 20 00 47 01 78
> 0000120 02 78 02 00 08 47 01 78 06 78 06 00 08 38 79 00
> 0000140 79 00
> 
> Settings:
> Parallel port mode: ECP+EPP
> ECP DMA select: 3

Try to get an update for your BIOS or file a bug report to your
mainboard vendor else.
