Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292890AbSB0TFG>; Wed, 27 Feb 2002 14:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292761AbSB0TE7>; Wed, 27 Feb 2002 14:04:59 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:64018 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S292890AbSB0TEv>;
	Wed, 27 Feb 2002 14:04:51 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200202271904.WAA09439@ms2.inr.ac.ru>
Subject: Re: Fw: memory corruption in tcp bind hash buckets on SMP?
To: davem@redhat.com (David S. Miller)
Date: Wed, 27 Feb 2002 22:04:25 +0300 (MSK)
Cc: raghuangadi@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020226.231934.116353439.davem@redhat.com> from "David S. Miller" at Feb 26, 2 11:19:34 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I think his analysis is alright but he patch is questionable.

Yes. "if (tb) tcp_tw_put(tw)" cannot be right, no doubts.

Seems, it is enough to remove from bind hash _before_ established.

The idea was that bind hash is pure slave of another state, so that
it need not refcounting at all. Note that adding the second increment
does not help: when we verify that leakage (the situation, when
bucket is in bind hash, but has no timer running) is impossible
we immediately arrive to elimination of the refcount.

Raghu, could you check the variant with inverted order of removal?
Do you see holes? From my side... I need to think more. :-)

Alexey
