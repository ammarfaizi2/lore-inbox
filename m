Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRB0OqD>; Tue, 27 Feb 2001 09:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129469AbRB0Opo>; Tue, 27 Feb 2001 09:45:44 -0500
Received: from [138.6.98.137] ([138.6.98.137]:40967 "EHLO
	caspian.prebus.uppsala.se") by vger.kernel.org with ESMTP
	id <S129245AbRB0Opg>; Tue, 27 Feb 2001 09:45:36 -0500
Message-ID: <E44E649C7AA1D311B16D0008C73304460933B0@caspian.prebus.uppsala.se>
From: Per Erik Stendahl <PerErik@onedial.se>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Bug in cdrom_ioctl?
Date: Tue, 27 Feb 2001 15:42:05 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > In linux-2.4.2/drivers/cdrom/cdrom.c:cdrom_ioctl() branches
> > CDROM_SET_OPTIONS and CDROM_CLEAR_OPTIONS both return like this:
> > 
> >     return cdi->options;
> > 
> > If cdi->options is non-zero, the ioctl() calls returns non-zero.
> > My ioctl(2) manpage says that a successful ioctl() should return
> > zero. Now I dont know which is at fault here - the cdrom.c code or
> > the manpage. :-) Could somebody enlighten me?
> > 
> > /Per Erik Stendahl
> > -
> 
> Specifically, (at the API) upon an error -1 (nothing else) is to be
> returned and 'errno' set appropriately. The results of a 
> successful ioctl()
> operation is supposed to have been returned in the parameter list (via
> pointer). So, you have found a design bug. I wonder how much stuff
> gets broken if this gets fixed?

I looked around a bit more in cdrom_ioctl(). There are more cases
where data gets passed back in the return code. If the official
ioctl() policy is to only pass success/fail status in the return
code then it would require some work to fix cdrom_ioctl (breaking
a number of apps in the process :-).

> I suggest you just fix it and see what breaks. Maybe sombody's
> CD writer will break, but a patch will quickly be made by the
> maintainer(s).

For now I did the quickest thing and check ioctl() for -1 instead
of 0.

Is there any good documentation on ioctl calls somewhere?

/Per Erik Stendahl
