Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272862AbVBFKKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272862AbVBFKKs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 05:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273062AbVBFKKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 05:10:47 -0500
Received: from mproxy.gmail.com ([216.239.56.248]:11784 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S272862AbVBFKKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 05:10:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=sj0TidfXDNlkwWwXsMRfdP8FaKWtYjhG6GvbIWl4Gk6pgT45v8+gP6TtA5a6DWh+LqXfbdL2VGYX4/QTsG5Jvof9BjNp3kecg3iQ4Tzqolo5nw2wXv+Gl4WRNsgt+mxRPVWJtGSeTdhJFRW/GCuyXyi04cyOiuZ+OSx1W4skCTI=
Message-ID: <21d7e9970502060210251815fb@mail.gmail.com>
Date: Sun, 6 Feb 2005 21:10:04 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: 2.6.10 dies when X uses G550
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <21d7e997050203215715f32c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fa.ks44mbo.ljgao4@ifi.uio.no>
	 <21d7e99705012205012c95665@mail.gmail.com> <41F76B4D.8090905@hist.no>
	 <20050130111634.GA9269@hh.idb.hist.no>
	 <21d7e9970501300322ffdabe0@mail.gmail.com>
	 <9e473391050130070520631901@mail.gmail.com>
	 <20050130163241.GA18036@hh.idb.hist.no>
	 <9e473391050130090532067a5f@mail.gmail.com>
	 <20050204034304.GA24195@hh.idb.hist.no>
	 <21d7e997050203215715f32c3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

https://bugs.freedesktop.org/show_bug.cgi?id=2431

might have something to do with this...

Dave.

On Fri, 4 Feb 2005 16:57:50 +1100, Dave Airlie <airlied@gmail.com> wrote:
> > The logs with secondary radeon used to end like this:
> > (II) LoadModule: "int10"
> > (II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
> > (II) RADEON(0): initializing int10
> > (**) RADEON(0): Option "InitPrimary" "on"
> > (II) Truncating PCI BIOS Length to 53248
> >
> > The logs for secondary G550 ends like this, with or without int10
> > (--) MGA(0): Pseudo-DMA transfer window at 0xF3000000
> > (==) MGA(0): BIOS at 0xC0000
> > (WW) MGA(0): Video BIOS info block not detected!
> > (II) MGA(0): MGABios.RamdacType = 0x0
> > (==) MGA(0): Write-combining range (0xf0000000,0x2000000)
> > (--) MGA(0): VideoRAM: 2048 kByte
> > (II) Loading sub module "ddc"
> > (II) LoadModule: "ddc"
> > (II) Reloading /usr/X11R6/lib/modules/libddc.a
> > (II) Loading sub module "i2c"
> > (II) LoadModule: "i2c"
> > (II) Loading /usr/X11R6/lib/modules/libi2c.a
> > (II) Module i2c: vendor="The XFree86 Project"
> >         compiled for 4.3.0.1, module version = 1.2.0
> >         ABI class: XFree86 Video Driver, version 0.6
> > (==) MGA(0): Write-combining range (0xf0000000,0x200000)
> > (II) MGA(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
> > (II) MGA(0): I2C bus "DDC" initialized.
> > (II) MGA(0): I2C device "DDC:ddc2" registered at address 0xA0.
> > (II) MGA(0): I2C device "DDC:ddc2" removed.
> > (II) MGA(0): I2C Monitor info: (nil)
> > (II) MGA(0): end of I2C Monitor info
> >
> > The video bios is apparently not detected at all, and therefore not run.
> >
> > The kernel doesn't actually hang, only X gets stuck.  sysrq+T
> > dumped stack traces for all tasks except the xserver.  For X,
> > there was only one line identifying the xserver process and the fact
> > that it was Running.  No stack dump.  I managed to kill all tasks
> > and have init proceeding into init 2.
> >
> > So I wonder - is Debians X 4.3.0.1 buggy, or the kernel?
> > The fact remains that the newer kernels locks up while trying to use the
> > secondary radeon, while it actually works with 2.6.8.1.
> 
> I've had some luck in reproducing this, however I've had to retask my
> test machine to find some hangs in my real life application (can run
> for 5 or 6 days without crashing :-), so I might get back to looking
> for this at some stage but when is anybodys guess, all I did was take
> a Radeon AGP card, and a  PCI SiS crappy card and ran X on 2.6.10 and
> it hung....
> 
> Dave.
>
