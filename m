Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267968AbUIJXDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267968AbUIJXDC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 19:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUIJXDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 19:03:01 -0400
Received: from the-village.bc.nu ([81.2.110.252]:33202 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267968AbUIJXCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 19:02:35 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409102254250.13921@skynet>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094853588.18235.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 23:00:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 23:19, Dave Airlie wrote:
> If the kernel developers can address this point I would be most
> interested, in fact I don't want to hear any more about sharing lowlevel
> VGA device drivers until someone addresses why it is acceptable to have
> two separate driver driving the same hardware for video and not for
> anything else.. (remembering graphics cards are not-multifunction cards -
> like Christoph used as an example before - 2d/3d are not separate
> functions...)...

We've addressed this before. Zillions of drivers provide multiple
functions to multiple higher level subsystems. They don't all have to
be compiled together to make it work. 

2D and 3D _are_ to most intents and purposes different functions. They
are as different as IDE CD and IDE disk if not more so.

> something worthy of multiple PhDs (maybe I'll go back to college), Ians
> work is going to exist mainly in userspace using the DRM for paging things
> and locking, I think the only way we can really do this is with a simple
> fb memory manager in the kernel that the userspace one overrides and then
> tells the fb drivers the new settings - and the fb drivers use those
> settings until told otherwise..

The memory manager is a later problem. Yes you need minimal memory
management in kernel but you have to put the pieces together in a sane
way *first*. Having a vga class device is easy. It fixes up your
multiple pci device registration problem, it allows DRI/fbdev
co-existance, it fixes hotplugging. It's about using the kernel tools we
already have and implementing it the way the kernel wants to think. If
you fight the kernel you get a mess, if you move with it then it ends up
where you want it. Kind of like Aikido source management.

The basics I have provide (well they crash but they will provide) the
equivalent of pci_register_* for video and DRI modules. Notifiers for
use between the two and an ability to find one from the other.

Once you have that then you can begin plugging in crap like memory
managers for those cases you need it kernel side.

Alan

