Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270910AbRHNWi1>; Tue, 14 Aug 2001 18:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270907AbRHNWiR>; Tue, 14 Aug 2001 18:38:17 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:27914 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S270906AbRHNWiF>; Tue, 14 Aug 2001 18:38:05 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
In-Reply-To: <20010814.144347.95061445.davem@redhat.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-686-smp (i686))
Message-Id: <E15Wmp0-00056i-00@gondolin.me.apana.org.au>
Date: Wed, 15 Aug 2001 08:38:02 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@redhat.com> wrote:
>   From: Tim Hockin <thockin@sun.com>
>   Date: Tue, 14 Aug 2001 14:08:40 -0700

>   poll() currently does not allow you to pass more fd's than you have open. 

> Tim, please check the latest sources, this has been fixed
> in 2.4.x for several months.

Hmm, it still seems to be wrong:

        /* Do a sanity check on nfds ... */
        if (nfds > NR_OPEN)
                return -EINVAL;

        if (nfds > current->files->max_fds)
                nfds = current->files->max_fds;

The second if statement should be removed.  And it might be better to use
current->rlim[RLIMIT_NOFILE].rlim_cur instead of NR_OPEN.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
