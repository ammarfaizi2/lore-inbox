Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWIJW1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWIJW1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 18:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWIJW1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 18:27:16 -0400
Received: from soundwarez.org ([217.160.171.123]:12680 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932137AbWIJW1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 18:27:15 -0400
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue
	handling fix
From: Kay Sievers <kay.sievers@vrfy.org>
To: balagi@justmail.de
Cc: Greg KH <greg@kroah.com>, Phillip Susi <psusi@cfl.rr.com>,
       linux-kernel@vger.kernel.org, "petero2@telia.com" <petero2@telia.com>
In-Reply-To: <op.tfoglqsiiudtyh@master>
References: <op.tfkmp60biudtyh@master> <20060908210042.GA6877@kroah.com>
	 <4501E33B.50204@cfl.rr.com> <20060908220129.GB20018@kroah.com>
	 <op.tfmh56j9iudtyh@master> <20060909213054.GC19188@kroah.com>
	 <1157842406.7592.12.camel@pim.off.vrfy.org>  <op.tfoglqsiiudtyh@master>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 00:25:46 +0200
Message-Id: <1157927146.26962.13.camel@min.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-10 at 21:33 +0200, Thomas Maier wrote:
> Hello,
> 
> > Is this always device specific, or also driver global information? Is
> > pktcdvd always on a block device? Maybe you just want them to be a group
> > of attributes in the block device directory where they belong to, like:
> >   /sys/block/sr0/pktcdvd/info
> >   /sys/block/sr0/pktcdvd/write_queue_size
> >   /sys/block/sr0/pktcdvd/...
> >
> > Does that make sense? We should avoid messing around with symlinks
> > pointing to other devices, if not absolutely needed. We should also not
> > create a new device type, just for adding properties to an existing one,
> > especially if there is not some kind of "device stacking". The
> > "mapped_to" link to the parent device looks like a wild hack to me, we
> > should avoid.
> 
> The pktcdvd driver creates new block devices using a "struct gendisk"
> that creates the /sys/block/pktcdvd[0-7]/ entries (alloc_disk() -> add_disk()).
> 
> Since the files like write_queue_size are per pktcdvd device and belong to
> this device, they should be below the /sys/block/pktcdvd[0-7]/ directory,
> not below the e.g. /sys/block/sr0/ .

So the pktcdvd device have their own device nodes, userspace talks to?

Kay

