Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWIIWwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWIIWwq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 18:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWIIWwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 18:52:46 -0400
Received: from soundwarez.org ([217.160.171.123]:11493 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S964989AbWIIWwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 18:52:45 -0400
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue
	handling fix
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Thomas Maier <balagi@justmail.de>, Phillip Susi <psusi@cfl.rr.com>,
       linux-kernel@vger.kernel.org, "petero2@telia.com" <petero2@telia.com>
In-Reply-To: <20060909213054.GC19188@kroah.com>
References: <op.tfkmp60biudtyh@master> <20060908210042.GA6877@kroah.com>
	 <4501E33B.50204@cfl.rr.com> <20060908220129.GB20018@kroah.com>
	 <op.tfmh56j9iudtyh@master>  <20060909213054.GC19188@kroah.com>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 00:53:25 +0200
Message-Id: <1157842406.7592.12.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-09 at 14:30 -0700, Greg KH wrote:
> On Sat, Sep 09, 2006 at 08:11:56PM +0200, Thomas Maier wrote:
> > Hello,
> > 
> > >> +    write_queue_size  (r)  Contains the size of the bio write
> > >> +                           queue.
> > ...
> > >> +    mapped_to              Symbolic link to mapped block device
> > >> +                           in the /sys/block tree.
> > >
> > > Shouldn't this whole thing be in /sys/class/ instead of /sys/block/ ?
> > 
> > Don't know. I thought, the pktcdvd is a block driver, so put
> > the control files into /sys/block ..
> > Is /sys/class better? If yes, where to put it?
> 
> Use /sys/class/pktcdvd/ and use struct device instead of struct
> class_device, so I don't have to convert the code later :)

Is this always device specific, or also driver global information? Is
pktcdvd always on a block device? Maybe you just want them to be a group
of attributes in the block device directory where they belong to, like:
  /sys/block/sr0/pktcdvd/info
  /sys/block/sr0/pktcdvd/write_queue_size
  /sys/block/sr0/pktcdvd/...

Does that make sense? We should avoid messing around with symlinks
pointing to other devices, if not absolutely needed. We should also not
create a new device type, just for adding properties to an existing one,
especially if there is not some kind of "device stacking". The
"mapped_to" link to the parent device looks like a wild hack to me, we
should avoid.

Thanks,
Kay

