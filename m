Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132478AbQLQLPG>; Sun, 17 Dec 2000 06:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132456AbQLQLO5>; Sun, 17 Dec 2000 06:14:57 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:22788 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131880AbQLQLOr>; Sun, 17 Dec 2000 06:14:47 -0500
Date: Sun, 17 Dec 2000 10:44:09 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Rasmus Andersen <rasmus@jaquet.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] link time error in drivers/mtd (240t13p2) 
In-Reply-To: <1875.977049144@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0012171039400.14423-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2000, Keith Owens wrote:

> Messing about with conditional compilation because the link order is
> incorrect is the wrong fix.  The mtd/Makefile must link the objects in
> the correct order.

The conditional compilation is far more obvious to people than subtle
issues with link order. So I prefer to avoid the latter at all costs.

I have to have some conditional compilation in my tree to allow it to
compile under 2.0 uClinux. Admittedly that doesn't have to get into 2.4,
but I obviously prefer the code in 2.4 to be as close to my working copy
as possible.

I'll poke at it and try to come up with a cleaner solution. It may be that
I can shift all the conditional stuff off into the compatmac.h and leave
the 'real' code path in a cleaner state than the current one.

> 2.4.0-test13-pre2 almost does that, the only obvious problem is that
> cfi_probe appears before cfi_cmdset.  Move cfi_probe to link after
> cfi_cmdset, do you still get link order problems with the 2.4.0-test11
> version of include/linux/mtd.h?

I haven't had problems. But the possibility exists.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
