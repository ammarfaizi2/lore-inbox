Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWGLRTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWGLRTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWGLRTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:19:46 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48391 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932137AbWGLRTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:19:45 -0400
Date: Wed, 12 Jul 2006 13:19:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: ray-gmail@madrabbit.org
cc: Dave Jones <davej@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: annoying frequent overcurrent messages.
In-Reply-To: <2c0942db0607121009l1fc00764ye0b98d686700a74c@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0607121314490.6111-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006, Ray Lee wrote:

> On 7/12/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> > Dave Jones wrote:
> > > I have a box that's having its dmesg flooded with..
> > >
> > > hub 1-0:1.0: over-current change on port 1
> > > hub 1-0:1.0: over-current change on port 2
> > > hub 1-0:1.0: over-current change on port 1
> > > hub 1-0:1.0: over-current change on port 2
> > ...
> >
> > > over and over again..
> > > The thing is, this box doesn't even have any USB devices connected to it,
> > > so there's absolutely nothing I can do to remedy this.
> >
> > Since you're not using the UHCI controller on that computer, you could
> > simply rmmod uhci-hcd (or modify /etc/modprobe.conf to prevent it from
> > being loaded in the first place).  That would stop the constant interrupts
> > and the syslog spamming.
> 
> For the syslog spamming, you could jus emit the message once when the
> state is first noticed, then emit a everything good message when it
> clears up. There's no need to log it repeatedly during the problem
> period.

That's almost exactly how the driver behaves currently -- the message is
printed just once when the state is first noticed.  Nothing is printed 
when the state is cleared, and nothing gets printed repeatedly during the 
problem period.  But then the problem recurs very quickly.


On Wed, 12 Jul 2006, Dave Jones wrote:

> we could at least rate-limit the messages.

That's true for every message in the kernel.  How do you decide which 
messages to rate-limit?

Note that this particular message will cause problems only in the presence 
of defective hardware.

Alan Stern

