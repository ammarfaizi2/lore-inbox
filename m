Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263288AbTDCGU5>; Thu, 3 Apr 2003 01:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263295AbTDCGU5>; Thu, 3 Apr 2003 01:20:57 -0500
Received: from granite.he.net ([216.218.226.66]:39946 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id <S263288AbTDCGU4>;
	Thu, 3 Apr 2003 01:20:56 -0500
Date: Wed, 2 Apr 2003 22:33:59 -0800
From: Greg KH <greg@kroah.com>
To: Albert Cranford <ac9410@attbi.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
Message-ID: <20030403063359.GA1536@kroah.com>
References: <1049328958830@kroah.com> <3E8BD2D9.8050002@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8BD2D9.8050002@attbi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 01:21:13AM -0500, Albert Cranford wrote:
> I read the thread concerning the removal of proc.c & proc.h
> but hope that this does not go to Linus until the interface
> between i2c & sensors to application is somewhat defined.
> 
> At the moment we have a sysctl API used by sensors, video and
> other i2c kernel applications that is working.

The only in-kernel drivers that were using the sysctl/proc interface was
the lm75 and adm1021 drivers.  The video and other i2c kernel drivers do
not use this interface at all.

Those two drivers, and the two other chip drivers that I added to the
kernel in this set of patches were converted over to the sysfs interface
(well one of the new ones were, the other one will build and run, but
doesn't export any sysfs files yet, that will change soon.)

> Our desire to switch the sensors to sysfs interface should not
> break other applications.  At least until we have a model/api
> to propose to these other drivers.

Yes, any applications that used the sysctl interface to get data from
those two driver will break.  However we have to switch at some point in
time, and the userspace library can't be worked on very well if the
kernel can't support it yet :)

So I'm choosing to update the kernel first, and will be working on the
library in the coming weeks.  As there is no real sensors support
besides those two drivers in the main kernel, I didn't break much :)

> In my personal home systems I use it87 driver and have been
> somewhat successful in switching to sysfs.  A big blocking
> point is there is no application to read/set/monitor the
> driver, so it is basically unverified.

I tested the changes I did by using echo and cat, no library or other
applications are needed just yet.

thanks,

greg k-h
