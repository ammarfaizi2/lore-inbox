Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbSLCVBY>; Tue, 3 Dec 2002 16:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbSLCVBY>; Tue, 3 Dec 2002 16:01:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:32389 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265995AbSLCVBX>; Tue, 3 Dec 2002 16:01:23 -0500
Date: Tue, 3 Dec 2002 16:11:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Duncan Sands <baldrick@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reserving physical memory at boot time
In-Reply-To: <200212031303.16487.baldrick@wanadoo.fr>
Message-ID: <Pine.LNX.3.95.1021203160658.20996A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2002, Duncan Sands wrote:

> I would like to reserve a particular page of physical memory when
> the kernel boots.  By reserving I mean that no one else gets to read
> from it or write to it: it is mine.  Any suggestions for the best way
> to go about this with a 2.5 kernel?
> 
> Thanks,
> 
> Duncan.

If you need a certain page reserved at boot-time you are out-of-luck.
You can tell the kernel (using mem=xxx on the boot command line) that
you have somewhat less memory than you do and then you can write a
module that accesses the other memory that the kernel doesn't use.

If you just want to make sure that your module owns a particular
page that nobody else uses, just use ioremap() in your module to
allocate a particular address. Those page(s) are now owned by
your module and will never be paged. You can access those pages
from user-space by providing some connectivity in your module
(like read()/write()/ioctl()). 

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


