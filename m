Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268931AbTBZUnc>; Wed, 26 Feb 2003 15:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268932AbTBZUnc>; Wed, 26 Feb 2003 15:43:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6859 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S268931AbTBZUnb>;
	Wed, 26 Feb 2003 15:43:31 -0500
Date: Wed, 26 Feb 2003 21:46:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Scott Lee <scottlee@redhot.rose.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide write barriers
Message-ID: <20030226204641.GJ945@suse.de>
References: <200302262031.MAA18505@redhot.rose.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302262031.MAA18505@redhot.rose.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26 2003, Scott Lee wrote:
> > The goal is to make the use of write
> > back cache enabled ide drives safe with journalled file systems.
> 
> Does this mean that having write caching enabled is not safe if you
> are using ext3 on an IDE drive?  Should "hdparm -W 0 /dev/hda" be used
> for example.  (I see a 50% performance hit using "-W 0" when my box is
> under load.)  If this is the case, what is the root cause?  Do IDE
> drives reorder writes when they are cached?

As it stands, it's not safe to use write back caching on IDE drives.
When the write completes as seen from the fs, it's not on the platter
yet. That's a problem. And as you mention, there's no guarentee that
writes won't be reordered as well.

So yes, either use the barrier patch or disable write caching.

-- 
Jens Axboe

