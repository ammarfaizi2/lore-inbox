Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbUKKE3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbUKKE3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 23:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbUKKE3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 23:29:50 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:20693 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262097AbUKKE3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 23:29:43 -0500
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Message-Id: <200411110429.iAB4Teq16832@inv.it.uc3m.es>
Subject: Re: kernel analyser to detect sleep under spinlock
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Thu, 11 Nov 2004 05:29:40 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@inv.it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" <ptb@inv.it.uc3m.es> wrote in message news:<2Y9DE-4Tb-7@gated-at.bofh.it>...

(scanning for abuses of spinlocks in the kernel source)

>  ftp://oboe.it.uc3m.es/pub/Programs/c-1.2.tgz
> 
> To use the application, compile and then use "c" in place of
> "gcc" on a typical kernel compile line.

I've added some extra support for gcc 3.4.0 (which seems to use some
special builtin types such as __builtin_va_list that gcc 2.95.4 does
not generate) and put up the new archive at
    
  ftp://oboe.it.uc3m.es/pub/Programs/c-1.2.1.tgz

Please tell me of any parse rejects with 2.4 kernel files. I'll be very
happy to make the usually trivial parser additions required to scan the
gnuish C involved! I simply have only tried a few dozen kernel source
files myself and so don't have a complete picture of every weird extension
usage out there in the source.

I'll also start going through 2.6 kernel files to see if anything more is
needed for those. 

To remind you what this utility detects:

> Here's some typical output ...
> 
>  % ./c -D__KERNEL__ -DMODULE \
>    -I/usr/local/src/linux-2.4.25-xfs/include ../dbr/1/sbull.c
>  *************** sleepy functions *******************************
>  *       function                line    calls
>  *
>  * - /usr/local/src/linux-2.4.25-xfs/include/linux/smb_fs_sb.h
>  *       smb_lock_server         63      down
>  *
>  * - /usr/local/src/linux-2.4.25-xfs/include/linux/fs.h
>  *       lock_parent             1624    down
>  *       double_down             1647    down
>  *       triple_down             1668    down
>  *       double_lock             1718    double_down
>  *
>  * - /usr/local/src/linux-2.4.25-xfs/include/linux/locks.h
>  *       lock_super              38      down
>  *
>  * - ../dbr/1/sbull.c
>  *       sbull_ioctl             171     interruptible_sleep_on
>  *
>  * - /usr/local/src/linux-2.4.25-xfs/include/linux/blk.h
>  *       sbull_request           358     interruptible_sleep_on
>  *
>  * - ../dbr/1/sbull.c
>  *       sbull_init              431     kmalloc
>  *       sbull_init              431     kfree
>  *       sbull_cleanup           542     kfree
>  *
>  ****************************************************************
>  *************** sleep_under_spinlock ****************************
>  *       function                line    calls
>  *
>  * - ../dbr/1/sbull.c
>  *       sbull_request           420     interruptible_sleep_on
>  *
>  *
>  * *** found 1 instances of sleep under spinlock ***
>  *
>  ***********************************************
> 
> It's GPL/LGPL.
 

Peter (ptb@inv.it.uc3m.es)

