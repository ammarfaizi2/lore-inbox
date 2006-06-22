Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWFVVPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWFVVPF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWFVVPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:15:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:17620 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932078AbWFVVPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:15:03 -0400
Date: Thu, 22 Jun 2006 14:11:57 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060622211157.GA15669@kroah.com>
References: <449AFFAD.2030601@gmail.com> <Pine.LNX.4.44L0.0606221706450.5772-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0606221706450.5772-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 05:09:43PM -0400, Alan Stern wrote:
> On Thu, 22 Jun 2006, Jiri Slaby wrote:
> 
> > > ages.  The "bogus requests" are attempts by the user to suspend a USB
> > > device (by writing to /sys/devices/.../power/state) without first
> > > suspending all its children and interfaces.
> > > 
> > > (This can't happen when doing a global suspend because the PM core 
> > > iterates through the entire device tree.  It matters only for "runtime" or 
> > > "selective" suspend.)
> > 
> > But everything I did is:
> > echo reboot > /sys/power/disk
> > echo disk > /sys/power/state
> > 
> > No writing anywhere else.
> 
> You misunderstood.  I meant that attempts to suspend a USB device without 
> first suspending all its children and interfaces can't happen when doing a 
> global suspend.  That's still true.
> 
> Your problem occurred because even though the PM core did _attempt_ to 
> suspend the new children added by Greg's patch, it didn't _succeed_ 
> because the patch did not provide suspend or resume methods.

Which because they are virtual "devices" they do not need a suspend or
resume method, so not having any is just fine.  If we abort because of
something like this, the core logic is quite broken...

thanks,

greg k-h
