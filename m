Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130880AbQKNSlb>; Tue, 14 Nov 2000 13:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131003AbQKNSlW>; Tue, 14 Nov 2000 13:41:22 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:27918 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130880AbQKNSlG>;
	Tue, 14 Nov 2000 13:41:06 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011141810.VAA23199@ms2.inr.ac.ru>
Subject: Re: [patch] acenic driver update
To: jes@trained-monkey.ORG (Jes Sorensen)
Date: Tue, 14 Nov 2000 21:10:52 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200011140031.TAA13437@plonk.linuxcare.com> from "Jes Sorensen" at Nov 14, 0 03:45:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> - netif_stop_queue() was called in post softnet mode when entering
>   start_xmit() which was unnecessary. Now it is only set when the
>   queue is full.

Jes, it is not necessary since linux-2.0 or so...

All the difference with softnet is that you need not _test_ tbusy
on entry. That's all, nothing more.

So, you do:

#if (LINUX_VERSION_CODE < 0x02032b)
	if (test_bit(&tbusy, 0))
		return 1;
#endif

on entry to start_xmit.

All the rest of code is invariant for 2.0, 2.2, 2.4, provided
netif_* macros are defined for earlier kernels.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
