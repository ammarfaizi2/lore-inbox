Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132204AbRAUSvu>; Sun, 21 Jan 2001 13:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132270AbRAUSvj>; Sun, 21 Jan 2001 13:51:39 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:45072 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132204AbRAUSvZ>;
	Sun, 21 Jan 2001 13:51:25 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101211837.VAA27543@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: andrea@suse.de (Andrea Arcangeli)
Date: Sun, 21 Jan 2001 21:37:49 +0300 (MSK)
Cc: torvalds@transmeta.com, mingo@elte.hu, raj@cup.hp.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010120215615.B5274@athlon.random> from "Andrea Arcangeli" at Jan 20, 1 09:56:15 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> So now the question is: when does this new nagle algorithm delay packets in the
> write queue? It _must_ do something, otherwise TCP_NODELAY would obviously be a
> noop.

It allows _one_ incomplete segment to fly. Minshall and BSD behave absolutely
similarly in all the curcumstances except for some exceptional situations.

Andrea, I have better question: what "classic" Nagle algorithm
does in this case? Just think and you will find the issue non-trivial. 8)8)


> This was all my wondering about uncorking not being equivalent to SIOCPUSH.

The samples are mostly equivalent.

The difference may happen depending on previous history of the connection.



> If I understood wall they would been equivalent if I did write(100000*MSS)
> instead of write(100000*MSS+1).

Under CORK you may do everything. Segmentation will be perfect in any case.

I spoke about default behaviour.


> IMHO latency can be fixed in a much better way using ioctl(SIOCPUSH)

No doubts.

Only all these tricks with CORKs, MOREs, PUSHes are orthogonal issue.
Nagling is used on generic connections, which do not know and do not want
to know anything about problems of tcp, and just write bytes to socket
and read bytes from it.


> 					Legacy userspace

Please, rewind thread and reread Linus' mail containing mantra
to read in such hard cases. 8)

Applications not using corking or some other our home-made extensions
are not "legacy". The word is different: they are "standard"
de facto and de jure.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
