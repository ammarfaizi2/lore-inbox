Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbUKMA6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbUKMA6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbUKMA4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 19:56:04 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:25280 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262708AbUKLXp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:45:56 -0500
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Message-Id: <200411122345.iACNjqt09561@inv.it.uc3m.es>
Subject: Re: kernel analyser to detect sleep under spinlock
In-Reply-To: From (env: ptb) at "Nov 11, 2004 05:29:40 am"
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Sat, 13 Nov 2004 00:45:52 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@inv.it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter T. Breuer <ptb (at) inv.it.uc3m.es> writes:
 
> I've added some extra support for gcc 3.4.0 [...]

And now kernel 2.6 files seem to be being parsed OK too.

% ./c -nostdinc -iwithprefix include -D__KERNEL__ -I/usr/local/src/linux-2.6.3/include -D__KERNEL__ -Wall -Wstrict-prototypes -Wno-trigraphs -I/usr/local/src/linux-2.6.3/include/asm-i386/mach-default -O2 -DMODULE -DKBUILD_BASENAME=nbd -DKBUILD_MODNAME=nbd /usr/local/src/linux-2.6.3/drivers/block/nbd.c
*************** sleep calls ************************************
*  function                     line    calls (locks)
*
* - /usr/local/src/linux-2.6.3/include/linux/fs.h
*  lock_super                   741     down (0)
*
* - /usr/local/src/linux-2.6.3/include/net/sock.h
*  sk_filter_release            710     kfree (0)
*
* - /usr/local/src/linux-2.6.3/drivers/block/nbd.c
*  nbd_send_req                 264     down (0)
*  do_nbd_request               510     nbd_send_req (-1)
*  nbd_ioctl                    569     nbd_send_req (-1)
*  nbd_ioctl                    574     down (0)
*
*
* *** found 0 instances of sleep under spinlock ***
*
***************************************************************




Archive at:

   ftp://oboe.it.uc3m.es/pub/Programs/c-1.2.2.tgz


GPL, LGPL, etc.

This is also useful for locating functions which can sleep, though of
course that can be done in other ways.

This utility works by applying a programming logic to the code semantics.
That bit's fine. What it's not so great at is resolving C references back
to the correct declaration, which results in under-reporting. I'll improve
that (mumbles, register actions to be carried out whenever anything
changes in the fact database instead of coding the inferences by hand). 

I'll undertake a survey of the current kernel.

Peter (ptb (at) inv.it.uc3m.es)
 
 


