Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbTBSRO7>; Wed, 19 Feb 2003 12:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbTBSRO7>; Wed, 19 Feb 2003 12:14:59 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:52953 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S261721AbTBSRO5>;
	Wed, 19 Feb 2003 12:14:57 -0500
Subject: Re: PATCH: clean up the IDE iops, add ones for a dead iface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1045678925.27427.16.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0302190853180.18995-100000@home.transmeta.com>
	 <1045674387.12533.48.camel@zion.wanadoo.fr>
	 <1045678925.27427.16.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045675595.12533.58.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Feb 2003 18:26:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 19:22, Alan Cox wrote:
> On Wed, 2003-02-19 at 17:06, Benjamin Herrenschmidt wrote:
> > Yup, you are right. Removing a disk from a controller shall return
> > anything with bit 7 at 0 per spec, but removing the controller
> > itself will return 0xff. Actually, in my "wait for BSY low" loop
> > I added to the probe code for pmac (should be made generic sooner
> > or later), I did special case 0xff.
> > 
> > So we should indeed fix the various bits in IDE. 0xff out of
> > status, I beleive, never means anything and can always be considered
> > as "this interface is gone".
> 
> I think thats the wrong approach too. We need to be defensive on things
> like IDE probes. We just have to be sure that we -do- eventually say
> 'its bust', and when we know from hotplug a channel has vanished also
> be sure to check the 'its dead jim' flag once I add it

Ok, then let's make sure we have no endless loops caused by BSY
returning 1 and _not_ checking the "dead" flag. I'm sure I can find
some of these in a couple of places (like when setting the PIO/DMA
mode).

Ben.
