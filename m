Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUDPXnw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbUDPXmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:42:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:399 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263895AbUDPXk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:40:56 -0400
Date: Fri, 16 Apr 2004 15:37:32 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040416223732.GC21701@kroah.com>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040415220232.GC23039@kroah.com> <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 04:24:48PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Apr 15, 2004 at 03:02:32PM -0700, Greg KH wrote:
> > No, we don't want that.  It's ok to have a dangling symlink in the fs if
> > the device the link was pointing to is now gone.  All of the struct
> > class_device stuff relies on the fact that a struct device can go away
> > at any time, and nothing bad will happen (with the exception of a stale
> > symlink.)
> > 
> > Yeah, it can cause a few odd looking trees when you unplug and replug a
> > device a bunch of times, all the while grabbing a reference to the class
> > device, but once everything is released by the user, it is cleaned up
> > properly, with no harm done to anything.
> 
> Except that these "symlinks" are expected to follow the target upon
> renames.

Since when did we ever assume that renaming a kobject would rename the
symlinks that might point to it?  Renaming kobjects are a hack that way,
if you use them, you need to be aware of this limitation.

So I really do not see the need for this change at all.

thanks,

greg k-h
