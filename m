Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVA2TKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVA2TKy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVA2TJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:09:02 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:59342 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261533AbVA2TIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:10 -0500
Date: Sat, 29 Jan 2005 12:25:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Possible bug in keyboard.c (2.6.10)
Message-ID: <20050129112510.GB2268@ucw.cz>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34> <20050127125637.GA6010@pclin040.win.tue.nl> <Pine.LNX.4.61.0501272248380.6118@scrub.home> <20050128105937.GA5963@ucw.cz> <20050129045055.GS8859@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129045055.GS8859@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 04:50:55AM +0000, Al Viro wrote:

> > I'm very sorry about the locking, but the thing grew up in times of
> > kernel 2.0, which didn't require any locking. There are a few possible
> 
> Incorrect.  You have blocking allocations in critical areas and they
> required locking all way back.

Ok. I see a problem where input_register_device() calls input handler
connect methods, which do kmalloc(). This would be bad even on 2.0.

Anything else? I believe the ->open()/->release() methods are still
protected.

> > races with device registration/unregistration, and it's on my list to
> > fix that, however under normal operation there shouldn't be any need for
> > locks, as there are no complex structures built that'd become
> > inconsistent. 
> 
> Um-hm...  Vojtech, meet USB mouse; USB mouse, meet Vojtech.  Now watch
> a disconnect and reconnect happening when luser suddenly gets overexcited
> and jerks the wrong hand a bit too hard while browsing the most profitable
> sort of website...

I know. As I said, this is a problem I know about, and will be fixed. I
was mainly interested whether anyone sees further problems in scenarios
which don't include device addition/removal.

We already fixed this in serio, and input and gameport are next in the
list.

> > If you find scenarios which will lead to trouble in the event delivery
> > system, please tell me, and I'll try to fix that as soon as possible.
> 
> See above.  Devices appearing and disappearing *are* normal.  

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
