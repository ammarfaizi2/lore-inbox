Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129354AbRBHR71>; Thu, 8 Feb 2001 12:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129709AbRBHR7J>; Thu, 8 Feb 2001 12:59:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9088 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129354AbRBHR7C>; Thu, 8 Feb 2001 12:59:02 -0500
Date: Thu, 8 Feb 2001 12:57:36 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephen Wille Padnos <stephenwp@adelphia.net>
cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Howells <dhowells@cambridge.redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] micro-opt DEBUG_ADD_PAGE
In-Reply-To: <3A82D532.C3888101@adelphia.net>
Message-ID: <Pine.LNX.3.95.1010208125335.2003B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Stephen Wille Padnos wrote:

> "Richard B. Johnson" wrote:
> [snip]
> > Another problem with 'volatile' has to do with pointers. When
> > it's possible for some object to be modified by some external
> > influence, we see:
> > 
> >         volatile struct whatever *ptr;
> > 
> > Now, it's unclear if gcc knows that we don't give a damn about
> > the address contained in 'ptr'. We know that it's not going to
> > change. What we are concerned with are the items within the
> > 'struct whatever'. From what I've seen, gcc just reloads the
> > pointer.
> > 
> > Cheers,
> > Dick Johnson
> > 
> gcc should treat
> volatile struct whatever *ptr;
> 
> as a different case than
> struct whatever * volatile ptr;
> 
> which is also different from
> volatile struct whatever * volatile ptr;
> 
> I think (but can't find my K&R C book to confirm :) that the first case
> declares the struct as volatile, and the second case declares the
> pointer volatile (the third case declares a volatile pointer to a
> structure with volatile parts).  So, the programmer should have the
> choice, if gcc is dealing with volatile correctly.
> 
> Of course, that doesn't mean that the authors have made the right choice
> :)
> 

Yes. My point is that a lot of authors have declared just about everything
'volatile' `grep volatile /usr/src/linux/drivers/net/*.c`, just to
be "safe". It's likely that there are many hundreds of thousands of
unneeded register-reloads because of this. 

It might be useful for somebody who has a lot of time on his/her
hands to go through some of these drivers.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
