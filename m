Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313948AbSDUXcB>; Sun, 21 Apr 2002 19:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313962AbSDUXcA>; Sun, 21 Apr 2002 19:32:00 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:5301 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S313948AbSDUXcA>; Sun, 21 Apr 2002 19:32:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@yahoo.com>
Reply-To: ivangurdiev@yahoo.com
Organization: ( )
To: Jeff Garzik <garzik@havoc.gtf.org>
Subject: Re: [PATCH] Via-rhine minor issues
Date: Sun, 21 Apr 2002 17:25:48 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <02042115164004.00745@cobra.linux> <20020421190255.B22314@havoc.gtf.org>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02042117254803.01262@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot the subject line for last mail
Message has no subject. Garzik's reply is Re: Your Mail.

As for the Interrupts:
Actually, RxNoBuf is handled by calling via_rhine_rx 
but not enabled when setting interrupt mask. My patch will fix that.

However, RxOverflow is never handled at all and neither is RxEarly.
Nor are they enabled when setting interrupt mask (patch enables).

How should RxOverflow be handled?
	Should I call via_rhine_rx, like other errors do? - add IntrRxOverflow (and 
possibly RxEarly)

       if (intr_status & (IntrRxDone | IntrRxErr | IntrRxDropped |
                IntrRxWakeUp | IntrRxEmpty | IntrRxNoBuf))
			via_rhine_rx(dev);


How should PCIErr be handled?
Other drivers say:

        /* Hmmmmm, it's not clear how to recover from PCI faults. */
	

> > RxEarly, RxOverflow, RxNoBuf are not handled
> > (which brings up another question - how should they be handled
> > and where?? It doesn't seem to me that those should end up in error,
> > sending CmdTxDemand. )
>
> *blink*  I had not noticed that.
>
> All drivers actually need to handle RxNoBufs and RxOverflow, assuming
> they have similar meaning to what I'm familiar with on other chips.
> The chip may recover transparently, but one should be at least aware of
> them.
>
> RxEarly you very likely do -not- want to handle...
>
> 	Jeff



