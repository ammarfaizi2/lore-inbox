Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290448AbSBKU7V>; Mon, 11 Feb 2002 15:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290445AbSBKU7M>; Mon, 11 Feb 2002 15:59:12 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:22038 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290421AbSBKU66>; Mon, 11 Feb 2002 15:58:58 -0500
Date: Mon, 11 Feb 2002 15:57:49 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200202112057.g1BKvnE03302@devserv.devel.redhat.com>
To: jh@sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: driver location for platform-specific drivers
In-Reply-To: <mailman.1013455503.17805.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1013455503.17805.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For SGI's upcoming Linux platform (nicknamed Scalable Node, or SN),
> we have some platform specific device drivers.  Where should these go?

>     1) Integrate in drivers/*.

I'd do this, unless you have dozens of them.
E.g. drivers/net/sunhme.c.

>     2) Company (sgi) directory.

That's nonsense, IMHO.

>     3) New platform directory.
>        Create a platform directory for SN, probably drivers/sn.
>        There is precedence for this with the drivers/macintosh
>        and drivers/s390.

I think this is only done if API is different. Often these
directories cannot be processed by a build process on other
architectures, so they are kept outside to have Makefiles smaller.
See also drivers/sbus, which could be called "drivers/sun" just
as well. But really, it's separate because of sparc_alloc_io().

I appreciate a lot that drivers/acpi is so easy to exclude
from builds - it breaks on anything but Intel stuff.

>     4) New architecture directory.
>        Another suggestion is to create an architecture directory,
>        in this case drivers/ia64/{char,net,etc.}/.

See #3. The ia64 uses standard APIs.

> I'm happy with whatever you'll accept.

Yeah, lessee what penguins say, and also I think DaveM may
lend some good expirience here.

-- Pete
