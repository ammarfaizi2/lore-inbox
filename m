Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTDRXFI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 19:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTDRXFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 19:05:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:6362 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263288AbTDRXFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 19:05:06 -0400
Date: Fri, 18 Apr 2003 16:19:04 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB deadlock in v2.5.67
Message-ID: <20030418231904.GA9090@kroah.com>
References: <200304180202.h3I227mw032608@napali.hpl.hp.com> <20030418045006.GB1813@kroah.com> <3EA01DF0.9080305@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA01DF0.9080305@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 08:46:56AM -0700, David Brownell wrote:
> Greg KH wrote:
> >On Thu, Apr 17, 2003 at 07:02:07PM -0700, David Mosberger wrote:
> >
> >><hcd_free_dev+0x140> translates into line 1249 in hcd.c, where it
> >>does:
> >>
> >>	spin_lock_irqsave (&hcd_data_lock, flags);
> >>
> >>The deadlock is pretty obvious: the same lock has already been
> >>acquired urb_unlink(), 4 levels up in the call-chain.
> >>
> >>Anybody have a fix for this?
> >
> >
> >David (Brownell, that is), does this help with the trace I sent you a
> >few hours ago?
> 
> Seems to be a different problem.  The patch below should
> resolve the keyboard problem -- just reorders two lines
> so the lock isn't held after the device's records get
> deleted, so the order is what it should always have been.

Applied to my trees, thanks.

greg k-h
