Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277135AbRJQTxr>; Wed, 17 Oct 2001 15:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277119AbRJQTxh>; Wed, 17 Oct 2001 15:53:37 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:45081 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S277115AbRJQTx0>; Wed, 17 Oct 2001 15:53:26 -0400
Subject: Re: looking for a preempt-patch for 2.4.10-ac12
From: Robert Love <rml@tech9.net>
To: elko <elko@home.nl>
Cc: =?ISO-8859-1?Q?Jos=E9?= Luis Domingo =?ISO-8859-1?Q?L=F3pez?= 
	<jdomingo@internautas.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <01101721471803.00726@ElkOS>
In-Reply-To: <01101619524411.00955@ElkOS>
	<20011016204753.B1472@dardhal.mired.net>  <01101721471803.00726@ElkOS>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.12.08.08 (Preview Release)
Date: 17 Oct 2001 15:53:54 -0400
Message-Id: <1003348439.1575.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-17 at 15:47, elko wrote:
> the patch is there, I applied it together with the stats-patch
> and my system is running like a charm right now, never have seen
> this kind of response in X.

Glad everything is working smooth...

> the only thing is, the perl-script at:
> http://www.tech9.net/rml/linux/top-latencies
> 
> shows something this:
> 
> ----[ SNIP ]----
> n   min  avg  max  cause   mask start line/file address end line/file
>   14 9512 9590 9711  spin_lock 5 2111/tcp_ipv4.c c0226736119/softirq.c
>   89 9454 9559 9682  spin_lock 9 2111/tcp_ipv4.c c0226736119/softirq.c
>    2 9540 9551 9563  spin_lock 3 2111/tcp_ipv4.c c0226736119/softirq.c
> 3895 7708 9532 14296 spin_lock 1 2111/tcp_ipv4.c c0226736119/softirq.c
>    1 9513 9513 9513  spin_lock 1 2111/tcp_ipv4.c c02267362152/tcp_ipv4.c
>  363 3594 6166 9512  spin_lock 0 2111/tcp_ipv4.c c02267362152/tcp_ipv4.c
> ----[ SNIP ]----
> 
> that 3895 number for '2111/tcp_ipv4.c c0226736119/softirq.c'
> keeps adding up, how should I translate that? big network
> latency, is that what it means? if so, any idea on how
> can I fix that??

the n column is the number of times the lock has been held.  the lock is
probably held numerous times in a given second, so you see large n
values.

note that all those rows you showed could be in one row, but the
top-latencies tool keeps them separate since they have a different mask.

anyhow, the max recorded latency is 9.5ms which is not too bad.  I'm not
looking at the code, but I would imagine its some TCP work done in a
BH.  I wouldn't worry too much.

	Robert Love

