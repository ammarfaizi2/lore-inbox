Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281810AbRKQTGr>; Sat, 17 Nov 2001 14:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281812AbRKQTGh>; Sat, 17 Nov 2001 14:06:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42848 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S281810AbRKQTGb>; Sat, 17 Nov 2001 14:06:31 -0500
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: mmap not working?
In-Reply-To: <200111170907.KAA24566@cave.bitwizard.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Nov 2001 11:47:31 -0700
In-Reply-To: <200111170907.KAA24566@cave.bitwizard.nl>
Message-ID: <m1wv0p8cak.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

R.E.Wolff@BitWizard.nl (Rogier Wolff) writes:

> I'm not sure wether the kernel has been wrong all the time or if
> something changed recently. I posted the "workaround" the first time
> through, which also works from userspace. I can change my application. 
> I can modify my libc. 
> 
> However, I'd rather have "mmap" fixed, as that fixes it for all other
> applications too. Not just for mine on my system. 
> 
> The SGI manpage says: 
> 
>      All implementations interpret an addr value of
>      zero as granting the system complete freedom in selecting pa, subject to
>      constraints described below.  A non-zero value of addr is taken to be a
>      suggestion of a process address near which the mapping should be placed.
> 
> which hints at a possible non-alignment. It also mentions that
> "offset" should be page-aligned, which I disagree with here:
> everything has been set up to "do the right thing" when the mapping is
> possible with an unaligned offset.

Except there is no way to give you enough information to munmap the page.
As the address passed to munmap must be page aligned.

The current policy appears to make an application think as up front
as possible about the need to be page aligned when talking to mmap,
while not being overly harsh.  We do have the silent rounding
up of length until it is a multiple of PAGE_SIZE.

Beyond this the internal linux implementation of mmap does not even
see the extra bits in the offset.  Instead the most recent syscall
entry point takes an argument as to which page you want to mmap from
the device.  This allows much larger devices to be mmaped while
still using 32bit arithmetic.

So I neither see that it is easy or even desirable to ``fix'' mmap.

Eric
