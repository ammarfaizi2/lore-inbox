Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTLJO1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 09:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTLJO1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 09:27:40 -0500
Received: from chaos.analogic.com ([204.178.40.224]:41344 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262119AbTLJO1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 09:27:38 -0500
Date: Wed, 10 Dec 2003 09:29:04 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Gene Heskett <gene.heskett@verizon.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: need hardware guru
In-Reply-To: <200312092118.36657.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.53.0312100842110.2805@chaos>
References: <200312092118.36657.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Gene Heskett wrote:

> My mobo is a Biostar M7VIB, VIA 82686 chipset.
>
> It appears that thre doesn't seem to be a way to force a floppy format
> at non 512 byte sectors, as in I need to do a 256 byte, 18 sectors
> per track on a  DS 360k disk.  fdutils, fdformat, and a format from
> the emulator itself all fail to write a correct disk, insisting on a
> 9 sector per track PC format.
>
> Ideas, including bigger hammer at this point, cheerfully discussed.

The FDC in that machine is a "Super I/O chip" made by National,
PC87309. It is known to work in all modes although that doesn't
mean that linux actually has code in place for all the modes.

The sectors-per-track and the number of bytes per sector are part
of the "Specify" command which is executed prior to any major
change like format. These are all standard and documented. However,
if you need 256 bytes per sector, 18 sectors per track, you
need a new (lower) data-rate. The data-rate port is at 0x3f7.
You put a 0x00 in there for 500 kb/s, 0x01 for 250 kb/s, etc.
It's an independent port, you can write anything to it at
any time. I would guess that if you made a iopl(3) program
that writes 1 to that port just prior to executing
fdformat /dev/fd0D360, it might work. That might verify
the problem.

It is possible that Linux doesn't muck with the data-rate, that
it is whatever was set by the BIOS. It should. I haven't looked
at the Linux FDC code but I did write a complete BIOS so I know
how the FDC controller(s) work.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


