Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267997AbRH0UDA>; Mon, 27 Aug 2001 16:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268133AbRH0UCx>; Mon, 27 Aug 2001 16:02:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17161 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268071AbRH0UCo>; Mon, 27 Aug 2001 16:02:44 -0400
Subject: Re: DOS2linux
To: Bart.Vandewoestyne@pandora.be (Bart Vandewoestyne)
Date: Mon, 27 Aug 2001 21:06:21 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B8AA1EC.9ECD94BD@pandora.be> from "Bart Vandewoestyne" at Aug 27, 2001 09:39:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bSeL-0004b3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) set AX register to 0xd800
> 2) set slot number to DiSC_Id.slot, (eg. 1 in my case -> base is
> 0x1000)
> 3) set function number to read
> 4) assign a 320-byte buffer for standard configuration data block
> 5) execute a software interrupt via the DOS specific int86x function,
> this puts configuration data into the 320-byte buffer.
> 6) check if we get a valid return
> 7) if we have a valid situation, assign values from the configuration
> block to DiSC_Id.it (it level) and DiSC_Id.dma (dma level)

Oh god, thats the deep magic EISA weirdness department

> On http://www.ctyme.com/intr/rb-1641.htm I can see that this is all
> about reading data from an EISA SYSTEM ROM.  I can't imagine there
> doesn't exist some linux-API that allows me to do just the same.

Well actually its one of those things that needs writing cleanly but 
currently appears in its own form in some EISA drivers

EISA slots are I/O mapped at 0x1000, 0x2000, 0x3000, 0x4000 -> 0x8000
The ID port is at base+0xc80
Configuration data follows at base+0xc84, 0xc88 ...

I would assume the 320 byte buffer is providing this same data block, and
maybe more but I don't know the details. I thought EISA boards had gone
away

Alan
