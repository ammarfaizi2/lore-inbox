Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318358AbSGYIPX>; Thu, 25 Jul 2002 04:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318362AbSGYIPX>; Thu, 25 Jul 2002 04:15:23 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:29283 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318358AbSGYIPW>; Thu, 25 Jul 2002 04:15:22 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200207250818.g6P8IFU22876@devserv.devel.redhat.com>
Subject: Re: [PATCH] 2.5.28: VM strict overcommit
To: akpm@zip.com.au (Andrew Morton)
Date: Thu, 25 Jul 2002 04:18:14 -0400 (EDT)
Cc: rml@tech9.net (Robert Love), torvalds@transmeta.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <3D3F6EBB.3B7817C5@zip.com.au> from "Andrew Morton" at Jul 24, 2002 08:21:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 		if (!vm_enough_memory((maxpos - inode->i_size) >> PAGE_SHIFT)) {
> 			err = -ENOMEM;
> 			goto out_nc;
> 		}
> 	}
> 
> tmpfs supports holes.  Looks to me like a small write which creates
> a big hole will be severely over-accounted for?

Intentionally. The base tree doesn't support page cache removal AS callbacks
so cannot support the ideal behaviour. The other rounding bits for the
tmpfs stuff are I think all fixed in 2.4 by Hugh's stuff, but fixing 2.5
tmpfs is an ongoing seperate project.

> vm_enough_memory() looks really slow.  I'll bench this a bit.

On the benches I've run I can't see any difference whatever the
accounting mode I am using. 

> of memory is dirty" is junk.  It really wants to know more
> information about the dynamic state of the system.  So tracking
> all those datums on-the-fly would be handy.  One day.

We need it three years ago not "one day"

Alan
