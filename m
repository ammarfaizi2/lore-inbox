Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267998AbUIJWUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUIJWUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267979AbUIJWUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:20:42 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:30922 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267987AbUIJWTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:19:45 -0400
Date: Fri, 10 Sep 2004 23:19:42 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <9e47339104091011402e8341d0@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0409102254250.13921@skynet>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>
  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>
  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>
  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>
  <1094835846.17932.11.camel@localhost.localdomain> <9e47339104091011402e8341d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> You are focusing on the resource claiming problem. That is an easy
> problem to solve, it's also not the one that is causing the hard
> problems.

I have to agree with Jon, nobody has addressed any of the issues he raises
except the one that is quite simple to solve, resource sharing is easy,

I think people are stuck in a graphics card having separate 2d/3d paths
and never the twain need meet, well that doesn't work, the 2d/3d split is
only in your mind, a graphics card is a single device, hence should only
one device driver, fbdev is not a complete driver, for all the reasons JOn
mentions (dualhead being a major one), the DRM is not a complete driver as
it ignores the basic VGA parts of the chip and relies on X or fb to set
them up..

> on a key stroke command. This completely violates normal OS rules of
> one driver per device. If video can do it, I want to do it for the
> disk and net subsystems too.

If the kernel developers can address this point I would be most
interested, in fact I don't want to hear any more about sharing lowlevel
VGA device drivers until someone addresses why it is acceptable to have
two separate driver driving the same hardware for video and not for
anything else.. (remembering graphics cards are not-multifunction cards -
like Christoph used as an example before - 2d/3d are not separate
functions...)...

Also I don't think what Jon has in mind is going to be truly possible and
IMHO an efficient flexible graphics card memory management system is
something worthy of multiple PhDs (maybe I'll go back to college), Ians
work is going to exist mainly in userspace using the DRM for paging things
and locking, I think the only way we can really do this is with a simple
fb memory manager in the kernel that the userspace one overrides and then
tells the fb drivers the new settings - and the fb drivers use those
settings until told otherwise..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

