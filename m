Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVGaTIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVGaTIh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVGaTIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:08:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30199 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261923AbVGaTH5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:07:57 -0400
Subject: Re: hashed spinlocks
From: Daniel Walker <dwalker@mvista.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050731.114613.119242519.davem@davemloft.net>
References: <20050729070702.GA3327@elte.hu> <42E9E91B.9050403@cosmosbay.com>
	 <1122827276.18047.26.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050731.114613.119242519.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 31 Jul 2005 12:06:47 -0700
Message-Id: <1122836811.28450.4.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 11:46 -0700, David S. Miller wrote:
> From: Daniel Walker <dwalker@mvista.com>
> Date: Sun, 31 Jul 2005 09:27:55 -0700
> 
> > >From 2.6.13-rc4 this hunk
> > 
> > +#else
> > +# define rt_hash_lock_addr(slot) NULL
> > +# define rt_hash_lock_init()
> > +#endif
> > 
> > Doesn't work with the following,
> > 
> > +               spin_unlock(rt_hash_lock_addr(i));
> > 
> > 
> > Cause your spin locking a NULL .. I would give a patch, but I'm not sure
> > what should be done in this case..
> 
> That spinlock debugging code is such a pain in the butt,
> nothing at all should be happening with spinlocks on
> a non-SMP build.
> 
> We should just change the route.c ifdef to check for
> CONFIG_DEBUG_SPINLOCK as well as CONFIG_SMP, in order
> to fix this.

The ifdef that switched between the two rt_hash_lock_addr() switched on
for CONFIG_SMP or CONFIG_DEBUG_SPINLOCK . I was compiling UP , so I
didn't get either.

Seems like you'll need to have an rt_hash_lock(slot) that replaces the
spin_lock calls ..

Daniel


