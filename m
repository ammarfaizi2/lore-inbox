Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbRBHRXS>; Thu, 8 Feb 2001 12:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbRBHRXI>; Thu, 8 Feb 2001 12:23:08 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:36562 "EHLO
	smtprelay1.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S129741AbRBHRW6>; Thu, 8 Feb 2001 12:22:58 -0500
Message-ID: <3A82D532.C3888101@adelphia.net>
Date: Thu, 08 Feb 2001 12:19:47 -0500
From: Stephen Wille Padnos <stephenwp@adelphia.net>
X-Mailer: Mozilla 4.76C-SGI [en] (X11; U; IRIX64 6.5 IP28)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Howells <dhowells@cambridge.redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] micro-opt DEBUG_ADD_PAGE
In-Reply-To: <Pine.LNX.3.95.1010208115135.873A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
[snip]
> Another problem with 'volatile' has to do with pointers. When
> it's possible for some object to be modified by some external
> influence, we see:
> 
>         volatile struct whatever *ptr;
> 
> Now, it's unclear if gcc knows that we don't give a damn about
> the address contained in 'ptr'. We know that it's not going to
> change. What we are concerned with are the items within the
> 'struct whatever'. From what I've seen, gcc just reloads the
> pointer.
> 
> Cheers,
> Dick Johnson
> 
gcc should treat
volatile struct whatever *ptr;

as a different case than
struct whatever * volatile ptr;

which is also different from
volatile struct whatever * volatile ptr;

I think (but can't find my K&R C book to confirm :) that the first case
declares the struct as volatile, and the second case declares the
pointer volatile (the third case declares a volatile pointer to a
structure with volatile parts).  So, the programmer should have the
choice, if gcc is dealing with volatile correctly.

Of course, that doesn't mean that the authors have made the right choice
:)

-- 
Stephen Wille Padnos
Programmer, Engineer, Problem Solver
swpadnos@adelphia.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
