Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131320AbRCULDe>; Wed, 21 Mar 2001 06:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131341AbRCULDY>; Wed, 21 Mar 2001 06:03:24 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:10401 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131320AbRCULDO>; Wed, 21 Mar 2001 06:03:14 -0500
Message-ID: <3AB88929.D1B324F2@mvista.com>
Date: Wed, 21 Mar 2001 02:57:45 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Keith Owens <kaos@ocs.com.au>, nigel@nrg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org>
		<22991.985166394@ocs3.ocs-net> <15032.30533.638717.696704@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Keith Owens writes:
>  > Or have I missed something?
> 
> Nope, it is a fundamental problem with such kernel pre-emption
> schemes.  As a result, it would also break our big-reader locks
> (see include/linux/brlock.h).

He has this one covered.  The patch puts preemption locks around
read_locks.

By the by, if a preemption lock is all that is needed the patch defines
it and it is rather fast (an inc going in and a dec & test comming
out).  A lot faster than a spin lock with its "LOCK" access.  A preempt
lock does not need to be "LOCK"ed because the only contender is the same
cpu.

George

> 
> Basically, anything which uses smp_processor_id() would need to
> be holding some lock so as to not get pre-empted.
> 
> Later,
> David S. Miller
> davem@redhat.com
