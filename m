Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288799AbSANF4k>; Mon, 14 Jan 2002 00:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288811AbSANF4a>; Mon, 14 Jan 2002 00:56:30 -0500
Received: from dsl081-053-223.sfo1.dsl.speakeasy.net ([64.81.53.223]:34433
	"EHLO starship.berlin") by vger.kernel.org with ESMTP
	id <S288810AbSANF4U>; Mon, 14 Jan 2002 00:56:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, rml@tech9.net (Robert Love)
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 06:59:35 +0100
X-Mailer: KMail [version 1.3.2]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjan@fenrus.demon.nl,
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <E16Pn2o-0007I8-00@the-village.bc.nu>
In-Reply-To: <E16Pn2o-0007I8-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Q09g-0000kn-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 13, 2002 04:59 pm, Alan Cox wrote:
> > > I disable a single specific interrupt, I don't disable the timer 
interrupt.
> > > Your code doesn't seem to handle that.
> > 
> > It can if we increment the preempt_count in disable_irq_nosync and
> > decrement it on enable_irq.
> 
> A driver that knows about how its irq is handled and that it is sole
> user (eg ISA) may and some do leave it disabled for hours at a time

Good point.  Preemption would be disabled for that thread if we mindlessly 
shut it off for every irq_disable.  For that driver we probably just want to 
leave preemption enabled, it can't hurt.

--
Daniel
