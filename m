Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272468AbTHBJ5z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 05:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272472AbTHBJ5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 05:57:55 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:25056 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S272468AbTHBJ5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 05:57:53 -0400
Subject: Re: Linux 2.4.22-pre10-ac1
From: Marcel Holtmann <marcel@holtmann.org>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030802094153.GA4901@ranty.pantax.net>
References: <200308012216.h71MGLe31285@devserv.devel.redhat.com>
	<20030802040917.GA22776@ip68-4-255-84.oc.oc.cox.net>
	<20030802063749.GA23189@ranty.pantax.net>
	<1059816240.22299.31.camel@pegasus> 
	<20030802094153.GA4901@ranty.pantax.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Aug 2003 11:57:31 +0200
Message-Id: <1059818258.22190.43.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manuel,

> > > > ccache gcc -D__KERNEL__ -I/home/barryn/lsx/kernels/2.4/build/linux-2.4.22-pre10-ac1/include -Wall -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS -include /home/barryn/lsx/kernels/2.4/build/linux-2.4.22-pre10-ac1/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=firmware_class  -DEXPORT_SYMTAB -c firmware_class.c
> > > > firmware_class.c: In function `call_helper':
> > > > firmware_class.c:78: error: `hotplug_path' undeclared (first use in this function)
> > > > firmware_class.c:78: error: (Each undeclared identifier is reported only once
> > > > firmware_class.c:78: error: for each function it appears in.)
> > > > make[1]: *** [firmware_class.o] Error 1
> > > > make[1]: Leaving directory `/home/barryn/lsx/kernels/2.4/build/linux-2.4.22-pre10-ac1/lib'
> > > > make: *** [_mod_lib] Error 2
> > > [snip]
> > > > # CONFIG_HOTPLUG is not set
> > > 
> > >  CONFIG_HOTPLUG needs to be enabled, attached patch to make it explicit:
> > 
> > your patch didn't fix the problem, because it will be the same if some
> > internal driver needs request_firmware() and CONFIG_HOTPLUG is not set.
> > The call_helper() funtcion needs to be put into #idef's.
> 
>  request_firmware() needs hotplug to do anything useful, without
>  hotplug it doesn't make any sense. It is useless.

not quite true. If hotplug is not enabled it tells the driver that the
firmware can't be loaded. It is the same if hotplug_path is zero, or you
don't have the firmware.agent script, or your firmware is not present on
the filesystem or any other worse happens. But to handle these problems
is up to the driver.

You will have the same problem, if you disable the /proc filesystem or
don't mount it. You can't control all things a user is doing from inside
the kernel.

Regards

Marcel


