Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265078AbSKAQxY>; Fri, 1 Nov 2002 11:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265254AbSKAQxY>; Fri, 1 Nov 2002 11:53:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:18816 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265078AbSKAQxW>; Fri, 1 Nov 2002 11:53:22 -0500
Date: Fri, 1 Nov 2002 12:00:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <davej@codemonkey.org.uk>, boissiere@adiglobal.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5]  October 30, 2002
In-Reply-To: <1036169388.12534.48.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.1021101115139.1318A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Nov 2002, Alan Cox wrote:

> On Fri, 2002-11-01 at 14:05, Eric W. Biederman wrote:
> > When you have a correctable ECC error on a page you need to rewrite the
> > memory to remove the error.  This prevents the correctable error from becoming
> > an uncorrectable error if another bit goes bad.  Also if you have a
> > working software memory scrub routine you can be certain multiple
> > errors from the same address are actually distinct.  As opposed to
> > multiple reports of the same error.
> 
> Note that this area has some extremely "interesting" properties. For one
> you have to be very careful what operation you use to scrub and its
> platform specific. On x86 for example you want to do something like lock
> addl $0, mem. A simple read/write isnt safe because if the memory area
> is a DMA target your read then write just corrupted data and made the
> problem worse not better!
> 

The correctable ECC is supposed to be just that (correctable). It's
supposed to be entirely transparent to the CPU/Software. An additional
read of the affected error produces the same correction so the CPU
will never even know. The x86 CPU/Software is only notified on an
uncorrectable error. I don't know of any SDRAM controller that
generates an interrupt upon a correctable error. Some store "logging"
information internally, very difficult to get at on a running system.

Given that, "scrubbing" RAM seems to be somewhat useless on a
running system. The next write to the affected area will fix the
ECC bits, that't what is supposed to clear up the condition.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


