Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265945AbUGIV6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265945AbUGIV6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUGIV6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:58:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:36736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265945AbUGIV6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:58:20 -0400
Date: Fri, 9 Jul 2004 17:57:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Qiuyu Zhang <qiuyu.zhang@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: strange about copy_from_user
In-Reply-To: <c26fd828040709143843b3143f@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0407091752360.2731@chaos>
References: <c26fd828040709143843b3143f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2004, Qiuyu Zhang wrote:

> Hi all,
> I am working on writing a module driver.
>
> I am trying to use API copy_from_user to copy a bunch of memory from
> user space to kernel space. I write a ioctl function to register the
> pointer of the memory to kernel. And in the ioctl function I can use
> copy_from_user to get the correct data, but the strange thing is that
> when I use copy_from_user in other kernel function such as
> dev_hard_xmit function , I cannot
> get the correct result. I don't konw what the reason is . Thx.
> -

Without looking at the code it's hard to figure out what you
may be doing. However, copy_from_user() and copy_to_user() may
not ever be executed with a spin-lock held. Generally, if
you need to put user data into kernel "things", you need
to buffer it, i.e., copy_from_user() into a kmalloc(ed) buffer,
then work with it in kernel space.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


