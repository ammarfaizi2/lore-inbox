Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbUL2B4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUL2B4s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 20:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbUL2B4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 20:56:48 -0500
Received: from dsl-209-183-20-58.tor.primus.ca ([209.183.20.58]:19840 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261292AbUL2B4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 20:56:44 -0500
Date: Tue, 28 Dec 2004 20:56:22 -0500
From: William Park <opengeometry@yahoo.ca>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, Andreas Unterkircher <unki@netshadow.at>
Subject: Re: waiting 10s before mounting root filesystem?
Message-ID: <20041229015622.GA2817@node1.opengeometry.net>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	linux-kernel@vger.kernel.org,
	Andreas Unterkircher <unki@netshadow.at>
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <Pine.LNX.4.61.0412290231580.3528@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412290231580.3528@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 02:38:25AM +0100, Jesper Juhl wrote:
> On Tue, 28 Dec 2004, William Park wrote:
> 
> > On Mon, Dec 27, 2004 at 10:23:34PM +0100, Andreas Unterkircher wrote:
> > > [1] http://www.xenotime.net/linux/usb/usbboot-2422.patch

> > Thanks Andreas.  I can now boot from my el-cheapo USB key drive
> > (256MB SanDisk Cruzer Mini).  Since mine takes about 5sec to show
> > up, I decided to wait 5sec instead of 1sec.  Here is diff for
> > 2.6.10:
> > 
> > --- ./init/do_mounts.c--orig	2004-12-27 17:36:35.000000000 -0500
> > +++ ./init/do_mounts.c	2004-12-28 17:27:26.000000000 -0500
> > @@ -301,7 +301,14 @@ retry:
> >  				root_device_name, b);
> >  		printk("Please append a correct \"root=\" boot option\n");
> >  
> How about adding a loglevel to this printk() while you are at it?  like 
> this for instance:
> 	printk(KERN_ERR "Please append a correct \"root=\" boot option\n");
> 
> or maybe that should be KERN_CRIT ...
> 
> 
> > +#if 0	/* original code */
> >  		panic("VFS: Unable to mount root fs on %s", b);
> > +#else
> > +		printk ("Waiting 5 seconds to try again...\n");
> 
> ^^^ And here I think a loglevel of KERN_INFO would be resonable :
> 	printk (KERN_INFO "Waiting 5 seconds to try mounting root fs again...\n");
> 
> 
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		schedule_timeout(5 * HZ);
> 
> I could be mistaken, but I would have said that msleep would have been 
> better here.???
> 
> 
> > +		goto retry;
> > +#endif
> >  	}
> >  	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
> 
> ^^^ and this one : 
> 	panic(KERN_CRIT "VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
> 
> 
> -- 
> Jesper Juhl

Jesper, I have no idea what I'm doing. :-) I simply adapted the 2.4
patch for 2.6.10 kernel.

Ideally, motherboard should support booting from USB key drive directly.
I'm told that most modern motherboards do support usbboot, but my
machine doesn't.  So, I trying to load the kernel from floppy (harddisk
for testing purpose).  This is part of my attempt to build Linux
thin-client out of mini-ITX type of computer (Via CLE266 chipset, Via C3
cpu).

Now, I need to find a machine that actually can do usbboot...

-- 
William Park <opengeometry@yahoo.ca>
Open Geometry Consulting, Toronto, Canada
Linux solution for data processing. 
