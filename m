Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVAXVno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVAXVno (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVAXVm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:42:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:38597 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261675AbVAXVkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:40:23 -0500
Date: Mon, 24 Jan 2005 13:40:14 -0800
From: Greg KH <greg@kroah.com>
To: Mitch Williams <mitch.a.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] disallow seeks and appends on sysfs files
Message-ID: <20050124214014.GF18933@kroah.com>
References: <Pine.CYG.4.58.0501211441430.3364@mawilli1-desk2.amr.corp.intel.com> <20050122080556.GA6999@kroah.com> <Pine.CYG.4.58.0501241005070.3748@mawilli1-desk2.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0501241005070.3748@mawilli1-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:16:37AM -0800, Mitch Williams wrote:
> 
> 
> On Sat, 22 Jan 2005, Greg KH wrote:
> 
> >
> > On Fri, Jan 21, 2005 at 02:49:39PM -0800, Mitch Williams wrote:
> > > This patch causes sysfs to return errors if the caller attempts to
> > append
> > > to or seek on a sysfs file.
> >
> > And what happens to it today if you do either of these?
> >
> > Also, isn't this two different things?
> >
> Appending and seeking are obviously two different operations, but the
> result is the same to the sysfs file system.  Because the store method
> doesn't have an offset argument, it must assume that all writes are based
> from the beginning of the buffer.
> 
> So if your sysfs file contains "123" and you do
>    echo "45" >> mysysfsfile
> instead of the expected "12345", you end up with "45" in the file with no
> errors.  Opening the file, seeking, and writing gives the same type of
> behavior, with no errors.

Ick, yeah, but users shouldn't be doing that :)

Anyway, ok, I'll accept this kind of patch, to give errors for that.

> However, if you want two even simpler patches, I'm willing to comply.  Of
> the three patches I sent, this is the most important to me.

Yes, could you split it up?

> > Please, no {} for one line if statements.  Like the one above it :)
> 
> I'll be glad to fix this and resubmit.  I prefer to not have braces
> either, but I've seen a bunch of places in the kernel where people do it,
> so I really wasn't sure which was right.  It's not really called out in
> the coding style doc either.

Yes, please fix this and resubmit it.

thanks,

greg k-h
