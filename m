Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131617AbRAAQeC>; Mon, 1 Jan 2001 11:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131957AbRAAQdw>; Mon, 1 Jan 2001 11:33:52 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64782 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131617AbRAAQds>; Mon, 1 Jan 2001 11:33:48 -0500
Subject: Re: PATCH: __bad_udelay fixes(?) for linux-2.4.0-prerelease
To: adam@yggdrasil.com (Adam J. Richter)
Date: Mon, 1 Jan 2001 16:04:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001231213459.A17636@baldur.yggdrasil.com> from "Adam J. Richter" at Dec 31, 2000 09:34:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14D7Rq-00010O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (that is, 20 milliseconds).  I guess the purpose of this change is
> to tell driver maintainers to either take a harder look at whether they
> really need to do a busy sleep for that long (you can still do it with

It is primarily there because udelay() that long will fail. An mdelay is
an acceptable substitution. mdelay knows the delays will be bigger so the
time to do the math and a loop doesnt throw small delays

> drivers/video/atyfb.c           - An intentional 50ms delay.
> drivers/video/clgenfb.c	        - An intentional 100ms delay.
> 				  I've changed both files to keep the
> 				  delays by using mdelay instead of udelay.
> 				  Perhaps somebody could check the
> 				  approaprirate documentation and test
> 				  on real hardware to determine if the
> 				  delays really need to be this long.

Seems sane. For toshoboe in my tree I just switched it to mdelay()

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
