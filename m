Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVLEQUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVLEQUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 11:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbVLEQUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 11:20:36 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49114 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751382AbVLEQUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 11:20:35 -0500
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for
	benchmarks
From: Lee Revell <rlrevell@joe-job.com>
To: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@osdl.org>, Dirk Henning Gerdes <mail@dirk-gerdes.de>,
       axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <200512042013.13214.rob@landley.net>
References: <1133443051.6110.32.camel@noti>
	 <20051201172520.7095e524.akpm@osdl.org>
	 <200512042013.13214.rob@landley.net>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 11:20:40 -0500
Message-Id: <1133799641.21641.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-04 at 20:13 -0600, Rob Landley wrote:
> > Add /proc/sys/vm/drop-pagecache.  When written to, this will cause the
> > kernel to discard as much pagecache and reclaimable slab objects as it can.
> >
> > It won't drop dirty data, so the user should run `sync' first.
> 
> This is deeply, deeply cool.
> 
> > Caveats:
> >
> > a) Holds inode_lock for exorbitant amounts of time.
> 
> Voluntary preemption point, maybe?

I thin it's a bad idea, that would just encourage people to use this for
anything other than debugging.  If you care about latency don't discard
the page cache.

The GNOME people have been asking for this for a while, in order to
improve startup times, they would like a way to simulate a cold start
without rebooting.

Lee

