Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289005AbSBIKo4>; Sat, 9 Feb 2002 05:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291910AbSBIKop>; Sat, 9 Feb 2002 05:44:45 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:21489 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S289005AbSBIKo3>; Sat, 9 Feb 2002 05:44:29 -0500
Date: Sat, 9 Feb 2002 10:46:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: alad@hss.hns.com
cc: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <65256B5B.00314689.00@sandesh.hss.hns.com>
Message-ID: <Pine.LNX.4.21.0202091033490.6135-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2002 alad@hss.hns.com wrote:
> 
> Is it possible to modify your patch from:
> 
> if (in_interrupt())
>    BUG();
> 
> to
> 
> if (unlikely(in_interrupt())
>     BUG();

Unlikely!

But seriously, that function is so full of checks for the improbable,
that it would seem a bit odd for me to add one just for this instance:
unless you've noticed that spectacularly bad code is generated here?

I think I'd prefer to blend in with the surroundings for now, and
leave it for, say, the ACME Janitorial Services to come along and
put BUG_ON()s throughout.

Hugh

