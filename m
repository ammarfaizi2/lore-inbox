Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758742AbWK2EEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758742AbWK2EEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 23:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758744AbWK2EEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 23:04:55 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40106
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1758742AbWK2EEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 23:04:54 -0500
Date: Tue, 28 Nov 2006 20:04:53 -0800 (PST)
Message-Id: <20061128.200453.104036587.davem@davemloft.net>
To: kaos@ocs.com.au
Cc: nmiell@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick
 away 
From: David Miller <davem@davemloft.net>
In-Reply-To: <21982.1164772580@kao2.melbourne.sgi.com>
References: <1164769705.2825.4.camel@entropy>
	<21982.1164772580@kao2.melbourne.sgi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Owens <kaos@ocs.com.au>
Date: Wed, 29 Nov 2006 14:56:20 +1100

> Secondly, I believe that this is a separate problem from bug 22278.
> hpet_readl() is correctly using volatile internally, but its result is
> being assigned to a pair of normal integers (not declared as volatile).
> In the context of wait_hpet_tick, all the variables are unqualified so
> gcc is allowed to optimize the comparison away.
> 
> The same problem may exist in other parts of arch/i386/kernel/time_hpet.c,
> where the return value from hpet_readl() is assigned to a normal
> variable.  Nothing in the C standard says that those unqualified
> variables should be magically treated as volatile, just because the
> original code that extracted the value used volatile.  IOW, time_hpet.c
> needs to declare any variables that hold the result of hpet_readl() as
> being volatile variables.

I disagree with this.

readl() returns values from an opaque source, and it is declared
as such to show this to GCC.  It's like a function that GCC
cannot see the implementation of, which it cannot determine
anything about wrt. return values.

The volatile'ness does not simply disappear the moment you
assign the result to some local variable which is not volatile.

Half of our drivers would break if this were true.
