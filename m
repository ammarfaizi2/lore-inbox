Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279846AbRKMPJX>; Tue, 13 Nov 2001 10:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279822AbRKMPJP>; Tue, 13 Nov 2001 10:09:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:51075 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S273065AbRKMPJJ>; Tue, 13 Nov 2001 10:09:09 -0500
Date: Tue, 13 Nov 2001 10:08:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Robert A H Holmberg <rahholmb@cc.helsinki.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: Odd partition overlapping problem
In-Reply-To: <Pine.OSF.4.30.0111131627170.14606-100000@sirppi.helsinki.fi>
Message-ID: <Pine.LNX.3.95.1011113095524.1544A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Robert A H Holmberg wrote:

> Hi,
> I have a dual-boot setup with win98 and linux. I primarily use linux, but
> I want to keep windows around for some inportant productivity
> applications, mostly games.  My partition table is as follows:
> 
> <snip>
> [root@localhost documents]# fdisk /dev/hda
> 
> The number of cylinders for this disk is set to 3736.
> There is nothing wrong with that, but this is larger than 1024,
> and could in certain setups cause problems with:
> 1) software that runs at boot time (e.g., old versions of LILO)
> 2) booting and partitioning software from other OSs
>    (e.g., DOS FDISK, OS/2 FDISK)
> 
> Command (m for help): p
> 
> Disk /dev/hda: 255 heads, 63 sectors, 3736 cylinders
> Units = cylinders of 16065 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/hda1   *         1       523   4200966    c  Win95 FAT32 (LBA)
> /dev/hda2           524       525     16065   83  Linux
> /dev/hda3           526      2647  17044965   83  Linux
> /dev/hda4          2648      3736   8747392+   5  Extended
> /dev/hda5          2648      2713    530113+  82  Linux swap
> /dev/hda6          2714      3736   8217216    c  Win95 FAT32 (LBA)
> 
> Command (m for help):
> </snip>
[SNIPPED...]

The extended partition goes from 2648 to 3736. The first part of
this extended partition from 2648 to 2713 is swap. The second part
of 2714 to 3736 is the FAT32 partition. It looks as though M$ tries
to use the swap area, ignoring the 82 code for Linux swap. This
may be why the M$ partition gets trashed. To test this theory,
disable swap on this drive (comment it out in /etc/fstab). Re-do
the M$ partition and see if it remains clean. If it remains
clean, then do a `mkswap` from Linux. Reboot to M$ and verify that
the last partition is now corrupt. This will show that M$ is
trying to use the swap area. If it is, re-fdisk the extended
partition to put Linux swap at the end instead of the beginning.

This should work around the M$ bug.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


