Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130651AbRA0S17>; Sat, 27 Jan 2001 13:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131436AbRA0S1t>; Sat, 27 Jan 2001 13:27:49 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:18952 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130651AbRA0S1h>;
	Sat, 27 Jan 2001 13:27:37 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101271827.VAA02754@ms2.inr.ac.ru>
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
To: dwd@bell-labs.com (Dave Dykstra)
Date: Sat, 27 Jan 2001 21:27:29 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010126145622.A25707@lucent.com> from "Dave Dykstra" at Jan 26, 1 02:56:22 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Why is it a bug to accept the ACK from it?  RFC793 page 69 says 
> 
>     If the RCV.WND is zero, no segments will be acceptable, but
>     special allowance should be made to accept valid ACKs, URGs and
>     RSTs.

8) This obscure place is discussed for ages. The question is:
What is "valid"? Solaris folks apparently read that valid
are "all".

BSD interprets valid as "segment fits to window after truncation".


> Why shouldn't this be considered a valid ACK?

It may be considered as a valid ACK, provided all the pieces of TCP
do window updates right. If window update algorithm were sane,
it would not be a big problem from tcp viewpoint
(though it remains security hole)

Actually, the same effect (pathological window expansion)
happens in other cases. See tcp-impl, Subj: "Send window update algorithm ...".


> can point me to it.  Why doesn't the probe use the correct sequence number
> instead of backing up one?  Perhaps a workaround is for Linux to not send
> the zero probe with the deliberately incorrect sequence number.

Linux does things, which are recommended by RFC.
BSD style zero window probes are known to be wrong way.

However, I repeat, real problem is not here.

Problem is that Solaris has inconsistent window update
algorithm. It currupts its SND.WND (like all BSD), but
also fails to recover from this (unlike BSD).

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
