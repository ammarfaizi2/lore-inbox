Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130191AbRBZHjO>; Mon, 26 Feb 2001 02:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130194AbRBZHjD>; Mon, 26 Feb 2001 02:39:03 -0500
Received: from isunix.it.ilstu.edu ([138.87.124.103]:61956 "EHLO
	isunix.it.ilstu.edu") by vger.kernel.org with ESMTP
	id <S130191AbRBZHit>; Mon, 26 Feb 2001 02:38:49 -0500
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <200102260728.BAA28731@isunix.it.ilstu.edu>
Subject: Re: IDE not fully found (2.4.2) PDC20265
To: andre@linux-ide.org (Andre Hedrick)
Date: Mon, 26 Feb 2001 01:28:54 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101152228320.12967-100000@master.linux-ide.org> from "Andre Hedrick" at Jan 15, 2001 10:29:13 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 15 Jan 2001, Tim Hockin wrote:
> 
> > Motherboard (MSI 694D-AR) has Via Apollo Pro chipset, those IDE drives seem
> > fine.  Board also has a promise PDC20265  RAID/ATA100 controller.  On each
> > channel of this controller I have an IBM 45 GB ATA100 drive as master.
> > (hde and hdg).  BIOS sees these drives fine.  Linux only see hde and never
> > hdg (ide[012] but not ide3).  I thought I'd post it here, in case anyone

So I have a clue - pci-ide.c is looking at a PCI register to determine if
ide channels are enabled.  It seems that the BIOS on this board is not
enabling the second channel of the promise controller in this register.
There are other "enabled" bits, apparently.  pdc202xx.c checks some IO
registers from one of the base addresses to determine status.

Unfortunately, the enabled bit of this register seems to be
write-protected.  There must be an unlock bit in another register.  Anyone
have a datasheet for a pdc202x?  How do I unprotect PCI reg 0x50 

If I bypass the test for the enabled bit in ide-pci.c, I get all my drives
properly.  

Tim
