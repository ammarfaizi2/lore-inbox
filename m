Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269267AbUISQMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269267AbUISQMb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 12:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbUISQMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 12:12:31 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:47151 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269267AbUISQMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 12:12:03 -0400
Message-ID: <9e473391040919091252baeb1a@mail.gmail.com>
Date: Sun, 19 Sep 2004 12:12:03 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
Cc: Mike Mestnik <cheako911@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1095569317.6670.26.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104091811431fb44254@mail.gmail.com>
	 <20040918195807.18874.qmail@web11906.mail.yahoo.com>
	 <9e47339104091815125ef78738@mail.gmail.com>
	 <1095569317.6670.26.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 14:48:38 +1000, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sun, 2004-09-19 at 08:12, Jon Smirl wrote:
> 
> > I'm still undecided if there needs to be a root priv daemon caching
> > the EDID and polling for a monitor change. EDID can be regenerated on
> > each request to change mode but it takes a few seconds. The root priv
> > daemon will dynamically link to card specific libraries. Initially I'm
> > going to add the functions to the mesa libraries but they may get
> > broken out later.
> 
> I'd rather have the kernel driver do the actual probing and provide
> the EDID or other infos for non-EDID capable monitors to userland (via
> hotplug maybe ?), though userland can then of course decide to
> "override" it and it's still userland that decodes it etc....
> 
> There are various cases of HW hackery involved in proper monitor
> detection that I'd rather not see in userland anymore. Also, some cards
> may provide an interrupt for detecting connector state change.

The design doesn't force DDC to be in the kernel or user space. You
can do it in either place.

In the driver I'm working on I use a standard in kernel i2c driver and
the i2c eeprom driver. This makes the EDID appear as a block in sysfs.
I've also take the monitor detection code from radeonfb and made it
into an IOCTL that the user space app calls.

The radeon driver has that extra code for intializing older DDC. That
can be handled generically in the I2C layer by writing a ddc driver
that is a superset of the eeprom driver.  I'd rather get that code
into a generic driver than repeat it in every video card driver.

-- 
Jon Smirl
jonsmirl@gmail.com
