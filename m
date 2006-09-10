Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWIJTZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWIJTZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 15:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWIJTZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 15:25:28 -0400
Received: from mout0.freenet.de ([194.97.50.131]:22759 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S932553AbWIJTZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 15:25:26 -0400
Date: Sun, 10 Sep 2006 21:33:16 +0200
To: "Kay Sievers" <kay.sievers@vrfy.org>, "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue handling fix
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: "Phillip Susi" <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org,
       "petero2@telia.com" <petero2@telia.com>
Content-Type: text/plain; charset=iso-8859-15
MIME-Version: 1.0
References: <op.tfkmp60biudtyh@master> <20060908210042.GA6877@kroah.com> <4501E33B.50204@cfl.rr.com> <20060908220129.GB20018@kroah.com> <op.tfmh56j9iudtyh@master> <20060909213054.GC19188@kroah.com> <1157842406.7592.12.camel@pim.off.vrfy.org>
Content-Transfer-Encoding: 7bit
Message-ID: <op.tfoglqsiiudtyh@master>
In-Reply-To: <1157842406.7592.12.camel@pim.off.vrfy.org>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Is this always device specific, or also driver global information? Is
> pktcdvd always on a block device? Maybe you just want them to be a group
> of attributes in the block device directory where they belong to, like:
>   /sys/block/sr0/pktcdvd/info
>   /sys/block/sr0/pktcdvd/write_queue_size
>   /sys/block/sr0/pktcdvd/...
>
> Does that make sense? We should avoid messing around with symlinks
> pointing to other devices, if not absolutely needed. We should also not
> create a new device type, just for adding properties to an existing one,
> especially if there is not some kind of "device stacking". The
> "mapped_to" link to the parent device looks like a wild hack to me, we
> should avoid.

The pktcdvd driver creates new block devices using a "struct gendisk"
that creates the /sys/block/pktcdvd[0-7]/ entries (alloc_disk() -> add_disk()).

Since the files like write_queue_size are per pktcdvd device and belong to
this device, they should be below the /sys/block/pktcdvd[0-7]/ directory,
not below the e.g. /sys/block/sr0/ .

The pktcdvd driver can only be mapped to block devices, as i know.

-Thomas Maier

