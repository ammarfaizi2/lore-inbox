Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUBDAAv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUBDAAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:00:51 -0500
Received: from buerotecgmbh.de ([217.160.181.99]:6532 "EHLO buerotecgmbh.de")
	by vger.kernel.org with ESMTP id S266195AbUBDAAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:00:48 -0500
Date: Wed, 4 Feb 2004 01:01:17 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] udev 016 release
Message-ID: <20040204000117.GA31071@vrfy.org>
References: <20040203201359.GB19476@kroah.com> <1075843712.7473.60.camel@nosferatu.lan> <1075849413.11322.6.camel@nosferatu.lan> <20040203231341.GA22058@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203231341.GA22058@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 03:13:41PM -0800, Greg KH wrote:
> On Wed, Feb 04, 2004 at 01:03:33AM +0200, Martin Schlemmer wrote:
> > On Tue, 2004-02-03 at 23:28, Martin Schlemmer wrote:
> > > On Tue, 2004-02-03 at 22:13, Greg KH wrote:
> > > 
> > > Except if I miss something major, udevsend and udevd still do not
> > > work:
> > > 
> > 
> > Skip that, it does work if SEQNUM is set :P
> > 
> > Anyhow, is it _really_ needed for SEQNUM to be set?  What about
> > the attached patch?
> 
> Yes it is necessary, as that is what the kernel spits out.  It's also
> the whole reason we need udevd :)
> 
> If you don't want to give a SEQNUM, just call udev directly.

Oh, never use this udevsend in any script. It expects the SEQNUM from
the kernel, not a random one from you! You will always get timeouts
everytime you use your own SEQNUM, like the timeout after the start of udevd.

If you really need udevsend, I can't imagine for what case, we need to
add some logic to it, to bypass the event ordering and waiting to put
the event straight to the exec_queue.


> > 2) events gets missing.  If you for example use udevsend in the
> > initscript that populate /dev (/udev), the amount of nodes/links
> > created is off with about 10-50 (once about 250) entries.

Your are calling udevsend with your script?

> Hm, that's not good.  I'll go test that and see what's happening.


thanks,
Kay
