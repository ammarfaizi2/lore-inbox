Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132006AbRAXAd2>; Tue, 23 Jan 2001 19:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132086AbRAXAdR>; Tue, 23 Jan 2001 19:33:17 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:44454 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132006AbRAXAdC>; Tue, 23 Jan 2001 19:33:02 -0500
Message-ID: <3A6E247A.C6A2FD17@uow.edu.au>
Date: Wed, 24 Jan 2001 11:40:26 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: John Roll <john@cfa.harvard.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Network hang with 2.4.1-pre9 and 3c59x
In-Reply-To: <200101231740.MAA27037@panic.harvard.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Roll wrote:
> 
> Hi,
> 
> I read about some problems with my ethernet card (3c59x) but it was rumored
> that they were fixed in 2.4.1-pre8.  I have 6 IDE drives raided together and
> was stress testing the disk IO.  Suddenly there was no network!
> 
>
> ...
> Linux image.harvard.edu 2.4.1-pre9 #1 SMP Mon Jan 22 12:59:32 EST 2001 i686 unknown
> 
> ...
> eth0: Interrupt posted but not delivered -- IRQ blocked by another device?

This is due to a lost APIC interrupt acknowledgement.  A workaround
is to boot with the `noapic' LILO option.

This long-standing and very nasty problem was discussed extensively
a week or two ago.  Suspicions were cast at the disable_irq() function
but I'm not sure anything 100% conclusive was arrived at.

I guess I'll have to find a way to make disable_irq() go away,
see if that helps.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
