Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbQLGRwc>; Thu, 7 Dec 2000 12:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131220AbQLGRwW>; Thu, 7 Dec 2000 12:52:22 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:64778 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130466AbQLGRwJ>;
	Thu, 7 Dec 2000 12:52:09 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012071721.UAA30863@ms2.inr.ac.ru>
Subject: Re: [Fwd: lost need_resched flag re-introduced?]
To: jsun@mvista.COM (Jun Sun)
Date: Thu, 7 Dec 2000 20:21:16 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A2EE42C.F59317E9@mvista.com> from "Jun Sun" at Dec 7, 0 04:15:03 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > A while back I reported the lost need_resched flag bug ( it happens if
> > need_resched is set right before switch_to() is called).  Later on a one-line
> > fix is added to __schedule_tail().
> > 
> >         current->need_resched |= prev->need_resched;
> > 
> > I looked at the latest kernel and found this one is gone.  Is the lost
> > need_resched problem taken care of in some other way?  Or is it re-introduced?

It is removed not only because it was wrong (which you have found too),
but because it was useless even if copied correctly.

current->need_resched is not changed in interrupt context outside
runqueue lock except for scheduler timer, where copying results
in nothing but spurious reschedule.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
