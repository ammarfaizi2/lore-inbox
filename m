Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265201AbUGOAsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUGOAsT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUGOArD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:47:03 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:65230 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S265201AbUGOApQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:45:16 -0400
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
From: Peter Zaitsev <peter@mysql.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040715000438.GS974@dualathlon.random>
References: <1089771823.15336.2461.camel@abyss.home>
	 <20040714031701.GT974@dualathlon.random>
	 <1089776640.15336.2557.camel@abyss.home>
	 <20040713211721.05781fb7.akpm@osdl.org>
	 <1089848823.15336.3895.camel@abyss.home>
	 <20040715000438.GS974@dualathlon.random>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1089852210.15336.3988.camel@abyss.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 17:43:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 17:04, Andrea Arcangeli wrote:

> the oom without swap you reproduced is not related to ZONE_NORMAL
> shortage. The pages in ZONE_NORMAL never goes into swap.

Hm. It looks like it gets now even more unclear. If ZONE_NORMAL pages do
not go to swap what goes where, ie on low memory boxes which do not have
HIGHMEM  ? 

> 
> the ZONE_NORMAL oom is a separate issue from the oom killing you
> reproduced. with 2.6.7 if you were hitting the ZONE_NORMAL shortage your
> machine would lockup and it would never oom-kill anything (Andrew just
> changed that in kernel CVS, so thanks to that change a ZONE_NORMAL
> shortage will not deadlock anymore in 2.6.8, but OTOH in 2.6.8 adding
> swap will not be enough anymore to workaround the oom-killing you
> reproduced).

OOM is better than Lockup but still not good at all.  The problem is
from user standpoint one can control only general memory allocation, the
zones kernel internally is transparent on this level, so if one has OOM
killer or lockup  having allocated just ie 3G out of 4G this just looks
like a bug, well if it is documented I would call it gotcha.

> 
> About the ZONE_NORMAL shortage without swap, rather than running
> cpu-cache-hungry memcopies from lowmemzone to highmem (or even worse to
> pass through swap like it happens in 2.6 mainline with swap enabled), I
> believe it's better to reserve some ram in the lowmem zone, 800M of ram
> on a 32G box should be a cheap price to pay compared to the cpu/IO cost
> involved in moving memory around during the bench.

Right.  On other hand whatever performance problem is other class of the
problem than lockups and OOM kills.  Poor performance is much less
critical problem than lockups and firing OOM without good reason,
especially if user has a way to tune kernel to improve performance.



-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



