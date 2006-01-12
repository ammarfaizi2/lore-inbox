Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWALRjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWALRjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWALRjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:39:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:20615 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932460AbWALRjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:39:41 -0500
Date: Thu, 12 Jan 2006 09:38:16 -0800
From: Greg KH <greg@kroah.com>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: "Mike D. Day" <ncmike@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
Message-ID: <20060112173816.GC10513@kroah.com>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com> <43C65196.8040402@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C65196.8040402@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 01:54:46PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> >>Huh?  You can't just throw a "MODULE_VERSION()", and a module_init()
> >>somewhere into the xen code to get this to happen?  Then all of your
> >>configurable paramaters show up automagically.
> >
> >No, I can't. Xen does not have modules. Xen loads and runs linux.
> 
> You can.  Just look at a recent drivers/xen/blkback/blkback.c, the 
> module parameters specified there show up in 
> /sys/module/blkback/parameters, no matter whenever the code was built 
> statically into the kernel or as module (which curently doesn't work for 
> blkback anyway ...).
> 
> Any read-only attributes can trivially be implemented that way.  Simple 
> writable stuff (balloon driver?) probably too, I don't know whenever a 
> notify callback on parameter changes is possible though.

Yes it is.

> The current /proc files which are not simple attributes such as 
> /proc/xen/{privcmd,xenbus} are a bit more tricky, not sure what the best 
> approach for these is.  privcmd returns a filehandle which is then used 
> for ioctls (misc char dev maybe?).  xenbus can be opened and (I think) 
> read(2) on to listen for any xenbus activity, much like /proc/kmsg. 
> Suggestions what to use here instead of procfs?  Or just leave it there?

Your own filesystem?  You can do that in about 200 lines of code these
days :)

And no, it does not belong in procfs.

thanks,

greg k-h
