Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129219AbQKRKW6>; Sat, 18 Nov 2000 05:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbQKRKWj>; Sat, 18 Nov 2000 05:22:39 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:21650 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129219AbQKRKW2>; Sat, 18 Nov 2000 05:22:28 -0500
To: David Mansfield <lkml@dm.ultramaster.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] semaphore fairness patch against test11-pre6
In-Reply-To: <3A15D4F5.B39D61BD@dm.ultramaster.com>
From: Christoph Rohland <cr@sap.com>
Date: 18 Nov 2000 10:45:07 +0100
In-Reply-To: David Mansfield's message of "Fri, 17 Nov 2000 20:01:41 -0500"
Message-ID: <m3bsvdd36k.fsf@linux.local>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Mansfield <lkml@dm.ultramaster.com> writes:
> If you can find the time to check this out more completely, I recommend
> it, because it seems like a great improvement to be able to accurately
> see vmstat numbers in times of system load.  I hope the other side
> effects are beneficial as well :-)

I wanted to point out that there may be some performance impacts by
this: We had exactly the new behaviour on SYSV semaphores. It led to
very bad behaviour in high load situations since for high frequency,
short critical paths this led to very high context switch rates
instead of using the available time slice for the program.

We changed the behaviour of SYSV semaphores to the current kernel sem
behaviour and never had problems with that change.

I still think that your change is right since this is kernel space and
you do not have the notion of a time slice.

        Christoph


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
