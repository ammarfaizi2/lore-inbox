Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282067AbRLKRZM>; Tue, 11 Dec 2001 12:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282242AbRLKRYw>; Tue, 11 Dec 2001 12:24:52 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:15122 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S282067AbRLKRYq>;
	Tue, 11 Dec 2001 12:24:46 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200112111724.UAA02436@ms2.inr.ac.ru>
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2
To: davem@redhat.com (David S. Miller)
Date: Tue, 11 Dec 2001 20:24:15 +0300 (MSK)
Cc: Mika.Liljeberg@welho.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011210.161332.30184646.davem@redhat.com> from "David S. Miller" at Dec 10, 1 04:13:32 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> A socket in a synchronized state is required to enforce legal sequence
> numbers, is it not?

They are . :-)

Well, assuming that this is really illegal we could just add
missing LAST_ACK close to its relative CLOSING, CLOSE_WAIT
(where it was forgotten old days occasionally, I think).
It is minimal change and this is good.

But I look at problem at our side: if we receive such packet yet,
what should we make? Earlier we sent an ACK and dropped
bad segment or aborted connection. Now we just blackhole them
and the bug with missing case LAST_ACK just allowed to see the fact
that we changed behaviour, which is not good. :-)

Alexey
