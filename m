Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281915AbRKUQRg>; Wed, 21 Nov 2001 11:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281909AbRKUQR0>; Wed, 21 Nov 2001 11:17:26 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:7280 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S281905AbRKUQRW>; Wed, 21 Nov 2001 11:17:22 -0500
Date: Wed, 21 Nov 2001 16:19:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "David S. Miller" <davem@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 + Bug in swap_out.
In-Reply-To: <Pine.LNX.4.33L.0111211338330.1491-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0111211558160.1394-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Rik van Riel wrote:
> On Wed, 21 Nov 2001, Hugh Dickins wrote:
> >
> > fork and exec are well ordered in how they add to the mmlist,
> > and that ordering (children after parent) suited swapoff nicely,
> > to minimize duplication of a swapent while it's being unused;
> > except swap_out randomized the order by cycling init_mm around it.
> 
> Urmmm, so the code was obfuscated in order to optimise
> swapoff() ?

To speed swapoff, I changed the code back to how fork (see comment
on "Add it to the mmlist" in fork.c old and new) and exec seemed to
intend.  I don't see see that I _obfuscated_ the code:
what's so difficult about swap_mm?

> Exactly how bad was the "mmlist randomising" for swapoff() ?

It was unnecessary and counter-productive, I changed it.
Exact number?  No, but small.

Hugh

