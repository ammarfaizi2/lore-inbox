Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTFUWk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 18:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263547AbTFUWk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 18:40:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39632 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262872AbTFUWk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 18:40:58 -0400
Date: Sat, 21 Jun 2003 23:55:00 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Pavel Machek <pavel@ucw.cz>, Steven Whitehouse <steve@chygwyn.com>
Subject: Re: [PATCH] nbd driver for 2.5+: fix for module removal & new block device layer
Message-ID: <20030621225500.GL6754@parcelfarce.linux.theplanet.co.uk>
References: <3EF4D2C8.6060608@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF4D2C8.6060608@aros.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 03:48:56PM -0600, Lou Langholtz wrote:
> This patch prevents memory corruption from "rmmod nbd" with the existing 
> 2.5.72 (and earlier) nbd driver. It does this by updating the nbd driver 
> to the new block layer requirement that every disk has its own 
> request_queue structure. This is the first of a series of patchlets 
> designed to break down the essential changes I proposed in my last 
> "enormous" patch. Note that another patchlet will make the whole 
> allocation of per nbd_device memory be dynamic (rather than staticly 
> tied to MAX_NBD). Please try out this patch and let me know how nbd is 
> working for you before versus after. With any luck, some of these 
> smaller patch breakdowns can actually see there way into new kernel 
> releases. Thanks.

	a) you don't have to have queue per device.  It often does make
sense (for nbd it's almost certainly a win), but it's not required.

	b) you definitely don't have to use separate queue locks.  The
thing will work fine with spinlock being shared and I doubt that there
will be any noticable extra contention.

	c) please, make allocation of queue dynamic _and_ separate from
any other allocated objects.
