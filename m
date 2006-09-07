Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWIGWGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWIGWGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWIGWGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:06:12 -0400
Received: from mail.suse.de ([195.135.220.2]:60587 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751893AbWIGWGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:06:11 -0400
Date: Thu, 7 Sep 2006 15:05:59 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Subject: Re: Naughty ramdrives
Message-ID: <20060907220559.GA29771@kroah.com>
References: <20060907205927.GA5193@martell.zuzino.mipt.ru> <20060907145412.db920bb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907145412.db920bb5.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 02:54:12PM -0700, Andrew Morton wrote:
> On Fri, 8 Sep 2006 00:59:27 +0400
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > You'd laugh, but...
> > 
> > Summary:
> > 
> > 	After loading and unloading rd.ko many times "ls -l /dev/ram*"
> > 	results are not persistent.
> > 
> > Steps to reproduce:
> > 
> > 	# while true; do modprobe rd && rmmod rd; done
> > 		[wait ~10 seconds]
> > 	^C
> > 	# modprobe rd
> > 
> > 	# ls -l /dev/ram*
> > 	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram12 -> rd/12
> > 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram6 -> rd/6
> > 	# ls -l /dev/ram*
> > 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram0 -> rd/0
> > 	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram13 -> rd/13
> > 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram6 -> rd/6
> > 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram7 -> rd/7
> > 	# ls -l /dev/ram*
> > 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram0 -> rd/0
> > 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram1 -> rd/1
> > 	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram11 -> rd/11
> > 	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram12 -> rd/12
> > 	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram14 -> rd/14
> > 	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram15 -> rd/15
> > 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram3 -> rd/3
> > 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram7 -> rd/7
> > 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram8 -> rd/8
> > 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram9 -> rd/9
> > 
> > Versions:
> > 
> > 	Linux 2.6.18-rc5
> > 	udev 087
> 
> So I assume udev is still madly crunching on its message backlog while
> this is happening?

It shouldn't be, this should not take that long.  Run 'udevmonitor' to
see what udev is doing at the moment to verify this or not.

> If so, ug.

I agree.  What distro is this?

I just tested this on my box running Gentoo and a newer version of udev
(099), and it worked just fine.  It took a while for udev to catch back
up with the flood of events, but it did and everything was fine.  No
harm done in the end.

thanks,

greg k-h
