Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269300AbUJFSEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269300AbUJFSEe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269340AbUJFSEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:04:34 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:6821 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269328AbUJFSEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:04:20 -0400
Date: Wed, 6 Oct 2004 20:04:21 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-ID: <20041006180421.GD10153@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041006173823.GA26740@kroah.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20041006173823.GA26740@kroah.com>
User-Agent: Mutt/1.3.28i
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: greg@kroah.com, akpm@osdl.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 October 2004 10:38:23 -0700, Greg KH wrote:
> On Tue, Oct 05, 2004 at 08:52:14PM +0200, J?rn Engel wrote:
> > --- linux-2.6.8cow/init/main.c~console	2004-10-05 20:46:40.000000000 +0200
> > +++ linux-2.6.8cow/init/main.c	2004-10-05 20:46:08.000000000 +0200
> > @@ -695,8 +695,11 @@
> >  	system_state = SYSTEM_RUNNING;
> >  	numa_default_policy();
> >  
> > -	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
> > +	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0) {
> >  		printk("Warning: unable to open an initial console.\n");
> > +		if (open("/dev/null", O_RDWR, 0) == 0)
> > +			printk("         Falling back to /dev/null.\n");
> > +	}
> 
> Your printk() calls need the proper KERN_* level.

As does the original one.  Which one would you like for both?

> And what happens if you can't open /dev/null?

Same as before.

> (hint, udev enabled boxes
> usually do not have a /dev/null this early in the boot process).  Does
> this mean we should add a /dev/null to the initramfs image, like the
> /dev/console node we currently have there?

Yes, that would fix the case.  Is this a problem?

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein
