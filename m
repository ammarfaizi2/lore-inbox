Return-Path: <linux-kernel-owner+willy=40w.ods.org-S277995AbVBDEwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S277995AbVBDEwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 23:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S277761AbVBDEuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 23:50:23 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:31642 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S277171AbVBDErz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 23:47:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=N1VPGUltXqj7uChcTxv7sDVya1SbV5gJOQ7OvwQTqM2syVIRcnYAHzsnYgIbxcW4dajA1LSbs/MEtX/0dz4Ey1UNj1Pqr4t/4B9/NH+xKDw0qT5Uk+arR0UsTTLaK8umGYUHtIy3wWAkSqZO4QPlz5rk7GKcI1UyGtJaSpGmCG8=
Message-ID: <9e473391050203204799d26a@mail.gmail.com>
Date: Thu, 3 Feb 2005 23:47:55 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: 2.6.10 dies when X uses G550
Cc: Dave Airlie <airlied@gmail.com>,
       Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org,
       Xserver development <xorg@freedesktop.org>
In-Reply-To: <20050204034304.GA24195@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fa.ks44mbo.ljgao4@ifi.uio.no>
	 <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de>
	 <21d7e99705012205012c95665@mail.gmail.com> <41F76B4D.8090905@hist.no>
	 <20050130111634.GA9269@hh.idb.hist.no>
	 <21d7e9970501300322ffdabe0@mail.gmail.com>
	 <9e473391050130070520631901@mail.gmail.com>
	 <20050130163241.GA18036@hh.idb.hist.no>
	 <9e473391050130090532067a5f@mail.gmail.com>
	 <20050204034304.GA24195@hh.idb.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This appears to me to be a problem with the drivers in the X server.
DRM isn't active yet so I don't think the problem is there. There may
have been a kernel change that caused BIOS reset to stop working.

X does nasty things to the PCI bus from user space and there are many
ways that X and the kernel could interfere with each other. Maybe some
one that owns a PCI video card and a Matrox G550 can step through this
in a debugger and see what is happening.

You can look at the contents in of the video BIOS ROMs in recent
kernels. Go into sys and find your video card. echo 1 >rom. That will
enable the rom access code. You can then hexdump the ROM contents.

This is a small program for running a reset on video cards. It will
reset all of your cards. You might want to try running it. If it hangs
it will be easier to debug than an X server.
ftp://ftp.scitechsoft.com/devel/obsolete/x86emu/x86emu-0.8.tar.gz

I added the X server dev list on the CC.


On Fri, 4 Feb 2005 04:43:04 +0100, Helge Hafting <helgehaf@aitel.hist.no> wrote:
> On Sun, Jan 30, 2005 at 12:05:27PM -0500, Jon Smirl wrote:
> > On Sun, 30 Jan 2005 17:32:41 +0100, Helge Hafting
> > <helgehaf@aitel.hist.no> wrote:
> > > Yes, it is a PCI radeon.  And the machine has an AGP slot
> > > too, which is used by a matrox G550.  This AGP card was not
> > > used in the test, (other than being the VGA console).
> > > Note that there is no crash if I don't compile
> > > AGP support, so the crash is related to AGP somehow even though
> > > AGP is not supposed to be used in this case.
> >
> > Can you set the PCI card to be primary in your BIOS or remove the AGP
> > card, and then see if it works? It could be that X's video reset code
> > for secondary PCI cards is broken.
> >
> I tried this. I already reported that X came up on the radeon.
> I could not run X on the G550, now that it was "secondary",
> but the crash was different from the radeon crash.
> 
> The logs with secondary radeon used to end like this:
> (II) LoadModule: "int10"
> (II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
> (II) RADEON(0): initializing int10
> (**) RADEON(0): Option "InitPrimary" "on"
> (II) Truncating PCI BIOS Length to 53248
> 
> The logs for secondary G550 ends like this, with or without int10
> (--) MGA(0): Pseudo-DMA transfer window at 0xF3000000
> (==) MGA(0): BIOS at 0xC0000
> (WW) MGA(0): Video BIOS info block not detected!
> (II) MGA(0): MGABios.RamdacType = 0x0
> (==) MGA(0): Write-combining range (0xf0000000,0x2000000)
> (--) MGA(0): VideoRAM: 2048 kByte
> (II) Loading sub module "ddc"
> (II) LoadModule: "ddc"
> (II) Reloading /usr/X11R6/lib/modules/libddc.a
> (II) Loading sub module "i2c"
> (II) LoadModule: "i2c"
> (II) Loading /usr/X11R6/lib/modules/libi2c.a
> (II) Module i2c: vendor="The XFree86 Project"
>         compiled for 4.3.0.1, module version = 1.2.0
>         ABI class: XFree86 Video Driver, version 0.6
> (==) MGA(0): Write-combining range (0xf0000000,0x200000)
> (II) MGA(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
> (II) MGA(0): I2C bus "DDC" initialized.
> (II) MGA(0): I2C device "DDC:ddc2" registered at address 0xA0.
> (II) MGA(0): I2C device "DDC:ddc2" removed.
> (II) MGA(0): I2C Monitor info: (nil)
> (II) MGA(0): end of I2C Monitor info
> 
> The video bios is apparently not detected at all, and therefore not run.
> 
> The kernel doesn't actually hang, only X gets stuck.  sysrq+T
> dumped stack traces for all tasks except the xserver.  For X,
> there was only one line identifying the xserver process and the fact
> that it was Running.  No stack dump.  I managed to kill all tasks
> and have init proceeding into init 2.
> 
> So I wonder - is Debians X 4.3.0.1 buggy, or the kernel?
> The fact remains that the newer kernels locks up while trying to use the
> secondary radeon, while it actually works with 2.6.8.1.
> 
> Well, actually 2.6.8.1 is a bit unstable once 3D stuff starts on the
> radeon - but it is only the radeon xserver that locks up in an
> infinite loop after a while. Other processes remain responsive.
> 
> Helge Hafting
> 


-- 
Jon Smirl
jonsmirl@gmail.com
