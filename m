Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIRrp>; Tue, 9 Jan 2001 12:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAIRrf>; Tue, 9 Jan 2001 12:47:35 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22029 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129324AbRAIRra>; Tue, 9 Jan 2001 12:47:30 -0500
Subject: Re: wavelan has fatal error with 2.4.0 (but worked in 2.4.0-test12)
To: jt@hpl.hp.com
Date: Tue, 9 Jan 2001 17:48:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rutt@chezrutt.com (John Ruttenberg),
        linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <20010109094217.A30225@bougret.hpl.hp.com> from "Jean Tourrilhes" at Jan 09, 2001 09:42:17 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14G2t8-00074Q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It is a bug in the driver.
> 
> 	Please check again the code and point me the invalid
> udelay(). You will realise that there is no delay in the driver that
> is longer than 100ms.

The udelay limit is set a lot lower than 100mS. It has to be somewhat lower
otherwise you have to do two levels of loops which will throw small udelay
timings a fair whack.

> 	The bug is that udelay() can't be passed a variable but only a
> constant. Therefore bug in udelay().

Sounds like a compiler bug.

#define udelay(n) (__builtin_constant_p(n) ? \
	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
	__udelay(n))

non constants are covered.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
