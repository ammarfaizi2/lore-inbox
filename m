Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbULMN1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbULMN1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 08:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbULMN1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 08:27:31 -0500
Received: from alog0285.analogic.com ([208.224.222.61]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262259AbULMN1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 08:27:24 -0500
Date: Mon, 13 Dec 2004 08:25:52 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Zhenyu Wu <y030729@njupt.edu.cn>
cc: quade@hsnr.de, linux-kernel@vger.kernel.org
Subject: Re: about kernel_thread!
In-Reply-To: <302945938.22534@njupt.edu.cn>
Message-ID: <Pine.LNX.4.61.0412130823410.4142@chaos.analogic.com>
References: <302945938.22534@njupt.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Zhenyu Wu wrote:

> Oh, my god. I find another problem, my linux kernel is 2.4.20, and i can't find
> the function allow_signal at all. BTW, whether there is such funcion in kernel
> 2.4.20?
>
> Thanks,
> Zhenyu Wu
>

Normally we do our own work... However, if you understand macros,
these might help you.


//
//  Copyright(c)  2004  Analogic Corporation
//
//
//  This program may be distributed under the GNU Public License
//  version 2, as published by the Free Software Foundation, Inc.,
//  59 Temple Place, Suite 330 Boston, MA, 02111.
//
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

#ifndef _CONFIG_H_
#define _CONFIG_H_
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//  Below are macros to handle different kernel versions.
//
#ifndef IRQ_HANDLED
#define IRQ_HANDLED 
typedef void irqreturn_t;
#endif

#ifdef KVER6
#define REMAP(a,b,c,d,e) remap_page_range((a), (b), (c), (d), (e))
#define __io_virt(p) ((void *)(p))
#define DAEMONIZE             \
     daemonize("%s", devname); \
     allow_signal(SIGTERM)
#define PCI_FIND_DEVICE(a,b,c) pci_get_device((a),(b),(c))
#else
#define lock_kernel()
#define unlock_kernel()
#define REMAP(a,b,c,d,e) remap_page_range((b), (c), (d), (e))
#define DAEMONIZE                          \
     exit_files(current);                   \
     daemonize();                           \
     spin_lock_irq(&current->sigmask_lock); \
     sigemptyset(&current->blocked);        \
     recalc_sigpending(current);            \
     spin_unlock_irq(&current->sigmask_lock)
#define PCI_FIND_DEVICE(a,b,c) pci_find_device((a),(b),(c))
#endif
#endif


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
