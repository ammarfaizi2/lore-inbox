Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312748AbSDFUHi>; Sat, 6 Apr 2002 15:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312757AbSDFUHh>; Sat, 6 Apr 2002 15:07:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24633 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312748AbSDFUHg>; Sat, 6 Apr 2002 15:07:36 -0500
To: Byron Stanoszek <gandalf@winds.org>
Cc: Jeremy Jackson <jerj@coplanar.net>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Faster reboots - calling _start?
In-Reply-To: <Pine.LNX.4.44.0204061201281.7190-100000@winds.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Apr 2002 13:00:55 -0700
Message-ID: <m1r8lsoavc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Byron Stanoszek <gandalf@winds.org> writes:

> On Fri, 5 Apr 2002, Jeremy Jackson wrote:
> 
> > ----- Original Message -----
> > From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
> > Sent: Friday, April 05, 2002 5:48 PM
> > 
> > > I need to avoid going through the BIOS ... this is a
> > > multiquad NUMA machine, and it doesn't take kindly
> > > to the reboot through the BIOS for various reasons.
> > > It also takes about 4 minutes, which is a pain ;-)
> > >
> > > I have source code access to our BIOS if I really wanted,
> > > I just want to avoid modifying it if possible.
> > 
> > well keep in mind that the fastest LinuxBIOS boot is 3 seconds...
[ to login prompt ]

> > a large part of the boot time on most PCs is the BIOS setting up
> > DOS support and painting silly logos on the screen, all of which
> > can go away.  I'm guessing your NUMA system has a bit more
> > to do at this stage due to the hardware, but still...

Especially given that I can load the kernel on a dual P4 xeon system in
3 seconds from power on.  But traditional BIOS's are slow, and getting
slower for unknown reasons.

> Wouldn't it be easier to just ljmp to the start address of the kernel in memory
> (the address after the bootloader has done its thing), effectively restarting
> the kernel from line 1? Or is tehre an issue with some hardware being in an
> invalid state when doing this?
> 
> Maybe Eric Biederman can comment on this since he's adding new functionality to
> the boot loader..

I've also written the patch that allows this.

In the general case where you want to boot another version of the kernel
you must rerun the BIOS query code.  In case your new kernel can handle your
hardware better than the previous version.

The are bad cases where the kernel can leave the hardware in a state
that either confuses the BIOS or confuses the drivers when they load.
This is rare and being worked on.  But it is an independent problem.

http://download.lnxi.com/pub/src/linux-kernel-patches/kexec/linux-2.5.7.kexec.diff
http://download.lnxi.com/pub/src/mkelfImage/elfboottools-2.0.tar.gz

And despite the name I can kexec plain bzImages, now.

Eric
