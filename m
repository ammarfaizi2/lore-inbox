Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUHGSAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUHGSAk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 14:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUHGSAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 14:00:40 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:34785 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S264002AbUHGSAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 14:00:19 -0400
From: David Brownell <david-b@pacbell.net>
To: Michael Guterl <mguterl@gmail.com>
Subject: Re: [linux-usb-devel] Re: USB troubles in rc2
Date: Sat, 7 Aug 2004 10:51:23 -0700
User-Agent: KMail/1.6.2
Cc: linux-usb-devel@lists.sourceforge.net,
       "Luis Miguel =?utf-8?q?Garc=FD?= Mancebo" <ktech@wanadoo.es>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
References: <200408022100.54850.ktech@wanadoo.es> <200408050834.27452.david-b@pacbell.net> <944a03770408051005614aa25e@mail.gmail.com>
In-Reply-To: <944a03770408051005614aa25e@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408071051.23047.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 10:05, Michael Guterl wrote:
> Thanks for the reply David, but where exactly does this leave me and
> the others experiencing this problem?  Is there any more information I
> can provide that might help?  Any possible solutions, patches, etc?

It leaves you (and others) with the problem partially isolated, so that
someone with time to track it down will have that much less work to do.

The most effective solutions involve someone who has the problem
actually stepping up and debugging the whole thing, then providing
a patch fixing the problem.

A second-best would be collaboration between someone who has
the time (not me!) and someone who has the problem (you?) to
remotely debug the problem.

A third-best would be for someone (you?) to find out exactly which patch
caused the problem -- a binary search of the USB patches, luckily it's
made easier by the fact that it could only be a change in HID, usbcore,
or some HCD.  (And most likely IMO it's usbcore.)  Then that patch can
either be further debugged, or reverted.

- Dave


> On Thu, 5 Aug 2004 08:34:27 -0700, David Brownell <david-b@pacbell.net> 
wrote:
> > ....
> > 
> > The dmesg output shows this is a HID failure.  It's likely connected
> > with some changes in the unlink logic, since that's what returns
> > the "-ENOENT" status.  The usb_kill_urb() changes added a new
> > URB state as I recall, maybe that's part of the issue here... since
> > that routine replaced the previous "synchronous unlink" logic.
> > 
> > - Dave
> > 
> >
> 
