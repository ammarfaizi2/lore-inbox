Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVE3T2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVE3T2u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVE3T2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:28:49 -0400
Received: from colin.muc.de ([193.149.48.1]:12305 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261703AbVE3T23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:28:29 -0400
Date: 30 May 2005 21:28:26 +0200
Date: Mon, 30 May 2005 21:28:26 +0200
From: Andi Kleen <ak@muc.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Chris Friesen <cfriesen@nortel.com>, john cooper <john.cooper@timesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: spinaphore conceptual draft
Message-ID: <20050530192826.GB25794@muc.de>
References: <934f64a205052715315c21d722@mail.gmail.com> <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <m1r7fpvupa.fsf@muc.de> <429B289D.7070308@nortel.com> <20050530164003.GB8141@muc.de> <429B4957.7070405@nortel.com> <m1k6lgwqro.fsf@muc.de> <02485B05-6AE5-4727-8778-D73B2D202772@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02485B05-6AE5-4727-8778-D73B2D202772@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 02:04:36PM -0400, Kyle Moffett wrote:
> >I suspect any attempt to use time stamps in locks is a bad
> >idea because of this.
> 
> Something like this could be built only for CPUs that do support that
> kind of cycle counter.

That gets you into a problem with binary distribution kernels.
While binary patching works to some extent, it also becomes
messy pretty quickly.

> >My impression is that the aggressive bus access avoidance the
> >original poster was trying to implement is not that useful
> >on modern systems anyways which have fast busses. Also
> >it is not even clear it even saves anything; after all the
> >CPU will always snoop cache accesses for all cache lines
> >and polling for the EXCLUSIVE transition of the local cache line
> >is probably either free or very cheap.
> 
> The idea behind these locks is for bigger systems (8-way or more) for
> heavily contended locks (say 32 threads doing write() on the same fd).

Didn't Dipankar & co just fix that with their latest RCU patchkit? 
(assuming you mean the FD locks)

> In such a system, cacheline snooping isn't practical at the hardware
> level, and a lock such as this should be able to send several CPUs to

Why not? Cache snooping has to always work with low overhead, otherwise the
machine is not very useful coherent. I assume that any bigger system
has a cache directory anyways, which should minimze the traffic; 
and for smaller setups listening to broadcasts works fine.


-Andi
