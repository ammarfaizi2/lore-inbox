Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318896AbSHMBNQ>; Mon, 12 Aug 2002 21:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318897AbSHMBNQ>; Mon, 12 Aug 2002 21:13:16 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:44026 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318896AbSHMBNP>; Mon, 12 Aug 2002 21:13:15 -0400
Subject: Re: [PATCH] fast reader/writer lock for gettimeofday 2.5.30
From: john stultz <johnstul@us.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200208130054.g7D0s1N09420@eng2.beaverton.ibm.com>
References: <200208130054.g7D0s1N09420@eng2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Aug 2002 18:02:53 -0700
Message-Id: <1029200573.1058.73.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  The following patch generalizes Andrea's trick of using sequence numbers
>  to create a reader region/writer lock. It against the 2.5.30 kernel.

Ah! Very nice! I have hit the xtime_lock starvation issue, and was
looking to implement something like vxtime_lock to help it (I'm also
hoping to port the vsyscall gtod to i386 as well). 

>  A new composite primitive 'frlock' is defined in include/linux/frlock.h
>  and used to replace the rwlock xtime_lock enforce consistent access to
>  the clock time variables.

My only comment is that while you have wrapped it up nicely, I'm not
sure this locking algorithm is worth generalizing. While the vxtime_lock
implementation for x86-64 might take a bit to grasp, the macros are very
short, fairly straight forward, and difficult to confuse with a standard
spin/rw_lock. Additionally, the extra complexity of managing the
sequence number isn't really being hidden (and really, I'm not sure how
one would hide it).

Maybe I'm just partial to the way Andrea did it (especially considering
I'd like to use the lock from userspace as well), but regardless this
style of rwlock is definitely needed for the xtime_lock. Very cool!

thanks
-john
 

