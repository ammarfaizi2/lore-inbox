Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWAXVa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWAXVa1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWAXVa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:30:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15238 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750725AbWAXVa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:30:26 -0500
Date: Tue, 24 Jan 2006 22:30:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-ID: <20060124213010.GA1602@elf.ucw.cz>
References: <200601240929.37676.rjw@sisk.pl> <20060124131312.0545262d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124131312.0545262d.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This patch introduces a user space interface for swsusp.
> 
> How will we know if/when this feature is ready for mainline?  What criteria
> can we use to judge that?

It was stable for me last time I tested. I do not think it needs
longer -mm testing than usual patches.

> Will you be developing and long-term maintaining the userspace tools?  Is
> it your expectation/hope that distros will migrate onto using them?
> etc.

It looks like I'll do it, or Rafael can have it as an original
author. They are currently hosted at sf.net/projects/suspend. SuSE is
very likely to use them for 10.2 or so -- we want to provide nice
splashscreen so that users are not scared :-), we would like to do
encryption/compression too, etc.

> > +static int snapshot_ioctl(struct inode *inode, struct file *filp,
> > +                          unsigned int cmd, unsigned long arg)
> > +{
> >
> > ...
> >
> > +	case SNAPSHOT_ATOMIC_RESTORE:
> > +		if (data->mode != O_WRONLY || !data->frozen ||
> > +		    !snapshot_image_loaded(&data->handle)) {
> > +			error = -EPERM;
> > +			break;
> > +		}
> > +		down(&pm_sem);
> > +		pm_prepare_console();
> > +		error = device_suspend(PMSG_FREEZE);
> > +		if (!error) {
> > +			mb();
> > +			error = swsusp_resume();
> > +			device_resume();
> > +		}
> 
> whee, what does the mystery barrier do?  It'd be nice to comment this
> (please always comment open-coded barriers).

It is probably relic from very early code, should not be needed, but
everyone is scared of removing it.
								Pavel
-- 
Thanks, Sharp!
