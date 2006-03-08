Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWCHVzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWCHVzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWCHVzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:55:04 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:20362 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932583AbWCHVzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:55:02 -0500
Date: Wed, 8 Mar 2006 16:55:00 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: david-b@pacbell.net, <linux-usb-devel@lists.sourceforge.net>,
       <greg@kroah.com>, <torvalds@osdl.org>, <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: Fw: Re: oops in choose_configuration()
In-Reply-To: <20060308125407.2cd5d829.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0603081644520.5360-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2006, Andrew Morton wrote:

> Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > What about those scheduler changes you found through the bisection search?  
> >  Any word on that?
> 
> Ingo's gone over them pretty closely.  The current theory is that the CPU
> scheduler change alters timing sufficiently for the bug to bite.
> 
> The machine passes memtest86.
> 
> Ingo's suspecting stack corruption.  Do you know whether USB anywhere does
> DMA into automatically-allocated storage (ie: kernel stacks)?

We try to avoid doing that, but such things have been known to creep into
the sources from time to time.  We fix them whenever they surface.  I'm
pretty sure that usbcore and usb-storage are clean in this respect, and
probably usbhid is also (I haven't gone through it to check personally;  
presumably others have).  The only drivers listed in your
/proc/bus/usb/devices were hub and usbhid, and the ALPS UGX device didn't
have any drivers bound.

Have you tried running your test with the USB devices unplugged?  That 
won't prevent usb_choose_configuration from getting called (since it's 
used for the virtual root hubs exported by the host controller drivers) 
but it should make everything more deterministic.

Alan Stern

