Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269206AbUINIc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269206AbUINIc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 04:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269202AbUINIc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 04:32:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14816 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269206AbUINIai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 04:30:38 -0400
Date: Tue, 14 Sep 2004 10:28:17 +0200
From: Jens Axboe <axboe@suse.de>
To: "C.Y.M." <syphir@syphir.sytes.net>
Cc: linux-kernel@vger.kernel.org, "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Message-ID: <20040914082816.GM2336@suse.de>
References: <20040914071555.GJ2336@suse.de> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAlWQshEZFqEyYIBOxibqMHgEAAAAA@syphir.sytes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAlWQshEZFqEyYIBOxibqMHgEAAAAA@syphir.sytes.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2004, C.Y.M. wrote:
> > 
> > Forgot to attach the code, here it is...
> > 
> 
> When I use your test application on the disabled drives, I get the following
> results:
> 
> issuing FLUSH_CACHE: worked
> issuing FLUSH_CACHE_EXT: failed 0x51/0x4!

As expected - so your drive does support FLUSH_CACHE, but doesn't
advertise it.

> Is FLUSH_CACHE_EXT also a requirement?  Would it not be possible to just add

No, only for drives that are bigger than what lba28 can address: 128GiB.

> this test function to ide-probe.c instead of looking for what the drive may
> or may not be advertising properly?

This is what the code used to do, but some flash cards go nuts when you
issue unknown commands to it. So we cannot do that anymore.

-- 
Jens Axboe

