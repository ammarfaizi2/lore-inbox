Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262977AbSJTPpH>; Sun, 20 Oct 2002 11:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbSJTPpG>; Sun, 20 Oct 2002 11:45:06 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:33776 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262977AbSJTPpG>;
	Sun, 20 Oct 2002 11:45:06 -0400
Date: Mon, 21 Oct 2002 01:50:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: george anzinger <george@mvista.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ] POSIX clocks & timers take 3 (NOT HIGH RES)
Message-Id: <20021021015050.21dbd4d9.sfr@canb.auug.org.au>
In-Reply-To: <3DAF4362.EE87F7F1@mvista.com>
References: <3DAF4362.EE87F7F1@mvista.com>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On Thu, 17 Oct 2002 16:10:26 -0700 george anzinger <george@mvista.com> wrote:
>
> +++ linux/include/asm-generic/siginfo.h	Thu Oct 17 15:33:39 2002
> @@ -43,8 +43,9 @@
>  
>  		/* POSIX.1b timers */
> 		struct {
> -			unsigned int _timer1;
> -			unsigned int _timer2;
> +			timer_t _tid;		/* timer id */
> +			int _overrun;		/* overrun count */
> +			sigval_t _sigval;	/* same as below */
>  		} _timer;

This, of course, will only work on architectures where (sizeof(timer_t) +
sizeof(int) + alignment padding for sigval_t) is the same as
(sizeof(pid_t) + sizeof(uid_t) + alignment padding for sigval_t). Which is
true as far as I can see, but is fragile.  It might be worth a comment.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
