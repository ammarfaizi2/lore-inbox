Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311284AbSCQDnu>; Sat, 16 Mar 2002 22:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311283AbSCQDnk>; Sat, 16 Mar 2002 22:43:40 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:13576 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S311285AbSCQDnV>; Sat, 16 Mar 2002 22:43:21 -0500
Date: Sat, 16 Mar 2002 19:43:20 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
Subject: Re: /dev/md0: Device or resource busy
In-Reply-To: <E16mRYV-000853-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203161937390.7016-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Alan Cox wrote:

> > i just tried a "linux init=/bin/sh" boot, and it's still saying Device or
> > resource busy:
> >
> > init-2.05a# raidstop /dev/md0
> > md: md0 still in use.
> > /dev/md0: Device or resource busy
> > init-2.05a# mount /proc
>
> Duplicated. Seems the md code deos indeed have a bug there

ACK!  sorry.  it's not the kernel code, it's raidstop.  it seems to open
/dev/md0 an extra time for what reason i'm not sure.  it even does it when
you're referring to other md devices.  for example:

# strace raidstop /dev/md3
...
open("/dev/md0", O_RDONLY)              = 4
ioctl(4, 0x800c0910, 0x804fd1c)         = 0
open("/dev/md3", O_RDWR)                = 5
fstat64(5, {st_mode=S_IFBLK|0660, st_rdev=makedev(9, 3), ...}) = 0
ioctl(5, 0x932, 0)                      = 0
...

mdctl doesn't have this problem.

fwiw dpkg tells me i've got raidtools 0.90.20010914-9

-dean

