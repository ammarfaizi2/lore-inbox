Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267930AbUJGTPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267930AbUJGTPa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUJGTNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:13:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4992 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267851AbUJGTMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:12:19 -0400
Date: Thu, 7 Oct 2004 15:12:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephen Hemminger <shemminger@osdl.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Probable module bug in linux-2.6.5-1.358
In-Reply-To: <1097175903.29576.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0410071507080.3586@chaos.analogic.com>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
 <1097175903.29576.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Stephen Hemminger wrote:

> Since you want to play fast and loose with the GPL and modules
> licensing, I see no reason to help you debug your problem.
>
> If you can reproduce the same problem with some GPL version of
> standalone (even dummy) code, then come back and see us sometime.
>

Well it isn't my problem. It's a kernel problem that only exists
in 2.6.n kernels. Versions 2.4.x work fine. And what are you
bitching for? You have the entire source-code.

Further, it exists in a dummy driver that impliments a dummy
open(), close(), and ioctl().

Once a character-device module is installed, then removed. If
you attempt to open() the module again, instead of the kernel
reloading it, it crashes. The last thing executed is
sys_open(). It should have stopped at chrdev_open(), but
the code is broken.


> --------------
> /*
> *   Since some in the Linux-kernel development group want to play
> *   lawyer, and require that a GPL License exist for every kernel
> *   module,  I provide the following:
> *
> *   Everything in this file (only) is released under the so-called
> *   GNU Public License, incorporated herein by reference.
> *
> *   Now, we just link this with any proprietary code and everybody
> *   but the lawyers are happy.
> */
> #ifndef __KERNEL__
> #define __KERNEL__
> #endif
> #ifndef MODULE
> #define MODULE
> #endif
> #include <linux/module.h>
> #if defined(MODULE_LICENSE)
> MODULE_LICENSE("GPL");
> #endif
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

