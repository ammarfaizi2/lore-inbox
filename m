Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbTAJVap>; Fri, 10 Jan 2003 16:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTAJVap>; Fri, 10 Jan 2003 16:30:45 -0500
Received: from web20508.mail.yahoo.com ([216.136.226.143]:64567 "HELO
	web20508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266010AbTAJVan>; Fri, 10 Jan 2003 16:30:43 -0500
Message-ID: <20030110213928.9073.qmail@web20508.mail.yahoo.com>
Date: Fri, 10 Jan 2003 13:39:28 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: Using lilo to boot off any drive ...
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1030110161101.10394A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

Thanks for the response. 

Even if I can get the map information using the INT
0x13h disk interrupt, I would still need some way of
knowing if sda has indeed failed. 

What I am thinking of if it is possible to make the
"boot" option in lilo.conf variable. Or better,
introduce a serial# option and the serial# can be
scanned for on startup. Or make use of a lun# option. 

I was also thinking if BIOS id's for the disks can be
used here. Are BIOS id's assigned for all drives?

Thanks
Manish

--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> On Fri, 10 Jan 2003, Manish Lachwani wrote:
> 
> > In my current setup, I am having 12 ide drives
> > connected to a 3ware controller labelled sda to
> sdl.
> > Suppose sde is the drive we want the system to
> boot
> > off. What I do is modify the lilo.conf on sda,
> sdb,
> > sdc etc. to have the "boot" entry point to
> /dev/sde.
> > 
> > This way when the controller is transferred to
> lilo on
> > sda, it will load the kernel from sde. 
> > 
> > consider this. If sda is bad and is not exported
> to
> > the OS or is not detected in the BIOS due to a bad
> > cable etc. In this scenario, the OS mappings would
> > change. Now, sdb will become sda. The lilo.conf on
> sdb
> > (now sda) would have "boot" parameter still point
> to
> > sde, which is now sdd. 
> > 
> > When the control is transferred to lilo on sda
> (sdb
> > actually), is there a way for me to boot off sdd
> now
> > (which was previously sde)? I mean, is there any
> way
> > that lilo can load the appropriate kernel image?
> > 
> > One of the ways I was thinking of was to modify
> the
> > lilo sources to scan for drive serial# and we boot
> off
> > that drive for which the serial# matches. But,
> does
> > anyone have a better alternative?
> > 
> > Thanks
> > Manish
> > 
> 
> When LILO boots, there is no file-system (anywhere)!
> The
> boot-record of LILO contains a table which points to
> the
> contents of the map file. This file exist only when
> LILO is being configured, i.e., when Linux is up
> with a
> mounted file-system. The contents of this file
> describe
> the location of all of the pieces of the operating
> system,
> the boot message, and any RAM-disk data. All of
> these
> pieces, plus the data of this file, itself, must be
> accessible
> from the INT 0x13 disk software interrupt when the
> machine
> is being booted.
> 
> Since these pieces are known just as:
> 		BIOS device;
> 		device_offset;
> 		data_length;
> 
> ... not as file-system directory entries that can be
> "scanned for",
> you will not be able to substitute anything. LILO
> recommends that
> all of the boot components be put on one physical
> drive so you
> don't have problems with controllers or the BIOS
> rearranging
> things.
> 
> If you want to perform a "smart" boot, then you boot
> an initial
> RAM disk. This allows you to configure the system in
> way you
> want, rearranging disk-drives, even mounting network
> file-systems
> for the root file-system or even falling-back to
> alternative
> file-systems when certain ones are off-line.
> 
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.18 on an i686 machine
> (797.90 BogoMips).
> Why is the government concerned about the lunatic
> fringe? Think about it.
> 
> 


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
