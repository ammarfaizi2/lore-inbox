Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316889AbSHBThQ>; Fri, 2 Aug 2002 15:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSHBThQ>; Fri, 2 Aug 2002 15:37:16 -0400
Received: from mk-smarthost-1.mail.uk.tiscali.com ([212.74.114.37]:7440 "EHLO
	mk-smarthost-1.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id <S316889AbSHBThP>; Fri, 2 Aug 2002 15:37:15 -0400
X-Mailer: exmh version 2.5 07/13/2001 (debian 2.5-1) with nmh-1.0.4+dev
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: John Weber <john.weber@linux.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Toshiba Laptop Support and IRQ Locks 
In-Reply-To: Your message of "02 Aug 2002 18:55:39 BST."
             <1028310939.18309.93.camel@irongate.swansea.linux.org.uk> 
References: <3D4AAD53.7010008@linux.org>  <1028310939.18309.93.camel@irongate.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Aug 2002 20:40:25 +0100
From: Jonathan Buzzard <jonathan@buzzard.org.uk>
Message-Id: <E17aiHh-00034N-00@jelly.buzzard.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
> Hi,
> 
> Toshiba laptop support is broken.  Here's my rookie attempt at fixing
> it.

Whats broken? I have not seen the patch, though I don't track the latest
2.5 kernels either.

> Looks basically sound. You probably want to use spinlock_irqsave - the
> spin locks are less overhead than the reader/writer locks and you
> don't really seem to be using it for anything else. I'm assuming we
> want the irqsave to block interrupts because the I/O cycles might have
> to happen one after another - if not they could be relaxed - perhaps
> Jonathan knows ?

Someone show me the patch and I can say for sure.

Two things to bare in mind, Toshiba have yet to do any sort of
multi processor laptop, are extremely unlikely to ever manufacture
one, and to the best of my knowledge the module only loads on Toshiba
laptops. If it loads on anything else it is broken and needs fixing
so it does not.

On this ground I always felt that use of cli() was more than justified.
Though I understand that you might want to banish this stuff from the
kernel, and use something multiprocessor safe.

Secondly bare in mind that the Toshiba laptop module for the most part
puts the processor into System Management Mode. This does its own
locking, once you are in SMM thats *everything* else on hold till it
finishes.

While I am at it, I have been recently pestered with patches to
toshiba.c to add random proc interfaces for various HCI calls. I
have personally rejected the patches as I don't believe that exposing
HCI calls in the kernel is the right thing to do. Firstly there are
over 30 calls to expose, and it makes not sense to just expose one or
two that happen to be the favourite of some random person. Secondly
everything the patches do can be achieved with a userspace program
that use the ioctl on /dev/toshiba that the module provides. Thus
avoiding any bloat to the kernel, and avoiding the need to constantly
add new proc based interfaces each time I discover a new HCI call. 

If someone does propose such a patch I recommend rejecting it.

JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan@buzzard.org.uk
Northumberland, United Kingdom.       Tel: +44(0)1661-832195


