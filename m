Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265288AbUGNDpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUGNDpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 23:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265348AbUGNDpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 23:45:44 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:714 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S265288AbUGNDpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 23:45:41 -0400
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
From: Peter Zaitsev <peter@mysql.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040714031701.GT974@dualathlon.random>
References: <1089771823.15336.2461.camel@abyss.home>
	 <20040714031701.GT974@dualathlon.random>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1089776640.15336.2557.camel@abyss.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 20:44:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 20:17, Andrea Arcangeli wrote:

> > Out of Memory: Killed process 19821 (mysqld).
> 
> this is a well known 2.6 oom-killer problem w/o swap. Not the worst one,
> I mentioned the worst one here just a few weeks ago:

Thanks Andrea,

Your reply is very helpful as usually. 


> 	
> 	http://groups.google.com/groups?q=g:thl1518647992d&dq=&hl=en&lr=&ie=UTF-8&selm=fa.i50b3kk.p0qsjs%40ifi.uio.no
> 
> 
> the only fix at the moment is to use 2.4 with oom killer disabled (the
> same issue could happen with 2.4 too). even if it would work better than
> the above the oom killer will still get screwed by mlock and it simply
> cannot know how much lowmem is freeable leading to deadlock instead of
> -ENOMEM with syscalls if you fill the whole lowmem zone.
> 
> I fixed everything related to oom in 2.4 some year back, now need to
> port to 2.6.

When do you think it is going to happen ?

To be honest I recently was quite happy with 2.6.x stability, and in
2.6.7  IO performance for MySQL workloads seems to be mainly fixed - it
performs well even with default "as" scheduler.   However this problem
makes me to be more cautious once again.

> 
> workaround is to add swap in 2.6, but in some condition it'll still
> underpeform compared to 2.4 due the lack of the zone-reserve-ratio algo.

The reason for me to disable swap both in 2.4 and 2.6 is - it really
hurts performance. In some cases performance can be 2-3 times slower
with swap file enabled.   Using O_DIRECT and mlock() for buffers helps 
but not completely.

RedHat 2.4.x kernels are especially affected.  They seems to love to get
a lot of swap into the swap, however caching the large part of swapped
out. This still negatively affects performance. 



-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



