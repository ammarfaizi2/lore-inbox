Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbQL0QhI>; Wed, 27 Dec 2000 11:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbQL0Qg6>; Wed, 27 Dec 2000 11:36:58 -0500
Received: from smartmail.smartweb.net ([207.202.14.198]:3084 "EHLO
	smartmail.smartweb.net") by vger.kernel.org with ESMTP
	id <S129507AbQL0Qgy>; Wed, 27 Dec 2000 11:36:54 -0500
Message-ID: <3A4A1383.A262BF38@dm.ultramaster.com>
Date: Wed, 27 Dec 2000 11:06:27 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cdrom changes in test13-pre2 slow down cdrom access by 70%
In-Reply-To: <3A43D48D.B1825354@dm.ultramaster.com> <20001223133737.D300@suse.de> <3A4904CA.EA1062AF@dm.ultramaster.com> <3A4911ED.95A73903@dm.ultramaster.com> <20001227063810.E5981@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> In principle it looks ok, but after some time we are bound to fail 8
> frame allocations anyway and this patch won't help. For the modular
> case, preallocation of a bigger chunk at init time is no good either.
> Builtin would be fine of course. This almost screams sg to me :-)
> 

Nonetheless, with your first patch and my patch, the system starts off
using the old method of trying to allocate 8 frames buffer (which is
essential for performance) and falls back to the current (as of
test13-pre2) way in low/fragmented memory situations. To me, that's
better than either the previous or the current method, with the slight
increased cost of the failed kmalloc every time in the low/fragmented
memory case.  BTW, have you gotten reports of that kmalloc failing for
people?  I've been ripping audio with every kernel since pre4 and have
never had a failure.  Granted, I put 'workstation' loads on my machine,
but I run some benchmarks from time-to-time, put memory pressure on
etc.  (H*ll, just netscape alone is memory pressure enough :-).

I just don't want to have to patch every kernel I run from here to
eternity.  Call me selfish.

David

-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
