Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUBSXH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 18:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267414AbUBSXH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 18:07:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:40936 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267415AbUBSXH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 18:07:56 -0500
Date: Thu, 19 Feb 2004 15:07:49 -0800
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <1@pervalidus.net>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: HOWTO use udev to manage /dev
Message-ID: <20040219230749.GA15848@kroah.com>
References: <20040219185932.GA10527@kroah.com> <20040219191636.GC10527@kroah.com> <Pine.LNX.4.58.0402191918440.688@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0402191918440.688@pervalidus.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 07:22:30PM -0300, Frédéric L. W. Meunier wrote:
> On Thu, 19 Feb 2004, Greg KH wrote:
> 
> >  - modify the rc.sysinit script to call the start_udev script as one of
> >    the first things that it does, but after /proc and /sys are mounted.
> >    I did this with the latest Fedora startup scripts with the patch at
> >    the end of this file.
> >
> >  - make sure the /etc/udev/udev.conf file lists the udev_root as /dev.
> >    It should contain the following line in order to work properly.
> > 	udev_root="/dev/"
> >
> >  - reboot into a 2.6 kernel and watch udev create all of the initial
> >    device nodes in /dev
> >
> >
> > If anyone has any problems with this, please let me, and the
> > linux-hotplug-devel@lists.sourceforge.net mailing list know.
> 
> Unless I'm missing something, it doesn't seem to work if you
> don't have /dev/null before it gets mounted.

Did you build udev using glibc or klibc?  I used klibc and it worked
just fine, as udev and udevd does not need /dev/null to work, unlike
programs built against glibc.

As for needing the fb nodes, you should probably just add them to the
start_udev script in the section that we add the other needed symlinks
to /dev until the kernel starts exporting those sysfs entries (hopefully
any day now...)

thanks,

greg k-h
