Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132535AbQKDIVN>; Sat, 4 Nov 2000 03:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132562AbQKDIVE>; Sat, 4 Nov 2000 03:21:04 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:27895 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S132535AbQKDIU6>; Sat, 4 Nov 2000 03:20:58 -0500
Date: Sat, 4 Nov 2000 09:20:49 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.0-test9
Message-ID: <20001104092049.W7204@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.3.95.1001103213717.2705A-100000@chaos.analogic.com> <3A037E9F.55B16633@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A037E9F.55B16633@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Nov 03, 2000 at 10:12:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 10:12:31PM -0500, Jeff Garzik wrote:
> But if you are going to eliminate info->vxi_base, it seems like that
> would flush out all direct de-refs, whether they are buried in an
> obscure macro or not.  And if you find all that crap, you might as well
> use readb/writel at that point...
> 
> 	info->registers[0x7FF] = newvalue;
> 		becomes
> 	writel(newvalue, &info->registers[0x7FF]);
> and
> 	regval = info->registers[0x7FF];
> 		becomes
> 	regval = readl(&info->registers[0x7FF]);

Wasn't this the clean and recommended interface anyway? 
(ref. IO-mapping.txt:150)

I hope this will be kept, because virtually all devices map[1] their
registers continously starting at a base address. It's easy to
access for the driver writer and easy to decode for the device.

Regards

Ingo Oeser

[1] If they don't map it in IO space, which I know is differently
   accessed on some architectures.
-- 
Feel the power of the penguin - run linux@your.pc
<esc>:x
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
