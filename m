Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTKRNvQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTKRNtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:49:03 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9091 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262817AbTKRNsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:48:18 -0500
Date: Tue, 18 Nov 2003 08:49:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Maciej Zenczykowski <maze@cela.pl>
cc: Christian Axelsson <smiler@lanil.mine.nu>,
       Pontus Fuchs <pof@users.sourceforge.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Announce: ndiswrapper
In-Reply-To: <Pine.LNX.4.44.0311181422300.29639-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.53.0311180838150.30178@chaos>
References: <Pine.LNX.4.44.0311181422300.29639-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003, Maciej Zenczykowski wrote:

> > Pontus Fuchs wrote:
> > > Hi,
> > >
> > > Since some vendors refuses to release specs or even a binary
> > > Linux-driver for their WLAN cards I desided to try to solve it myself by
> > > making a kernel module that can load Ndis (windows network driver API)
> > > drivers. I'm not trying to implement all of the Ndis API but rather
> > > implement the functions needed to get these unsupported cards working.
> >
> > Sounds like a plan!
>
> Definetely agree - question though, are you loading these drivers into
> ring 0 (kernel space)?  As far as I know linux only supports ring 0
> (kernel) and 3 (userspace).  However this would seem to be the perfect
> place to load the binary modules in ring 1 (or even userspace if that was
> possible...).  I can't say I trust any binary only and/or windows driver
> to not make a mess of my kernel :)  actually the driver may actually be
> errorless - it's just designed for a different operating system and thus
> some unexplainable misshaps could easily happen...
>
> While we're at it, loading binary only modules into ring 1 would probably
> also be a good idea for the NV module et al.  Although I have no idea how
> hard it would be to make ring 1 function (and whether there actually is
> any point to doing it in ring 1 instead of ring 3 with iopl/ioperm anyway)
> and how big the performance penalty for non-ring 0 would be...
>
> Cheers,
> MaZe.
>

Do the NDIS drivers work in 32-bit land? Some kludges do! They were
the real-mode DOS driver interface to MS-DOS. Now there is a kludge
on top of a kludge called NDIS-6. They also used the Pascal calling
convention which screws up 'C' code (you need an assembly wrapper).

They are a waste-of-time. Why would you clone a Microsoft interface
for a non-Microsoft Operating System when you can't allow such
junk to run inside the kernel anyway.

The problem with third-party binary drivers is not the interface
to the kernel. Linux has a public interface, well established
and well known. The problem is that any third-party driver can
completely f**k up the kernel, either by mistake or by design.
So the third-party drivers MUST provide source-code so they
can be fixed or made to behave if (read when) problems are found.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


