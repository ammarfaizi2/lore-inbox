Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271924AbRIMRaA>; Thu, 13 Sep 2001 13:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271921AbRIMR3l>; Thu, 13 Sep 2001 13:29:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3333 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271913AbRIMR32>; Thu, 13 Sep 2001 13:29:28 -0400
Subject: Re: some possible bugs around (race conditions etc.)
To: martin.macok@underground.cz (=?iso-8859-2?Q?Martin_Ma=E8ok?=)
Date: Thu, 13 Sep 2001 18:34:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010913190741.A8184@sarah.kolej.mff.cuni.cz> from "=?iso-8859-2?Q?Martin_Ma=E8ok?=" at Sep 13, 2001 07:07:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15haNR-0006xR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel/capability.c:
> 59-63, 91-93, 203-206: SMP race, possible fix: rwlock

Looks ok to me 

> kernel/exit.c:
> 485: sys_exit doesn't return anything (nor long type)
>         why it isn't void ?

Syscall return - its to keep syscall wrappers happy no more

> kernel/fork.c:
> 586: isn't memcpy() more effective?

gcc will do that magic itself

>     if (old_acct)
> 

Nope. old_acct is saved carefulyl so it seems ok

> kernel/sys.c:
> 1217: mixed signed/unsigned - doesn't it return EINVAL even when it
>         shouldn't?

It returns ok when it shouldnt - fixed

> 428: why wmb() ?

So the other CPUs cant see the priviledge change before dumpable clear

> 1323: is this needed on UP?

Not really

> 603:  is this correct on SMP? shouldn't there be some penalty
>         accounted for being "randomly" woken/run?

No

> kernel/kmod.c
> 211: shouldn't module_name be tested a bit?

modprobe checks
