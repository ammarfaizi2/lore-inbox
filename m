Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUIJSJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUIJSJZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 14:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267664AbUIJSJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 14:09:25 -0400
Received: from the-village.bc.nu ([81.2.110.252]:60081 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267449AbUIJSJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 14:09:22 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <9e47339104091010221f03ec06@mail.gmail.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <DA459966-02B9-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104090917353554a586@mail.gmail.com>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094835846.17932.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 18:04:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 18:22, Jon Smirl wrote:
> My "personal plan" has been posted for comment to all relevant email
> lists -- xorg, fbdev, dri, and lkml. All feedback that was received
> was addressed and incorporated. Various aspects of the plan were

Addressed and eliminated would be closer. The BSD folks don't want GPL
frame buffer code in there kernel, nobody needs a single nasty splat
where DRI and fbdev got hammered into one block of code by someone with
a glue gun.

> Plan as orginally posted to lkml:
> http://lkml.org/lkml/2004/8/2/111

None of which is about nailing all the code together. You just don't
need to do that kind of stuff, and it'll make it much harder to
maintain.

Now, think about what happens if you register a pci handler for
everything which is "Video" class (or VIDEO/VGA). Your one mini module
now claims every video object in the kernel with a couple of exceptions
you can hand list.

vga_class.c now owns all the video devices. It can keep a global list
and a sorted by vga router list as well as letting frame buffer drivers
and other code add heads of a device lists.

Add register/unregister functions in the same format to allow DRI and FB
(and any future layers) to find cards and you don't need to glue stuff
together at all. You can load dri, you can load fb drivers, you can load
both. You also require minimal kernel changes to the drivers.

That is what I keep telling you, that is what I've been fiddling with
but keep getting distracted from by immediate locking and other kernel
catastrophes.

===
If the kernel community is going to reject this plan please let me
know now so that I won't waste a year of my life writing the code for
it. If Linux wants to stay with a 1980's desktop that's fine; at least
Microsoft and Apple are innovating.

I see you've been taking lessons from Hans Reiser.

Alan

