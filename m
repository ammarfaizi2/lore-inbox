Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271205AbRHOONj>; Wed, 15 Aug 2001 10:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271206AbRHOONb>; Wed, 15 Aug 2001 10:13:31 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30994 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271205AbRHOONX>; Wed, 15 Aug 2001 10:13:23 -0400
Date: Wed, 15 Aug 2001 16:13:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: thockin@sun.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
Message-ID: <20010815161318.C7382@athlon.random>
In-Reply-To: <20010814.163804.66057702.davem@redhat.com> <3B79BA07.B57634FD@sun.com> <20010815021110.F4304@athlon.random> <20010814.171609.75760869.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010814.171609.75760869.davem@redhat.com>; from davem@redhat.com on Tue, Aug 14, 2001 at 05:16:09PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 05:16:09PM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Wed, 15 Aug 2001 02:11:10 +0200
> 
>    On Tue, Aug 14, 2001 at 04:53:43PM -0700, Tim Hockin wrote:
>    > -	if (nfds > NR_OPEN)
>    > +	if (nfds > current->rlim[RLIMIT_NOFILE].rlim_cur)
>    
>    Here SuS speaks about OPEN_MAX, not sure if OPEN_MAX corresponds to the
>    current ulimit or to the absolute maximum (to me it sounds more like our
>    NR_OPEN).
> 
> Right, and our equivalent is "NR_OPEN".

I was backporting the new version to 2.2 and I noticed that by using
NR_OPEN an luser will actually be able to lock into RAM something of the
order of the dozen mbytes per process. So I'm wondering that it would be
saner to use the rlimit instead, after all I don't see much of a value
to use NR_OPEN instead of the rlimit (even if strictly speaking SuS asks
us to use NR_OPEN). Any weird program (if any) that would depend on
NR_OPEN instead of the rlimit can be easily fixed with a one liner at
most. So I guess I'd be more happy with the rlimit instead of NR_OPEN.
Comments?

Andrea
