Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266475AbUGKB76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266475AbUGKB76 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 21:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUGKB76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 21:59:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:39809 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266475AbUGKB74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 21:59:56 -0400
Date: Sat, 10 Jul 2004 21:59:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Qiuyu Zhang <qiuyu.zhang@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about copy_from_user/copy_to_user
In-Reply-To: <c26fd82804071013442f4c1447@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0407102153400.5590@chaos>
References: <c26fd82804071013442f4c1447@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2004, Qiuyu Zhang wrote:

> Hi all,
>
> I am working on a module driver. A user application alloc a bunch of
> memory for storing packet. And module driver can read /write data
> from/into the memory in user space. I use ioctl function to pass the
> pointer of memory of user space to module driver.  What I want to do
> is to store the pointer in kernel space and when I need to write or
> read data from memory of user space, I try to use copy_from_user or
> copy_to_user to get/put data. But I always get wrong data. I don't
> know the reason. Would you guys give me some help?
>
> Simple description of the code:
>
> device_ioctl() {
>      // get the pointer of memory of user space, and assign the
> pointer to kernel variable.
> }
>
>
>
> device_xmit(){
>      // when upper layer send a packet to this device.
>      //  I try to use the copy_from_user to get some information from
> user space buf
>      // but I cannot get correct information.
> }
>
> Thx
> -

The kernel executes functions upon behalf of the caller. The
caller's pointer is only valid when the caller calls the
kernel. At another time, the kernel has its data-segment
set to KERNEL_DS and other times set to the virtual address
space of other callers.

Anything written like you propose is likely to vomit and
take your corner of the galaxy with it. Please get a good
book about kernel device drivers first before you start.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


