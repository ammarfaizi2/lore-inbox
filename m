Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267578AbUBSXqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 18:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267585AbUBSXqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 18:46:52 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:6298 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S267578AbUBSXqp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 18:46:45 -0500
X-qfilter-stat: ok
X-Analyze: Velop Mail Shield v0.0.4
Date: Thu, 19 Feb 2004 20:46:42 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: HOWTO use udev to manage /dev
In-Reply-To: <20040219230749.GA15848@kroah.com>
Message-ID: <Pine.LNX.4.58.0402192033490.694@pervalidus.dyndns.org>
References: <20040219185932.GA10527@kroah.com> <20040219191636.GC10527@kroah.com>
 <Pine.LNX.4.58.0402191918440.688@pervalidus.dyndns.org> <20040219230749.GA15848@kroah.com>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Greg KH wrote:

> On Thu, Feb 19, 2004 at 07:22:30PM -0300, Frédéric L. W. Meunier wrote:
> > On Thu, 19 Feb 2004, Greg KH wrote:
> >
> > >  - modify the rc.sysinit script to call the start_udev script as one of
> > >    the first things that it does, but after /proc and /sys are mounted.
> > >    I did this with the latest Fedora startup scripts with the patch at
> > >    the end of this file.
> > >
> > >  - make sure the /etc/udev/udev.conf file lists the udev_root as /dev.
> > >    It should contain the following line in order to work properly.
> > > 	udev_root="/dev/"
> > >
> > >  - reboot into a 2.6 kernel and watch udev create all of the initial
> > >    device nodes in /dev
> > >
> > >
> > > If anyone has any problems with this, please let me, and the
> > > linux-hotplug-devel@lists.sourceforge.net mailing list know.
> >
> > Unless I'm missing something, it doesn't seem to work if you
> > don't have /dev/null before it gets mounted.
>
> Did you build udev using glibc or klibc?  I used klibc and it worked
> just fine, as udev and udevd does not need /dev/null to work, unlike
> programs built against glibc.

I used your instructions, so klibc.

# ldd /sbin/udev*

/sbin/udev:
        not a dynamic executable
/sbin/udevd:
        not a dynamic executable
/sbin/udevinfo:
        not a dynamic executable
/sbin/udevsend:
        not a dynamic executable
/sbin/udevtest:
        not a dynamic executable

It doesn't complain if I mount in /udev after I boot with
devfs, probably because it can find /dev/null etc. But I want
to boot with devfs=nomount and use it in /dev.

I changed /etc/rc.d/rc.S to:

[ -e /dev/.devfsd -a -x /sbin/devfsd ] && devfsd /dev

mount -vn -t proc proc /proc # Needed for LABEL= in /etc/fstab

mount -vn -t sysfs sysfs /sys

[ ! -e /dev/.devfsd -a -d /sys/block ] && /etc/rc.d/start_udev

but it shouldn't make any difference. It's just to not use both
at the same time or try to run the script in 2.4.

-- 
http://www.pervalidus.net/contact.html
