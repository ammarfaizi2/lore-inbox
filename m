Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbTBQIIu>; Mon, 17 Feb 2003 03:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266959AbTBQIIp>; Mon, 17 Feb 2003 03:08:45 -0500
Received: from are.twiddle.net ([64.81.246.98]:27031 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S266955AbTBQIFz>;
	Mon, 17 Feb 2003 03:05:55 -0500
Date: Mon, 17 Feb 2003 00:15:44 -0800
From: Richard Henderson <rth@twiddle.net>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Protect smp_call_function_data w/ spinlocks on Alpha
Message-ID: <20030217001544.A13101@twiddle.net>
Mail-Followup-To: Zwane Mwaikambo <zwane@holomorphy.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <Pine.LNX.4.50.0302140634000.3518-100000@montezuma.mastecende.com> <20030214175332.A19234@jurassic.park.msu.ru> <Pine.LNX.4.50.0302141158070.3518-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.50.0302141158070.3518-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Fri, Feb 14, 2003 at 12:16:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 12:16:12PM -0500, Zwane Mwaikambo wrote:
> Ok the reason being is that the lock not only protects the 
> smp_call_function_data pointer but also acts as a lock for that critical 
> section. Without it you'll constantly be overwriting the pointer halfway 
> through IPI acceptance (or even worse whilst a remote CPU is assigning the 
> data members).

Really.  Show me the sequence there? 

I happen to like the pointer_lock a lot, and think we should
make more use of it on systems known to have cmpxchg.  It
saves on the number of cache lines that have to get bounced
between processors.


r~
