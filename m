Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbTCHUoD>; Sat, 8 Mar 2003 15:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262198AbTCHUoD>; Sat, 8 Mar 2003 15:44:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6951 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262197AbTCHUnD>; Sat, 8 Mar 2003 15:43:03 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
       Chris Dukes <pakrat@www.uk.linux.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
References: <Pine.LNX.4.44.0303081132030.12316-100000@kenzo.iwr.uni-heidelberg.de>
	<m14r6dlu4w.fsf@frodo.biederman.org>
	<20030308161936.C1896@flint.arm.linux.org.uk>
	<m1zno5kdnz.fsf@frodo.biederman.org>
	<20030308170532.D1896@flint.arm.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Mar 2003 11:01:05 -0700
In-Reply-To: <20030308170532.D1896@flint.arm.linux.org.uk>
Message-ID: <m1r89hkaam.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Sat, Mar 08, 2003 at 09:48:16AM -0700, Eric W. Biederman wrote:
> > I can change the contents of my ramdisk as easily as I can change
> > the kernel command line.  For the complex setups just placing
> > a configuration file in the ramdisk is what seems to work the best
> > in practice.
> 
> You'll forgive me if I don't think that "change the contents of ramdisk"
> is as easy as changing the kernel command line.
> 
> Last time I checked, to change the contents of a ramdisk image, you needed
> to ungzip it, mount it, make some changes, unmount it, re-gzip it, and
> re-install the thing.  Or, in the case of initramfs, you need to rebuild
> the kernel image.  Compare this to changing the kernel command line from
> "root=/dev/hda1" to "root=/dev/nfs ip=dhcp" in the boot loader by hitting
> a few keys on the keyboard before the kernel loads, and I think you'll
> start to get my point here.


Currently on systems I am talking I have a directory structured like:

dir/config
dir/bzImage
dir/ramdisk
dir/ramdisk/sbin/init
dir/ramdisk/etc/
.....

So I edit dir/ramdisk/etc/somefile.conf and run a script that rebuilds
everything.  Or I edit dir/config which has my command line in it
and run the script again.

Getting to this point took a bit of effort but that is where I am
at now.

With initramfs it becomes as designed it becomes easier because it easier
to build a cpio archive.  But mkcramfs has similar properties for
building filesystems.   The whole building the initramfs thing into
the kernel is something that probably needs to be worked so the
initramfs can be attached to the kernel separately.  When the bootable
kernel image is ELF that is easy.  With something like bzImage on x86
it can be a pain, as there isn't any room to extend the things.

And all I asserted is that for ``me'' it is equally simple to change
the ramdisk contents as to changes those of a file.  

For something like /bin/kinit that contains the default kernel
polices on how to mount root it should certainly be command line
driven.  

For complicated setups where I am partitioning the hard drives,
making filesystems, and installing over the network.  A configuration
file has proven to be easier, and that is what I do.  The fundamental
issue is that after a certain point the command line just does not
have room for all of the parameters needed.

Possibly I answered the wrong question? 

As for hitting a few keys on the keyboard in the bootloader before
the kernel loads well....  That is good on one machine, it gets to be
a pain on 4.  And at a 1000 I have much better things to do with my
time.  Which just shows my bias from working on with clusters.  On a
cluster the only time you want to treat a machine as an individual is
when you are replacing bad hardware.

I have played with parsing command line options.  And messing
with /proc/cmdline or being /sbin/init and just getting those options
from the kernel is not difficult.  For prototyping it may be a good
idea to read /proc/cmdline so the kernel can eat the options before
kinit does.

Eric
