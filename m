Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288166AbSAMWFz>; Sun, 13 Jan 2002 17:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288173AbSAMWFp>; Sun, 13 Jan 2002 17:05:45 -0500
Received: from dsl081-053-223.sfo1.dsl.speakeasy.net ([64.81.53.223]:28033
	"EHLO starship.berlin") by vger.kernel.org with ESMTP
	id <S288166AbSAMWFi>; Sun, 13 Jan 2002 17:05:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@fenrus.demon.nl
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Sun, 13 Jan 2002 23:06:56 +0100
X-Mailer: KMail [version 1.3.2]
Cc: landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <E16PTIR-0002sL-00@the-village.bc.nu>
In-Reply-To: <E16PTIR-0002sL-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16PsmG-0000FB-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 12, 2002 07:54 pm, Alan Cox wrote:
> Another example is in the network drivers. The 8390 core for one example
> carefully disables an IRQ on the card so that it can avoid spinlocking on 
> uniprocessor boxes.
> 
> So with pre-empt this happens
> 
> 	driver magic
> 	disable_irq(dev->irq)
	inc task's preempt inhibit

> PRE-EMPT:
> 	[large periods of time running other code]
> PRE-EMPT:
> 	We get back and we've missed 300 packets, the serial port sharing
> 	the IRQ has dropped our internet connection completely.

	We are ok
	dec tasks's preempt inhibit
	jmp if nonzero

--
Daniel
