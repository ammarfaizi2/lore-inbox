Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTEIVTq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263473AbTEIVTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:19:46 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:39998 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263468AbTEIVTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:19:45 -0400
Date: Fri, 9 May 2003 14:28:28 -0700
From: Andrew Morton <akpm@digeo.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 Interrupt Latency
Message-Id: <20030509142828.59552d0a.akpm@digeo.com>
In-Reply-To: <1052512235.2997.8.camel@diemos>
References: <1052323940.2360.7.camel@diemos>
	<1052336482.2020.8.camel@diemos>
	<20030507152856.2a71601d.akpm@digeo.com>
	<1052402187.1995.13.camel@diemos>
	<20030508122205.7b4b8a02.akpm@digeo.com>
	<1052503920.2093.5.camel@diemos>
	<1052512235.2997.8.camel@diemos>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 May 2003 21:32:19.0463 (UTC) FILETIME=[782A5970:01C31672]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> In the process of eliminating kernel options to isolate
> the problem, eliminating USB completely appears to fix it.
> 
> One machine (server) was using usb-uhci and
> the other (laptop) was using usb-ohci.
> 
> So it looks like something with USB in 2.5.68-bk11

ah, that helps.

This code was added to wakeup_hc().  It is called from uhci_irq():

+	/* Global resume for 20ms */
+	outw(USBCMD_FGR | USBCMD_EGSM, io_addr + USBCMD);
+	wait_ms(20);

The changelog just says "Minor patch for uhci-hcd.c"

Can you delete the wait_ms() and see if that is our culprit?
