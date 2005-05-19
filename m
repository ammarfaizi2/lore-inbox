Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVESTn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVESTn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 15:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVESTn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 15:43:57 -0400
Received: from alog0043.analogic.com ([208.224.220.58]:9865 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261228AbVESTny
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 15:43:54 -0400
Date: Thu, 19 May 2005 15:43:21 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Gianluca Varenni <gianluca.varenni@gmail.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem mapping small PCI memory space.
In-Reply-To: <02e801c55ca5$7a9d1000$1a4da8c0@NELSON2>
Message-ID: <Pine.LNX.4.61.0505191533590.2987@chaos.analogic.com>
References: <02e801c55ca5$7a9d1000$1a4da8c0@NELSON2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, Gianluca Varenni wrote:

> Hi all.
>
> I'm writing a driver for a PCI board that exposes two memory spaces (out of
> the 6 IO address regions).
>
> One of them is 1MB, and I can map it to user level without problems. The
> other one is only 512 bytes.
> If I try to open it with /dev/mem, it returns EINVAL (the 1MB memory space
> is opened without any problem). If I try to expose it through mmap, mmap
> succeeds, but I only see garbage at user level. At kernel level, I can
> access that 512 bytes memory by using ioremap() on the physical address
> returned by pci_resource_start().
>
> Are there any lower limits on the size of a PCI memory region?
>
> Have a nice day
> GV
>

You impliment mmap() in your driver. It accesses the first megabyte
as 256 pages. Then you tack on the additional page that your 512
bytes resides at. mmap() only works with pages. The pages must
be ioremap_nocache and they must be reserved. The reserved part
is important to have them visible from user-space using mmap.

That's IFF you really need to see the stuff in user-mode. Normally,
you write a driver that accesses everything using the PCI primatives
provided in the kernel, for the kernel.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
