Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264843AbUF1HOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbUF1HOI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 03:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbUF1HOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 03:14:08 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:17244 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264843AbUF1HOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 03:14:01 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/19] New set of input patches
Date: Mon, 28 Jun 2004 02:13:58 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <20040628065259.GA1291@ucw.cz>
In-Reply-To: <20040628065259.GA1291@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280213.58978.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 June 2004 01:52 am, Vojtech Pavlik wrote:
> On Mon, Jun 28, 2004 at 12:08:21AM -0500, Dmitry Torokhov wrote:
> > Hi,
> > 
> > Here is the 2nd version of my set of input patches that mostly do serio sysfs
> > integration. Among the changes - dropped psmouse KVM resync patch as it was
> > bogus, added platform devices to those of serio providers that don't have
> > proper parent device (i8042, q40kbd, etc).
> > 
> > 01-psmouse-state-locking.patch
> >         - Acquire underlying serio lock when changing psmouse state to
> >           prevent interrupt handler running on us
> 
> IMO drivers have no bussiness messing with the serio locks. We could use
> 'plug' and 'unplug' functions like the network driver use, or handle it
> inside the driver, but taking the lock is the wrong thing to do.

OK, I just don't want to introduce another lock just for that...
 
> 
> I'm not sure if we really need the 'legacy position' thing. We probably
> should drop the 'phys' stuff some time after we transition to sysfs, and
> exporting it through sysfs will make that harder.
> 

I'll drop it then...

> 
> > 10-serio_raw.patch
> >         - raw access to serio data ala 2.4 /dev/psaux
> 
> OK, finally those who insist on /dev/psaux can shut up

:)

> 
> > 15-synaptics-passthrough-handling.patch
> >         - If data looks like a pass-through packet and tuchpad has
> >           pass-through capability do not pass it to the main handler
> >           if child port is disconnected.
> 
> I'll have to look closer on this one - I think we want to pass the data
> to the serio layer even if there is no driver listening on the
> passthrough serio.

We probably should issue serio_interrupt on child port to force rescan but
that packet has no business in parent's motion handling routine and that's
what this patch tries to fix. Anyway, I will look at it more later.
  
> 
> > (*) These patches have also been sent to Greg KH.
> 
> Did he accept them already?
>
 
No, not yet. He promised to take a look at platoform_device_register_simple by
the end of the week but I guess kernel.bkbits.net troubles might intervene...
And other 2 I just send out today.

> > This time I tried compiling the stuff using defconfing for SPACR64 and PPC64
> > (thanks to Andrew for pointing to me availability of cross-compile
> > tools), so I should be a bit better now... Alpha failed on cpumask.h...
> 
> Great! ;)
> 
> > The patches are against today's Linus tree + recent pull form Vojtech's tree
> > + recent pull from Greg KH's tree. I have patches against 2.6.7 that will
> > bring it to my version of the tree at:
> > 
> > 	http://www.geocities.com/dt_or/input/2_6_7/
> 

-- 
Dmitry
