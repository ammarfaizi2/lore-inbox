Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTJXH54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 03:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTJXH54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 03:57:56 -0400
Received: from rth.ninka.net ([216.101.162.244]:1934 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262066AbTJXH5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 03:57:54 -0400
Date: Fri, 24 Oct 2003 00:57:50 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Randall Hyde" <randyhyde@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap to Access PCI space?
Message-Id: <20031024005750.114ab4fb.davem@redhat.com>
In-Reply-To: <06d801c399df$f8af9880$6501a8c0@rhyde>
References: <102420030310.18374.4e89@comcast.net>
	<06d801c399df$f8af9880$6501a8c0@rhyde>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Oct 2003 20:36:12 -0700
"Randall Hyde" <randyhyde@earthlink.net> wrote:

> I need to access a couple of SATA chips from a user-mode
> program (yep, running as root). I know for a fact that my
> chip resides at address 0xfc300000 (/proc/iomem and /proc/ide/siimage
> tells me this).  Can I do a mmap like the following to access the registers
> on ths chip?
> 
> fdDevMem = open( "/dev/mem", O_RDWR );
> ptr =
>     mmap
>     (
>         NULL,
>         4096,
>         PROT_READ | PROT_WRITE,
>         MAP_SHARED,
>         fdDevMem,
>         0xfc300000
>     );

That's not portable and will only work on a few platforms.
Please use mmap() and ioctl() operations on /proc/bus/pci/*
nodes to accomplish your task.
