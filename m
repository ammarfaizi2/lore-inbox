Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbULKBkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbULKBkH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 20:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbULKBkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 20:40:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:29071 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261904AbULKBj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 20:39:59 -0500
Date: Fri, 10 Dec 2004 17:39:30 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [RFC PATCH] debugfs - yet another in-kernel file system
Message-ID: <20041211013930.GB12846@kroah.com>
References: <20041210005055.GA17822@kroah.com> <200412101729.01155.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412101729.01155.david-b@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 05:29:01PM -0800, David Brownell wrote:
> On Thursday 09 December 2004 4:50 pm, Greg KH wrote:
> > What if there was a in-kernel filesystem that was explicitly just for
> > putting debugging stuff? ?Some place other than proc and sysfs, and that
> > was easier than both of them to use. ?Yet it needed to also be able to
> > handle complex stuff like seq file and raw file_ops if needed.
> 
> The problem with sysfs here is:  no seq_file support.
> Otherwise it solves the basic "where to put the debug
> files associated with "device X" or "driver Y" problems
> in a good non-confusing way:  there are directories
> already set up for devices and for drivers.

Yes, but that's a design decision for sysfs.  no seq_file support is a
feature, not a shortcoming :)

> The problem with procfs here is that it doesn't have
> such a naming solution:  there's no automatic mapping
> betwen a /proc/driver/...file and its device, or vice
> versa.  That issue is shared with debugfs.

Agreed.

> Couldn't debugfs just be a thin shim on top of sysfs,
> adding seq_file support?  Or on top of procfs, adding
> device/driver naming domains, and maybe file-per-value
> read/write support for drivers that want them?

Ick.

> What I'd really want out of a debug file API is to resolve
> the naming issues, work with seq_file, and "softly and
> silently vanish away".  I think this patch has the last
> two, but not the first one!

I considered adding a kobject as a paramater to the debugfs interface.
The file created would be equal to the path that the kobject has.  Would
that work for you?

thanks,

greg k-h
