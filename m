Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVINRju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVINRju (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbVINRjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:39:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:43232 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030243AbVINRjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:39:48 -0400
Date: Wed, 14 Sep 2005 10:38:47 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@novell.com>
Cc: Mr Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] hdaps driver update.
Message-ID: <20050914173847.GA24058@kroah.com>
References: <1126713453.5738.7.camel@molly> <20050914160527.GA22352@kroah.com> <1126714175.5738.21.camel@molly> <20050914161622.GA22875@kroah.com> <1126715517.5738.35.camel@molly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126715517.5738.35.camel@molly>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 12:31:57PM -0400, Robert Love wrote:
> On Wed, 2005-09-14 at 09:16 -0700, Greg KH wrote:
> 
> > But you are reference counting a static object, right?  Which
> > isn't the nicest thing to have done.
> 
> I would not say it is not "the nicest thing", it is just not necessary
> to do the reference counting.  But we want the ref counting for other
> reasons, so it seems sensible.

Like was mentioned, please use platform_device_register_simple()
instead, that's what it is there for.

> > No, if you have that .owner field in your driver, you get a symlink in
> > sysfs that points from your driver to the module that controls it.  You
> > just removed that symlink, which is not what I think you wanted to have
> > happen :(
> 
> But device release == module unload.

Sure.

> I am not following, sadly.

Load the version of the driver in 2.6.14-rc1.  Look in the /sys/
directory for where your driver shows up.  You should see a symlink
called "module" in there that points back to /sys/module/ for where your
module lives.  That symlink was created by the fact that you had set the
.owner field in the struct device_driver.

Taking that field away like you did removes that symlink, which is not a
good thing.

thanks,

greg k-h
