Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbTFRH6d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 03:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265085AbTFRH6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 03:58:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29350 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265083AbTFRH6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 03:58:32 -0400
Date: Wed, 18 Jun 2003 09:12:28 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Alan Stern'" <stern@rowland.harvard.edu>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Russell King'" <rmk@arm.linux.org.uk>, "'Greg KH'" <greg@kroah.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030618081227.GA6754@parcelfarce.linux.theplanet.co.uk>
References: <A46BBDB345A7D5118EC90002A5072C780DD16A55@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780DD16A55@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 12:48:59AM -0700, Perez-Gonzalez, Inaky wrote:
 
> [I happen not to know the block layer as well as you and many others 
> do, so please correct me where I am wrong ...]
> 
> So what? _every_ block device will have some form of physical 
> back-up that can be linked back into sysfs.

... except ones that will not.  Wonderful.  I bow to that logics - there
is nothing it wouldn't cover.
 
> In cases like this, doesn't it make sense to have some 
> /sys/devices/SOMETHING/ hierarchy for those  "logical" or "virtual" 
> devices that back-up those block devices? 
> 
> You could even say that RAID and ramdisks -as used in the example 
> above- would belong to /sys/devices/"virtual"/raid/ and 
> ...../ramdisks/; after all, you have to create those devices before
> being able to attach them (last time I checked):
 
> In the tree structure it makes sense, because each block
> device, at the end is or a partition (and thus is embedded
> in a "true" block device) or a true block device on a 1:1
> relationship with a physical device.

BS.  There is nothing to stop you from having a block device that talks
to userland process instead of any form of hardware.  As the matter of
fact, we already have such a beast - nbd.  There is also RAID - where
there fsck is 1:1 here?  There's also such thing as RAID5 over partitions
that sit on several disks - where do you see 1:1 or 1:n or n:1?
There is such thing as e.g. encrypted loop over NFS.  There are all
sorts of interesting things, with all sorts of interesting relationship
to some pieces of hardware.
