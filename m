Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264827AbRGCQOE>; Tue, 3 Jul 2001 12:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264816AbRGCQNy>; Tue, 3 Jul 2001 12:13:54 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:35582 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264825AbRGCQNo>; Tue, 3 Jul 2001 12:13:44 -0400
Date: Tue, 3 Jul 2001 16:34:18 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: about kmap_high function
Message-ID: <20010703163418.E28793@redhat.com>
In-Reply-To: <3620762046.20010629150601@turbolinux.com.cn> <20010703103809.A29868@redhat.com> <15169.48856.428247.217216@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15169.48856.428247.217216@cargo.ozlabs.ibm.com>; from paulus@samba.org on Tue, Jul 03, 2001 at 10:47:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 03, 2001 at 10:47:20PM +1000, Paul Mackerras wrote:
> Stephen C. Tweedie writes:
> 
> On PPC it is a bit different.  Flushing a single TLB entry is
> relatively cheap - the hardware broadcasts the TLB invalidation on the
> bus (in most implementations) so there are no cross-calls required.  But
> flushing the whole TLB is expensive because we (strictly speaking)
> have to flush the whole of the MMU hash table as well.

How much difference is there?  We only flush once per kmap sweep, and
we have 1024 entries in the global kmap pool, so the single tlb flush
would have to be more than a thousand times less expensive overall
than the global flush for that change to be worthwhile.

If the page flush really is _that_ much faster, then sure, this
decision can easily be made per-architecture: the kmap_high code
already has all of the locking and refcounting to know when a per-page
tlb flush would be safe.

Cheers,
 Stephen
