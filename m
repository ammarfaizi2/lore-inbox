Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310141AbSCAWoN>; Fri, 1 Mar 2002 17:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310142AbSCAWoE>; Fri, 1 Mar 2002 17:44:04 -0500
Received: from ns.suse.de ([213.95.15.193]:3091 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310141AbSCAWnu>;
	Fri, 1 Mar 2002 17:43:50 -0500
To: Julian Anastasov <ja@ssi.bg>
Cc: linux-kernel@vger.kernel.org, kain@kain.org
Subject: Re: OOPS: Multipath routing 2.4.17
In-Reply-To: <Pine.LNX.4.44.0203012316120.1420-100000@u.domain.uli.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Mar 2002 23:43:49 +0100
In-Reply-To: Julian Anastasov's message of "1 Mar 2002 23:30:20 +0100"
Message-ID: <p73sn7jkixm.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julian Anastasov <ja@ssi.bg> writes:

> 	Hello,
> 
> Kain wrote:
> 
> > impossible 888
> > divide error: 0000
> 
> > > > EIP; c024c5ea <fib_select_multipath+5a/a0>   <=====
> > Trace; c02232e8 <ip_route_output_slow+318/670>
> 
> 	There is no write locking in fib_select_multipath,
> combined with high rate of route resolutions and ... boom,
> fi->fib_power is 0:

In theory yes, but the

#if 1
		if (power <= 0) {
			printk(KERN_CRIT "impossible 777\n");
			return;
		}
#endif

should stop it; making it just not work, but not crash.
If he still gets a division by zero then something else is fishy.

-Andi
