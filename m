Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129126AbRBCSC7>; Sat, 3 Feb 2001 13:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbRBCSCt>; Sat, 3 Feb 2001 13:02:49 -0500
Received: from mail.mbi-berlin.de ([194.95.11.12]:15352 "EHLO
	mail.mbi-berlin.de") by vger.kernel.org with ESMTP
	id <S129126AbRBCSCq>; Sat, 3 Feb 2001 13:02:46 -0500
Message-ID: <3A7C45E4.15C470A3@informatik.hu-berlin.de>
Date: Sat, 03 Feb 2001 18:54:44 +0100
From: Viktor Rosenfeld <rosenfel@informatik.hu-berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG?] ISA-PnP and 3c509 NIC won't work together
Content-Type: multipart/mixed;
 boundary="------------72BEB5C842A45375AE93E0CD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------72BEB5C842A45375AE93E0CD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi kernel hackers,

I have troubles getting both ISA-PnP and the driver for my 3c509 NIC
working together.  Here are the error messages I get:

Kernel 2.4.1 with ISA-PnP and 3c509 support compiled in, on boot time:
# /etc/init.d/networking start
SIOCSIFADDR: No such device
eth0: unknown interface: No such device
SIOCSIFNETMASK: No such device
SIOCSIFBRDADDR: No such device
eth0: unknown interface: No such device
eth0: unknown interface: No such device


With ISA-PnP compiled in, and 3c509 support compiled as module:
# modprobe 3c509
/lib/modules/2.4.1/kernel/drivers/net/3c509.o: invalid parameter parm_io
/lib/modules/2.4.1/kernel/drivers/net/3c509.o: insmod
/lib/modules/2.4.1/kernel/drivers/net/3c509.o failed
/lib/modules/2.4.1/kernel/drivers/net/3c509.o: insmod 3c509 failed


With both ISA-PnP and 3c509 compiled as modules:
# modprobe 3c509
isapnp: Scanning for Pnp cards...
isapnp: Card 'TERRATEC SOUNDSYSTEM BASE 1'
isapnp: 1 Plug & Play card detected total
/lib/modules/2.4.1/kernel/drivers/net/3c509.o: invalid parameter parm_io
/lib/modules/2.4.1/kernel/drivers/net/3c509.o: insmod
/lib/modules/2.4.1/kernel/drivers/net/3c509.o failed
/lib/modules/2.4.1/kernel/drivers/net/3c509.o: insmod 3c509
failed              
# insmod /lib/modules/2.4.1/kernel/drivers/net/3c509.o
/lib/modules/2.4.1/kernel/drivers/net/3c509.o: unresolved symbol
isapnp_find_dev_Rb2fa20db


I can only get my NIC to work when I leave ISA-PnP completely out of the
kernel.  When I have ISA-PnP activated, the card will not show up in
/proc/isapnp (see below) nor is it listed in the table that my system
displays prior to starting LILO.  The kernel help on the 3c509 driver
suggests to completely deactivate PNP for the NIC, which is what I have
done since kernel 2.0.x.  Unfortunately, I can't find info on
re-enabling PNP on the card.

Below, I have attached the content of /proc/isapnp.  If I can do
anything to provide more info, let me know.

Thanks for a great kernel,
Viktor
-- 
Viktor Rosenfeld
WWW: http://www.informatik.hu-berlin.de/~rosenfel/
Geek Code (3.1):
  GCS/SS d-@ s+: a20 C++@ UL++$ P+ L+++ E--- W++ N++ o? K? !W O? M? V?
  PS++@ PE+(-) Y+ P?(+++) t+ 5+ X- R? !tv b+ DI+ D- G e>+++ h-- r- !y+
--------------72BEB5C842A45375AE93E0CD
Content-Type: text/plain; charset=us-ascii;
 name="isapnp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isapnp"

Card 1 'TER1411:TERRATEC SOUNDSYSTEM BASE 1' PnP version 1.0 Product version 1.1
  Logical device 0 'ADS7180:Unknown'
    Supported registers 0x2
    Device is not active
    Resources 0
      Priority preferred
      Port 0x220-0x220, align 0x1f, size 0x10, 16-bit address decoding
      Port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
      Port 0x530-0x530, align 0x7, size 0x10, 16-bit address decoding
      IRQ 5 High-Edge
      DMA 1 8-bit byte-count type-A
      DMA 3 8-bit byte-count type-A
      Alternate resources 0:1
        Priority acceptable
        Port 0x220-0x240, align 0x1f, size 0x10, 16-bit address decoding
        Port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
        Port 0x530-0x530, align 0xf, size 0x10, 16-bit address decoding
        IRQ 5,7 High-Edge
        DMA 0,1,3 8-bit byte-count type-A
        DMA 0,1,3 8-bit byte-count type-A
      Alternate resources 0:2
        Priority functional
        Port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
        Port 0x388-0x3b8, align 0x7, size 0x4, 16-bit address decoding
        Port 0x500-0x560, align 0xf, size 0x10, 16-bit address decoding
        IRQ 5,7,10 High-Edge
        DMA 0,1,3 8-bit byte-count type-A
        DMA 0,1,3 8-bit byte-count type-A
      Alternate resources 0:3
        Priority functional
        Port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
        Port 0x388-0x3b8, align 0x7, size 0x4, 16-bit address decoding
        Port 0x500-0x620, align 0xf, size 0x10, 16-bit address decoding
        IRQ 5,7,10,11 High-Edge
        DMA 0,1,3 8-bit byte-count type-A
        DMA <none> 8-bit byte-count type-A
      Alternate resources 0:4
        Priority functional
        Port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
        Port 0x388-0x3b8, align 0x7, size 0x4, 16-bit address decoding
        Port 0x500-0x620, align 0xf, size 0x10, 16-bit address decoding
        IRQ 5,7,2/9,10,11,15 High-Edge
        DMA 0,1,3 8-bit byte-count type-A
        DMA <none> 8-bit byte-count type-A
  Logical device 1 'ADS7181:Unknown'
    Supported registers 0x2
    Compatible device PNPb006
    Device is not active
    Resources 0
      Priority preferred
      Port 0x330-0x330, align 0xf, size 0x2, 16-bit address decoding
      IRQ 2/9 High-Edge
      Alternate resources 0:1
        Priority acceptable
        Port 0x300-0x330, align 0xf, size 0x2, 16-bit address decoding
        IRQ 2/9 High-Edge
      Alternate resources 0:2
        Priority functional
        Port 0x300-0x330, align 0xf, size 0x2, 16-bit address decoding
        IRQ 2/9,10,11,15 High-Edge
  Logical device 2 'ADS7182:Unknown'
    Supported registers 0x2
    Compatible device PNPb02f
    Device is not active
    Resources 0
      Priority preferred
      Port 0x200-0x200, align 0x7, size 0x8, 16-bit address decoding
      Alternate resources 0:1
        Priority acceptable
        Port 0x200-0x208, align 0x7, size 0x8, 16-bit address decoding
  Logical device 3 'TER2211:Unknown'
    Supported registers 0x2
    Device is not active
    Resources 0
      Priority preferred
      Port 0x590-0x590, align 0x7, size 0x8, 16-bit address decoding
      Alternate resources 0:1
        Priority acceptable
        Port 0x590-0x5a8, align 0x7, size 0x8, 16-bit address decoding
      Alternate resources 0:2
        Priority functional
        Port 0x590-0x5c8, align 0x7, size 0x8, 16-bit address decoding

--------------72BEB5C842A45375AE93E0CD--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
