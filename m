Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbTEMPLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbTEMPLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:11:49 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:53543 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261515AbTEMPLq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:11:46 -0400
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
From: Paul Fulghum <paulkf@microgate.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Hinds <dahinds@users.sourceforge.net>
In-Reply-To: <20030512234828.C17227@flint.arm.linux.org.uk>
References: <1052775331.1995.49.camel@diemos>
	 <1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk>
	 <1052742964.1467.3.camel@doobie>
	 <20030512234828.C17227@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1052839384.2255.10.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 May 2003 10:23:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-12 at 17:48, Russell King wrote:
> On Mon, May 12, 2003 at 07:36:05AM -0500, Paul Fulghum wrote:
> > On Mon, 2003-05-12 at 16:07, Alan Cox wrote:
> > > On Llu, 2003-05-12 at 22:35, Paul Fulghum wrote:
> > > > The 2.5.X PCMCIA kernel support seems to have a problem
> > > > with drivers/pcmcia/rsrc_mgr.c in function undo_irq().
> > > 
> > > Does this still happen with all the patches Russell King posted
> > > that everyone else is ignoring ?
> > 
> > I don't know, I've been ignoring them :-)
> > 
> > Seriously, are they centralized someplace or
> > should I scan back and try to extract them
> > from the lk archive? Do you know about when
> > they were posted?
> 
> Try this one.  Its a slightly updated version from the one I sent earlier.

I tested this patch, and it works.
But I was not seeing any problems before the patch,
other than the 'sleeping in illegal context message'

There seems to be agreement that the cause of the
message is that individual PCMCIA drivers need to be
modified to call the release function directly
instead of from a timer context.

I modified my synclink_cs driver to do this and it
works and eliminates the error message.

Which brings up a question:
The include/pcmcia/ds.h file defines the dev_link_t
structure that contains the release timer_list member.

Should I continue to initialize this member in
my driver or will this member be eliminated requiring
that all references to this member be removed from
the individual PCMCIA drivers?

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


