Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVABUD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVABUD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVABUD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:03:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:9658 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261311AbVABUDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:03:49 -0500
Date: Sun, 2 Jan 2005 12:03:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: wli@holomorphy.com, riel@redhat.com, andrea@suse.de,
       linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com,
       kernel@kolivas.org
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-Id: <20050102120324.2b52a848.akpm@osdl.org>
In-Reply-To: <20050102151147.GA1930@suse.de>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com>
	<20041220125443.091a911b.akpm@osdl.org>
	<Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com>
	<20041224160136.GG4459@dualathlon.random>
	<Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com>
	<20041224164024.GK4459@dualathlon.random>
	<Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com>
	<20041225020707.GQ13747@dualathlon.random>
	<Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com>
	<20041225190710.GZ771@holomorphy.com>
	<20050102151147.GA1930@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > Lifting the artificial lowmem restrictions on blockdev mappings
>  > (thereby nuking mapping->gfp_mask altogether) would resolve a number of
>  > problems, not that anything making that much sense could ever happen.
> 
>  It should be lifted for block devices, it doesn't make any sense.

Before we can permit blockdev pagecache to use highmem we must convert
every piece of code which accesses the cache to use kmap/kmap_atomic.  If
you grep around for b_data you'll see there are a lot of such places.

Probably the migration could be done on a per-fs basis.
