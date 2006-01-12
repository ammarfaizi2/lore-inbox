Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161188AbWALTJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbWALTJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWALTJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:09:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:4010 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161188AbWALTJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:09:11 -0500
Date: Thu, 12 Jan 2006 11:08:45 -0800
From: Greg KH <greg@kroah.com>
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Gerd Hoffmann <kraxel@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       "Mike D. Day" <ncmike@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
Message-ID: <20060112190845.GA13073@kroah.com>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com> <43C65196.8040402@suse.de> <1137072089.2936.29.camel@laptopd505.fenrus.org> <43C66ACC.60408@suse.de> <20060112173926.GD10513@kroah.com> <43C6A5B4.80801@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C6A5B4.80801@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 12:53:40PM -0600, Anthony Liguori wrote:
> Greg KH wrote:
> 
> >What exactly do the different ioctls do?  Do they have to be ioctls?
> >Can you use configfs or sysfs for most of the stuff there?
> > 
> >
> The canonical example is /proc/xen/privcmd which is our userspace 
> hypercall interface.  A hypercall is software interrupt with a number of 
> parameters passed via registers.  This has to come from ring 1 for 
> security reasons (the kernel is running in ring 1).
> 
> We wish to make management hypercalls as the root user in userspace 
> which means we have to go through the kernel.  Currently, we do this by 
> having /proc/xen/privcmd accept an ioctl() that takes a structure that 
> describe the register arguments.  The kernel interface allows us to 
> control who in userspace can execute hypercalls.
> 
> It would perhaps be possible to use a read/write interface for 
> hypercalls but ioctl() seems a little less awkward.  Suggestions are 
> certainly appreciated though.
> 
> Right now, I think a misc char device with an ioctl() interface seems 
> like the most promising way to do this.  This doesn't seem like the sort 
> of think one would want to expose in sysfs...

ick ick ick.

Why not do the same thing that the Cell developers did for their
"special syscalls"?  Or at the least, make it a "real" syscall like the
ppc64 developers did.  It's not like there isn't a whole bunch of "prior
art" in the kernel today that you should be ignoring.

Please don't abuse /proc with ioctls like that.

And if you tried to do that with sysfs...

thanks,

greg k-h
