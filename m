Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267114AbSLaBQG>; Mon, 30 Dec 2002 20:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbSLaBQG>; Mon, 30 Dec 2002 20:16:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:6289 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267114AbSLaBQG>;
	Mon, 30 Dec 2002 20:16:06 -0500
Message-ID: <3E10F1C7.258629F6@digeo.com>
Date: Mon, 30 Dec 2002 17:24:23 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Zahorik <matt@albany.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: How does the disk buffer cache work?
References: <Pine.BSF.4.43.0212301918280.370-100000@ender.tmmz.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 01:24:23.0917 (UTC) FILETIME=[5A15E9D0:01C2B06B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Zahorik wrote:
> 
> Earlier I wrote to the list where my SS10 hung on the partition check
> if a bad disk was installed.
> 
> This behavior is new to the 2.4.20 kernel.  I previously ran 2.2.20 on the
> machine. (the default in a Debian 3.0r0 install)  I can't vouch for 2.4
> kernels previous to 2.4.20.
> 
> I have traced the problem to a hang in the one of the disk buffer caches.
> 
> Can anyone tell me how to correct the behavior so that I:
> 
> 1.  Don't break things for other parts of the kernel
> 2.  The disk cache will return with an error for a hung disk?
> 
> Here's the tail of the console with debugging printk's inserted:
> 
> ...
> [.. the next function call in read_cache_page() is lock_page(), which we
> hang forever on ..]

lock_page() will sleep until the page is unlocked.  The page is unlocked
from end_buffer_io_sync(), which is called from within the context of
the disk device driver's interrupt handler.

This is probably a device driver or interrupt routing problem: the disk
controller hardware interrupts are not making it through to the CPU.
