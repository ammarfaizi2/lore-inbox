Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUDTOLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUDTOLu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 10:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbUDTOLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 10:11:50 -0400
Received: from ra.sai.msu.su ([158.250.29.2]:56493 "EHLO ra.sai.msu.su")
	by vger.kernel.org with ESMTP id S262388AbUDTOLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 10:11:45 -0400
Date: Tue, 20 Apr 2004 18:11:12 +0400 (MSD)
From: "E.Rodichev" <er@sai.msu.su>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux problem (2.6.5)
In-Reply-To: <200404200736.38616.dtor_core@ameritech.net>
Message-ID: <Pine.GSO.4.58.0404201718220.4975@ra.sai.msu.su>
References: <Pine.GSO.4.58.0404200404360.22353@ra.sai.msu.su>
 <200404200736.38616.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not a problem of mousedev, but the problem of make menuconfig.

The relevant part of .config is

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

Starting from original linux-2.6.5.tar.gz it seems impossible to
disable CONFIG_INPUT_MOUSEDEV_PSAUX without disabling CONFIG_INPUT_MOUSEDEV.

If I comment out the line CONFIG_INPUT_MOUSEDEV_PSAUX by hand, make
silently restore this line to yes.

Regards,
E.R.

On Tue, 20 Apr 2004, Dmitry Torokhov wrote:

> On Monday 19 April 2004 07:26 pm, E.Rodichev wrote:
>
> > The reason is that in 2.6.5 it looks impossible to disable the existing
> > mouse driver, which conflicts with driver from Tuukka Toivonen. My
> > temporary solution was as follows:
> >
> >
> > --- drivers/input/Kconfig.orig ?2004-04-04 07:36:18.000000000 +0400
> > +++ drivers/input/Kconfig ? ? ? 2004-04-20 03:45:31.000000000 +0400
> > @@ -26,7 +26,6 @@ comment "Userland interfaces"
> >
> > ?config INPUT_MOUSEDEV
> > ? ? ? ? tristate "Mouse interface" if EMBEDDED
> > - ? ? ? default y
> > ? ? ? ? depends on INPUT
> > ? ? ? ? ---help---
> > ? ? ? ? ? Say Y here if you want your mouse to be accessible as char devices
> >
>
> Ok, I am slow today, but how does mousedev affect his psaux implementation?
> I can see that his module can conflict with psmouse (which is configurable),
> but mousedev?
>
> The reason it is always on because it is useful for any kind of mouse -
> serial, USB, PS/2. You really want to keep it around...
>
> --
> Dmitry
>

_________________________________________________________________________
Evgeny Rodichev                          Sternberg Astronomical Institute
email: er@sai.msu.su                              Moscow State University
Phone: 007 (095) 939 2383
Fax:   007 (095) 932 8841                       http://www.sai.msu.su/~er
