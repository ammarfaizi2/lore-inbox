Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbTL2Toz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTL2ToR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:44:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:29607 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265115AbTL2Tnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:43:37 -0500
Date: Mon, 29 Dec 2003 11:43:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add support for checking before-the-fact whether an IRQ is
In-Reply-To: <1072725508.4233.11.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0312291140360.2113@home.osdl.org>
References: <200312291905.hBTJ56k1032326@hera.kernel.org>
 <1072725508.4233.11.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Arjan van de Ven wrote:
> On Mon, 2003-12-29 at 19:18, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1552, 2003/12/29 10:18:11-08:00, torvalds@home.osdl.org
> > 
> > 	Add support for checking before-the-fact whether an IRQ is
> > 	already registered or not. The x86 PCI layer wants this for
> > 	its availability testing.
> > 	
> > 	Doing a request_irq()/free_irq() pair to check this condition
> > 	like we used to do can lock the machine if the irq happens to
> > 	be screaming.
> 
> 
> question; which lock prevents someone else claiming the irq and making
> it unsharable/unclaimable between can_request_irq() and the eventual
> request_irq() ????

Nothing. It never did. This is basically a heuristic: "find the irq that 
looks the least used".

I just fixed the heuristic so that it shouldn't cause problems if the 
system comes up with the BIOS having done something silly like leaving an 
irq pending..

		Linus
