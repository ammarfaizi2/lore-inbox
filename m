Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272493AbRH3Vr1>; Thu, 30 Aug 2001 17:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272500AbRH3VrL>; Thu, 30 Aug 2001 17:47:11 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:14602 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272496AbRH3Vqt>;
	Thu, 30 Aug 2001 17:46:49 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108302146.f7ULkkC23320@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.3.95.1010830171614.18406A-100000@chaos.analogic.com> from
 "Richard B. Johnson" at "Aug 30, 2001 05:17:50 pm"
To: root@chaos.analogic.com
Date: Thu, 30 Aug 2001 23:46:45 +0200 (MET DST)
CC: "Herbert Rosmanith" <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org, ptb@it.uc3m.es
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson wrote:"
> The problem really can't be solved with macros. Here is a little script
> that you can run, which shows that some versions of gcc don't even
> perform macro-expansion correctly.

That's not an experiment which proves that. To show what you claim
by experiment, you would have to expand out the macro yourself and
demonstrate that gcc treats the code with the macro and the code
with your (verbatim!) expansion differently..

Since we know that gcc does a -E first (do we?), the whole idea
is absurd! You must intend to say that gcc treats the code wrongly,
whether or not it's derived from a macro or not:

> #define MIN(a, b) ((unsigned int)(a) < (unsigned int)(b) ? (a) : (b)) 

>    unsigned int j;
>    i = j = 0;
>    printf("%08x\n", MIN(i, j));

> /tmp/xxx.c:9: warning: signed and unsigned type in conditional expression
> rm -f /tmp/xxx.c
> gcc --version
> 2.96

> As you can see, the casts are !!!IGNORED!!! in gcc 2.96.

ummmm .... well, yes, one would have to say that they are ignored
for the purpose of delivering the warning to you. After all, you
requested to be warned, and it seems reasonable to me that gcc
undo your possibly mistaken casts in order to try and advise you of an
underlying problem.

One can see the algorithm in use here :-) it marks expressions as
signed or unsigned and propagates the signedness up through operators.
I think it's smart to ignore sign-changing casts, since they don't
change the _fact_ of a possible incorrect result. OTOH if you always
compare quantities that are both fundamentally signed or fundamentally
unsigned, no warning will issue and indeed there is no possibility
of an incorrect result (modulo arithmetic overflows ...).

> in length and certainly 2 bytes will fit into it. Because of the
> overloading of common functions to return -1 and other signed values,
> it is commonplace to use signed integers to store large values without
> regard for sign. Whether or not this is a design error is moot. It's
> done "everywhere".

Yes, I know what you mean. But we are reaching limits with 31 bit
numbers in many areas of the file system and vm code. It is certainly
necessary to try and expose possible bugs.

Peter
