Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbUC1UTO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbUC1UTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:19:13 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:38079 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262439AbUC1UTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:19:04 -0500
Message-ID: <07af01c414fe$d6836300$fc82c23f@pc21>
From: "Ivan Godard" <igodard@pacbell.net>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <048e01c413b3_3c3cae60_fc82c23f@pc21> <20040327103401.GA589@openzaurus.ucw.cz> <066b01c41464$7e0ec9c0$fc82c23f@pc21> <20040328062422.GB307@elf.ucw.cz> <06ea01c4148e$67436c80$fc82c23f@pc21> <20040328185410.GE406@elf.ucw.cz>
Subject: Re: Kernel support for peer-to-peer protection models...
Date: Sun, 28 Mar 2004 11:56:57 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Pavel Machek" <pavel@ucw.cz>
To: "Ivan Godard" <igodard@pacbell.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Sunday, March 28, 2004 10:54 AM
Subject: Re: Kernel support for peer-to-peer protection models...


> Hi!
>
> > > Strange system.... If an application does not grant kernel access to
> > > its space, how is kernel supposed to do its job? For example, that
> > > "paranoid DLL" becomes unswappable, then?
> >
> > Pretection is in the *virtual* space, not physical. The physical-page
> > manager (who has the TLB and underlying mapping tables in its space) can
see
> > and deal with any physical address, which in turn has the usual aliasing
> > relationship with virtual addresses. Of course, physical is just one of
the
> > virtual spaces (and is distinguished solely by the one-to-one
> > virtual-physical mapping). So the protection can be penetrated by anyone
who
> > can see the underlying physical page - but that's always true.
>
> Aha, so some part of kernel exist that has "absolute right". Ok, now I
> can imagine that it can work.

The "boot process" comes up with unlimited access to everything and the
virt2phys direct mapped. As it forks procesess it can arbitrarily restrict
their vision, transitively, and set the translation tables any way it wants.
What I've sketched is one model, where a particular virtual space is used to
map physical and the kernel is broken up into distinct address spaces with
protection boundaries between, and each driver and app in ots own space. But
you could emulate a conventoional, with the kernel and the drivers all in
one space (and mutually vulnerable), or others.

> > > If most changes are in arch/, it should be acceptable...
> >
> > I fear that it might be more extensive than that :-)
>
> Well, make patch and lets see... That means that 2.8 needs to be your
> target. If impact outside of arch is not "total rewrite", you might
> have a chance. If it is "total rewrite".... well you just need to be
> very clever.

How badly would the average driver break if it did not have direct data
access to kernal data structures? Calls into the kernel and direct access by
the called functions are OK.

Ivan


