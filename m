Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280191AbRKFTC2>; Tue, 6 Nov 2001 14:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280101AbRKFTCX>; Tue, 6 Nov 2001 14:02:23 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:56719 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280031AbRKFTBN>; Tue, 6 Nov 2001 14:01:13 -0500
Message-ID: <3BE841C4.947416CB@t-online.de>
Date: Tue, 06 Nov 2001 21:02:12 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
CC: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
In-Reply-To: <Pine.LNX.4.33.0111051219080.29021-100000@druid.if.uj.edu.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski wrote:
> 
> On 4 Nov 2001, Thomas Hood wrote:
> >
> > Maciej: perhaps on your machine the motherboard uses 0x3f0-0x3f1
> > for some other (secret, highly classified) purpose.  Have you
> > read your hardware reference manual?
> >
> I did that before posting the previous time - beautiful over 100 page
> manual - but no mention of 03xf0-0x3f1 being special and can't find them
> in any bios setup screens either...

Diagnosis:
----------
Your PNPBIOS announces these ports:
   0c PNP0c02 Motherboard resources
        io 0x03f0-0x03f1

These ports are used by various SuperIO chips, e.g.Winbond W83877ATF:
  8.2 Extended Function Index Registers (EFIRs), Extended Function Data Registers(EFDRs)
  After the extended function mode is entered, the Extended Function Index Register (EFIR) must be
  loaded with an index value (0H, 1H, 2H, ..., or 29H) to access Configuration Register 0 (CR0),
  Configuration Register 1 (CR1), Configuration Register 2 (CR2), and so forth through the Extended
  Function Data Register (EFDR). The EFIRs are write-only registers with port address 251H or 3F0H
  (as described in section 8.0) on PC/AT systems; the EFDRs are read/write registers with port address
  252H or 3F1H (as described in section 8.0) on PC/AT systems. The function of each configuration
  register is described ...

You have to write various magic vendor defined values to
vendor defined ports to enable "extended function mode" :-)

http://home.t-online.de/home/gunther.mayer/lssuperio-0.63.tar.gz will
identify your chip sitting at 0x3f0/0x3f1 !

Solution:
---------
PnPBIOS in linux should _not_ reserve these 2 ports (this kind of
solution is commonly called a quirks).
