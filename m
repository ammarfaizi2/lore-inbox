Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131708AbRBQV4g>; Sat, 17 Feb 2001 16:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132001AbRBQV40>; Sat, 17 Feb 2001 16:56:26 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:39173 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S131708AbRBQV4O>; Sat, 17 Feb 2001 16:56:14 -0500
Date: Sat, 17 Feb 2001 21:56:12 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <kuznet@ms2.inr.ac.ru>
cc: <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: SO_SNDTIMEO: 2.4 kernel bugs
In-Reply-To: <200102172029.XAA28904@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.30.0102172155190.16262-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alexey,

Damn you are quick! :) Testing immediately

Cheers
Chris

On Sat, 17 Feb 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > Unfortunately, it seems to be very buggy. Here are two buggy scenarios.
>
>
> --- ../vger3-010210/linux/net/ipv4/tcp.c	Sat Feb 10 23:16:51 2001
> +++ linux/net/ipv4/tcp.c	Sat Feb 17 23:27:43 2001
> @@ -691,6 +691,8 @@
>
>  		set_current_state(TASK_INTERRUPTIBLE);
>
> +		if (!timeo)
> +			break;
>  		if (signal_pending(current))
>  			break;
>  		if (tcp_memory_free(sk) && !vm_wait)
> --- ../vger3-010210/linux/net/core/sock.c	Tue Jan 30 21:20:16 2001
> +++ linux/net/core/sock.c	Sat Feb 17 23:27:44 2001
> @@ -727,6 +727,8 @@
>  	clear_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
>  	add_wait_queue(sk->sleep, &wait);
>  	for (;;) {
> +		if (!timeo)
> +			break;
>  		if (signal_pending(current))
>  			break;
>  		set_bit(SOCK_NOSPACE, &sk->socket->flags);
>

