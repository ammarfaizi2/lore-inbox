Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSGSBQW>; Thu, 18 Jul 2002 21:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSGSBQW>; Thu, 18 Jul 2002 21:16:22 -0400
Received: from t3o913p58.telia.com ([195.252.45.58]:45184 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S315485AbSGSBQV>;
	Thu, 18 Jul 2002 21:16:21 -0400
To: Dave Jones <davej@suse.de>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
References: <3D361091.13618.16DC46FB@localhost>
	<Pine.LNX.3.96.1020718123016.8220B-100000@gatekeeper.tmr.com>
	<20020718222229.B21997@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 19 Jul 2002 03:18:18 +0200
In-Reply-To: <20020718222229.B21997@suse.de>
Message-ID: <m2ele0ldlx.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de> writes:

> On Thu, Jul 18, 2002 at 12:46:43PM -0400, Bill Davidsen wrote:
> 
>  > > o UDF Write support for CD-R/RW (packet writing)  (Jens Axboe, Peter Osterlund)
>  > 	Hopefully this is close as well
> 
> This has been around for an age, but I haven't seen anything for 2.5
> yet. Then again, I dropped off the packet-writing mailing list a long
> time ago, so I'm not sure how up to date those folks are.

Patches for 2.5 can be found here:

        http://w1.894.telia.com/~u89404340/patches/packet/2.5/

The most recent patch is for 2.5.25. As far as I know, there are only
two remaining problems with the 2.5 patch:

1. Some drives require a "synchronize cache" command to be inserted
   before a read command if the previous command was a write. This is
   implemented in the 2.4 patch in a rather ugly way, but not in 2.5.

2. The 2.5 version uses "bio" objects instead of buffer_heads, so the
   2.4 functionality to fill in missing parts of packets with data
   from the buffer cache doesn't work. This affects performance but
   not correctness.

Jens thinks the cache sync commands should be handled at the level
below the packet writing module, in ide-cd.c and sr.c. I agree, but
haven't implemented it simply because I haven't figured out how to do
it yet.

Regarding the use of cached data for partial packets, Jens suggested
using the page cache instead of the buffer cache. I haven't figured
out how to do this either.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
