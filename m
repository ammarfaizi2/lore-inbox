Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272379AbTHBJmP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 05:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272381AbTHBJmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 05:42:15 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:55432 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S272379AbTHBJmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 05:42:14 -0400
Date: Sat, 2 Aug 2003 11:41:53 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre10-ac1
Message-ID: <20030802094153.GA4901@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <200308012216.h71MGLe31285@devserv.devel.redhat.com> <20030802040917.GA22776@ip68-4-255-84.oc.oc.cox.net> <20030802063749.GA23189@ranty.pantax.net> <1059816240.22299.31.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059816240.22299.31.camel@pegasus>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 11:23:53AM +0200, Marcel Holtmann wrote:
> Hi Manuel,
> 
> > > ccache gcc -D__KERNEL__ -I/home/barryn/lsx/kernels/2.4/build/linux-2.4.22-pre10-ac1/include -Wall -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS -include /home/barryn/lsx/kernels/2.4/build/linux-2.4.22-pre10-ac1/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=firmware_class  -DEXPORT_SYMTAB -c firmware_class.c
> > > firmware_class.c: In function `call_helper':
> > > firmware_class.c:78: error: `hotplug_path' undeclared (first use in this function)
> > > firmware_class.c:78: error: (Each undeclared identifier is reported only once
> > > firmware_class.c:78: error: for each function it appears in.)
> > > make[1]: *** [firmware_class.o] Error 1
> > > make[1]: Leaving directory `/home/barryn/lsx/kernels/2.4/build/linux-2.4.22-pre10-ac1/lib'
> > > make: *** [_mod_lib] Error 2
> > [snip]
> > > # CONFIG_HOTPLUG is not set
> > 
> >  CONFIG_HOTPLUG needs to be enabled, attached patch to make it explicit:
> 
> your patch didn't fix the problem, because it will be the same if some
> internal driver needs request_firmware() and CONFIG_HOTPLUG is not set.
> The call_helper() funtcion needs to be put into #idef's.

 request_firmware() needs hotplug to do anything useful, without
 hotplug it doesn't make any sense. It is useless.

 The patch may not be it, but, IMHO, the way to go is making
 request_firmware() explicitly depend on hotplug, because it does depend
 on it. Suggestions are welcomed.

 Regards

 	Manuel
