Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVJRSkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVJRSkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 14:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVJRSkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 14:40:09 -0400
Received: from sccrmhc12.comcast.net ([63.240.77.82]:39555 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750953AbVJRSkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 14:40:07 -0400
Date: Tue, 18 Oct 2005 11:05:33 -0400
From: Christopher Li <usb-devel@chrisli.org>
To: Greg KH <greg@kroah.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: usb: Patch for USBDEVFS_IOCTL from 32-bit programs
Message-ID: <20051018150533.GB21786@64m.dyndns.org>
References: <20051017181554.77d0d45d.zaitcev@redhat.com> <20051018171333.GA29504@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018171333.GA29504@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 10:13:33AM -0700, Greg KH wrote:
> > I'm cross-posting to l-k because someone I know was making sounds at
> > a notion of #ifdef CONFIG_COMPAT. But I think this solutions is superior
> > to adding anything outside of devio.c.
> 
> Why not put this in fs/compat_ioctl.c where the other usbfs 32bit ioctls
> are?
> 
There are a few exception like submit urb and reap urb is in devio.c
because it contain user space pointer which need some state if put
under compat_ioctl.c.

I want to know why it is better in devio.c in this case as well.

Another comment regarding the change, the USBDEVFS_IOCTL is passing an ioctl
buffer inside another ioctl wrapper.

I am a little nervous no check have been done to what ioctl it is
passing. Most of the case you don't need to convert the buffer, but
what if there is some ioctl need to do something special.

On the safe side, I am expecting a big switch to list all the ioctl
we known can safely pass, can grow the list when needed.

BTW, the other common case is the disconnect ioctl.

Chris

