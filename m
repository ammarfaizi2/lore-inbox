Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVFUICj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVFUICj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVFUIAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:00:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:28649 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262043AbVFUGqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:46:13 -0400
Date: Mon, 20 Jun 2005 23:45:54 -0700
From: Greg KH <greg@kroah.com>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Message-ID: <20050621064554.GC15239@kroah.com>
References: <200506191639.27970.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506191639.27970.nick@linicks.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 04:39:27PM +0100, Nick Warne wrote:
> Andrew Haninger wrote:
> 
> > Anyway, just a heads-up to anyone else experiencing a breaking of
> > 'less' and missing /dev files.
> 
> Yep... I had 'less' break too (you will find 'man' is broke also, rolling on 
> from that).
> 
> It turns out to be a problem (typo?) in  /etc/udev/rules.d/udev.rules
> 
> Try changing:
> 
> # pty devices
> KERNEL="pty[p-za-e][0-9a-f]*", NAME="pty/m%n", SYMLINK="%k"
> KERNEL="tty[p-za-e][0-9a-f]*", NAME="tty/s%n", SYMLINK="%k"
> 
> to:
> 
> # pty devices
> KERNEL="pty[p-za-e][0-9a-f]*", NAME="pty/m%n", SYMLINK="%k"
> KERNEL="tty[p-za-e][0-9a-f]*", NAME="pty/s%n", SYMLINK="%k"
> 
> (change is in second line tty -> pty)

Hm, that's what already ships with the udev tarball in the gentoo rule
set (which is usually the most up-to-date rule set in the tarball.)

Which one are you looking at?

> As to the missing /dev/ entries - remember you are using udev now - they 
> appear 'on the fly' as and when you plug something in - ensure you have set 
> 'hotplug' to start.

Not necessarily, people are getting udev working and full hotplug
support by setting /sbin/hotplug to NULL.  Ah, the magic of netlink...

thanks,

greg k-h
