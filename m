Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971803-26836>; Mon, 13 Jul 1998 10:14:59 -0400
Received: from val4-111.abo.wanadoo.fr ([193.252.200.111]:62171 "EHLO lw2l.bnc.interdrome.fr" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <971788-26836>; Mon, 13 Jul 1998 10:14:02 -0400
From: Andrew Derrick Balsa <andrebalsa@altern.org>
Reply-To: andrebalsa@altern.org
To: Philip Gladstone <philip@raptor.com>
Subject: Re: new version of time.c
Date: Mon, 13 Jul 1998 17:13:18 +0200
X-Mailer: KMail [version 0.7.9]
Content-Type: text/plain; charset=US-ASCII
References: <35AA1F4F.A4840FDA@raptor.com>
Cc: linux-kernel@vger.rutgers.edu, "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
MIME-Version: 1.0
Message-Id: <98071317313602.00441@lw2l.bnc.interdrome.fr>
Content-Transfer-Encoding: 7BIT
Sender: owner-linux-kernel@vger.rutgers.edu

Hi Philip,

On Mon, 13 Jul 1998, Philip Gladstone wrote:
>>Hi,
>
>This code suffers from the same problem that all the existing
>do_fast code suffers from -- namely, the assumption that the timer
>interrupt is processed exactly on the 100Hz tick.

You are right. :-)

Even the "top half" of the timer interrupt sometimes doesn't run immediately,
when e.g. a driver has disabled interrupts and is waiting for something to
happen.

>
>The attached patch fixes the problem for 2.0.3x series kernels
>and has been running for a time without problems. It also includes
>a debugging function (do_both_gettimeoffset) that can be used
>to demonstrate the problem.

Looks very good, specially the debugging function.
>
>The trick is to record (using the do_slow mechanism) the time
>when the interrupt is actually taken, and then factor that into
>the calculation.

Excellent, and the cost is not high at all (2 I/O cycles every 10 ms).

Just one microscopic knitpicking, if you allow me: since reading the TSC is
*much* faster than latching the 8253/82C54 CTC, it should come first.

And a question:
What are and why did you do those changes in /kernel/time.c? (I mean, I
understood those in /arch/i386/kernel/time.c)

Cheers,
---------------------
Andrew D. Balsa
andrebalsa@altern.org


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
