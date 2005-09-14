Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbVINQbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVINQbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVINQbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:31:21 -0400
Received: from peabody.ximian.com ([130.57.169.10]:9453 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1030259AbVINQbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:31:20 -0400
Subject: Re: [patch] hdaps driver update.
From: Robert Love <rml@novell.com>
To: Greg KH <greg@kroah.com>
Cc: Mr Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050914161622.GA22875@kroah.com>
References: <1126713453.5738.7.camel@molly>
	 <20050914160527.GA22352@kroah.com> <1126714175.5738.21.camel@molly>
	 <20050914161622.GA22875@kroah.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 12:31:57 -0400
Message-Id: <1126715517.5738.35.camel@molly>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 09:16 -0700, Greg KH wrote:

> But you are reference counting a static object, right?  Which
> isn't the nicest thing to have done.

I would not say it is not "the nicest thing", it is just not necessary
to do the reference counting.  But we want the ref counting for other
reasons, so it seems sensible.

> Why not just dynamically create it?

Seems silly to dynamically create something that we know a priori we
only have one of.  E.g., why dynamically create something that is not
dynamic.

But it is not a big deal.  If this is some rule of yours, I can
kmalloc() the device_driver structure and kfree() it in my release()
function.  Is that what you want?

> No, if you have that .owner field in your driver, you get a symlink in
> sysfs that points from your driver to the module that controls it.  You
> just removed that symlink, which is not what I think you wanted to have
> happen :(

But device release == module unload.

I am not following, sadly.

> I also think you don't get the module reference counting for your
> driver's and devices sysfs files but haven't looked deep enough to see
> if this is true for your code or not.  Should be easy for you to test,
> just open a sysfs file for your device and see if the module reference
> is incremented or not.

The module reference counting is fine.

The count is elevated while one of the sysfs files is open, decremented
when it closes.

	Robert Love


