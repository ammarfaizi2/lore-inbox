Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTILUCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbTILUCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:02:52 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:48772 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261823AbTILUB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:01:59 -0400
Date: Fri, 12 Sep 2003 22:01:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Raphael Assenat <raph@raphnet.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ioctl entries for joystick in compat_ioctl.h
Message-ID: <20030912200148.GA7711@ucw.cz>
References: <20030912112557.C10099@raphnet.net> <20030912184145.GB5805@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912184145.GB5805@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 08:41:45PM +0200, Pavel Machek wrote:
> Hi!
> 
> > I wanted to use a joystick on my sparc64 workstation, and discovered that the
> > joystick driver uses simple ioclt that are safe to pass from 32bit user space
> > to 64bit kernel space. My patch adds the necessary entries in compat_ioctl.h.
> > 
> > There is only one missing ioctl in the patch. The ioctl is defined like this:
> > #define JSIOCGNAME(len)         _IOC(_IOC_READ, 'j', 0x13, len)
> > so the command does not have a fixed value. I dont know how to handle this one,
> > but it is only used to get the joystick name, all the applications I tried work
> > well even if this ioctl fails.
> 
> Well, whoever invented that JSIOCGNAME should be shot. That is not
> single ioctl, its 2^14 of them!

Well, who could ever have known that this will be a problem in 1998?
It's not the only ioctl done this way.

> Testing for CONFIG_INPUT_JOYDEV_MODULE looks like bad idea. AFAIR
> CONFIG_INPUT_JOYDEV_MODULE implies CONFIG_INPUT_JOYDEV. But this would
> mean that you can not insert joydev module into kernel compiled with
> JOYDEV=n. Perhaps it better to just simply kill the ifdef?
> 
> Vojtech, this fill be needed on x86-64, too. Can you take care of it?

Yes, I will.

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
> 
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
