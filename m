Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTHTVdr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 17:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbTHTVdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 17:33:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:12703 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262239AbTHTVdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 17:33:45 -0400
Date: Wed, 20 Aug 2003 14:33:31 -0700
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [RFC] add class/video to fb drivers - Take 2
Message-ID: <20030820213331.GA4894@kroah.com>
References: <20030820212626.GA4854@kroah.com> <Pine.LNX.4.44.0308202227490.9662-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308202227490.9662-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 10:28:28PM +0100, James Simmons wrote:
> 
> > Well, it's not "ideal" but it will do for 2.6 to use this patch.  If you
> > look at the tty core, it's the same way that currently works.
> > 
> > Ideally in 2.7 I'd like to convert to have all fb drivers create the
> > fb_info structure dynamically, but that's much to big of a change to do
> > this late in the 2.6 development cycle.
> 
> What is the advantage of creating every fb_info dynamically?

Then we can add a struct class_device into fb_info, which will allow us
to export sysfs attributes for each fb_info device to userspace.  It
will provide the proper lifetime rules for such structures, and allow
the individual drivers a place within sysfs to export different things
they might want to export.  Any /proc files you currently have could
then be removed.

For an example of what needs to be done, see the recent v4l core changes
that were just introduced into the kernel tree.

Again, this is a 2.7 thing (which could easily be backported to 2.6.late
afterwards), nothing I want to attempt to do at this time.

thanks,

greg k-h
