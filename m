Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318518AbSGaWsJ>; Wed, 31 Jul 2002 18:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318519AbSGaWsJ>; Wed, 31 Jul 2002 18:48:09 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:32765 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318518AbSGaWsI>; Wed, 31 Jul 2002 18:48:08 -0400
Subject: Re: [PATCH] 2.5.29: some compilation fixes for irq frenzy [OSS +
	i8x0 audio]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1028152202.964.84.camel@andyp>
References: <1028062608.964.6.camel@andyp> 
	<1028067951.8510.44.camel@irongate.swansea.linux.org.uk> 
	<1028063953.964.13.camel@andyp> 
	<1028069255.8510.46.camel@irongate.swansea.linux.org.uk> 
	<1028152202.964.84.camel@andyp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 01:08:12 +0100
Message-Id: <1028160492.13008.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-31 at 22:50, Andy Pfiffer wrote:
> After reading the code in question, it appears to me that the existing
> save_flags/cli constructs are being used to atomically query/modify
> elements of an audio_devs[N] entry.  I can see how it might be possible
> for the patch to break SMP.

The cli() is doing a lock across all processors. The local_irqsave won't
protect other processors against the modifications. The ISA side of the
OSS audio world is midbogglingly ugly for this and for lock_kernel
horrors but the PCI side isnt too bad.

The DMA pointers in ISA OSS are also touched by interrupt handling code
- which again cli() locked across all processors and lock_irq* doesn't.

Rusty submitted a much better patch for this - deleting all the old OSS
ISA drivers, so that people can just fix and use the ALSA code instead.
I'm not saying don't analyse the locks and interrupt paths and fix the
OSS audio for ISA stuff, just that it might not be the best use of time
even if you do get it sorted out.


