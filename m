Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWCFVsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWCFVsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbWCFVsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:48:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64900 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751662AbWCFVse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:48:34 -0500
Date: Mon, 6 Mar 2006 22:47:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Zabolotny <zap@homelink.ru>, adaplas@gmail.com,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
Message-ID: <20060306214758.GB4701@elf.ucw.cz>
References: <1141571334.6521.38.camel@localhost.localdomain> <20060306010909.190f06fe.zap@homelink.ru> <1141603734.6521.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141603734.6521.85.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well with power it's simple: LCD is either powered or it's not. After
> > resuming the LCD should be always powered on, and the program can then
> > turn it back off if it's desired. FB blanking isn't a issue with X11/
> > Qtopia, as far as I understand? And finally, the 'user' requested power
> > state has to be tracked by the program that does the blanking (say an
> > audio player or such).
> 
> So the user powers down the LCD, the FB blanking then blanks and
> unblanks. What should the current LCD power status be? The LCD should
> still be off as far as I can see yet the LCD/backlight class doesn't do
> this at present.
> 
> I'm beginning to favour a system where backlight drivers only provide
> two functions:
> 
> int (*set_status)(struct backlight_device *, int brightness, int power, int fb_blank);
> int (*get_status)(struct backlight_device *);
> 
> set_status passes the user requested brightness and power values along
> with the current fb_blanking status to the driver. The driver can then
> set the hardware up as appropriate. 
> 
> get_status returns the brightness for the current configuration.
> 
> The backlight core itself keeps track of the requested power and
> brightness values rather than having every backlight driver including
> the logic. This has the advantage of keeping behaviour the same and
> avoiding subtle logic bugs of which there are several at the moment.
> 
> This also means that "echo 31 > brightness; cat brightness" will always
> give the expected answer of whatever brightness the user is requesting
> and the actual current driver brightness choice is available through
> "cat driver_brightness".
> 
> Does this seem reasonable?

Yep. Keeping hardware drivers as simple as possible is good.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
