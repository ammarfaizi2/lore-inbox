Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271747AbTHMKqY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 06:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271746AbTHMKqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 06:46:24 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:24328 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271743AbTHMKqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 06:46:22 -0400
Date: Wed, 13 Aug 2003 12:46:19 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops in sd_shutdown
Message-ID: <20030813104619.GA7421@win.tue.nl>
References: <Pine.LNX.4.53.0308111426570.16008@thevillage.soulcatcher> <20030812002844.B1353@pclin040.win.tue.nl> <20030812075353.A18547@infradead.org> <20030812213549.GA2158@kroah.com> <20030813002450.GA8712@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813002450.GA8712@beaverton.ibm.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 05:24:50PM -0700, Mike Anderson wrote:

> > > Well, this same problem could show upb in any other driver.  Could
> > > you instead send a patch to Pat that the driver model never calls
> > > the shutdown method for a driver that hasn't finished ->probe?
> > 
> > I think it already will not do that due to taking the bus->subsys.rwsem
> > before calling either probe() or remove().
> 
> Is the shutdown being called directly? The shutdown call is protected by
> a different rwsem. Depending on the call graph setting dev->driver on
> return of probe may provide a solution.

Yes, that is precisely what I had considered doing.

> I have not looked at all probe
> routines to understand if this would cause any bad side effects.
> 
> Andries,
> 	Can you send the oops output?

top of stack was reported as (process reboot):

sd_shutdown + 0x22/0x110 NULL deref (namely, sdkp)
i8042_notify_sys
device_shutdown
sys_reboot
do_clock_nanosleep

