Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933195AbWKNDoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933195AbWKNDoF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 22:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933179AbWKNDoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 22:44:05 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49889 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S933195AbWKNDoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 22:44:02 -0500
X-Sasl-enc: wRJdumkdnyAsFfuD2r4a2f47/O5ZhOsr7fCz6TUz97V3 1163475842
Date: Tue, 14 Nov 2006 01:43:55 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Pavel Machek <pavel@ucw.cz>
Cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>,
       Andi Kleen <ak@suse.de>, John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com
Subject: HD head unloads (was: Re: AHCI power saving)
Message-ID: <20061114034355.GB5810@khazad-dum.debian.net>
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz> <45589008.1080001@garzik.org> <200611131637.56737.ak@suse.de> <455893E5.4010001@garzik.org> <4558B232.8080600@rtr.ca> <20061113220127.GA1704@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113220127.GA1704@elf.ucw.cz>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006, Pavel Machek wrote:
> On Mon 2006-11-13 12:58:10, Mark Lord wrote:
> > Jeff Garzik wrote:
> > >Andi Kleen wrote:
> > >
> > >>How does it shorten its life?
> > >
> > >Parks your hard drive heads many thousands of times more often than it 
> > >does without the aggressive PM features.
> > 
> > Spinning-down would definitely shorten the drive lifespan.  Does it do that?
> 
> Not on my machine.

Heck, given just how much a ThinkPad T43 BIOS will attempt to do it for you,
consider yourself lucky if the X60 behaves differently.  When I thought of
monitoring the head unload counter through SMART on mine, my HD was already
beyond 14k unloads... and the notebook had been powered up less than 100
times :p

The BIOS likes to set the drive APM mode to something other than "off", and
in many drives (well, Hitachi ones at least), that means the drive will be
happy to unload heads every chance it gets, so as to be able to power off
the head assembly motion drive.

> > Parking heads is more like just doing some extra (long) seeks.

Long seeks don't lift the head assembly off the plates, head unloads do.
And head unloads will also power down some stuff in laptop HDs, seeks don't
do that either.

And even old-style parking places the heads on a different surface than the
data area.  That's a lot different from seeks no matter how one looks at it.

> > Is this documented somewhere as being a life-shortening action?

Yes, although not often with that many words.

For example, a Hitachi Travelstar 5k100 is rated for 600k load/unload
cycles, and 20k emergency load/unload cycles (each emergency unload counts
as 30 normal unloads, but the tech docs say it is about 100 times more
stressfull to the drive).  It is in the public drive datasheet, along with
other important information, such as that the drive needs to spin down often
(no less than once every 48h) or its lifespan will be shortened.

A typical desktop HD can probably survive a lot less head load/unload
cycles and spin up/down cycles than that.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
