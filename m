Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965264AbVKHSrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbVKHSrX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965267AbVKHSrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:47:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:30622 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965264AbVKHSrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:47:23 -0500
Date: Tue, 8 Nov 2005 10:34:23 -0800
From: Greg KH <greg@kroah.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
Message-ID: <20051108183423.GA15799@kroah.com>
References: <E1EYdMs-0001hI-3F@think.thunk.org> <20051106203421.GB2527@kroah.com> <20051107053648.GA7521@thunk.org> <20051107155243.GA14658@kroah.com> <20051107181706.GB8374@thunk.org> <20051107182434.GC18861@kroah.com> <20051108033019.GA6129@thunk.org> <20051108044348.GB5516@kroah.com> <20051108131451.GD6129@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108131451.GD6129@thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 08:14:51AM -0500, Theodore Ts'o wrote:
> On Mon, Nov 07, 2005 at 08:43:49PM -0800, Greg KH wrote:
> > 
> > The input subsystem moved to handle nested class devices, so udev had to
> > change to handle this properly.  I bet however Debian does the initial
> > population of the /dev tree is messed up somehow, as that is what it
> > looks like is happening (event3 I bet is from a USB device that is added
> > after init starts?)
> > 
> 
> Nope, it looks like there's some sort of layering/nesting going on:
> 
> % cat /sys/class/input/event1/device/description
> i8042 Kbd Port
> 
> % cat /sys/class/input/event2/device/description
> i8042 Aux Port
> 
> % cat /sys/class/input/event3/device/description
> Synaptics pass-through
> 
> .. and the Synaptics driver wants to talk to /dev/input/event2, and
> _not_ /dev/input/event3.  But the Debian scripts seem to think that
> the only thing of value to expose is the /dev/input/event3, the very
> top of the stack.  /dev/input/event1, and /dev/input/event2 are both
> not showing up on my system once a I boot a post-2.6.14 kernel.

Is there a "dev" file in /sys/class/input/event1/ and
/sys/class/input/event2/ ?  That should be all the udev cares about.

thanks,

greg k-h
