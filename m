Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbTFVJxF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 05:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbTFVJxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 05:53:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2180 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264723AbTFVJxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 05:53:03 -0400
Date: Sun, 22 Jun 2003 12:03:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Lou Langholtz <ldl@aros.net>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>,
       Steven Whitehouse <steve@chygwyn.com>
Subject: Re: [PATCH] nbd driver for 2.5+: fix for module removal & new block device layer
Message-ID: <20030622100301.GJ608@suse.de>
References: <3EF4D2C8.6060608@aros.net> <20030621225500.GL6754@parcelfarce.linux.theplanet.co.uk> <3EF4E73A.4070108@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF4E73A.4070108@aros.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21 2003, Lou Langholtz wrote:
> >	b) you definitely don't have to use separate queue locks.  The
> >thing will work fine with spinlock being shared and I doubt that there
> >will be any noticable extra contention.
> >
> Probably not noticeable no.

The approach you took is probably _worse_ than a single lock, since you
don't even cache align the locks. I'd say just keep the single nbd_lock
and use that in all queues, seperate locks are a questionable win but do
take up extra space.

-- 
Jens Axboe

