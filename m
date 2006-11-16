Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424692AbWKPVsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424692AbWKPVsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424694AbWKPVsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:48:23 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:45870 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1424692AbWKPVsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:48:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MDPLGybUqC7JyQTd/g+FL66rqY+tFXdYFxXFhrsGcYJzqI0obXIOVLfXXE1xTLqtw4MfkLZcYxxi6UodJuq+SfeTqw0+eBX4UFAYeESStLEzf1RetnTE7Nc7cO6Qq/5iWuJDcsAeNmM3IS/+mwNkJabiAnG0PkDJUA9UQ2NhQm8=
Message-ID: <653402b90611161348k163a004ax483f1c2bc6928fd9@mail.gmail.com>
Date: Thu, 16 Nov 2006 22:48:20 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: ACPI output/lcd/auxdisplay mess
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Luming Yu" <Luming.yu@intel.com>, "Andrew Zabolotny" <zap@homelink.ru>,
       linux-acpi@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611161450180.31960@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
	 <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
	 <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
	 <653402b90611160045s6ddf1305jdb262ee55b0f16bf@mail.gmail.com>
	 <Pine.LNX.4.64.0611161450180.31960@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/06, James Simmons <jsimmons@infradead.org> wrote:
>
> >
> > cfag12864bcfb is a "fbdev" (actually, it is a "fb wrapper" for
> > cfag12864b, so it behaves like a framebuffer, although it is not an
> > usual framebuffer. f.e. it has asynchronous refresh rate, a mmaped
> > page to appear to be a fb...).
>
> BTW to use it as a fb you need to set the FILLRECT etc. See Kconfig in the
> drivers/video directory and look at one of the graphic card examples.

I see, thanks you. I will take care of that.

>
> > Still, it is not the front panel lcd of any specific device like PDA,
> > so people that expects only their primary video/ displays may be
> > confused if it appears at such section. So we decided to go away from
> > video/. Maybe we can change the description, as right now it only
> > refers to front panel lcds.
>
>   Neither is a monitor for a PC desktop. That is why we have ddc. If I
> take a desktop with more than one video card and swap the lcd monitors
> the lcd monitor data remains the same. As soon as the display device is
> attached to the graphics card the graphics card will then communicate
> with the monitor to retrieve data. For example if the mode of the
> graphics card is set to 1900x1080 which is supported by the current
> monitor. Then we swap it for a CRT that supports only 1280x1024 then in
> that case when the graphics card probes the CRT it will change the
> resolution to the maximum that is supported by the CRT.
>   Currently the fbdev layer handles all this with struct fb_monspecs. Now
> I know that structure doesn't cover everything. Nor does it handle
> multiple displays attached to one piece of hardware. These where things I
> was hoping to fix. Now that there are display devices that can handle
> there own power management I have no problem having another sysfs device
> to handle it. A representation that is more generic than lcd in the
> backlight directory. Like the output device suggested by Yu. Of course I'm
> not fond of that name. Display would be better.
>

Yep, indeed it would be better to have both generic place and sysfs
device to put all these generic displays, however, I think they
shouldn't be at video/* (maybe video/something/* or outside). I mean,
we can do something like:

1. First, we move auxiliary-special displays (including cfag12864b,
[*]"Arc Monochrome LCD board" and stuff like that: they aren't really
primary video displays) to another folder outside video/, maybe
"drivers/display/" ("drivers/auxdisplay/"...).
2. Then we create a sysfs device, called "display" ("auxdisplay"...)
for all of them, which must be generic as you suggested, not just lcds
or "front panels".

So finally we will have usual-primary fbdevs and video drivers at
"drivers/video/*", and all the other stuff at "drivers/display/*" or
some similar place.

Is that a good suggestion?

[*] I saw fbdevs like "Arc Monochorme LCD board support" that can be
put there the same way like auxdisplay/cfag12864b, as they look pretty
similar.

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
