Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVCVJ7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVCVJ7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVCVJ7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:59:10 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:37338 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262591AbVCVJ7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:59:05 -0500
From: Michael Stickel <michael.stickel@4g-systems.biz>
To: ppopov@embeddedalley.com
Subject: Re: Bitrotting serial drivers
Date: Tue, 22 Mar 2005 10:58:35 +0100
User-Agent: KMail/1.7
Cc: Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050320224028.GB6727@linux-mips.org> <423DFE7C.7040406@embeddedalley.com>
In-Reply-To: <423DFE7C.7040406@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503221058.35903.michael.stickel@4g-systems.biz>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:f72049c8971f462876d14eb8b3ccbbf1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we leave the driver for the au1x00 as it is it should not have the 
register_serial / unregister_serial functions and it should be renamed to 
something else, e.g. ttySAxxx like it is done for the internal serial port of 
the strongarm (sa1100).

I have thought about the serial driver and came along this.
I we take a look at the hardware, we have a chip, the 8250 and its successors 
and the chip is integrated into some kind of hardware. So the chip has an 
interface. It has some address lines for register access, it has data lines 
and some controll lines. It also has an interrupt pin, some (GP)IO-Pins, that 
are freely programmable and a clock input.  The chip is integrated thru some 
interface as I mentioned before. It can be an ISA-IO card or a PCI card or a 
multiport card, where more than one chip is accessed thru the same io-range 
and the hip to access is selected thru a single register. The au1x00 serial 
driver is like an ISA card except that the chip is mapped to a memory region 
instead of an io-region and the fact, that we can calculate the baud_base 
using the pll configuration of the au1x00, if we assume a 12MHz oscilator, 
which is standard for the au1x00.

We need some access methods to access the chip registers, some way to handle 
intterupts, some way to deal with the gpio-pins, and we need a way to get the 
clock input of the chip. What should the serial-chip driver know about and 
what should the card driver know about.

It's like the streams concept, where the chip driver does not know how to 
access the chip or what resources it uses, but what to do with the chip.

Regards,
Michael
