Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTEGWUJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 18:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbTEGWUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 18:20:09 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:32806 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264308AbTEGWUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 18:20:08 -0400
Date: Wed, 7 May 2003 15:28:56 -0700
From: Andrew Morton <akpm@digeo.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 Interrupt Latency
Message-Id: <20030507152856.2a71601d.akpm@digeo.com>
In-Reply-To: <1052336482.2020.8.camel@diemos>
References: <1052323940.2360.7.camel@diemos>
	<1052336482.2020.8.camel@diemos>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2003 22:32:38.0140 (UTC) FILETIME=[903D23C0:01C314E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> 2.5.69
> Latency 100-110usec (5x increase)
> Spikes from 5-10 milliseconds
> 
> This is all on a PCI adapter not sharing interrupts
> on a dual Pentium II-400 Netserver LC3.
> 
> Any ideas what happened?

Could be that some random piece of code forgot to reenable interrupts, and
things stay that way until they get reenabled again by schedule() or
syscall return.

One way of finding the culprit would be:

	my_isr()
	{
		if (this interrupt is more than 5 milliseconds delayed)
			dump_stack();
	}

the stack dump will point up at the place where interrupts finally got
enabled.

If you can describe what drivers are in use, and what workload triggers the
problem then it may be locatable by inspection.

