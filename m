Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130541AbRASSet>; Fri, 19 Jan 2001 13:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135473AbRASSek>; Fri, 19 Jan 2001 13:34:40 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:4880 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130541AbRASSe2>;
	Fri, 19 Jan 2001 13:34:28 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101191818.VAA24360@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 19 Jan 2001 21:18:04 +0300 (MSK)
Cc: mingo@elte.hu, torvalds@transmeta.com, raj@cup.hp.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010119162552.D3447@athlon.random> from "Andrea Arcangeli" at Jan 19, 1 04:25:52 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The "uncork" won't push the last skb on the wire if there is not acknowledged
> data in the write_queue and the payload of the last skb in the write_queue
> isn't large MSS. This because the `uncork' will only re-evaluate the
> write_queue in function of the _nagle_ algorithm, quite correctly because the
> "uncork" will move frok "cork" to "nagle" (not from "cork" to "nodelay").

At least for your own implementation of SIOCPUSH has "1" among
arguments of push_pending_frames, so that this does not happen. 8)8)

The second thing, which makes argument above wrong is that
both classic Nagle and linux-2.4 Nagle (extended by Minshall),
do not have this problem. Your argument applies to buggy flavor
of nagling specific to 2.2.


However, SIOCPUSH really affects latency badly in some curcumstances.
Actually, Ingo already learned this from bad experience with TUX. 8)
Namely, when push cannot push anything due to congestion window
or receiver window, http/1.0 style synchronous connections suffer.
The lesson is that when reply is better to be disabled.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
