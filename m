Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLGTWV>; Thu, 7 Dec 2000 14:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbQLGTWF>; Thu, 7 Dec 2000 14:22:05 -0500
Received: from hybrid-024-221-181-223.ca.sprintbbd.net ([24.221.181.223]:39150
	"EHLO hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S129314AbQLGTV5>; Thu, 7 Dec 2000 14:21:57 -0500
Message-ID: <3A2FDC3C.C2DA705D@mvista.com>
Date: Thu, 07 Dec 2000 10:51:40 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: lost need_resched flag re-introduced?]
In-Reply-To: <200012071721.UAA30863@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > > A while back I reported the lost need_resched flag bug ( it happens if
> > > need_resched is set right before switch_to() is called).  Later on a one-line
> > > fix is added to __schedule_tail().
> > >
> > >         current->need_resched |= prev->need_resched;
> > >
> > > I looked at the latest kernel and found this one is gone.  Is the lost
> > > need_resched problem taken care of in some other way?  Or is it re-introduced?
> 
> It is removed not only because it was wrong (which you have found too),
> but because it was useless even if copied correctly.
> 
> current->need_resched is not changed in interrupt context outside
> runqueue lock except for scheduler timer, where copying results
> in nothing but spurious reschedule.
> 
> Alexey

Alexey,

I think wake_up_process() is called in interrupt routine quite often and it
will set need_resched flag (through reschedule_idle()).  ???

I did several run time tests and confirmed the missing need_resched flag was
happening.  Ether some new code takes care of it.  Or it is still there.

Jun
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
