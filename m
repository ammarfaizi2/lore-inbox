Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUJAQzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUJAQzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUJAQzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:55:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:33436 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264531AbUJAQzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:55:44 -0400
Date: Fri, 1 Oct 2004 09:47:50 -0700
From: Greg KH <greg@kroah.com>
To: Timo Ter??s <ext-timo.teras@nokia.com>
Cc: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: kobject events questions
Message-ID: <20041001164750.GA11646@kroah.com>
References: <415ABA96.6010908@nokia.com> <1096486749.4666.31.camel@betsy.boston.ximian.com> <415D28B7.5070306@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415D28B7.5070306@nokia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 12:51:51PM +0300, Timo Ter??s wrote:
> Robert Love wrote:
> >On Wed, 2004-09-29 at 16:37 +0300, Timo Ter??s wrote:
> >>1) Send the events so that they are always associated with the network 
> >>devices class_device kobject. I guess this would be quite clean way to 
> >>do it, but it'd require adding a new signal type and would limit the 
> >>iptables target to be associated always with a interface.
> >>
> >>2) Create a device class that has virtual timer devices that trigger 
> >>events (ie. /sys/class/utimer). Each timer could have some attributes 
> >>(like expired, expire_time, etc.) and would emit "change" signals 
> >>whenever timer expires.
> >
> >Well, #1 is the intention and spirit of the kevent system.
> >
> >And adding a new signal type is fine.
> >
> >So the only downside is that the table to interface association thing.
> >I have no idea how big an issue that is for you.
> 
> I'm just a bit dubious about adding new signals since they are hardcoded 
> in the kernel. It's a time consuming process to add new signals (either 
> for development build or for official kernels). This is one of the 
> reasons I liked more about the original kevent patch. Wouldn't simple 
> #defines have been enough for signal names?

What's the difference between a #define and a enum?  We want these to be
well known, and correct.  A enum gives us that.

> >You could of course create a new kobject, ala #2, but that does not seem
> >optimal if the object is otherwise worthless.  I don't think that you
> >should create a new class.  Better to put something under /sys/net
> >related to what you are doing.
> 
> I thought quite a bit about to where add my kobjects. I couldn't find a 
> /sys/net on my current system (am I missing some config option?). If you 
> mean /sys/class/net aren't all kobject in there supposed to be of same 
> type (namely class_device associated with net_device).

Yes, that is what /sys/class/net contains.

Good luck,

greg k-h
