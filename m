Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbTGBGpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 02:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264786AbTGBGpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 02:45:23 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:27872 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264770AbTGBGpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 02:45:22 -0400
Date: Wed, 2 Jul 2003 08:59:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC/PATCH] Touchpads in absolute mode (synaptics) and mousedev
Message-ID: <20030702085921.A16501@ucw.cz>
References: <200307010303.53405.dtor_core@ameritech.net> <200307011329.50551.dtor_core@ameritech.net> <16130.7342.567086.595743@gargle.gargle.HOWL> <200307011957.22997.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200307011957.22997.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Tue, Jul 01, 2003 at 07:57:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 07:57:22PM -0500, Dmitry Torokhov wrote:

> I see there are 2 possible solutions. If I understand what Vojtech wrote 
> regarding synaptics driver the track stick (or other pass-through device)
> is best implemented as a separate serio. So you could have your touchpad
> in absolute mode and stick as a separate device in native relative.

And if a separate serio is not possible, then at least a separate input
device. It definitely should not be mixed together into one input device
when in reality there are two.

> Other way is to check (in your userspace driver) whether your motion 
> packets contains absolute packets and if they are present discard any 
> relative events in this batch.
> 
> Hmmm... what if we introduce something like sythrelbit[NBITS(REL__MAX)]
> for passing synthesized relative events and have mousedev use values in 
> following order of precedence:
> - absbit - lowest priority
> - synthrelbit
> - relbit - highest.
> 
> What you think?

... why? I really don't see a reason why we should generate any
synthetic events in the kernel. Not at the device driver level, not at
the handler level.

> > A device should present raw events.  Whatever the user says to the
> > device should come out eventX uninterpreted.
> > mousedev should interpret what it can and present this out
> > /dev/psaux.  As it can do limited interpretation of ABS events, it
> > should.
> 
> The thing is that the result is not useable with touchpads right now. 
> It just does not work :(

There exists an XFree86 driver that uses eventX for Synaptics. Same
thing hopefully will be added to GPM soon. AND, I hope I'll be able to
get rid of the relativization code in mousedev soon, too, because it's
beyond ugly, as soon as a similar XFree86 driver is written for 'generic
tablet's.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
