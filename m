Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbTAJVQw>; Fri, 10 Jan 2003 16:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266228AbTAJVQw>; Fri, 10 Jan 2003 16:16:52 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5250 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266224AbTAJVQu>; Fri, 10 Jan 2003 16:16:50 -0500
Date: Fri, 10 Jan 2003 16:28:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Manish Lachwani <m_lachwani@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Using lilo to boot off any drive ...
In-Reply-To: <20030110210035.76482.qmail@web20502.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1030110161101.10394A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Manish Lachwani wrote:

> In my current setup, I am having 12 ide drives
> connected to a 3ware controller labelled sda to sdl.
> Suppose sde is the drive we want the system to boot
> off. What I do is modify the lilo.conf on sda, sdb,
> sdc etc. to have the "boot" entry point to /dev/sde.
> 
> This way when the controller is transferred to lilo on
> sda, it will load the kernel from sde. 
> 
> consider this. If sda is bad and is not exported to
> the OS or is not detected in the BIOS due to a bad
> cable etc. In this scenario, the OS mappings would
> change. Now, sdb will become sda. The lilo.conf on sdb
> (now sda) would have "boot" parameter still point to
> sde, which is now sdd. 
> 
> When the control is transferred to lilo on sda (sdb
> actually), is there a way for me to boot off sdd now
> (which was previously sde)? I mean, is there any way
> that lilo can load the appropriate kernel image?
> 
> One of the ways I was thinking of was to modify the
> lilo sources to scan for drive serial# and we boot off
> that drive for which the serial# matches. But, does
> anyone have a better alternative?
> 
> Thanks
> Manish
> 

When LILO boots, there is no file-system (anywhere)! The
boot-record of LILO contains a table which points to the
contents of the map file. This file exist only when
LILO is being configured, i.e., when Linux is up with a
mounted file-system. The contents of this file describe
the location of all of the pieces of the operating system,
the boot message, and any RAM-disk data. All of these
pieces, plus the data of this file, itself, must be accessible
from the INT 0x13 disk software interrupt when the machine
is being booted.

Since these pieces are known just as:
		BIOS device;
		device_offset;
		data_length;

... not as file-system directory entries that can be "scanned for",
you will not be able to substitute anything. LILO recommends that
all of the boot components be put on one physical drive so you
don't have problems with controllers or the BIOS rearranging
things.

If you want to perform a "smart" boot, then you boot an initial
RAM disk. This allows you to configure the system in way you
want, rearranging disk-drives, even mounting network file-systems
for the root file-system or even falling-back to alternative
file-systems when certain ones are off-line.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


