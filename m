Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267578AbUIKGM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267578AbUIKGM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 02:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUIKGM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 02:12:27 -0400
Received: from host-63-144-52-41.concordhotels.com ([63.144.52.41]:55616 "EHLO
	080relay.CIS.CIS.com") by vger.kernel.org with ESMTP
	id S267578AbUIKGMY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 02:12:24 -0400
Subject: Re: radeon-pre-2
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Dave Airlie <airlied@linux.ie>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409110600120.26651@skynet>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.58.0409110600120.26651@skynet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Sat, 11 Sep 2004 02:12:16 -0400
Message-Id: <1094883136.6095.75.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-11 at 06:19 +0100, Dave Airlie wrote:
> >
> > You're probably right, but it still doesn't follow that this driver must
> > include all the fbdev and DRM code as well. Both fbdev and the DRM could
> > use that driver, e.g., just like ide_cd and ide_disk use the IDE driver.
> 
> I think your wrong, look at drivers/video/aty/radeon* and tell me what in
> there is capable of being abstracted from the hardware, every file access
> lowlevel registers for something or other, be it mode setting or I2C, 

I'm not talking about abstracting much of anything, just moving
(arbitration of) actual hardware access to a common lowlevel driver. The
things you mentioned but snipped above, basically.

> now accessing lowlevels while the CP is running on a radeon is a one way
> express to the land of the lockups... 

No need to tell me that...

> (think mode setting a second head, while a 3d app is running on the first 
> head...), the lowlevel driver can provide a DRM and FB interface to fbcon 
> and 3d stuff, but the lowlevel driver needs all the code to do both...

I still haven't seen a complete logical chain leading to that
conclusion.

The lowlevel driver could provide all the necessary arbitration and
safety measures to prevent the two from stepping on each other's toes.


> The other thing I think some people are confusing is 2.4 fbdev and 2.6...

Again, not me.

> there is no console support in 2.6 fbdev drivers, it is all in the fbcon
> stuff, so the fbdev drivers are only doing 2d mode setting and monitor
> detection, [...]

Exactly. Why not leave it like that, and the DRM taking care of memory
management and rendering?


> 1. It doesn't matter where the code lives, fbdev/DRM need to start talking
> about things

Agreed.

> 2. A generic interface between the two is probably going to be impossible,

Probably true, I'm not talking about a generic interface (although some
parts might be generic, just like the DRM userspace interface).


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer
