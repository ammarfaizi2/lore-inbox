Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWI2QBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWI2QBs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWI2QBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:01:48 -0400
Received: from mx2.rowland.org ([192.131.102.7]:23569 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S932311AbWI2QBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:01:47 -0400
Date: Fri, 29 Sep 2006 12:01:46 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [GIT PATCH] More USB patches for 2.6.18
In-Reply-To: <200609281756.07130.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0609291143150.25378-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006, David Brownell wrote:

> On Thursday 28 September 2006 5:20 pm, Andrew Morton wrote:
> > On Thu, 28 Sep 2006 17:08:33 -0700
> > David Brownell <david-b@pacbell.net> wrote:
> > 
> > > ... reviewing and testing those new OHCI changes is still on my
> > > list;
> > 
> > erm, we prefer to do that before code hits mainline.

We are victims of bad timing.  This all started with the USB autosuspend 
patches, submitted around a month ago.  Greg didn't merge all of them 
because he experienced some problems (which we still haven't sorted out!), 
but the rest went into -mm.  But then Greg was away for a while and too 
busy to help with debugging.

I hadn't done any testing of OHCI controllers with CONFIG_USB_SUSPEND
turned off, and when problems turned up a couple of weeks ago it became
apparent that some of the existing code in ohci-hcd had to change or be
removed, as it wasn't compatible with the new autosuspend mechanism.  
This was done just in the past week, and David hasn't had much of a chance
to go through and review it yet.

As a result, when the autosuspend patches went upstream for 2.6.19-rc1 the
extra ohci-hcd changes had to go with them, even though they have received
very little testing and review.  Perhaps things moved too quickly, but
this wasn't obvious at the time, and anyway it's done now.

> Exactly why I mentioned the issue.  I trust Alan basically got the
> ohci parts of that new root hub suspend code right, but I probably
> have a lot more variety in OHCI silicon here ... but virtually no
> time to assemble the relevant platform patches and test them with
> new patches from MM/etc, given other ongoing work.

Exactly.  The new code works on the one system I have with OHCI
controllers, and a few other people have used it successfully.  However
this is hardly a wide sampling, and we know there are controllers out
there with bizarre quirks which might not like the changes.

The problems with last-minute compile errors are symptoms that the new 
code has shaken down yet -- compounded by the way different versions of 
GCC don't all report the same classes of errors.

> > > all that suspend stuff needs care, things that work on PCs don't
> > > necessarily work on embedded hardware (where OHCI is common, and
> > > PM tends to be more critical).
> > 
> > I guess we'll find out.

Hopefully in plenty of time to get straightened out before too many 
2.6.19-rc releases have gone by.

Alan Stern

