Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132808AbRDIRuA>; Mon, 9 Apr 2001 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132809AbRDIRtu>; Mon, 9 Apr 2001 13:49:50 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:6407 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132808AbRDIRth>;
	Mon, 9 Apr 2001 13:49:37 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104091748.VAA03998@ms2.inr.ac.ru>
Subject: Re: [PATCH] Re: softirq buggy
To: manfred@colorfullife.COM (Manfred Spraul)
Date: Mon, 9 Apr 2001 21:48:02 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AD1D4A3.1E7FACD8@colorfullife.com> from "Manfred Spraul" at Apr 9, 1 07:45:03 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Btw, you don't schedule the ksoftirqd thread if do_softirq() returns
> from the 'if(in_interrupt())' check.

ksoftirqd will not be switched to before the first schedule
or ret form syscall, when softirqs will be processed in any case.
So, wake up in this case would be mistake.


> I assume that this is the most common case of delayed softirq
> processing:

softirqs have the same latency warranty as rt threads, so that
this is not a problem at all.

The _real_ problem is softirqs generated from another softirqs:
additonal thread is made _not_ to speed up softirqs, but to _tame_
them (if I understood Andres's explanations correctly).

Alexey
