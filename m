Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUF1O6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUF1O6r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 10:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUF1O6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 10:58:47 -0400
Received: from web81305.mail.yahoo.com ([206.190.37.80]:48284 "HELO
	web81305.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264997AbUF1Oyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 10:54:54 -0400
Message-ID: <20040628145454.9403.qmail@web81305.mail.yahoo.com>
Date: Mon, 28 Jun 2004 07:54:53 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 0/19] New set of input patches
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Mon, Jun 28, 2004 at 02:13:58AM -0500, Dmitry Torokhov wrote:
> 
> > > IMO drivers have no bussiness messing with the serio locks. We could
> use
> > > 'plug' and 'unplug' functions like the network driver use, or handle
> it
> > > inside the driver, but taking the lock is the wrong thing to do.
> >
> > OK, I just don't want to introduce another lock just for that...
> 
> I think a bit in flags "PSMOUSE_ENABLED", like we have the
> "ATKBD_ENABLED" bit might be just fine - handle the interrupt, but throw
> away the data during the protocol switch. We aren't interested in the
> data anyway.
>

But the flag will not give you atomicity of resetting other fields, like
pktcount. I guess we can ensure it by carefully rearranging the states
and what is reset at what point but it is too fragile.

Would you accept a pair serio_rx_suspend/serio_rx_resume that would still
take the lock internally but not expose this fact to the driver?
 
> > > > 15-synaptics-passthrough-handling.patch
> > > >         - If data looks like a pass-through packet and tuchpad has
> > > >           pass-through capability do not pass it to the main handler
> > > >           if child port is disconnected.
> > >
> > > I'll have to look closer on this one - I think we want to pass the
> data
> > > to the serio layer even if there is no driver listening on the
> > > passthrough serio.
> >
> > We probably should issue serio_interrupt on child port to force rescan
> but
> > that packet has no business in parent's motion handling routine and
> that's
> > what this patch tries to fix. Anyway, I will look at it more later.
> 
> Indeed, we need it for the rescan. It shouldn't be that hard to fix at
> once.
> 

Ok

> >
> > > > (*) These patches have also been sent to Greg KH.
> > >
> > > Did he accept them already?
> >
> > No, not yet. He promised to take a look at
> platoform_device_register_simple by
> > the end of the week but I guess kernel.bkbits.net troubles might
> intervene...
> > And other 2 I just send out today.
> 
> Ok. I'll wait then.

Sysfs changes should be useable even without platform device changes
and I would like start syncing with you. Would you take patches 2 
through 10 (I will drop the legacy_position stuff)?

--
Dmitry
