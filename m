Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131061AbQK1VUx>; Tue, 28 Nov 2000 16:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131027AbQK1VUn>; Tue, 28 Nov 2000 16:20:43 -0500
Received: from 213-123-72-140.btconnect.com ([213.123.72.140]:49417 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S130991AbQK1VUa>;
        Tue, 28 Nov 2000 16:20:30 -0500
Date: Tue, 28 Nov 2000 20:52:08 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
In-Reply-To: <20001128214309.F2680@sith.mimuw.edu.pl>
Message-ID: <Pine.LNX.4.21.0011282049470.1940-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Jan Rekorajski wrote:
> --- linux/kernel/fork.c~	Tue Sep  5 23:48:59 2000
> +++ linux/kernel/fork.c	Sun Nov 26 20:22:20 2000
> @@ -560,7 +560,8 @@
>  	*p = *current;
>  
>  	retval = -EAGAIN;
> -	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur)
> +	if (p->user->uid &&
> +	   (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur))

Jan,

Hardcoding things signifying special treatment of uid=0 is almost always a
bad idea. If you _really_ think that superuser (whatever entity that might
be) should be exempt from RLIMIT_NPROC and can prove that (SuSv2 seems to
be silent so you may be right), then you should use capable() to do proper
capability test and not that horrible explicit uid test as in your patch
above.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
