Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310383AbSCBN3I>; Sat, 2 Mar 2002 08:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310381AbSCBN27>; Sat, 2 Mar 2002 08:28:59 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:25094 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S310376AbSCBN2v>;
	Sat, 2 Mar 2002 08:28:51 -0500
Date: Sat, 2 Mar 2002 15:28:34 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: kuznet@ms2.inr.ac.ru
cc: kain@kain.org, <linux-kernel@vger.kernel.org>, <ak@suse.de>
Subject: Re: OOPS: Multipath routing 2.4.17
In-Reply-To: <200203021259.PAA20250@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.44.0203021519010.4102-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sat, 2 Mar 2002 kuznet@ms2.inr.ac.ru wrote:

> > w = jiffies % fi->fib_power;
>
> 	power = fi->fib_power;
> 	barrier();
> 	if (power) ...
>
> Such thing are made in this way.

	I hope you are sure about this solution for fib_select_multipath
because I'm not. IMO, the solution from Andi looks more correct
for the current scheduler.

	What about the new scheduler (for 2.5?), of course, after
replacing the wrong write_lock() with spin_lock_bh(&fib_nh_powers) ?
This lock will be used only in fib_select_multipath because
fib_sync_{up,down} will not play with nh_power. It will protect
only nh_power and I hope the DEAD flag change will not make big
problems for fib_select_multipath.

> Alexey

Regards

--
Julian Anastasov <ja@ssi.bg>

