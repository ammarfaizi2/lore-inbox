Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQLOTPD>; Fri, 15 Dec 2000 14:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbQLOTOy>; Fri, 15 Dec 2000 14:14:54 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27913 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129413AbQLOTOm>; Fri, 15 Dec 2000 14:14:42 -0500
Subject: Re: [lkml]Re: VM problems still in 2.2.18
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 15 Dec 2000 18:46:32 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jjs@toyota.com (J Sloan),
        linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <20001215192207.E17781@inspiron.random> from "Andrea Arcangeli" at Dec 15, 2000 07:22:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146zsJ-0001fT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o	don't wait I/O completion to avoid deadlocking on the i_sem
> o	swap_out returns 1 and memory balancing code so thinks we did progress
> 	in freeing memory and goes to allocate memory from the freelist
> 	without waiting I/O completion
> o	repeat N times the above

so the actual problem is either - the returning 1 when it is the wrong answer
- or the failure to block somewhere else (where its safe) based on a kpiod
maintained semaphore ?

> Yes, the same `current' context must run the down/up pair of calls and as you
> said it is legal to rely on it on all the places it's used.

I assume thats not an issue to reiserfs ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
