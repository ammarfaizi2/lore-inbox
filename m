Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbULHT10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbULHT10 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbULHT1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:27:25 -0500
Received: from gw.goop.org ([64.81.55.164]:43403 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261331AbULHTZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:25:08 -0500
Subject: Re: [PATCH] ioctl entries for joystick in compat_ioctl.h
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@ucw.cz>, Raphael Assenat <raph@raphnet.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030912200148.GA7711@ucw.cz>
References: <20030912112557.C10099@raphnet.net>
	 <20030912184145.GB5805@elf.ucw.cz>  <20030912200148.GA7711@ucw.cz>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 11:25:05 -0800
Message-Id: <1102533905.691.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-0.mozer.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-12 at 22:01 +0200, Vojtech Pavlik wrote:
> On Fri, Sep 12, 2003 at 08:41:45PM +0200, Pavel Machek wrote:
> > Hi!
> > Raphael Assenat <raph@raphnet.net> wrote:
> > > I wanted to use a joystick on my sparc64 workstation, and discovered that the
> > > joystick driver uses simple ioclt that are safe to pass from 32bit user space
> > > to 64bit kernel space. My patch adds the necessary entries in compat_ioctl.h.
> > > 
> > > There is only one missing ioctl in the patch. The ioctl is defined like this:
> > > #define JSIOCGNAME(len)         _IOC(_IOC_READ, 'j', 0x13, len)
> > > so the command does not have a fixed value. I dont know how to handle this one,
> > > but it is only used to get the joystick name, all the applications I tried work
> > > well even if this ioctl fails.

[...]

> > Vojtech, this fill be needed on x86-64, too. Can you take care of it?


> > I have tested this patch with snes9x and jstest.c without any problems.
> > 
> > Regards,
> > Raphael Assenat
> > 
> > --- linux-2.6.0-test4/fs/compat_ioctl.c Fri Aug 22 20:00:50 2003
> > +++ linux-2.6.0-test4-raph/fs/compat_ioctl.c    Sun Sep  7 19:03:52 2003
> > @@ -65,6 +65,7 @@
> >  #include <linux/ctype.h>
> >  #include <linux/ioctl32.h>
> >  #include <linux/ncp_fs.h>
> > +#include <linux/joystick.h>
> > 
> >  #include <net/sock.h>          /* siocdevprivate_ioctl */
> >  #include <net/bluetooth/bluetooth.h>
> > --- linux-2.6.0-test4/include/linux/compat_ioctl.h      Fri Aug 22 20:01:27
> > 2003
> > +++ linux-2.6.0-test4-raph/include/linux/compat_ioctl.h Sun Sep  7 20:07:57
> > 2003
> > @@ -680,3 +680,16 @@
> >  COMPATIBLE_IOCTL(NBD_PRINT_DEBUG)
> >  COMPATIBLE_IOCTL(NBD_SET_SIZE_BLOCKS)
> >  COMPATIBLE_IOCTL(NBD_DISCONNECT)
> > +
> > +/* little j */
> > +#if defined(CONFIG_INPUT_JOYDEV)||defined(CONFIG_INPUT_JOYDEV_MODULE)
> > +COMPATIBLE_IOCTL(JSIOCGVERSION)
> > +COMPATIBLE_IOCTL(JSIOCGAXES)
> > +COMPATIBLE_IOCTL(JSIOCGBUTTONS)
> > +COMPATIBLE_IOCTL(JSIOCSCORR)
> > +COMPATIBLE_IOCTL(JSIOCGCORR)
> > +COMPATIBLE_IOCTL(JSIOCSAXMAP)
> > +COMPATIBLE_IOCTL(JSIOCGAXMAP)
> > +COMPATIBLE_IOCTL(JSIOCSBTNMAP)
> > +COMPATIBLE_IOCTL(JSIOCGBTNMAP)
> > +#endif

I notice that this patch does not appear in current kernels, and the
joystick doesn't work for 32-bit apps on x86-64.  Did this patch ever
make it into the kernel?  Or some replacement?  If not, what's the
problem?

Thanks,
	J

