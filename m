Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTDDWxN (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbTDDWxN (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 17:53:13 -0500
Received: from smtp-out2.iol.cz ([194.228.2.87]:14046 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261413AbTDDWxM (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 17:53:12 -0500
Date: Sat, 5 Apr 2003 01:03:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: New Software Suspend Patch for testing.
Message-ID: <20030404230320.GB154@elf.ucw.cz>
References: <1049454721.2418.33.camel@laptop-linux.cunninghams> <20030404133037.GA1333@elf.ucw.cz> <1049486400.3512.12.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049486400.3512.12.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > @@ -1804,7 +1801,8 @@
> >  	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
> >  		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n",
> >  			drive->name, drive->head);
> > -		if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
> > +		if (((drive->id->cfs_enable_2 & 0x3000) && drive->wcache) ||
> > +		    ((drive->id->command_set_1 & 0x20) && drive->id->cfs_enable_1 & 0x20))
> >  			if (do_idedisk_flushcache(drive))
> >  				printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
> >  					drive->name);
> > 
> > Is this swsusp related?
> 
> Yes. Under 2.4, some people found that if the writeback cache isn't
> flushed before we powerdown, the image isn't completely saved. This was
> the fix (the first test is the original one, the second is based upon
> hdparm's tests for writeback cache).

But this looks like you are fixing generic bug, which could make
kernel do something very wrong even without swsusp, right? If so,
submit it to Alan, ASAP.

> > What is this?
> 
> Used in the 2.4 version for kswsusp daemon. It provides another way to
> start the process. I agree with you that we probably don't want to
> implement this in 2.5 - I just forgot about removing it (I'm not
> claiming that this code is perfectly cleaned up!)

Sorry, I figured out it might be easier if I give you at least some
comments before you start splitting patch up -- it should be easier
for you this way.

								Pavel

-- 
When do you have heart between your knees?
