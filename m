Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUBTCCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 21:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267480AbUBTCCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 21:02:00 -0500
Received: from mail.kroah.org ([65.200.24.183]:53947 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267474AbUBTCBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 21:01:51 -0500
Date: Thu, 19 Feb 2004 17:54:34 -0800
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <1@pervalidus.net>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: HOWTO use udev to manage /dev
Message-ID: <20040220015433.GC3134@kroah.com>
References: <20040219185932.GA10527@kroah.com> <20040219191636.GC10527@kroah.com> <Pine.LNX.4.58.0402191918440.688@pervalidus.dyndns.org> <20040219230749.GA15848@kroah.com> <Pine.LNX.4.58.0402192033490.694@pervalidus.dyndns.org> <20040219235602.GI15848@kroah.com> <Pine.LNX.4.58.0402192057590.694@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0402192057590.694@pervalidus.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 09:51:52PM -0300, Frédéric L. W. Meunier wrote:
> On Thu, 19 Feb 2004, Greg KH wrote:
> 
> > So if you take out the line about starting udevd, does it
> > work for you?
> 
> No.
> 
> > How about changing the #!/bin/bash to #!/bin/sash in the
> > first line for the start_udev script?
> 
> I didn't have it, but compiled and changed. Yes, it works.
> 
> > What distro is this?
> 
> Slackware, with a cute rc.S. /bin/bash was also recompiled, shared:
> 
> $ ldd /bin/bash
>         libreadline.so.4 => /usr/lib/libreadline.so.4 (0x4001c000)
>         libhistory.so.4 => /usr/lib/libhistory.so.4 (0x40049000)
>         libncurses.so.5 => /lib/libncurses.so.5 (0x40050000)
>         libdl.so.2 => /lib/libdl.so.2 (0x4008f000)
>         libc.so.6 => /lib/libc.so.6 (0x40092000)
>         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
> 
> Maybe the problem ? Does yours differ ?

Mine does differ, but it is dynamic:

$ ldd /bin/bash
        linux-gate.so.1 =>  (0xffffe000)
        libtermcap.so.2 => /lib/libtermcap.so.2 (0x4d5b5000)
        libdl.so.2 => /lib/libdl.so.2 (0x4d3b4000)
        libc.so.6 => /lib/tls/libc.so.6 (0x4d254000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x4d238000)

> bash from Slackware:
> 
>         libtermcap.so.2 => /lib/libtermcap.so.2 (0x4001c000)
>         libdl.so.2 => /lib/libdl.so.2 (0x4005c000)
>         libc.so.6 => /lib/libc.so.6 (0x4005f000)
>         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
> 
> OK, I'll later boot with it and see if it works. If it does,
> I'll run strace with the other.

How about using sash?  That is statically linked.

> > Can you run strace on the start_udev script after boot to see who is
> > needing access to /dev/null?
> 
> I forgot to run it, but noticed there was a /dev/null, but a
> text file (0644). And I didn't create it anywhere.

That sounds like some program is trying to write to it.

Hm, there is a patch in the Red Hat version of udev that basically makes
udev do the start_udev logic, in the .c file because they do not have a
shell in their initrd.  If you can dig it out of there, that might be a
solution for you to use.

Other than that, how about running strace on start_udev when your rc.S
script calls it?  That might help out.

thanks,

greg k-h
