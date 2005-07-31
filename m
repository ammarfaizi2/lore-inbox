Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVGaSrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVGaSrA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVGaSq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:46:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4501
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261880AbVGaSqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:46:31 -0400
Date: Sun, 31 Jul 2005 11:46:13 -0700 (PDT)
Message-Id: <20050731.114613.119242519.davem@davemloft.net>
To: dwalker@mvista.com
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org
Subject: Re: hashed spinlocks
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1122827276.18047.26.camel@c-67-188-6-232.hsd1.ca.comcast.net>
References: <20050729070702.GA3327@elte.hu>
	<42E9E91B.9050403@cosmosbay.com>
	<1122827276.18047.26.camel@c-67-188-6-232.hsd1.ca.comcast.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Walker <dwalker@mvista.com>
Date: Sun, 31 Jul 2005 09:27:55 -0700

> >From 2.6.13-rc4 this hunk
> 
> +#else
> +# define rt_hash_lock_addr(slot) NULL
> +# define rt_hash_lock_init()
> +#endif
> 
> Doesn't work with the following,
> 
> +               spin_unlock(rt_hash_lock_addr(i));
> 
> 
> Cause your spin locking a NULL .. I would give a patch, but I'm not sure
> what should be done in this case..

That spinlock debugging code is such a pain in the butt,
nothing at all should be happening with spinlocks on
a non-SMP build.

We should just change the route.c ifdef to check for
CONFIG_DEBUG_SPINLOCK as well as CONFIG_SMP, in order
to fix this.

