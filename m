Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135909AbRDTNOc>; Fri, 20 Apr 2001 09:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135910AbRDTNOX>; Fri, 20 Apr 2001 09:14:23 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:30754 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135909AbRDTNOL>; Fri, 20 Apr 2001 09:14:11 -0400
Date: Fri, 20 Apr 2001 13:13:57 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: RFC: pageable kernel-segments
Message-ID: <20010420131357.B1444@redhat.com>
In-Reply-To: <27525795B28BD311B28D00500481B7601F11D9@ftrs1.intranet.ftr.nl> <9bi53d$5n6$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9bi53d$5n6$1@cesium.transmeta.com>; from hpa@zytor.com on Tue, Apr 17, 2001 at 12:21:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 17, 2001 at 12:21:17PM -0700, H. Peter Anvin wrote:

> > Certain parts of drivers could get the __pageable prefix or so
> > (like the __init parts of drivers which get removed) for letting
> > the paging-code know that it can be discared if memory-pressure
> > demands it.
> 
> VMS does this.  It at least used to have a great tendency to crash
> itself, because it swapped out something that was called from a driver
> that was called by the swapper -- resulting in deadlock.  You need
> iron discipline for this to work right in all circumstances.

Actually, VMS doesn't do this, precisely because it is so hard to get
right.  VMS has both paged and non-paged pools for dynamically
allocated kernel memory, but the kernel code itself is non-pageable.  

The big problem with such pageable memory isn't really device driver
deadlocks --- the easy rule which makes that work is simply never to
use paged pool from a driver which might be involved in swapping. :)
Even more tricky is the handling of kernel locking --- you cannot
access any paged memory with a spinlock held unless you have pinned
the pages in core beforehand.

--Stephen
