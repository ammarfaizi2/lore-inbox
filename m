Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285326AbRLGACR>; Thu, 6 Dec 2001 19:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285328AbRLGACH>; Thu, 6 Dec 2001 19:02:07 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:2055 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285326AbRLGABy>;
	Thu, 6 Dec 2001 19:01:54 -0500
Date: Thu, 6 Dec 2001 16:00:55 -0800
From: Greg KH <greg@kroah.com>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: jonathan@daria.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Q: device(file) permissions for USB
Message-ID: <20011206160055.O2710@kroah.com>
In-Reply-To: <fa.ljcupnv.1ghotjk@ifi.uio.no> <664.3c0fd1b7.a66fa@trespassersw.daria.co.uk> <20011206223050.179cd30e.rene.rebe@gmx.net> <20011206152721.M2710@kroah.com> <20011207004521.19a131d4.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011207004521.19a131d4.rene.rebe@gmx.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 08 Nov 2001 18:50:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 12:45:21AM +0100, Rene Rebe wrote:
> 
> For usbfs I have to do script-hacking in /sbin/hotplug (I do not know
> how I did it since it is on my brothers box somewhere at the other
> end of Germany ... - but is was some if [$1 = "usb"]; then; chmod
> or maybe even some find /proc -name "xyz..." ...). Especially because
> I only got one parameter ($1 == usb?) the rest was empty. So even
> providing filesnames what got hot-plugged would be nice.

It's there in the DEVICE environment variable.  See
http://linux-hotplug.sourceforge.net/?selected=usb for more
documentation.

So a simple /sbin/hotplug script of:
	#!/bin/sh
	if [ "$1" == "usb" ]; then
		chmod 666 $DEVICE
	fi

would work just fine for your needs.

> Wouldn't it be nicer to use devfs and add this procfs hack for the
> "major dists"? - They could even mount devfs to /devfs and so use
> all the old-way in /dev and only use devfs for the usb stuff.

It's not a procfs hack, it is a stand alone filesystem.  The fact that
you happen to mount it within the /proc filesystem is your option.

The USB developers did not want to force people to use devfs to use USB
devices, and based on the fact that not a single distro is using devfs
(the one that did, now recommends that you disable it) backs up this
choice.

> I do not know why they adapt so slowly to such a cool technology
> anyway ...

See the numerous lkml posts about why this is so.

thanks,

greg k-h
