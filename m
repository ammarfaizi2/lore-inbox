Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWALRju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWALRju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWALRjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:39:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:24199 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932461AbWALRjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:39:48 -0500
Date: Thu, 12 Jan 2006 09:39:26 -0800
From: Greg KH <greg@kroah.com>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, "Mike D. Day" <ncmike@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
Message-ID: <20060112173926.GD10513@kroah.com>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com> <43C65196.8040402@suse.de> <1137072089.2936.29.camel@laptopd505.fenrus.org> <43C66ACC.60408@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C66ACC.60408@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 03:42:20PM +0100, Gerd Hoffmann wrote:
> Arjan van de Ven wrote:
> >>  privcmd returns a filehandle which is then used 
> >>for ioctls (misc char dev maybe?). 
> >
> >
> >EWWWWWWWWWWWWWW
> >
> >what is wrong with open() ?????
> >things that return fd's that aren't open() (or dup and socket) are just
> >evil. Esp if it's in proc or sysfs.
> 
> Nothing is wrong with open, but probably the sentense above is a bit too 
> short.  If you call fd = open("/proc/xen/privcmd", ...) you'll get a 
> filehandle returned for the thingy (as usual) and then you'll use that 
> filehandle to call ioctl(fd, ...), so it's the usual unix way ...

Sounds like a normal filesystem, please don't abuse proc for this.

What exactly do the different ioctls do?  Do they have to be ioctls?
Can you use configfs or sysfs for most of the stuff there?

thanks,

greg k-h
