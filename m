Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270951AbRHOADe>; Tue, 14 Aug 2001 20:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270948AbRHOADX>; Tue, 14 Aug 2001 20:03:23 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:7749 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270951AbRHOADJ>; Tue, 14 Aug 2001 20:03:09 -0400
Date: Wed, 15 Aug 2001 02:03:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
Message-ID: <20010815020303.D4304@athlon.random>
In-Reply-To: <20010814.144347.95061445.davem@redhat.com> <E15Wmp0-00056i-00@gondolin.me.apana.org.au> <20010814.154233.98555395.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010814.154233.98555395.davem@redhat.com>; from davem@redhat.com on Tue, Aug 14, 2001 at 03:42:33PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 03:42:33PM -0700, David S. Miller wrote:
>    From: Herbert Xu <herbert@gondor.apana.org.au>
>    Date: Wed, 15 Aug 2001 08:38:02 +1000
> 
>    Hmm, it still seems to be wrong:
>  ...
> 
>            if (nfds > current->files->max_fds)
>                    nfds = current->files->max_fds;
>    
>    The second if statement should be removed.  And it might be better to use
>    current->rlim[RLIMIT_NOFILE].rlim_cur instead of NR_OPEN.
> 
> It has to be limited to "max_fds", that is how many files we may
> legally address in current->files!

current->files only matters for the contents of the pollfd struct, not
for the number of pollfd structures passed on, removing such two lines
shouldn't destabilize anything, I think it's just a matter of API,
reading SuS it seems not to imply we have to truncate it to the max_fds
but OTOH the feedback I had was just happy with the 2.4 fix (so I didn't
even checked if the 2.4 fix was fully compliant or not..).

Andrea
