Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVAXVnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVAXVnn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVAXVnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:43:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:37829 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261672AbVAXVkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:40:22 -0500
Date: Mon, 24 Jan 2005 13:39:06 -0800
From: Greg KH <greg@kroah.com>
To: Mitch Williams <mitch.a.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] buffer writes to sysfs
Message-ID: <20050124213906.GE18933@kroah.com>
References: <Pine.CYG.4.58.0501211449410.3364@mawilli1-desk2.amr.corp.intel.com> <20050122080930.GB6999@kroah.com> <Pine.CYG.4.58.0501241016430.3748@mawilli1-desk2.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0501241016430.3748@mawilli1-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:37:00AM -0800, Mitch Williams wrote:
> 
> 
> On Sat, 22 Jan 2005, Greg KH wrote:
> 
> >
> > On Fri, Jan 21, 2005 at 02:52:29PM -0800, Mitch Williams wrote:
> > > This patch buffers writes to sysfs files and flushes them to the
> > kobject
> > > owner when the file is closed.
> >
> > Why?  This breaks the way things work today, right?
> >
> > What is this patch trying to fix?
> >
> 
> To be honest, I'm a bit ambivalent about this patch.  I wrote this code in
> response to a bug filed by our test lab.  If you write a bunch (e.g. > 1K)
> of data to a sysfs file, the c library splits it up into multiple writes
> of 1K or less.  Because the kobject store method doesn't support offsets,
> and because the call to copy_from_user doesn't honor offsets, you end up
> with multiple calls to the store method, with incorrect results and no
> error code.

Who is trying to send > 1K to a sysfs file?  Remember, sysfs files are
for 1 value only.  If you consider > 1K a "single value" please point me
to that part of the kernel that does that.

> To the typical user, there's really no difference in behavior, unless you
> are writing a ton of data into the file.  Of course, there's the obvious
> question of why you'd want to do so...

Exactly, you should not be doing that anyway.  So, because of that, I
really don't want/like this patch.

thanks,

greg k-h
