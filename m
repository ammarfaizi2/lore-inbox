Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263814AbTDULiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbTDULiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:38:14 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:46097 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263814AbTDULiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:38:14 -0400
Date: Mon, 21 Apr 2003 13:49:59 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: updates for the new IRQ API
In-Reply-To: <20030421042934.3728740d.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0304211340300.12110-100000@serv>
References: <20030421042934.3728740d.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 21 Apr 2003, Andrew Morton wrote:

> A change was made today to the kernel's IRQ handlers.  See
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=1999147&forum_id=2314
> 
> for details.

Hmm, if we are breaking already every driver, how about gettting rid of 
the pt_regs argument. The timer interrupt is the only real user and it can 
also be stored in irq_desc_t, from where the timer can get it with the 
irq number.
To preserve compatibility we could add something like this for 2.4:

#define alloc_irq(irq, handler, flags, name, id) \
	request_irq(irq, (irqreturn_t (*)(int, void *, struct pt_regs *))handler, flags, name, id)

bye, Roman

