Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSGXT7K>; Wed, 24 Jul 2002 15:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317495AbSGXT7K>; Wed, 24 Jul 2002 15:59:10 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9601 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317489AbSGXT7J>; Wed, 24 Jul 2002 15:59:09 -0400
Date: Wed, 24 Jul 2002 16:03:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andries Brouwer <aebr@win.tue.nl>
cc: Kareem Dana <kareemy@earthlink.net>, Andrew Rodland <arodland@noln.com>,
       linux-kernel@vger.kernel.org
Subject: Re: loop.o device busy after umount
In-Reply-To: <20020724194130.GB13180@win.tue.nl>
Message-ID: <Pine.LNX.3.95.1020724155946.8122A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, Andries Brouwer wrote:

> On Wed, Jul 24, 2002 at 03:33:19PM -0400, Kareem Dana wrote:
> 
> > losetup worked like a charm. Thanks. Any reason umount would not do that automatically though?
> 
> Read mount(8), the places where losetup is mentioned.

It works in my system and `umount` is version 2.10o

umount: umount-2.10o

It works because (strace output), umount does the LOOP_CLR_FD ioctl().

munmap(0x400aa000, 4096)                = 0
oldumount("/mnt")                       = 0
open("/dev/loop0", O_RDONLY)            = 3
ioctl(3, LOOP_CLR_FD, 0)                = 0
close(3)                                = 0

If you don't have such an `umount`, loop will remain active, preventing
the module from being unloaded.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

