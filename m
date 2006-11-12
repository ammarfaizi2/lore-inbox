Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932951AbWKLQb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932951AbWKLQb0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 11:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932952AbWKLQb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 11:31:26 -0500
Received: from mx2.rowland.org ([192.131.102.7]:6926 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S932951AbWKLQb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 11:31:26 -0500
Date: Sun, 12 Nov 2006 11:31:24 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI
 wakeup via sysfs
In-Reply-To: <200611111429.56345.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.44L0.0611121120110.6353-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006, Andrey Borzenkov wrote:

> On Tuesday 20 June 2006 00:12, David Brownell wrote:
> > > > > > An alternative (but post-boot) workaround _should_ be
> > > > > >
> > > > > >     echo disabled > /sys/bus/pci/devices/0000:00:02.0/power/wakeup
> > > >
> > > > Did that work?
> > >
> > > No. But
> > >
> > > 	echo -n disabled >
> > > /sys/devices/pci0000:00/0000:00:02.0/usb1/power/wakeup
> >
> > That's what I meant ... thanks, and sorry for the confusion.
> 
> this does not work anymore in current rc5. After writing 
> cat /sys/devices/pci0000:00/0000:00:02.0/usb1/power/wakeup shows "disabled" 
> but messages continue to be logged.
> 
> Anything I can do to help narrow it down?

Undoubtedly this change in behavior is caused by the "autostop" code I 
added to ohci-hcd.  It doesn't check the "wakeup" attribute.

Dave, is there any clue about exactly what triggers the immediate wakeup?  
If you could tell me what to test for, I could try writing a patch to fix 
it.  Perhaps the driver needs a "resume_detect_is_broken" quirk.

Andrey, if you aren't using USB at all (you mentioned that no devices were 
plugged in), you can simply do "rmmod ohci-hcd" to stop all those log 
messages.

Alan Stern

