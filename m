Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUDOWTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 18:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUDOWTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 18:19:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:1476 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261248AbUDOWTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 18:19:49 -0400
Date: Thu, 15 Apr 2004 15:02:32 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040415220232.GC23039@kroah.com>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 02:36:15PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Apr 13, 2004 at 06:10:37PM +0530, Maneesh Soni wrote:
> > Hi,
> > 
> > As pointed by Al Viro, the current symlinks support in sysfs is incorrect as
> > it always sees the old target if target is renamed and obviously does not
> > follow the new target. The page symlink operations as used by current sysfs
> > code always see the target information at the time of creation. 
> 
> a) we ought to take a reference to target when creating a symlink (and drop
> it on removal)

No, we don't want that.  It's ok to have a dangling symlink in the fs if
the device the link was pointing to is now gone.  All of the struct
class_device stuff relies on the fact that a struct device can go away
at any time, and nothing bad will happen (with the exception of a stale
symlink.)

Yeah, it can cause a few odd looking trees when you unplug and replug a
device a bunch of times, all the while grabbing a reference to the class
device, but once everything is released by the user, it is cleaned up
properly, with no harm done to anything.

thanks,

greg k-h
