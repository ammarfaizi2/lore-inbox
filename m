Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTDKUpP (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTDKUpP (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:45:15 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:34240 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261824AbTDKUpM (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 16:45:12 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Fri, 11 Apr 2003 22:56:52 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       message-bus-list@redhat.com, Daniel Stekloff <dsteklof@us.ibm.com>
References: <20030411032424.GA3688@kroah.com> <200304112131.56457.oliver@neukum.org> <20030411201029.GP1821@kroah.com>
In-Reply-To: <20030411201029.GP1821@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304112256.52628.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you are worried about this, don't reuse x:y.  Make them purely
> dynamic, and incrementing :)  Yes, this is a 2.7 thing, but will happen

Not enough numbers. Not even in a 32:32 major:minor split.

> eventually.  I need this framework in order to be able to do that, so
> one can't happen without the other...
>
> > It's worse, if you miss a 'remove' event. In that case you are
> > potentially permanently screwed.
>
> I don't want to ever miss events.

Surely, you don't want to miss them. Yet there are cases you are screwed.
Look at the hotplug spawning code and you'll see that it takes only one
kmalloc failling.

[..]
> Then it gets swapped back in.  There isn't anything I can do from
> userspace about this.  Hm, well I could pin the memory for the daemon,
> but that wouldn't be nice :)

That's exactly what you need to do. You can do this, if you change
the hotplugging notification to a pure pipe thing and lock the demon
into memory.  But then you have no advantage freom doing it in user
space, in fact you'll have the overhead of page tables for no benefit.

> Ok, if you are worried about these kinds of things, then use the
> in-kernel devfs.  I'm not going to dispute that userspace faults can
> happen.

Yes, in my oppinion putting such things into user space is stupid.
Your considerable talents would be better used to help Adam getting
his simplified devfs ready.

[..]
> > And yes, any scheme that handles device removal in user space has this
> > problem.
>
> True.  This is hard, let's go shopping...

Your attitude is admirably relaxed :-)

[..]
> > > Yes, if you lose a remove, things can get out of whack.  My goal is to
> > > not lose any.
> >
> > How? Or precisely, how can you guarantee it?
>
> I can guarantee nothing :)

Then you fail. Security without guarantee is no security.

> But I can do a lot to prevent losses.  A lot of people around here point
> to the old way PTX used to regenerate the device naming database on the
> fly.  We could do that by periodically scanning sysfs to make sure we
> are keeping /dev in sync with what the system has physically present.
> That's one way, I'm sure there are others.

Walking sysfs is a race condition by itself.
Don't get me started on that.

	Regards
		Oliver

