Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUDPRHs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 13:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbUDPRHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 13:07:47 -0400
Received: from mproxy.gmail.com ([216.239.56.247]:2018 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S263435AbUDPRHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 13:07:45 -0400
Message-ID: <73CA03E0.6595EF57@mail.gmail.com>
Date: Fri, 16 Apr 2004 10:07:44 -0700
From: Ross Biro <ross.biro@gmail.com>
To: root@chaos.analogic.com
Subject: Re: Kernel writes to RAM it doesn't own on 2.4.24
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.53.0404161150450.542@chaos> <73979326.58EE2AD2@mail.gmail.com> <Pine.LNX.4.53.0404161251570.10809@chaos>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004 12:55:33 -0400 (EDT), Richard B. Johnson
<root@chaos.analogic.com> wrote:
> 
> On Fri, 16 Apr 2004, Ross Biro wrote:
> 
> > mem= isn't there to tell the kernel what ram it owns and what ram it
> > doesn't own.  It's there to tell the kernel what ram is in the system.
> >  Since you told the system it only has 500m, it assumes the rest of
> > the 3.5G of address space is available for things like memory mapped
> > i/o.  If you cat /proc/iomem, you'll probably see something has
> > reserved the memory range in question.
> >
> 
> No!  This is address space, not RAM. Whether or not a PCI device
> or whatever has internal RAM that's mapped makes no difference.
> 
> I told the kernel that it has 500m of RAM. It better not assume
> I don't know what I'm talking about. I might have reserved that
> RAM because it's bad or I may have something else important to
> do with that RAM (which I do).

The problem is that the kernel does assume you know what you are
talking about, and you don't.  You are abusing the mem= parameter. 
That's fine, but then you have to tell the kernel what you really
mean.  What you really want to say is there is memory above 500M and I
don't want you to touch it.  There may be a way to do that via the
fancy mem=@ parameters.

What mem= tells the kernel is that there is RAM in a certain spot an
no where else.  Since you told the kernel there is no ram about 500M,
that means that address space is free to be used for memory mapped
I/O.  Since the kernel trusts you, it started using the memory above
500m for memory mapped i/o.  Since you LIED to the kernel, you are
getting results you do not like.  The solution I settled on was to
tell the kernel that people LIE to it and only use memory for I/O if
both the BIOS and the USER agree that it's available.   You have to
find a way to tell the kernel the TRUTH, or you will never get the
results you want.
