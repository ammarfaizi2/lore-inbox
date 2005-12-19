Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbVLSPTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVLSPTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVLSPTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:19:05 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:31133 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964773AbVLSPTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:19:04 -0500
Date: Mon, 19 Dec 2005 16:18:34 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Linux/m68k <linux-m68k@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/3] m68k: compile fix - updated vmlinux.lds to include
 LOCK_TEXT
In-Reply-To: <20051215161931.GW27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0512191557420.1609@scrub.home>
References: <20051215090037.GV27946@ftp.linux.org.uk>
 <Pine.LNX.4.61.0512151408560.1605@scrub.home> <20051215161931.GW27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Dec 2005, Al Viro wrote:

> Speaking of hardirq.h - come on; even argument about check being not
> in the same place where the value is defined...
> 
> * we compare NR_IRQS and HARDIRQ_BITS
> * one of them is defined in irq.h, another - in hardirq.h
> * due to current header ordering, comparison works in irq.h and not in
> hardirq.h

I rechecked what I did in the m68k tree. The basic idea is that 
<asm/irq.h> is mostly a private header (basically our <linux/irq.h>),
so if we move something around I would prefer the NR_IRQS definition.
I tried that, but it broke a few other dependencies, so I changed it that 
the (public) hardirq.h includes the (private) irq.h.

Basically what we need is a clear separation between private/public and 
low/high level irq header. For example <linux/interrupt.h> is high level 
header (it even pulls in <linux/sched.h>!) but it defines irqreturn_t 
which is also useful in lower level irq headers.

Christoph, what exactly is your plan regarding irq.h/hardirq.h?

bye, Roman
