Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131320AbRC3KB3>; Fri, 30 Mar 2001 05:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131289AbRC3KBT>; Fri, 30 Mar 2001 05:01:19 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:4182 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131270AbRC3KBH>; Fri, 30 Mar 2001 05:01:07 -0500
Date: Fri, 30 Mar 2001 04:00:04 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Chris Funderburg <chris@directcommunications.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: memcpy in 2.2.19
In-Reply-To: <CHEEIAEEAIFDOCGJIAKPOEDCCJAA.chris@directcommunications.net>
Message-ID: <Pine.LNX.3.96.1010330035203.8826H-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2001, Chris Funderburg wrote:
> What's wrong with this picture:
> ld -m elf_i386 -T /usr/src/kernel/stable/linux/arch/i386/vmlinux.lds -e
[...]
>         -o vmlinux
> drivers/scsi/scsi.a(aic7xxx.o): In function `aic7xxx_load_seeprom':
> aic7xxx.o(.text+0x116bf): undefined reference to `memcpy'
> make: *** [vmlinux] Error 1
> 
> Is this something outside the kernel tree that I've lost?  Seems a bit weird
> since memcpy must be
> used in thousands of other place.

It's even more strange because memcpy is not called at all from that
routine.  <insert Twilight Zone music>

Generally when this occurs, someone is using a gcc feature to copy a
structure, instead of calling memcpy directly.  Since the kernel is
sometimes compiled with -fno-builtins, and since we also have our own
kernel memcpy, using this particular gcc feature often runs into
problems.

It's not obvious from the code that this is going on, but it's one
possible cause.

Can you try the new aic7xxx driver?  Just search any linux-kernel mail
archive for Justin Gibbs, he is always [re-]posting the link to the
latest aic7xxx driver.  AFAIK it has kernel compatibility and thus
supports 2.2.x...

	Jeff



