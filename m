Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129544AbRAaWwU>; Wed, 31 Jan 2001 17:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129543AbRAaWwK>; Wed, 31 Jan 2001 17:52:10 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:45356 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129542AbRAaWwA>; Wed, 31 Jan 2001 17:52:00 -0500
Date: Thu, 1 Feb 2001 00:58:47 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Paul Powell <moloch16@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why isn't init PID 1?
In-Reply-To: <20010131144038.26689.qmail@web118.yahoomail.com>
Message-ID: <Pine.LNX.4.21.0102010057470.11152-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Paul Powell wrote:

> Hello,
> 
> I have a bootable linux CD that runs a custom init. 
> Under most versions of linux init runs as process ID
> one.  Under my bootable CD, it runs as process ID 15. 
> I need it to run as PID 1 so that I can execute a
> kill(-1,15) without killing init.
> 
> The boot CD uses and initrd image to load drivers. 
> The linuxrc file looks like:
> 
> #!/bin/sash
> 
> aliasall
> 
> echo "Loading aic7xxx module"
> insmod /lib/aic7xxx.o
> echo "Loading ips module"
> insmod /lib/ips.o ips=ioctlsize:512000
> echo "Loading sg module"
> insmod /lib/sg.o
> echo "Loading FAT modules"
> insmod /lib/fat.o
> insmod /lib/vfat.o
> 
> echo "Mounting /proc"
> mount -t proc /proc /proc
> init
> umount /proc
> 
> Does it run as PID 15 because I execute insmod and
> mount before running init?

Yes. First program to run get PID 1. 

Solution : fork() in init and load the modules in the child.



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
