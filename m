Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbTLZRaO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 12:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbTLZRaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 12:30:14 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:7871 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S265193AbTLZRaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 12:30:10 -0500
Date: Fri, 26 Dec 2003 18:29:52 +0100
From: Manuel Estrada Sainz <ranty@debian.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20031226172952.GB16008@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <200312210137.41343.dtor_core@ameritech.net> <20031222230559.GE15612@ranty.pantax.net> <20031222232250.GB4358@kroah.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20031222232250.GB4358@kroah.com>
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: ranty@ranty.pantax.net
Subject: Re: [2.6 PATCH/RFC] Firmware loader - fix races and resource dealloocation problems
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 3.1 (built Wed Nov 26 20:40:04 CET 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 03:22:50PM -0800, Greg KH wrote:
> On Tue, Dec 23, 2003 at 12:05:59AM +0100, Manuel Estrada Sainz wrote:
> > 
> >  What can actually be a problem is that hotplug delays event handling
> >  while booting, and if firmware needing drivers load at boot time they
> >  usually timeout before the event gets handled, and when hotplug tryies
> >  to handle the event the files are already gone.
> 
> What would remove the files?

 Once the firmware load is over, whether normally or because of any error
 request_firmware() cleans up, and that includes removing sysfs files. 

> And if you need firmware at boot time, stick it, and the firmware loader
> in initramfs.

 Once klibc and hotplug go into the standard kernel I'll look into
 request_firmware support there, even ACPI could benefit from it, but
 until then ...

 Although I don't have it clear, what happens between mounting the real
 root device on top of rootfs and hotplug starting to handle events?
 Maybe hotplug could treat firmware events specially and not delay them
 even while booting.

 I guess that we will get the real taste of it once initramfs gets it's
 klibc and starts being used broadly.

 Have a nice day

 	Manuel


-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
