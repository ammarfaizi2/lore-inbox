Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276938AbRJHP3z>; Mon, 8 Oct 2001 11:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276945AbRJHP3q>; Mon, 8 Oct 2001 11:29:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2318 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276938AbRJHP3h>; Mon, 8 Oct 2001 11:29:37 -0400
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: hadi@cyberus.ca (jamal)
Date: Mon, 8 Oct 2001 16:35:24 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        andrea@suse.de (Andrea Arcangeli), mingo@elte.hu (Ingo Molnar),
        linux-kernel@vger.kernel.org (Linux-Kernel), netdev@oss.sgi.com,
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.GSO.4.30.0110081117140.5473-100000@shell.cyberus.ca> from "jamal" at Oct 08, 2001 11:20:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qcRA-0000uJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I hear you, but I think isolation is important;
> If i am telneted (literal example here) onto that machine (note eth0 is
> not cardbus based) and cardbus is causing the loops then iam screwed.
> [The same applies to everything that shares interupts]

Worst case it sucks, but it isnt dead.

Once you disable the IRQ and kick over to polling the cardbus and the
ethernet both still get regular service. Ok so your pps rate and your
latency are unpleasant, but you are not dead.

For a shared IRQ we know we can safely switch to a 200Hz poll of shared
irq lines marked 'stuck'. The problem ones are non shared ISA devices going
mad - there you have to be careful not to fake more irqs than real ones
are delivered since some ISA device drivers "know" the IRQ is for them.

Even at 200Hz polling a typical cardbus card with say 32 ring buffer slots
can process 6000pps.

Alan
