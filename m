Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSIDSa5>; Wed, 4 Sep 2002 14:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSIDSa5>; Wed, 4 Sep 2002 14:30:57 -0400
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:24082 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S314459AbSIDSay> convert rfc822-to-8bit; Wed, 4 Sep 2002 14:30:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Problem on a kernel driver(SuSE, SMP)
Date: Wed, 4 Sep 2002 11:35:26 -0700
Message-ID: <8C18139EDEBC274AAD8F2671105F0E8E121767@cacexc02.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem on a kernel driver(SuSE, SMP)
Thread-Index: AcJUQHl7qhfOWr59RraIm357nQ4PXgAACltw
From: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Sep 2002 18:35:27.0012 (UTC) FILETIME=[D69E9640:01C25441]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Richard B. Johnson [mailto:root@chaos.analogic.com]
> Sent: Wednesday, September 04, 2002 11:25 AM
> To: Libershteyn, Vladimir
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: Problem on a kernel driver(SuSE, SMP)
> 
> 
> On Wed, 4 Sep 2002, Libershteyn, Vladimir wrote:
> 
> > > 
> > > You are not too specific, which makes it hard to 
> understand what may
> > > be going wrong so I'll assume that you probably did a bad thing.
> > 
> > I think I gave all the specific information
> > 
> > > 
> > > (1)  You cannot sleep in an interrupt, which means you can't use
> > > down_*() and friends inside an ISR.
> > 
> > I DO NOT sleep in ISR, the up*() routine is inside the ISR, 
> dut not down*()
> > This is a standard use of the mechanism
> > 
> > > 
> > > (2)  Wait queues should work fine from the 'user-side' of 
> a driver,
> > > but again, you cannot ever sleep in an interrupt service routine.
> > > Look in ../linux/drivers/* for examples of code that works.
> > > 
> > 
> > Again there is NO sleep in ISR, and I know that queues 
> should work fine, 
> > but they don't, that why I have a problem, but problem only on
> > SMP machine.
> > 
> > > (3)  You can't use any wait-queue or sleep on a semaphore while
> > > holding a spin-lock or while the interrupts are disabled. You can
> > > manage your own lock against re-entry in your procedure, but you
> > > can't allow two tasks to try the same semaphore at (nearly) the
> > > same time or you can dead-lock.
> > 
> > I DO NOT hold any spinlocks, while use down_interruptible
> > 
> > > 
> > > 
> > > (4)	The fact that 'down' hangs means that there is nothing
> > > that the CPU can do. This is direct evidence that you have the
> > > interrupts disabled when down executes.
> > 
> > To be more specific, here is a code:
> > ----------------------------------------------------
> > function when thread go to sleep, if data not ready 
> > ---------------------------------------------------
> 
> Snipped code.
> 
> How do you know that 
>  	up(&a->sem[enumerator]);
> in the ISR and...
>  	down_interruptible(&a->sem[enumerator]);
> In axl_get_response...
> 	... have the same value of 'enumerator', therefore the same
> semaphore?
> 
> One comes from a modulus and another from indirection off from 'board
> address'?
> 
> I think there is a bug there.
> 

First of all it does not even come to the ISR routine. 
The hang appears at down_interruptible. the interrupt don't even occur yet.
I know that.

To prove it I did limited possible resources to one card (card 0) and to only
one logical device (enumerator 0). The probelm is the same.

Regards,
Vlad

P.S. This product has been shiped for 3 years with RH and SuSE, There was no problems 
with any but SuSE SMP machines.
