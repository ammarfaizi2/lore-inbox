Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUIOGWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUIOGWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 02:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266901AbUIOGWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 02:22:41 -0400
Received: from [66.35.79.110] ([66.35.79.110]:52412 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S266905AbUIOGVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 02:21:38 -0400
Date: Tue, 14 Sep 2004 23:21:29 -0700
From: Tim Hockin <thockin@hockin.org>
To: Greg KH <greg@kroah.com>
Cc: Robert Love <rml@ximian.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915062129.GA9230@hockin.org>
References: <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org> <20040915011146.GA27782@hockin.org> <1095214229.20763.6.camel@localhost> <20040915031706.GA909@hockin.org> <20040915034229.GA30747@kroah.com> <20040915044830.GA4919@hockin.org> <20040915050904.GA682@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915050904.GA682@kroah.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 10:09:04PM -0700, Greg KH wrote:
> > Well, I knew several groups at Sun who could have benefitted from "driver
> > hardening" event-logging stuff.  Things like IPMI, evlog, etc are what are
> > being used today.
> 
> Yes, it's a wide range of stuff that all should be consolidated.
> 
> But I haven't seen many people step up to do the work, that's my biggest
> complaint.  I know I don't have the time to do it either :)

Yeah, Sun wasn't really good about committing people to fix things that
it needed, they just like to find things they need.

> > driver is just not going to fly.  The barrier to creating a new "verb" is
> > not high, but there is a slight barrier.  Rather than deal with the
> > barrier, I fear (and I could be wrong) that people will just overload
> > existing verbs.
> 
> We'll see how it gets used.  If people start to do this, we'll
> reconsider the kernel code.  The interface to userspace will still be
> the same, so we aren't painting ourselves into a corner right now.

True, and a fair answer.

> > > > As much as we all like to malign "driver hardening", there is a *lot* that
> > > > can be done to make drivers more robust and to report better diagnostics
> > > > and failure events.
> > > 
> > > I agree.  But this interface is not designed or intended for that.  
> > 
> > Right.  I originally asked Robert if there was some way to make this
> > interface capable of handling that, too.  Maybe the answer is merely "no,
> > not this API".
> 
> Seriously, that's not what this interface is for.  This is a simple
> event notification interface.

Well, this API is not far from "good enough".  It's meant to be a "simple
event system" but with a few expansions, it can be a full-featured event
system :)  And yes, I know the term "feature creep".

> > > You are correct.  I also would like to see a way ECC and other types of
> > > errors and diagnostics be sent to userspace in a common and unified
> > > manner.  But I have yet to see a proposal to do this that is acceptable.
> > 
> > Well, let's open that discussion, then! :)  What requirements do you see?
> > 
> > Basically, they need to be exactly like this, except there needs to be
> > some amount of buffering of messages (somehow) and they need a data
> > payload.
> 
> Sounds good to me.

So what if the actual event system had a payload, and simple events don't
use it, and complex events do?  Or what if there were an exactly analogous
API for messages with payloads?

> > Really, other than payload, why NOT use this API for ECC and driver
> > faults?
> 
> The payload is a pretty good reason why to not use this right now.  No
> one has proposed a way to handle such a payload in a sane manner.

What's insane about a string payload?  Or rather, what are your objections
to saying that the payload string format is entirely dependant on the
{source, event} tuple?

ACPI events might come out of a kobject "/sys/devices/acpi" with an event
"event" and payload "button/power 00000000 00000001" or whatever the
actual values work out to be.

What's insane about that?  Currently we have a separate /proc/acpi/event
file which spits out "button/power 00000000 00000001".

> > ACPI *has* it's own event system.  It's fine, but it's Yet Another Event
> > System.
> 
> Yeah, it's pretty old too, that's why it is the way it is.

But semantically, it's the same as this new API (I think), just less
elegant.

> > Again, other than payload, why NOT use this API for ACPI?
> 
> Again, the payload is the big thing, right?

Yes, the payload is the big thing (that I see).  I'm not sure if you're
posing this as in "See, it needs a payload so we don't want it." or "If we
find a way to do a payload sanely, will you shut up?".

:)

Cheers,
Tim
