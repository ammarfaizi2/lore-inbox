Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293098AbSBWFPk>; Sat, 23 Feb 2002 00:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293099AbSBWFPb>; Sat, 23 Feb 2002 00:15:31 -0500
Received: from dial-10-208-apx-01.btvt.together.net ([209.91.3.208]:4494 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S293098AbSBWFPV>; Sat, 23 Feb 2002 00:15:21 -0500
Date: Sat, 23 Feb 2002 00:14:12 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow.websense.net
Reply-To: William Stearns <wstearns@pobox.com>
To: Michal Jaegermann <michal@harddata.com>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        William Stearns <wstearns@pobox.com>
Subject: Re: 2.4.18-rc4 does not boot
In-Reply-To: <20020222190538.A3819@mail.harddata.com>
Message-ID: <Pine.LNX.4.44.0202222350230.2192-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, Michal,
	(My apologies in advance if your problem is not a mischosen root 
partition).

On Fri, 22 Feb 2002, Michal Jaegermann wrote:

> On Monday, Feb 18, I posted a message that 2.4.18-pre9-ac4
> fails to boot on my machine with
> 
> FAT: bogus logical sector size 0
> FAT: bogus logical sector size 0

	See http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.3/0454.html 
; the post refers to the fact that the kernel doesn't know what filesystem 
is being used on the root device, so it tries all of the filesystem 
drivers.  The fat filesystem is whining because it can't recognize a fat 
filesystem on /dev/hda...

> Kernel panic: VFS: Unable to mount root fs on 03:00

	The 03:00 seems to imply to me that the kernel is looking for a 
root filesystem on /dev/hda (see /usr/src/linux/Documentation/devices.txt 
).  Is your root filesystem truly on /dev/hda (the entire drive), or (more 
likely) on one of the partitions, such as  /dev/hda1, /dev/hda2, etc.?
	If your root filesystem is on one of these others, you can tell 
the kernel what partition to use with:

rdev /path/to/my/kernel/file /dev/hda9	#Replace hda9 with your root partition

	or autodetect the partition with:

rdev /path/to/my/kernel/file `cat /etc/mtab | grep ' / ' | cut -f 1 -d ' '`

	If you're booting this kernel from a floppy, make sure 
you tell that kernel to use the right root as well; redo either of the 
above with

rdev /dev/fd0 /dev/hda9	#Replace hda9 with your root partition
rdev /dev/fd0 `cat /etc/mtab | grep ' / ' | cut -f 1 -d ' '`

	You might also want to check your boot loader's configuration file 
and make sure that it references the correct root filesystem.

/etc/lilo.conf:

image=/boot/bzImage-2.4.18-3
        label=2.4.18-3
        root=/dev/hda4
        read-only


	Cheers,
	- Bill


> messages.  2.4.18-rc1, and many different kernels, do not have
> troubles of that sort.  Tonight I found to my dismay that the
> same trouble afflicted 2.4.18-rc4.  No, I do not know why this
> happens; at least at this moment.


---------------------------------------------------------------------------
        "cc:Mail is a wonderful application, as long as you don't want
to read or send mail."
(Courtesy of Nix <nix@esperi.demon.co.uk>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts, 
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------

