Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263443AbRFKSoX>; Mon, 11 Jun 2001 14:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263536AbRFKSoN>; Mon, 11 Jun 2001 14:44:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30212 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263443AbRFKSoB>; Mon, 11 Jun 2001 14:44:01 -0400
Subject: Re: Problems with arch/i386/kernel/apm.c
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 11 Jun 2001 19:42:36 +0100 (BST)
Cc: jgolds@resilience.com (Jeff Golds), linux-kernel@vger.kernel.org
In-Reply-To: <3B2509CD.F898D2AE@mandrakesoft.com> from "Jeff Garzik" at Jun 11, 2001 02:11:25 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159We4-0000Cc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > needed.  What I am really desiring to know is if there are any devices
> > that depend on the apm::send_event(APM_NORMAL_RESUME) happening while
> > interrupts are disabled.
> 
> Good spotting...  If any devices depend on what you describe, I would
> argue that their drivers should handle that not the core apm code...

The drivers can't handle it at the moment. I've been talking to many people
about this all hitting this sort of driver problem.

I think the fix is to keep two classes of power management objects and do
the following

	Call each 'nonirq' suspend function
	(aborting if need be)
	cli()
	Call each irq blocked suspend function
	suspend


resume:
	call each irq blocked resume function
	sti();
	call each nonirq resume

That is an easy change set to make and solves a lot of grief

