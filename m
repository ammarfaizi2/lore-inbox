Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLKPnR>; Mon, 11 Dec 2000 10:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbQLKPnH>; Mon, 11 Dec 2000 10:43:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38413 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129314AbQLKPmu>; Mon, 11 Dec 2000 10:42:50 -0500
Subject: Re: your mail
To: Heiko.Carstens@de.ibm.com
Date: Mon, 11 Dec 2000 15:14:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <C12569B2.004D1644.00@d12mta01.de.ibm.com> from "Heiko.Carstens@de.ibm.com" at Dec 11, 2000 03:01:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145Uf0-00081R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sigp. To synchronize n CPUs one can create n kernel threads and give
> them a high priority to make sure they will be executed soon (e.g. by
> setting p->policy to SCHED_RR and p->rt_priority to a very high
> value). As soon as all CPUs are in synchronized state (with
> interrupts disabled) the new CPU can be started. But before this can
> be done there are some other things left to do:

You dont IMHO need to use such a large hammer. We already do similar sequences
for tlb invalidation on X86 for example. You can broadcast an interprocessor
interrupt and have the other processors set a flag each. You spin until they
are all captured, then when you clear the flag they all continue. You just
need to watch two processors doing it at the same time 8)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
