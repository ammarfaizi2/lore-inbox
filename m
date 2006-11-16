Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424183AbWKPPin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424183AbWKPPin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424182AbWKPPin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:38:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39831 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1424178AbWKPPim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:38:42 -0500
Date: Thu, 16 Nov 2006 15:38:39 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Miguel Ojeda <maxextreme@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>,
       linux-acpi@vger.kernel.org
Subject: Re: ACPI output/lcd/auxdisplay mess
In-Reply-To: <653402b90611160045s6ddf1305jdb262ee55b0f16bf@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611161450180.31960@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org> 
 <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com> 
 <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
 <653402b90611160045s6ddf1305jdb262ee55b0f16bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Is it a framebuffer device ? The framebuffer layer is abstracted to work
> > with such devices.
> > 
> 
> cfag12864bcfb is a "fbdev" (actually, it is a "fb wrapper" for
> cfag12864b, so it behaves like a framebuffer, although it is not an
> usual framebuffer. f.e. it has asynchronous refresh rate, a mmaped
> page to appear to be a fb...).

BTW to use it as a fb you need to set the FILLRECT etc. See Kconfig in the 
drivers/video directory and look at one of the graphic card examples.
 
> Still, it is not the front panel lcd of any specific device like PDA,
> so people that expects only their primary video/ displays may be
> confused if it appears at such section. So we decided to go away from
> video/. Maybe we can change the description, as right now it only
> refers to front panel lcds.

  Neither is a monitor for a PC desktop. That is why we have ddc. If I 
take a desktop with more than one video card and swap the lcd monitors 
the lcd monitor data remains the same. As soon as the display device is 
attached to the graphics card the graphics card will then communicate 
with the monitor to retrieve data. For example if the mode of the 
graphics card is set to 1900x1080 which is supported by the current 
monitor. Then we swap it for a CRT that supports only 1280x1024 then in 
that case when the graphics card probes the CRT it will change the 
resolution to the maximum that is supported by the CRT. 
  Currently the fbdev layer handles all this with struct fb_monspecs. Now
I know that structure doesn't cover everything. Nor does it handle 
multiple displays attached to one piece of hardware. These where things I 
was hoping to fix. Now that there are display devices that can handle 
there own power management I have no problem having another sysfs device
to handle it. A representation that is more generic than lcd in the 
backlight directory. Like the output device suggested by Yu. Of course I'm 
not fond of that name. Display would be better. 

