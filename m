Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbTFSBop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265694AbTFSBop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:44:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58871 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265693AbTFSBon
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:44:43 -0400
Subject: RE: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
	sks
From: Robert Love <rml@tech9.net>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Andrew Morton'" <akpm@digeo.com>,
       "'george anzinger'" <george@mvista.com>,
       "'joe.korty@ccur.com'" <joe.korty@ccur.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780DD16D38@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780DD16D38@orsmsx116.jf.intel.com>
Content-Type: text/plain
Message-Id: <1055987915.8770.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 18 Jun 2003 18:58:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-18 at 18:44, Perez-Gonzalez, Inaky wrote:

> Now that we are at that, it might be wise to add a higher-than-anything
> priority that the kernel code can use (what would be 100 for user space,
> but off-limits), so even FIFO 99 code in user space cannot block out
> the migration thread, keventd and friends.

I did this about a year ago, and it is merged into the kernel.

See MAX_USER_RT_PRIO and MAX_RT_PRIO in <linux/sched.h>.

We just need to change MAX_RT_PRIO to, say, (MAX_USER_RT_PRIO + 10).

The one kicker is if we end up changing the size of BITMAP_SIZE, the
default sched_find_first_bit() will break and we will need to implement
a new one. I did a generic one, as well as code to detect at
compile-time which to use, but the optimized one is a lot nicer. On
32-bit machines, the BITMAP_SIZE ends up being 160-bits
(5*sizeof(unsigned long)) so there are about 20 extra priority levels
one can add "for free."

	Robert Love

