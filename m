Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbTJPUNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 16:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTJPUNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 16:13:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17536 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263090AbTJPUNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 16:13:36 -0400
Date: Thu, 16 Oct 2003 16:10:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Maciej Zenczykowski <maze@cela.pl>
cc: Sanil K <Sanil.K@lntinfotech.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Interrupt handling
In-Reply-To: <Pine.LNX.4.44.0310162152590.29425-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.53.0310161603360.1209@chaos>
References: <Pine.LNX.4.44.0310162152590.29425-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003, Maciej Zenczykowski wrote:

> On Thu, 16 Oct 2003, Richard B. Johnson wrote:
>
> > The memory-map idea has security problems, though.
> > If the area ever gets unmapped (the user exits), a
> > fatal error could occur in kernel mode within the
> > ISR. In general, it's always best to allocate an
> > interrupt-safe buffer within the driver (module),
> > that is guaranteed to persist as long as the driver
> > is installed. This ultimately means that a copy
> > operation is necessary.
> >
> > Memory-to-memory copy is real fast now days. The
> > copy_to_user() is just memcpy() with a trap mechanism
> > that can save the kernel from a user-induced seg-fault.
> > The actual trap is hardware-induced in ix86 machines
> > and therefore adds no overhead to the normal copy operation.
>
> Is there any reason why we couldn't via kernel routine let user space
> access read-only certain pages of kernel memory?  I.e. having the
> userspace function call the driver to map into it's (user) address space a
> read-only mapping of the drivers (kernel) private r/w area?
> If I'm not mistaken this is doable on x86 hardware isn't it?
>
> Cheers,
> MaZe.
>
No reason. From user-space, using mmap, you can read the screen-memory
at 0xb8000, for instance, ........
-d b8000
000B8000  63 09 64 09 72 09 6F 09-6D 09 20 07 20 07 20 07   c.d.r.o.m. . . .
000B8010  20 07 20 07 20 07 20 07-20 07 20 07 20 07 20 07    . . . . . . . .
[SNIPPED]

You can look access many kernel areas that way. The probem is:

(1) When are new data available, and how much.
(2) How do you keep it from being overwritten by the next interrupt
    before it's been read.

These, and other, problems are why there are 'standard' ways of doing
things.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


