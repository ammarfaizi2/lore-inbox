Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSGUXjH>; Sun, 21 Jul 2002 19:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSGUXjH>; Sun, 21 Jul 2002 19:39:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1016 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315218AbSGUXjG>; Sun, 21 Jul 2002 19:39:06 -0400
Subject: Re: [PATCH] Alan says this needs fixing... (timer/cpu_relax)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020721235154.M26376@flint.arm.linux.org.uk>
References: <20020721235154.M26376@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 01:54:06 +0100
Message-Id: <1027299246.17234.121.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 23:51, Russell King wrote:
> While looking at some stuff, I noticed the following.  Alan confirmed
> that this patch is probably a good idea...
> 
> --- orig/kernel/timer.c	Sun Jul  7 23:21:28 2002
> +++ linux/kernel/timer.c	Sun Jul 21 23:50:17 2002
> @@ -176,7 +176,7 @@
>  #define timer_enter(t) do { running_timer = t; mb(); } while (0)
>  #define timer_exit() do { running_timer = NULL; } while (0)
>  #define timer_is_running(t) (running_timer == t)
> -#define timer_synchronize(t) while (timer_is_running(t)) barrier()
> +#define timer_synchronize(t) while (timer_is_running(t)) cpu_relax()

You still need the barrier() as well

