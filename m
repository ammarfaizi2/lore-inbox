Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933758AbWKYXEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933758AbWKYXEr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 18:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934218AbWKYXEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 18:04:47 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41658
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S933758AbWKYXEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 18:04:47 -0500
Date: Sat, 25 Nov 2006 15:05:00 -0800 (PST)
Message-Id: <20061125.150500.14841768.davem@davemloft.net>
To: rdreier@cisco.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org,
       tom@opengridcomputing.com
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
From: David Miller <davem@davemloft.net>
In-Reply-To: <adaodqv5e5l.fsf@cisco.com>
References: <adazmag5bk1.fsf@cisco.com>
	<20061124.220746.57445336.davem@davemloft.net>
	<adaodqv5e5l.fsf@cisco.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 25 Nov 2006 14:56:22 -0800

>  > Perhaps a better way to fix this is to use
>  > typeof() like other similar macros do.
> 
> I tried doing
> 
> #define ALIGN(x,a)				\
> 	({					\
> 		typeof(x) _a = (a);		\
> 		((x) + _a - 1) & ~(_a - 1);	\
> 	})
> 
> but that won't compile because of <net/neighbour.h>:

You would need to also cast the constants with typeof() to.

But yes, given the array sizing case in the neighbour code,
perhaps we can use your original patch for now.  Feel free
to push that to Linus.

