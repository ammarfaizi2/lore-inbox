Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbTFROSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbTFROSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:18:37 -0400
Received: from ida.rowland.org ([192.131.102.52]:2052 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265247AbTFROS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:18:26 -0400
Date: Wed, 18 Jun 2003 10:32:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: viro@parcelfarce.linux.theplanet.co.uk
cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Russell King'" <rmk@arm.linux.org.uk>, "'Greg KH'" <greg@kroah.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <20030618081227.GA6754@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44L0.0306181018540.741-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:

> BS.  There is nothing to stop you from having a block device that talks
> to userland process instead of any form of hardware.  As the matter of
> fact, we already have such a beast - nbd.  There is also RAID - where
> there fsck is 1:1 here?  There's also such thing as RAID5 over partitions
> that sit on several disks - where do you see 1:1 or 1:n or n:1?
> There is such thing as e.g. encrypted loop over NFS.  There are all
> sorts of interesting things, with all sorts of interesting relationship
> to some pieces of hardware.

This is the sort of thing that bothers me.  Block devices deserve their 
own "view", so we have /sys/block/ -- perhaps to be renamed 
/sys/class/block/.  Fine.

But what other sorts of things deserve their own "view" as well?  Some
are already established, maybe others aren't.  How's a developer supposed
to know whether the driver he's working on deserves its own entry in
/sys/class/ or not?  How's a user supposed to know where in the hierarchy
to look for a particular device?

Here's a suggestion for something that would definitely help.  Create a
listing (maybe in Documentation/driver-model/) of all the major kernel
subsystems that deserve to have their own entries in /sys/class/ (or the
equivalent).  Explain clearly that any device driver that registers with
one of those subsystems will receive a directory in the /sys/class/
hierarchy where it can register its class devices, and say what the name
of that directory will be.  Explain that a driver that doesn't register
with one of these subsystems will simply have to create its own entry in
/sys/devices/ under its parent node.

Not all this infrastructure has been created yet.  For instance, there 
isn't at the moment any place under /sys/class/usb/ for a USB host 
controller driver to register its class device.  But if these ideas were 
formalized and written down, it would be straightforward to fill in the 
missing pieces.

Alan Stern

