Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVKCTqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVKCTqW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 14:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVKCTqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 14:46:22 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:50076 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932088AbVKCTqW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 14:46:22 -0500
Date: Thu, 3 Nov 2005 14:46:18 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: "David S. Miller" <davem@davemloft.net>, <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: post-2.6.14 USB change breaks sparc64 boot
In-Reply-To: <Pine.LNX.4.55.0511031913500.24109@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.44L0.0511031439120.15359-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Maciej W. Rozycki wrote:

> On Thu, 3 Nov 2005, Alan Stern wrote:
> 
> > >  This might actually want to be split to disable legacy stuff as soon as
> > > possible to prevent a flood of interrupts, sending SMIs and what not else.  
> > > That just requires poking at the PCI config space.  Whatever's the rest
> > > could be done later.  I guess hot-plugged USB host controllers are not
> > > configured for legacy support, so the early bits should not matter for
> > > them.
> > 
> > See this email thread:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=113081793516723&w=2
> 
>  Hmm, how does this relate to my suggestion?  Apart from me having to note
> that I have a MIPS-based system with an UHCI -- so these HCs are not
> completely limited to Intel-based systems.  Though, unsurprisingly, it
> doesn't use any of the legacy crap.  SMI from the south bridge is routed
> to somewhere IIRC; probably an ordinary interrupt (and happily ignored).

It's not particularly related to your suggestion, but it is related to the 
preceding email.  I just replied to the latest message in the thread to 
make sure that my reply was sent to anyone who might be interested, that's 
all.

In any case, I'm not so sure to what extent you can separate out the
disable-legacy stuff from the rest.  It's not good enough to disable
interrupt generation and bus-mastering; some controllers don't like it if
you do that while they are running.  It's necessary to shut the controller
down first.  And it looks like the code does just that -- there's not much 
else to separate out.

Alan Stern

