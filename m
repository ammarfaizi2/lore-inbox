Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRB0Qty>; Tue, 27 Feb 2001 11:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129607AbRB0Qtf>; Tue, 27 Feb 2001 11:49:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15747 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129598AbRB0Qt3>; Tue, 27 Feb 2001 11:49:29 -0500
Date: Tue, 27 Feb 2001 11:48:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Per Erik Stendahl <PerErik@onedial.se>
cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Bug in cdrom_ioctl?
In-Reply-To: <E44E649C7AA1D311B16D0008C73304460933B0@caspian.prebus.uppsala.se>
Message-ID: <Pine.LNX.3.95.1010227113852.18337A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001, Per Erik Stendahl wrote:

> 
> > > In linux-2.4.2/drivers/cdrom/cdrom.c:cdrom_ioctl() branches
> > > CDROM_SET_OPTIONS and CDROM_CLEAR_OPTIONS both return like this:
> > > 
> > >     return cdi->options;
> > > 
> > > If cdi->options is non-zero, the ioctl() calls returns non-zero.
> > > My ioctl(2) manpage says that a successful ioctl() should return
> > > zero. Now I dont know which is at fault here - the cdrom.c code or
> > > the manpage. :-) Could somebody enlighten me?
> > > 
> > > /Per Erik Stendahl
> > > -
> > 
> > Specifically, (at the API) upon an error -1 (nothing else) is to be
> > returned and 'errno' set appropriately. The results of a 
> > successful ioctl()
> > operation is supposed to have been returned in the parameter list (via
> > pointer). So, you have found a design bug. I wonder how much stuff
> > gets broken if this gets fixed?
> 
> I looked around a bit more in cdrom_ioctl(). There are more cases
> where data gets passed back in the return code. If the official
> ioctl() policy is to only pass success/fail status in the return
> code then it would require some work to fix cdrom_ioctl (breaking
> a number of apps in the process :-).
> 
> > I suggest you just fix it and see what breaks. Maybe somebody's
> > CD writer will break, but a patch will quickly be made by the
> > maintainer(s).
> 
> For now I did the quickest thing and check ioctl() for -1 instead
> of 0.
> 
> Is there any good documentation on ioctl calls somewhere?
> 
> /Per Erik Stendahl
> 

Not that I've seen. There may be a C89 spec. Somebody was checking
for POSIX conformance in the kernel API. I don't know if anybody
is doing that anymore.

Looking at various documentation, I see things like "usually -1
indicates error...".  This probably means that "anything goes",
which is absurd, but probable. At one time you could get bludgeoned
for writing an ioctl() that returned anything but 0 and -1. Now,
maybe anything goes.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


