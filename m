Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLORji>; Fri, 15 Dec 2000 12:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLORj2>; Fri, 15 Dec 2000 12:39:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129228AbQLORjQ>; Fri, 15 Dec 2000 12:39:16 -0500
Date: Fri, 15 Dec 2000 12:07:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Mike Black <mblack@csihq.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
In-Reply-To: <20001215175632.A17781@inspiron.random>
Message-ID: <Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2000, Andrea Arcangeli wrote:

> On Fri, Dec 15, 2000 at 11:29:28AM -0500, Mike Black wrote:
> > include/linux/signal.h
> > 
> > There's a couple like this -- isn't this case statement upside down???
> > 
> > extern inline void siginitset(sigset_t *set, unsigned long mask)
> > {
> >         set->sig[0] = mask;
> >         switch (_NSIG_WORDS) {
> >         default:
> >                 memset(&set->sig[1], 0, sizeof(long)*(_NSIG_WORDS-1));
> >                 break;
> >         case 2: set->sig[1] = 0;
> >         case 1:
> >         }
> > }
> > 
> > gcc is complaining:
> > /usr/src/linux/include/linux/signal.h:193: warning: deprecated use of label
> > at end of compound statement
> 
> You're using a too recent gcc (I got flooded too indeed). I disagree with such
> a warning, current code makes perfect sense.
> 
> Andrea

Current code makes perfect sense if you put a 'break;' after the last
label. This doesn't generate any code, but makes the source comply with
the new rule.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
