Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbVLBTR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVLBTR2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 14:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVLBTR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 14:17:28 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:29717 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750963AbVLBTR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 14:17:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=GKPD9QtM55Z9aFWFgRUIoXK4YtqNXFj0U3Um13B4dIEc/lHpB2NynlJp323bYloXEntjRERBMvqQ8qcopF32fwBNSPtoEKE1dggnmY6WdVBRehmIhIeh5+bYjdr9TX1wQNltpuYeHu8TKogHPi8ERxAadhn5+NzahtTJGxvxC54=
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for
	benchmarks
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dirk Henning Gerdes <mail@dirk-gerdes.de>, axboe@suse.de,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051201172520.7095e524.akpm@osdl.org>
References: <1133443051.6110.32.camel@noti>
	 <20051201172520.7095e524.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 11:17:31 -0800
Message-Id: <1133551051.21429.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 17:25 -0800, Andrew Morton wrote:
> Dirk Henning Gerdes <mail@dirk-gerdes.de> wrote:
> >
> >  For doing benchmarks on the I/O-Schedulers, I thought it would be very
> >  useful to disable the pagecache.
> 
> That's an FAQ.   Something like this?
> 
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> Add /proc/sys/vm/drop-pagecache.  When written to, this will cause the kernel
> to discard as much pagecache and reclaimable slab objects as it can.
> 
> It won't drop dirty data, so the user should run `sync' first.
> 
> Caveats:
> 
> a) Holds inode_lock for exorbitant amounts of time.
> 
> b) Needs to be taught about NUMA nodes: propagate these all the way through
>    so the discarding can be controlled on a per-node basis.
> 
> c) The pagecache shrinking and slab shrinking should probably have separate
>    controls.
> 
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Yep. This is what I wanted also :) This is similar functionality as
"cfree" module some one wrote a while ago.

Cool, This will make some of the database folks get off my back for a
while :)


Thanks,
Badari

