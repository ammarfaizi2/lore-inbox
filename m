Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280838AbRKLQS6>; Mon, 12 Nov 2001 11:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280837AbRKLQSs>; Mon, 12 Nov 2001 11:18:48 -0500
Received: from astcc-423.astound.net ([24.219.123.215]:42757 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S280832AbRKLQSd>; Mon, 12 Nov 2001 11:18:33 -0500
Date: Mon, 12 Nov 2001 09:18:04 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Re: disk write cache and poweroff
In-Reply-To: <20011112134137.A17482@cistron.nl>
Message-ID: <Pine.LNX.4.10.10111120916500.14811-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Miquel,

Please use the latest patches found at www.linuxdiskcert.org.

Cheers,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

On Mon, 12 Nov 2001, Miquel van Smoorenburg wrote:

> Hello Andre,
> 
> A few users of the debian sysvinit package have complained that on
> their laptop, shutdown + poweroff is too fast. The disk is turned
> off before the write-cache on the disk is completely written,
> resulting in some filesystem corruption.
> 
> After some experimentation with turning off the write cache before
> shutdown etc, I found out that a side-effect of putting the IDE
> disk in standby mode is that the write cache is flushed. So now
> halt(8) has an extra option to put all IDE disks it can find
> (through /proc/ide/hd*) in standby mode just before it calls
> reboot(LINUX_REBOOT_CMD_POWER_OFF). Thus flag is used in the
> /etc/rc0.d/S90halt script, and appears to fix the problem. I think
> windows does the same :|
> 
> Anyway this should probably be done in the kernel. Perhaps the
> IDE driver should register a reboot notifier with
> register_reboot_notifier() that puts all IDE disks on the
> system in standby mode on SYS_HALT and SYS_POWER_OFF ?
> 
> Many other drivers do this too, grep for SYS_HALT in linux/drivers/*/*.c
> 
> Hmm I just noticed that a lot of driver check for SYS_DOWN (which
> is the same as SYS_RESTART: reboot) and SYS_HALT but not for
> SYS_POWEROFF, which is a bug in those drivers. Ugh.
> 
> Mike.
> -- 
> "Only two things are infinite, the universe and human stupidity,
>  and I'm not sure about the former" -- Albert Einstein.
> 


