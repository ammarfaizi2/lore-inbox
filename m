Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUITBGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUITBGL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 21:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUITBGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 21:06:11 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:59331 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265195AbUITBGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 21:06:06 -0400
Message-ID: <9e47339104091918064fe13cb9@mail.gmail.com>
Date: Sun, 19 Sep 2004 21:06:05 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
Cc: Mike Mestnik <cheako911@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1095638860.18428.21.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104091811431fb44254@mail.gmail.com>
	 <20040918195807.18874.qmail@web11906.mail.yahoo.com>
	 <9e47339104091815125ef78738@mail.gmail.com>
	 <1095569317.6670.26.camel@gaston>
	 <9e473391040919091252baeb1a@mail.gmail.com>
	 <1095638860.18428.21.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been talking to the I2C people about the right way to solve this
for the code in radeon_probe_i2c_connector(). This should be solvable
in the I2C framework by writing an EDID driver that implements the
code in it's attach_adapter/detach_adapter functions.  What I2C is
missing is a way to tell it to not run the DDC module on non video
buses. Buses need to be marked with a class like video or ram.

I agree that what you have in the radeon driver works. But this is a
generic problem with DDC monitors, not something that is radeon
specific. If possible I'd like to figure out a solution to this that
will work generically so we don't have to add this same code to all of
the video drivers.  I currently don't have a working solution for the
problem using the I2C framework.

I kept the code for the non-DDC monitor detection as is and just made
an IOCTL around it so that I can trigger it from the user space app.


On Mon, 20 Sep 2004 10:07:40 +1000, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2004-09-20 at 02:12, Jon Smirl wrote:
> 
> > The radeon driver has that extra code for intializing older DDC. That
> > can be handled generically in the I2C layer by writing a ddc driver
> > that is a superset of the eeprom driver.  I'd rather get that code
> > into a generic driver than repeat it in every video card driver.
> 
> I'm not a fan of this solution as you know... oh well... and there's
> all that code to detect non-DDC capable monitors as well, which won't
> go through /sys/*/i2c...
> 
> But do as you like, I don't have time to work on it so I'll shut up.
> 
> Ben.
> 
> 



-- 
Jon Smirl
jonsmirl@gmail.com
