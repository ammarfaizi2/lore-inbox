Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbSJQT3q>; Thu, 17 Oct 2002 15:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262081AbSJQT3q>; Thu, 17 Oct 2002 15:29:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23169 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262046AbSJQT3p>; Thu, 17 Oct 2002 15:29:45 -0400
Date: Thu, 17 Oct 2002 15:38:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: arun4linux <arun4linux@indiatimes.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cache flushing and invalidation in driver
In-Reply-To: <200210171839.AAA21371@WS0005.indiatimes.com>
Message-ID: <Pine.LNX.3.95.1021017152609.7608A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, arun4linux wrote:

> Hello,
> 
> I'm writing a driver for a PCI based application specific controller. Infact porting from OS/2.
> 
> I have couple of questions on caching problem ( i faced this when I worked on vxworks, PPC machine).
> 
> 
> Our card has its own RAM and we are mapping and using that in the driver. Ours is a pentium target machine.
> 
> I'd like to know how to do cache flushing and cache invalidation in linux? 
> 
> Do we need to do it explicitly on a pentium/linux machine?
> 
> The other question is existing OS/2 implementation exports the hardware personalities (PCI I/O and memory base addresses) to the application and application takes control after that.
> 
> We need to use mmap to acheive the same as per requirement. 
> 
> Will there be any cache or any other issues on this regard?
> 
> 
> Your answers would be helpful for us as we are in the design phase.
> 
> Warm Regards
> 
> Arun
> 
> 

Normally you obtain access to your devices' memory-mapped RAM
(or anything else) by using ioremap_nocache(). If you want to
leave it cached (for speed), you use ioremap(). In that case,
you can do a single dummy read from the same page that you
want updated, just before you do whatever required the
synchronization. This often gives better overall performance.
With shared RAM, the CPU (and its cache) doesn't know that
the RAM was written by some other device. Therefore, if this
is important, you need to leave it uncached.

FYI, the "nocache" doesn't affect the PCI FIFO. Therefore stuff
on the PCI Bus remains cached (sort of) anyway. Because of this,
you may need to force all PCI Bus writes to complete by doing a
dummy read before any important stuff anyway.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

