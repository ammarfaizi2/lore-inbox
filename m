Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUIKFTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUIKFTS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 01:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267592AbUIKFTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 01:19:18 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:55721 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267543AbUIKFTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 01:19:16 -0400
Date: Sat, 11 Sep 2004 06:19:13 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
Message-ID: <Pine.LNX.4.58.0409110600120.26651@skynet>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>
  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>
  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>
  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>
  <1094835846.17932.11.camel@localhost.localdomain>  <9e47339104091011402e8341d0@mail.gmail.com>
  <Pine.LNX.4.58.0409102254250.13921@skynet>  <1094853588.18235.12.camel@localhost.localdomain>
  <Pine.LNX.4.58.0409110137590.26651@skynet> <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> You're probably right, but it still doesn't follow that this driver must
> include all the fbdev and DRM code as well. Both fbdev and the DRM could
> use that driver, e.g., just like ide_cd and ide_disk use the IDE driver.
>

I think your wrong, look at drivers/video/aty/radeon* and tell me what in
there is capable of being abstracted from the hardware, every file access
lowlevel registers for something or other, be it mode setting or I2C, now
accessing lowlevels while the CP is running on a radeon is a one way
express to the land of the lockups... (think mode setting a second head,
while a 3d app is running on the first head...), the lowlevel driver can
provide a DRM and FB interface to fbcon and 3d stuff, but the lowlevel
driver needs all the code to do both...

The other thing I think some people are confusing is 2.4 fbdev and 2.6...
there is no console support in 2.6 fbdev drivers, it is all in the fbcon
stuff, so the fbdev drivers are only doing 2d mode setting and monitor
detection, some points I've considered are:

1. It doesn't matter where the code lives, fbdev/DRM need to start talking
about things
2. A generic interface between the two is probably going to be impossible,
graphics card interfaces aren't based on a standard like IDE (stop using
IDE for comparisons, it isn't the same IDE is a standard, and is designed
for things like cd drivers and hard drives, graphics card have no standard
interfaces, just because your pet card has a nice 2D/3D split it doesn't
mean that all do, if someone provides a better analogy feel free to use it
but can we all agree to drop the IDE comparisons now...)

I'm interested in seeing what Alan comes up with, even in a non-working
form .. I much prefer the evolution of these things than complete new
solutions... but I also think linking the fb and drm code together will
remove alot of the headaches and result in a more maintainable system
longterm, even if shortterm there are some ugly hacks..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

