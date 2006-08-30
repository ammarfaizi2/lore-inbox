Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWH3RHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWH3RHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWH3RHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:07:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:21765 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751161AbWH3RHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:07:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PObOMUYdi+HoI33K0DV5Y1lpZa8LBfMZYbxilfo1N8OshkVcDdM3/cDAP0zDTGnl5DIWiVVeGOsDO7i8P1y2JwAp0kEs09303UUZCIN9tunqODzhqMZTEi0AA8yuXtgrIGC8881qkKNeO1QMxV6Xtx+HUpah2DvzpQUZKkWcS/o=
Message-ID: <44F5C5E0.4050201@gmail.com>
Date: Wed, 30 Aug 2006 21:07:44 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
References: <20060830062338.GA10285@kroah.com>
In-Reply-To: <20060830062338.GA10285@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> A while ago, Thomas and I were sitting in the back of a conference
> presentation where the presenter was trying to describe what they did in
> order to add the ability to write a userspace PCI driver.  As was usual
> in a presentation like this, the presenter totaly ignored the real-world
> needs for such a framework, and only got it up and working on a single
> type of embedded system.  But the charts and graphs were quite pretty :)
> 
> Thomas and I lamented that we were getting tired of seeing stuff like
> this, and it was about time that we added the proper code to the kernel
> to provide everything that would be needed in order to write PCI drivers
> in userspace in a sane manner.  Really all that is needed is a way to
> handle the interrupt, everything else can already be done in userspace
> (look at X for an example of this...)


A while back, while we (myself and Andrew De Quincey) were struggling
with new DVB frontend devices that needed math operations to be
performed in the frontends themselves for frequency tracking / locking
etc, we found that eventually userspace was a much better place to have
such code, rather than being in kernel.

After quite some thoughts we found it would be much better to have them
implemented in userspace. We did finally draw up to some conclusions,
eventually.

We came up with some code eventually, but time was limited on our hands
that we went into discussion of the newer delivery systems that came
along, so development was a bit halted in that aspect.

http://www.thadathil.net/dvb/msg_transfer_interface
http://thadathil.net:8000/cgi-bin/hgwebdir.cgi/v4l-dvb-user
http://thadathil.net:8000/cgi-bin/hgwebdir.cgi/libdvbapi

> 
> Thomas mentioned that he had code to do all of this working in some
> customer sites already and that he would get it to me.
> 
> Fast forward to OLS of this year, and I bugged Thomas to send me the
> code.  He did, and then I sat on it for a while longer...
> 
> So, here's the code.  I think it does a bit too much all at once, but it
> is an example of how this can be done.  This is working today in some
> industrial environments, successfully handling hardware controls of very
> large and scary machines.  So it is possible to use this interface to
> successfully build your own laser wielding robot, all from userspace,
> allowing you to keep your special-secret-how-to-control-the-laser
> algorithm closed source if you so desire.
> 
> In looking at the proposed kevent interface, I think a few things in
> this proposed interface can be dropped in favor of using kevents
> instead, but I haven't looked at the latest version of that code to make
> sure of this.
> 
> And the name is a bit ackward, anyone have a better suggestion?
> 
> Thomas has also promised to come up with some userspace code that uses
> this interface to show how to use it, but seems to have forgotten.
> Consider this a reminder :)
> 
> Comments?


Being a bit excited and it is really interesting to have such a
proposal, it would simplify the matters that held us up even more,
probably. The name sounds fine though. All i was wondering whether there
would be any high latencies for the same using in such a context. But
since the transfers would occur in any way, even with a kernel mode
driver, i think it should be pretty much fine.


Manu


