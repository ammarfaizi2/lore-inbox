Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVAGMbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVAGMbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVAGMbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:31:45 -0500
Received: from news.suse.de ([195.135.220.2]:9168 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261388AbVAGMan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:30:43 -0500
Date: Fri, 7 Jan 2005 13:30:43 +0100
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: discuss@x86-64.org, Andi Kleen <ak@suse.de>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [discuss] Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050107123043.GB30264@wotan.suse.de>
References: <20041217014345.GA11926@mellanox.co.il> <20050106172613.GI5772@vana.vc.cvut.cz> <20050106175342.GA28889@wotan.suse.de> <200501071249.20767.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501071249.20767.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As a quick fix, wouldn't it be easy enough to just mark USBDEVFS_IOCTL as
> COMPATIBLE_IOCTL()? The number is actually different for 32 and 64 bit kernels,
> so a 32 bit application that knows about this could use 64 bit data structures
> and then just call ioctl(fd, USBDEVFS_IOCTL64, data) instead of using a weird
> hack to achieve exactly the same.
> Applications trying to call the 32 bit USBDEVFS_IOCTL would still see -EINVAL
> because there is no wrapper for this.
> Maybe the same can be done for some of the other ioctl calls. It effectively
> means moving part of the compat layer to user space from fs/compat_ioctl.c,
> but it appears that applications are already doing this.

That's too ugly. We would end up with different ABIs. 
I don't really want to do that, no.

-Andi
