Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132902AbRALUFe>; Fri, 12 Jan 2001 15:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132898AbRALUFS>; Fri, 12 Jan 2001 15:05:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:53509 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132805AbRALUEy>; Fri, 12 Jan 2001 15:04:54 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
Date: 12 Jan 2001 12:04:21 -0800
Organization: Transmeta Corporation
Message-ID: <93no05$7k1$1@penguin.transmeta.com>
In-Reply-To: <E14H8Ks-0004hA-00@the-village.bc.nu> <3A5F4827.2E443786@colorfullife.com> <20010112200541.A25675@unternet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010112200541.A25675@unternet.org>,
Frank de Lange  <frank@unternet.org> wrote:
>As per Linus' suggestion, I removed the disable_irq/enable_irq statements from
>the 8390 core driver, and replace the spinlocks with irq-safe versions. This
>seems to solve the network hangs, as I am currently running a heavy network
>load (which would have killed a non-patched driver within seconds). Network
>latency seems a bit higher, and there are some hiccups in the streaming audio
>(part of the network load, easy indicator of performance...), but no hangs.

Ok, so it's tentatively the IOAPIC disable/enable code.  But it could
obviously be something that just interacts with it, including just a
timing issue (ie the _real_ bug might just be bad behaviour when
changing IO-APIC state at the same time as an interrupt happens, and
disable/enable-irq just happen to be the only things that do it at a
high enough frequency that you can see the problem). 

Remind me: what polarity are your io-apic irq's? Level, edge, sideways?
Anything else that might be relevant?

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
