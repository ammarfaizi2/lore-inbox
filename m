Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbTFRRCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 13:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265404AbTFRRCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 13:02:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:13984 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265403AbTFRRCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 13:02:18 -0400
Date: Wed, 18 Jun 2003 10:15:27 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030618171527.GA1415@kroah.com>
References: <20030618081227.GA6754@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44L0.0306181018540.741-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0306181018540.741-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 10:32:22AM -0400, Alan Stern wrote:
> On Wed, 18 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> > BS.  There is nothing to stop you from having a block device that talks
> > to userland process instead of any form of hardware.  As the matter of
> > fact, we already have such a beast - nbd.  There is also RAID - where
> > there fsck is 1:1 here?  There's also such thing as RAID5 over partitions
> > that sit on several disks - where do you see 1:1 or 1:n or n:1?
> > There is such thing as e.g. encrypted loop over NFS.  There are all
> > sorts of interesting things, with all sorts of interesting relationship
> > to some pieces of hardware.
> 
> This is the sort of thing that bothers me.  Block devices deserve their 
> own "view", so we have /sys/block/ -- perhaps to be renamed 
> /sys/class/block/.  Fine.
> 
> But what other sorts of things deserve their own "view" as well?  Some
> are already established, maybe others aren't.  How's a developer supposed
> to know whether the driver he's working on deserves its own entry in
> /sys/class/ or not?  How's a user supposed to know where in the hierarchy
> to look for a particular device?

Ok, have you _read_ the documentation on the driver model?  In it,
classes and devices are clearly spelled out as to what the differences
are, and what shows up where.

See Pat's linux.conf.au 2003 paper for much more detail.

And yes, I need to fix up the Documentation/driver_model/class.txt with
the most recent info...

In short, devices describe physical things that are present in the
computer system.  Classes describe a type of device, be it virtual or
physical.  Almost always, classes refer to something a user uses through
the /dev filesystem (like mice, tty, block, audio, etc.)

So no, there is not always a 1:1 mapping from classes to devices, that
is why the driver model does not enforce such a mapping at all.  You can
have multiple "struct class_device" structures that point to the same
"struct device" or no "struct device" at all.

Hope this helps to clear up the confusion that seems to be happening.

thanks,

greg k-h
