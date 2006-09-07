Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751817AbWIGPPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWIGPPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWIGPPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:15:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2507 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751817AbWIGPPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:15:48 -0400
Date: Thu, 7 Sep 2006 08:15:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.18-rc5-mm1: strange /proc/interrupts contents on HPC nx6325
Message-Id: <20060907081528.e1fd8776.akpm@osdl.org>
In-Reply-To: <20060907135105.GA3318@elte.hu>
References: <200609062117.31125.rjw@sisk.pl>
	<20060906201953.d96ee183.akpm@osdl.org>
	<20060907135105.GA3318@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 15:51:05 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > This is due to a gruesome hack (IMO) in the genirq code 
> > (handle_irq_name()) which magically "knows" about the various types of 
> > IRQ handler, but doesn't know about the MSI ones.  It should be 
> > converted to a field in irq_desc, or a callback or something.
> 
> a field in irq_desc[] was frowned upon during initial genirq review, due 
> to size reasons, so i removed it and replaced it with the hack.

irq_desc[] is already in the hundred-byte range.  I'm a bit surprised that
another char* is worth sweating over.

What's in irq_chip.name, btw?  "name for /proc/interrupts".  hmm.

> > I already had a whine about this then forgot about it, but it seems that
> > code can't be changed by whining at it ;)
> 
> ;)
> 
> i think we could add a 'register handler name' API (or extend 
> set_irq_handler() API), to pass in the name of handlers, and store it in 
> a small array (instead of embedding it in irq_desc)? handle_irq_name() 
> is not performance-critical.

spose so.
