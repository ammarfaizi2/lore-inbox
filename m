Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUD2BNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUD2BNl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUD2BNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:13:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:29415 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262382AbUD2BNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:13:39 -0400
Date: Wed, 28 Apr 2004 18:13:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: brettspamacct@fastclick.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040428181319.601decfc.akpm@osdl.org>
In-Reply-To: <40904FD8.7020208@fastclick.com>
References: <409021D3.4060305@fastclick.com>
	<20040428170106.122fd94e.akpm@osdl.org>
	<40904FD8.7020208@fastclick.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brett E." <brettspamacct@fastclick.com> wrote:
>
> > I see no swapout from the info which you sent.
> 
>  pgpgout/s gives the total number of blocks paged out to disk per second, 
>  it peaks at 13,000 and hovers around 3,000 per the attachment.

Nope.  pgpgout is simply writes to disk, of all types.

swapout is accounted for under pswpout and your vmstat trace shows a little
bit of (healthy) swapout with swappiness=100 and negligible swapout with
swappiness=0.  In both cases, negligible swapin.  That's all just fine.

>  Swapping out is good, but when that's coupled with swapping in as is the 
>  case on my side, it creates a thrashing situation where we swap out to 
>  disk pages which are being used, we then immediately swap those pages 
>  back in, etc etc..

Look at your "si" column in vmstat.  It's practically all zeroes.

>  The usage pattern by the way is on a server which continuously hits a 
>  database and reads files so I don't know what "swappiness" should be set 
>  to exactly.  Every hour or so it wants to untar tarballs and by then the 
>  cache is large. From here, the system swaps in and out more while cache 
>  decreases. Basically, it should do what I believe Solaris does... simply 
>  reclaim cache and not swap.  Capping cache would be good too but the 
>  best solution IMO is to simply reclaim the cache on an as-needed basis 
>  before thinking about swapping.

swappiness=100: swaps a lot.  swappiness=0: doesn't swap much.

With a funny workload like that you might choose to set swappiness to 0
just around the hourly tar operation, but as the machine seems to not be
swapping there doesn't seem to be a need.
